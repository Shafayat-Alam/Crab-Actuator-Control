import rclpy
from rclpy.node import Node
from rclpy.executors import SingleThreadedExecutor  # Changed from MultiThreaded
from std_msgs.msg import Float32MultiArray, String
import time
import math
from queue import Queue

class CrabController2DOF(Node):
    """
    High-level motion engine for 2DOF actuators.
    Handles trajectory generation (Sine waves) and Closed-Loop PID control.
    Supports both Position-Offset PID and Direct Velocity PID via ROS2 parameters.
    
    Optimized for Single-Threaded execution to ensure deterministic control timing.
    """
    def __init__(self):
        super().__init__('crab_motion_engine')
        
        # --- ROS2 Parameter Definitions ---
        self.declare_parameter('operating_mode', 'velocity')
        self.declare_parameter('kp', 0.75)
        self.declare_parameter('ki', 0.05)
        self.declare_parameter('kd', 0.2)

        # --- Hardware Configuration ---
        self.actuators = {
            "left":  {"roll": 1.0, "pitch": 2.0},
            "right": {"roll": 3.0, "pitch": 4.0}
        }
        self.all_ids = [1.0, 2.0, 3.0, 4.0]
        
        # Zero-point calibration offsets (Radians)
        self.OFFSETS = {
            self.actuators["left"]["roll"]:  3.60,
            self.actuators["left"]["pitch"]: 3.3,
            self.actuators["right"]["roll"]: 3.00,
            self.actuators["right"]["pitch"]: 3.42
        }   

        # --- PID Control State ---
        self.error_sum = {sid: 0.0 for sid in self.all_ids}
        self.last_error = {sid: 0.0 for sid in self.all_ids}
        self.prev_time = time.time()

        # --- Communication ---
        # SingleThreadedExecutor handles callbacks sequentially, removing the need for 
        # ReentrantCallbackGroups and preventing race conditions on 'start_time'.
        self.parity_queue = Queue(maxsize=1000) 
        
        # Publishers
        self.joint_pub = self.create_publisher(Float32MultiArray, 'joint_cmd', 1)
        self.telemetry_pub = self.create_publisher(Float32MultiArray, 'telemetry', 10)

        # Subscriptions
        # No callback_group assigned = defaults to the node's main execution group
        self.motion_sub = self.create_subscription(String, 'motion_cmd', self.motion_cb, 10)
        self.feedback_sub = self.create_subscription(Float32MultiArray, 'joint_feedback', self.feedback_cb, 10)

        # --- Motion State ---
        self.current_cmd_id = 0.0
        self.full_feedback = {sid: {"pos": 0.0, "vel": 0.0, "curr": 0.0, "volt": 0.0} for sid in self.all_ids}
        self.active_motions = {}
        self.is_moving = False
        self.total_duration = 0.0
        self.start_time = 0.0
        
        # Initialization Delay
        time.sleep(1.5)
        self.torque_enable()
        
        # --- High-Frequency Timers ---
        # Using 1kHz. In SingleThreaded, these will interleave precisely.
        self.control_timer = self.create_timer(0.001, self.update_motion_loop)
        self.telemetry_timer = self.create_timer(0.001, self.publish_telemetry)

    def feedback_cb(self, msg):
        """Unpacks hardware feedback. Runs sequentially between control loops."""
        for i in range(0, len(msg.data), 6):
            sid = msg.data[i]
            if sid in self.full_feedback:
                self.full_feedback[sid].update({
                    "pos":  msg.data[i+2], "vel":  msg.data[i+3],
                    "curr": msg.data[i+4], "volt": msg.data[i+5]
                })

    def motion_cb(self, msg):
        """Parses motion commands and resets start_time safely on the main thread."""
        try:
            parts = msg.data.lower().replace(' ', '').split(']')
            data = {p.split(':[')[0]: p.split(':[')[1].split(',') for p in parts if ':[' in p}
            
            self.current_cmd_id = float(data['cmd_id'][0])
            freq, cycles = float(data['freqs'][0]), float(data['cycles'][0])
            
            self.total_duration = cycles / freq
            self.start_time = time.time() # Reset clock for new motion
            self.active_motions = {side: {"func": data['motions'][i], "mode": float(data['modes'][i]), 
                                   "freq": freq, "amp": float(data['amps'][i])} 
                                   for i, side in enumerate(data['actuators'])}
            self.is_moving = True
            self.get_logger().info(f"New Motion Loaded: ID {self.current_cmd_id}")
        except Exception as e:
            self.get_logger().error(f"Failed to parse motion command: {e}")

    def update_motion_loop(self):
        """
        Primary Real-Time Task (Sequential).
        Updates trajectory and executes PID control step.
        """
        now = time.time()
        dt = now - self.prev_time
        self.prev_time = now

        goals = {sid: 0.0 for sid in self.all_ids}
        target_modes = {sid: 3.0 for sid in self.all_ids}
        
        mode_setting = self.get_parameter('operating_mode').value
        kp, ki, kd = self.get_parameter('kp').value, self.get_parameter('ki').value, self.get_parameter('kd').value

        # --- Trajectory Step ---
        if self.is_moving:
            elapsed = time.time() - self.start_time
            if elapsed < self.total_duration:
                for side, p in self.active_motions.items():
                    res = getattr(self, p["func"])(elapsed, p["freq"], p["amp"])
                    goals[self.actuators[side]["roll"]] = res["roll"]
                    goals[self.actuators[side]["pitch"]] = res["pitch"]
                    target_modes[self.actuators[side]["roll"]] = p["mode"]
                    target_modes[self.actuators[side]["pitch"]] = p["mode"]
                self.get_logger().info(f'time: {elapsed}')
            else:
                self.is_moving = False 

        ids = sorted(goals.keys())
        final_cmd_values = []
        
        # --- PID Loop per Actuator ---
        for sid in ids:
            actual_pos = self.full_feedback[sid]["pos"]
            ideal_goal = goals[sid]
            error = ideal_goal - actual_pos

            self.error_sum[sid] += error * dt 
            d_error = (error - self.last_error[sid]) / dt if dt > 0 else 0.0 
            self.last_error[sid] = error
            
            effort = (kp * error) + (ki * self.error_sum[sid]) + (kd * d_error)

            if mode_setting == 'position':
                target_modes[sid] = 3.0
                final_cmd_values.append(ideal_goal + effort + self.OFFSETS.get(sid, 0.0))
            else:
                target_modes[sid] = 1.0
                final_cmd_values.append(effort)

        # Dispatch MultiArray
        cmd_msg = Float32MultiArray()
        cmd_msg.data = [float(sid) for sid in ids] + [target_modes[sid] for sid in ids] + final_cmd_values
        self.joint_pub.publish(cmd_msg)

        # Buffer data for telemetry
        if not self.parity_queue.full():
            self.parity_queue.put({
                "cmd_id": self.current_cmd_id, "ts": now,
                "goals": goals, "feedback": {k: v.copy() for k, v in self.full_feedback.items()}
            })

    def publish_telemetry(self):
        """Flushes parity queue. In Single-Threaded, this runs safely between control steps."""
        if self.parity_queue.empty(): return
        data = self.parity_queue.get()
        telem_msg = Float32MultiArray()
        telem_data = [data["cmd_id"], data["ts"]]
        for sid in sorted(self.all_ids):
            f = data["feedback"][sid]
            telem_data.extend([data["goals"][sid], f["pos"], f["vel"], f["curr"], f["volt"]])
        telem_msg.data = telem_data
        self.telemetry_pub.publish(telem_msg)

    # --- Sine Wave Primitive Library ---
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
    
    # Using SingleThreadedExecutor to eliminate time-jitter and race conditions
    executor = SingleThreadedExecutor()
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