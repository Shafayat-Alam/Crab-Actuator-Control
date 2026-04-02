import rclpy
from rclpy.node import Node
from std_msgs.msg import Float32MultiArray, String
import time
import math

class CrabController(Node):
    def __init__(self):
        super().__init__('crab_motion_engine')
        
        # --- Actuator Mapping ---
        self.actuators = {
            "left":  {"roll": 1.0, "pitch": 2.0},
            "right": {"roll": 3.0, "pitch": 4.0}
        }
        self.all_ids = [1.0, 2.0, 3.0, 4.0]

        # --- Physical Calibration Offsets (From your image) ---
        self.OFFSETS = {
            1.0: 3.65, # servo1
            2.0: 3.3,  # servo2
            3.0: 2.95, # servo3
            4.0: 1.86  # servo4
        }

        # --- ROS & Logging ---
        self.joint_pub = self.create_publisher(Float32MultiArray, 'joint_cmd', 10)
        
        # 1. Torque Lock on Startup
        self.get_logger().info("Waiting for hardware discovery...")
        time.sleep(1.5)
        self.torque_enable()

        # 2. Subscriptions
        self.motion_sub = self.create_subscription(String, 'motion_cmd', self.motion_cb, 10)
        
        # --- State & Failsafes ---
        self.command_count = 0
        # Limits expanded to allow for the hardware offsets (approx 1.57 rad swing around offset)
        self.LIMITS = {"min": 0.0, "max": 5.2} 
        
        self.current_goals = {id: 0.0 for id in self.all_ids}
        self.current_modes = {id: 3.0 for id in self.all_ids}
        
        self.active_motions = {} # Side -> Params
        self.timer = self.create_timer(0.05, self.update_motion_loop) # 20Hz Heartbeat

    # =========================================================================
    # MOTION LIBRARY
    # =========================================================================

    def calibration(self, t, freq, amp):
        """Zero out the actuator relative to the physical offsets."""
        return {"roll": 0.0, "pitch": 0.0}

    # =========================================================================
    # SYSTEM LOGIC
    # =========================================================================

    def torque_enable(self):
        msg = Float32MultiArray()
        # Note: Torque enable ignores goals, so we don't need offsets here
        msg.data = [
            1.0, 2.0, 3.0, 4.0,    # IDs
            -1.0, -1.0, -1.0, -1.0, # Torque-Only Flags
            0.0, 0.0, 0.0, 0.0      # Dummy Goals
        ]
        self.joint_pub.publish(msg)
        self.get_logger().info("Startup: Torque Locked.")

    def motion_cb(self, msg):
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
            self.get_logger().info(f"New Motion Loaded: {data['motions']}")
        except Exception as e:
            self.get_logger().error(f"Command Error: {e}")

    def update_motion_loop(self):
        if not self.active_motions: return
        
        goals = self.current_goals.copy()
        modes = self.current_modes.copy()

        for side, p in self.active_motions.items():
            t = time.time() - p["start_t"]
            
            if hasattr(self, p["func"]):
                motion_func = getattr(self, p["func"])
                result = motion_func(t, p["freq"], p["amp"])
                
                goals[self.actuators[side]["roll"]] = result["roll"]
                goals[self.actuators[side]["pitch"]] = result["pitch"]
                modes[self.actuators[side]["roll"]] = p["mode"]
                modes[self.actuators[side]["pitch"]] = p["mode"]

        self.send_to_actuator(goals, modes)

    def send_to_actuator(self, goals, modes):
        msg = Float32MultiArray()
        ids = sorted(goals.keys())
        
        # APPLY OFFSETS HERE: Physical Pos = Goal + Calibration Offset
        final_goals = []
        for idx in ids:
            # Shift the logical goal (0.0) to the physical offset (3.65, etc)
            physical_pos = goals[idx] + self.OFFSETS.get(idx, 0.0)
            # Apply safety limits
            safe_pos = max(self.LIMITS["min"], min(self.LIMITS["max"], physical_pos))
            final_goals.append(safe_pos)
        
        # Order: [IDs] + [Modes] + [Goals]
        msg.data = [float(idx) for idx in ids] + [modes[idx] for idx in ids] + final_goals
        self.joint_pub.publish(msg)
        self.current_goals = goals
        self.current_modes = modes

    def destroy_node(self):
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