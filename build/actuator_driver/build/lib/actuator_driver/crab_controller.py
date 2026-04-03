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

        # --- Physical Calibration Offsets ---
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

    def forward_flap(self, t, freq, amp):
        """
        Roll: Rotates +90 degrees (1.5708 rad) from calibration.
        Pitch: Flaps at the provided frequency and amplitude (radians).
        """
        # 1. Roll shift (Fixed at +90 degrees relative to offset)
        target_roll = 1.5708 
        
        # 2. Pitch Flap (Oscillates around the calibration offset)
        target_pitch = amp * math.sin(2 * math.pi * freq * t)
        
        return {"roll": target_roll, "pitch": target_pitch}
    
    def backward_flap(self, t, freq, amp):
        """
        Roll: Rotates -90 degrees (-1.5708 rad) from calibration.
        Pitch: Flaps with a 180-degree phase shift relative to forward_flap.
        """
        # 1. Roll shift (-90 degrees relative to offset)
        target_roll = -1.5708 
        
        # 2. Pitch Flap (Reversed phase)
        target_pitch = amp * math.sin(2 * math.pi * freq * t + math.pi)
        
        return {"roll": target_roll, "pitch": target_pitch}

    def forward_paddle(self, t, freq, amp):
        """
        Phase 1: Pitch 0 -> +Amp | Roll 0 -> +90
        Phase 2: Pitch +Amp -> -Amp | Roll HOLD +90
        Phase 3: Pitch -Amp -> 0 | Roll +90 -> 0
        """
        # Master clock (0 to 2*pi)
        theta = (2 * math.pi * freq * t) % (2 * math.pi)
        
        # 1. Pitch: Standard Continuous Flap
        target_pitch = amp * math.sin(theta)
        
        # 2. Roll: Custom Phased Sweep
        # We want Roll to reach 90 degrees exactly when Pitch hits +Amp (at pi/2)
        # and stay there until Pitch hits -Amp (at 3pi/2).
        
        if theta <= 0.5 * math.pi:
            # Phase 1: Rolling up to 90 as pitch flaps up
            target_roll = 1.5708 * math.sin(theta * 1.0) 
        elif theta <= 1.5 * math.pi:
            # Phase 2: Pitch is doing its full swing; Roll HOLDS +90
            target_roll = 1.5708
        else:
            # Phase 3: Pitch returning to 0; Roll sweeps back to 0
            # We map (1.5pi to 2pi) back to a (pi/2 to 0) range
            transition_theta = theta - math.pi # Shifting to align the curve
            target_roll = 1.5708 * math.sin(transition_theta)

        return {"roll": target_roll, "pitch": target_pitch}

    def backward_paddle(self, t, freq, amp):
        """
        Phase 1: Pitch 0 -> +Amp | Roll 0 -> -90
        Phase 2: Pitch +Amp -> -Amp | Roll HOLD -90
        Phase 3: Pitch -Amp -> 0 | Roll -90 -> 0
        """
        # Master clock (0 to 2*pi)
        theta = (2 * math.pi * freq * t) % (2 * math.pi)
        
        # 1. Pitch: Continuous 'Nice Flap' (Matches Forward Timing)
        target_pitch = amp * math.sin(theta)
        
        # 2. Roll: Custom Phased Sweep (Mirrored to -1.5708)
        if theta <= 0.5 * math.pi:
            # Phase 1: Sweeping back to -90
            target_roll = -1.5708 * math.sin(theta)
        elif theta <= 1.5 * math.pi:
            # Phase 2: Pitch is flapping; Roll HOLDS at the rear (-90)
            target_roll = -1.5708
        else:
            # Phase 3: Pitch returning to neutral; Roll resets to 0
            transition_theta = theta - math.pi
            target_roll = -1.5708 * math.sin(transition_theta)

        return {"roll": target_roll, "pitch": target_pitch}

    # =========================================================================
    # SYSTEM LOGIC
    # =========================================================================

    def torque_enable(self):
        msg = Float32MultiArray()
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
    """
    def update_motion_loop(self):
    if not self.active_motions: return
    
    # We will send a "burst" of the next 10 points (50ms of motion at 5ms intervals)
    msg = Float32MultiArray()
    packet = []
    
    # Header: [ID1, ID2, ID3, ID4, Mode1, Mode2, Mode3, Mode4]
    # Followed by: [Goal_t1_ID1, Goal_t1_ID2...]
    
    for step in range(10): # 10 future points
        lookahead_t = (time.time() - self.start_t) + (step * 0.005) 
        for side, p in self.active_motions.items():
            res = self.motion_func(lookahead_t, p["freq"], p["amp"])
            # Apply offsets and append to packet
            packet.append(res["roll"] + self.OFFSETS[roll_id])
            packet.append(res["pitch"] + self.OFFSETS[pitch_id])
            
    msg.data = header + packet
    self.joint_pub.publish(msg)
    """
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