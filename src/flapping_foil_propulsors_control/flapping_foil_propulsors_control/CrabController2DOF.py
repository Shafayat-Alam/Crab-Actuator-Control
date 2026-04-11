import rclpy
from rclpy.node import Node
from rclpy.executors import MultiThreadedExecutor
from rclpy.callback_groups import ReentrantCallbackGroup
from std_msgs.msg import Float32MultiArray, String
import time
import math
from queue import Queue

class CrabController2DOF(Node):
    def __init__(self):
        super().__init__('crab_motion_engine')
        
        self.actuators = {
            "left":  {"roll": 1.0, "pitch": 2.0},
            "right": {"roll": 3.0, "pitch": 4.0}
        }
        self.all_ids = [1.0, 2.0, 3.0, 4.0]
        self.OFFSETS = {1.0: 3.65, 2.0: 3.3, 3.0: 2.95, 4.0: 1.86}
        self.LIMITS = {"min": 0.0, "max": 6.28}

        # --- Concurrency Setup ---
        self.cb_group = ReentrantCallbackGroup()
        self.parity_queue = Queue(maxsize=1000) # Buffer to guarantee 1:1 telemetry

        # --- Publishers ---
        self.joint_pub = self.create_publisher(Float32MultiArray, 'joint_cmd', 1)
        self.telemetry_pub = self.create_publisher(Float32MultiArray, 'telemetry', 10)
        
        # --- Subscriptions ---
        self.motion_sub = self.create_subscription(String, 'motion_cmd', self.motion_cb, 10, callback_group=self.cb_group)
        self.feedback_sub = self.create_subscription(Float32MultiArray, 'joint_feedback', self.feedback_cb, 1, callback_group=self.cb_group)

        # --- State Variables ---
        self.current_cmd_id = 0.0
        self.full_feedback = {id: {"pos": 0.0, "vel": 0.0, "curr": 0.0, "volt": 0.0} for id in self.all_ids}
        self.active_motions = {}
        self.is_moving = False
        self.total_duration = 0.0
        self.start_time = 0.0

        time.sleep(1.5)
        self.torque_enable()
        
        # Control Loop (1kHz) - Thread 1
        self.control_timer = self.create_timer(0.001, self.update_motion_loop, callback_group=self.cb_group)
        # Telemetry Loop (1kHz) - Thread 2 (Pulls from queue)
        self.telemetry_timer = self.create_timer(0.001, self.publish_telemetry, callback_group=self.cb_group)

    def feedback_cb(self, msg):
        for i in range(0, len(msg.data), 6):
            sid = msg.data[i]
            if sid in self.full_feedback:
                self.full_feedback[sid].update({
                    "pos":  msg.data[i+2], "vel":  msg.data[i+3],
                    "curr": msg.data[i+4], "volt": msg.data[i+5]
                })

    def motion_cb(self, msg):
        try:
            parts = msg.data.lower().replace(' ', '').split(']')
            data = {p.split(':[')[0]: p.split(':[')[1].split(',') for p in parts if ':[' in p}
            self.current_cmd_id = float(data['cmd_id'][0])
            freq, cycles = float(data['freqs'][0]), float(data['cycles'][0])
            self.total_duration = cycles / freq
            self.start_time = time.time()
            self.active_motions = {side: {"func": data['motions'][i], "mode": float(data['modes'][i]), 
                                   "freq": freq, "amp": float(data['amps'][i])} 
                                   for i, side in enumerate(data['actuators'])}
            self.is_moving = True
        except Exception as e:
            self.get_logger().error(f"Command Error: {e}")

    def update_motion_loop(self):
        goals = {id: 0.0 for id in self.all_ids}
        modes = {id: 3.0 for id in self.all_ids}
        elapsed = 0.0

        if self.is_moving:
            elapsed = time.time() - self.start_time
            if elapsed < self.total_duration:
                for side, p in self.active_motions.items():
                    res = getattr(self, p["func"])(elapsed, p["freq"], p["amp"])
                    goals[self.actuators[side]["roll"]] = res["roll"]
                    goals[self.actuators[side]["pitch"]] = res["pitch"]
                    modes[self.actuators[side]["roll"]] = p["mode"]
                    modes[self.actuators[side]["pitch"]] = p["mode"]
            else:
                self.is_moving = False

        # 1. Hardware Command
        ids = sorted(goals.keys())
        final_goals = []
        for idx in ids:
            phys_cmd = goals[idx] + self.OFFSETS.get(idx, 0.0)
            safe_cmd = max(self.LIMITS["min"], min(self.LIMITS["max"], phys_cmd))
            final_goals.append(safe_cmd)
            goals[idx] = safe_cmd # Keep sanitized goal for telemetry

        cmd_msg = Float32MultiArray()
        cmd_msg.data = [float(idx) for idx in ids] + [modes[idx] for idx in ids] + final_goals
        self.joint_pub.publish(cmd_msg)

        # 2. Push snapshot to Parity Queue
        if not self.parity_queue.full():
            self.parity_queue.put({
                "cmd_id": self.current_cmd_id,
                "ts": time.time(),
                "goals": goals,
                "feedback": {k: v.copy() for k, v in self.full_feedback.items()}
            })

    def publish_telemetry(self):
        """Pulls from Queue to ensure 1:1 parity without blocking control math."""
        if self.parity_queue.empty():
            return

        data = self.parity_queue.get()
        telem_msg = Float32MultiArray()
        telem_data = [data["cmd_id"], data["ts"]]
        
        for idx in sorted(self.all_ids):
            f = data["feedback"][idx]
            telem_data.extend([data["goals"][idx], f["pos"], f["vel"], f["curr"], f["volt"]])
            
        telem_msg.data = telem_data
        self.telemetry_pub.publish(telem_msg)

    # --- Input Library ---
    def forward_paddle(self, t, f, a):
        theta = 2 * math.pi * f * t
        return {"roll": 1.5708 * math.sin(theta + (math.pi/2)), "pitch": a * math.sin(theta)}
    
    def backward_paddle(self, t, f, a):
        theta = 2 * math.pi * f * t
        return {"roll": 1.5708 * math.sin(theta - (math.pi/2)), "pitch": a * math.sin(theta)}

    def forward_flap(self, t, f, a):  return {"roll": 1.5708, "pitch": a * math.sin(2 * math.pi * f * t)}
    def backward_flap(self, t, f, a): return {"roll": -1.5708, "pitch": a * math.sin(2 * math.pi * f * t + math.pi)}
    def up_flap(self, t, f, a):       return {"roll": 0.0, "pitch": a * math.sin(2 * math.pi * f * t)}
    def down_flap(self, t, f, a):     return {"roll": 0.0, "pitch": a * math.sin(2 * math.pi * f * t + math.pi)}

    def torque_enable(self):
        msg = Float32MultiArray()
        msg.data = [1.0, 2.0, 3.0, 4.0] + [-1.0]*4 + [0.0]*4
        self.joint_pub.publish(msg)

    def destroy_node(self):
        msg = Float32MultiArray()
        msg.data = [1.0, 2.0, 3.0, 4.0] + [0.0]*4 + [0.0]*4
        self.joint_pub.publish(msg)
        super().destroy_node()

def main(args=None):
    rclpy.init(args=args)
    node = CrabController2DOF()
    executor = MultiThreadedExecutor()
    executor.add_node(node)
    try:
        executor.spin()
    except KeyboardInterrupt:
        pass
    finally:
        node.destroy_node()
        rclpy.shutdown()

if __name__ == '__main__':
    main()