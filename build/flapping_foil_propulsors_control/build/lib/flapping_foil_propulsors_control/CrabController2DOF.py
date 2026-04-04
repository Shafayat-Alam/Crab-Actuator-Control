import rclpy
from rclpy.node import Node
from std_msgs.msg import Float32MultiArray, String
import time
import math

class CrabController2DOF(Node):
    def __init__(self):
        super().__init__('crab_motion_engine')
        
        self.actuators = {
            "left":  {"roll": 1.0, "pitch": 2.0},
            "right": {"roll": 3.0, "pitch": 4.0}
        }
        self.all_ids = [1.0, 2.0, 3.0, 4.0]
        self.OFFSETS = {1.0: 3.65, 2.0: 3.3, 3.0: 2.95, 4.0: 1.86}
        self.LIMITS = {"min": 0.0, "max": 5.2}

        # --- Publishers ---
        self.joint_pub = self.create_publisher(Float32MultiArray, 'joint_cmd', 10)
        self.telemetry_pub = self.create_publisher(Float32MultiArray, 'telemetry', 10)
        
        # --- Subscriptions ---
        self.motion_sub = self.create_subscription(String, 'motion_cmd', self.motion_cb, 10)
        # Assuming your driver publishes actual encoder positions here:
        self.feedback_sub = self.create_subscription(Float32MultiArray, 'joint_feedback', self.feedback_cb, 10)

        # --- State ---
        self.current_cmd_id = 0.0
        self.actual_positions = {id: 0.0 for id in self.all_ids}
        self.active_motions = {}
        self.is_moving = False
        self.total_duration = 0.0
        self.start_time = 0.0

        time.sleep(1.5)
        self.torque_enable()
        self.timer = self.create_timer(0.05, self.update_motion_loop)

    def feedback_cb(self, msg):
        # Expecting msg.data as [ID1, Pos1, ID2, Pos2...]
        for i in range(0, len(msg.data), 2):
            self.actual_positions[msg.data[i]] = msg.data[i+1]

    def motion_cb(self, msg):
        try:
            parts = msg.data.lower().replace(' ', '').split(']')
            data = {p.split(':[')[0]: p.split(':[')[1].split(',') for p in parts if ':[' in p}
            
            self.current_cmd_id = float(data['cmd_id'][0])
            freq = float(data['freqs'][0])
            cycles = float(data['cycles'][0])
            
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

        self.send_and_log(goals, modes, elapsed)

    def send_and_log(self, goals, modes, elapsed):
        msg = Float32MultiArray()
        telem_msg = Float32MultiArray()
        ids = sorted(goals.keys())
        
        final_goals = []
        telem_data = [self.current_cmd_id, time.time()] # Cmd#, Timestamp

        for idx in ids:
            # Command Calculation
            phys_cmd = goals[idx] + self.OFFSETS.get(idx, 0.0)
            safe_cmd = max(self.LIMITS["min"], min(self.LIMITS["max"], phys_cmd))
            final_goals.append(safe_cmd)
            
            # Pack Telemetry: [Mode, Cmd_Pos, Actual_Pos]
            telem_data.extend([modes[idx], safe_cmd, self.actual_positions[idx]])

        # Send to Motors
        msg.data = [float(idx) for idx in ids] + [modes[idx] for idx in ids] + final_goals
        self.joint_pub.publish(msg)
        
        # Send to ROS Bag (Telemetry)
        telem_msg.data = telem_data
        self.telemetry_pub.publish(telem_msg)

    # --- Library Functions ---
    def forward_paddle(self, t, freq, amp):
        theta = 2 * math.pi * freq * t
        return {"roll": 1.5708 * math.sin(theta + (math.pi/2)), "pitch": amp * math.sin(theta)}
    
    def backward_paddle(self, t, freq, amp):
        theta = 2 * math.pi * freq * t
        return {"roll": 1.5708 * math.sin(theta - (math.pi/2)), "pitch": amp * math.sin(theta)}

    def forward_flap(self, t, freq, amp):
        return {"roll": 1.5708, "pitch": amp * math.sin(2 * math.pi * freq * t)}

    def backward_flap(self, t, freq, amp):
        return {"roll": -1.5708, "pitch": amp * math.sin(2 * math.pi * freq * t + math.pi)}

    def torque_enable(self):
        msg = Float32MultiArray()
        msg.data = [1.0, 2.0, 3.0, 4.0, -1.0, -1.0, -1.0, -1.0, 0.0, 0.0, 0.0, 0.0]
        self.joint_pub.publish(msg)

def main(args=None):
    rclpy.init(args=args)
    rclpy.spin(CrabController2DOF())
    rclpy.shutdown()

if __name__ == '__main__':
    main()