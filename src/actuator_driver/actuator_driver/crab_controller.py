"""
import rclpy
from rclpy.node import Node
from std_msgs.msg import Float32MultiArray
import csv
import time

class CrabController(Node):
    def __init__(self):
        super().__init__('crab_motion_engine')
        
        # --- ROS Communication ---
        self.joint_pub = self.create_publisher(Float32MultiArray, 'joint_cmd', 10)
        self.motion_sub = self.create_subscription(Float32MultiArray, 'motion_cmd', self.motion_cb, 10)
        self.feedback_sub = self.create_subscription(Float32MultiArray, 'joint_feedback', self.feedback_cb, 10)

        self.get_logger().info("Controller Online.")

        # --- Constants & State ---
        self.active_ids = [1.0, 2.0, 3.0, 4.0]
        self.current_feedback = [0.0] * 4
        self.current_mode = 3.0
    
    def destroy_node(self):
        self.csv_file.close()
        super().destroy_node()

def main(args=None):
    rclpy.init(args=args)
    node = CrabController()
    try:
        rclpy.spin(node)
    except KeyboardInterrupt:
        pass
    finally:
        node.destroy_node()
        if rclpy.ok():
            rclpy.shutdown()

if __name__ == '__main__':
    main()
"""
import rclpy
from rclpy.node import Node
from std_msgs.msg import Float32MultiArray, String
import csv
import time
import math

class CrabController(Node):
    def __init__(self):
        super().__init__('crab_motion_engine')
        
        # --- Actuator Mapping ---
        # Left: 1 (Roll), 2 (Pitch) | Right: 3 (Roll), 4 (Pitch)
        self.actuators = {
            "left":  {"roll": 1.0, "pitch": 2.0},
            "right": {"roll": 3.0, "pitch": 4.0}
        }
        self.all_ids = [1.0, 2.0, 3.0, 4.0]

        # --- ROS & Logging ---
        self.joint_pub = self.create_publisher(Float32MultiArray, 'joint_cmd', 10)
        self.motion_sub = self.create_subscription(String, 'motion_cmd', self.motion_cb, 10)
        self.feedback_sub = self.create_subscription(Float32MultiArray, 'joint_feedback', self.feedback_cb, 10)
        
        self.csv_file = open(f"crab_log_{int(time.time())}.csv", mode='w', newline='')
        self.csv_writer = csv.writer(self.csv_file)
        self.csv_writer.writerow(['ts', 'cmd_idx', 'id', 'mode', 'goal', 'actual'])

        # --- State & Failsafes ---
        self.command_count = 0
        self.LIMITS = {"min": -1.57, "max": 1.57} # Radian limits
        self.current_goals = {id: 0.0 for id in self.all_ids}
        self.current_modes = {id: 3.0 for id in self.all_ids}
        
        self.active_motions = {} # Side -> Params
        self.timer = self.create_timer(0.05, self.update_motion_loop) # 20Hz Heartbeat

    # =========================================================================
    # MOTION LIBRARY
    # =========================================================================

    def forward_flap(self, t, freq, amp):
        """Standard vertical flapping."""
        val = amp * math.sin(2 * math.pi * freq * t)
        return {"roll": val, "pitch": 0.0}

    def backward_flap(self, t, freq, amp):
        """Reverse flapping logic."""
        val = amp * math.sin(2 * math.pi * freq * t)
        return {"roll": -val, "pitch": 0.0}

    def forward_gait(self, t, freq, amp):

        """90-degree phase shift between Roll and Pitch."""
        roll_val = amp * math.sin(2 * math.pi * freq * t)
        pitch_val = amp * math.cos(2 * math.pi * freq * t)
        return {"roll": roll_val, "pitch": pitch_val}

    def calibration(self, t, freq, amp):
        """Zero out the actuator."""
        return {"roll": 0.0, "pitch": 0.0}

    # =========================================================================
    # SYSTEM LOGIC
    # =========================================================================

    def motion_cb(self, msg):
        """Parser: actuators:[l,r] motions:[f,b] modes:[3,3] freqs:[1,1] amps:[0.5,0.5]"""
        try:
            self.command_count += 1
            parts = msg.data.lower().replace(' ', '').split(']')
            data = {p.split(':[')[0]: p.split(':[')[1].split(',') for p in parts if ':[' in p}

            new_motions = {}
            for i, side in enumerate(data['actuators']):
                new_motions[side] = {
                    "func": data['motions'][i],
                    "mode": float(data['modes'][i]),
                    "freq": float(data['freqs'][i]),
                    "amp":  float(data['amps'][i]),
                    "start_t": time.time()
                }
            self.active_motions = new_motions
        except Exception as e:
            self.get_logger().error(f"Command Error: {e}")

    def update_motion_loop(self):
        if not self.active_motions: return
        
        goals = self.current_goals.copy()
        modes = self.current_modes.copy()

        for side, p in self.active_motions.items():
            t = time.time() - p["start_t"]
            
            # MODULE DYNAMICS: This looks for the function by name string
            if hasattr(self, p["func"]):
                motion_func = getattr(self, p["func"])
                result = motion_func(t, p["freq"], p["amp"]) # Calls the specific motion
                
                # Map results to specific Servo IDs
                goals[self.actuators[side]["roll"]] = result["roll"]
                goals[self.actuators[side]["pitch"]] = result["pitch"]
                modes[self.actuators[side]["roll"]] = p["mode"]
                modes[self.actuators[side]["pitch"]] = p["mode"]

        self.send_to_actuator(goals, modes)

    def send_to_actuator(self, goals, modes):
        msg = Float32MultiArray()
        ids = sorted(goals.keys())
        safe_goals = [max(self.LIMITS["min"], min(self.LIMITS["max"], goals[idx])) for idx in ids]
        msg.data = ids + [modes[idx] for idx in ids] + safe_goals
        self.joint_pub.publish(msg)
        self.current_goals = goals

    def feedback_cb(self, msg):
        ts = time.time()
        for i, val in enumerate(msg.data):
            sid = self.all_ids[i]
            self.csv_writer.writerow([ts, self.command_count, sid, self.current_modes[sid], self.current_goals[sid], val])
        self.csv_file.flush()

    def destroy_node(self):
        self.csv_file.close()
        super().destroy_node()

def main(args=None):
    rclpy.init(args=args)
    node = CrabController()
    try:
        rclpy.spin(node)
    except KeyboardInterrupt:
        pass
    finally:
        if rclpy.ok():
            node.destroy_node()
            rclpy.shutdown()

if __name__ == '__main__':
    main()