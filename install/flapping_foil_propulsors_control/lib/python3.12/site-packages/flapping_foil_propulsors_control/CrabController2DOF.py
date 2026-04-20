import rclpy
from rclpy.node import Node
from rclpy.executors import MultiThreadedExecutor
from rclpy.callback_groups import ReentrantCallbackGroup
from std_msgs.msg import Float32MultiArray, String
import time
import math
from queue import Queue

class CrabController2DOF(Node):
    """
    High-level motion engine for a 2DOF actuators.
    Handles trajectory generation (Sine waves) and Closed-Loop PID control.
    Supports both Position-Offset PID and Direct Velocity PID via ROS2 parameters.
    """
    def __init__(self):
        super().__init__('crab_motion_engine')
        
        # --- ROS2 Parameter Definitions ---
        # Allows tuning without recompilation. 
        # operating_mode: 'position' targets Mode 3 (Position), 'velocity' targets Mode 1 (Velocity).
        self.declare_parameter('operating_mode', 'velocity')
        self.declare_parameter('kp', 0.75)  # Proportional Gain
        self.declare_parameter('ki', 0.05) # Integral Gain
        self.declare_parameter('kd', 0.2)  # Derivative Gain

        # --- Hardware Configuration ---
        #Nested dictionary that maps actuators and servos to values
        self.actuators = {
            "left":  {"roll": 1.0, "pitch": 2.0},
            "right": {"roll": 3.0, "pitch": 4.0}
        }
        self.all_ids = [1.0, 2.0, 3.0, 4.0] #Active IDs of servos 
        
        # Zero-point calibration offsets (Radians)
        self.OFFSETS = {
            self.actuators["left"]["roll"]:  3.60,
            self.actuators["left"]["pitch"]: 3.3,
            self.actuators["right"]["roll"]: 3.00,
            self.actuators["right"]["pitch"]: 3.42
        }   

        # --- PID Control State ---
        # Track history per-actuator to compute I and D terms
        self.error_sum = {sid: 0.0 for sid in self.all_ids}
        self.last_error = {sid: 0.0 for sid in self.all_ids}
        self.prev_time = time.time()

        # --- Communication & Concurrency ---
        self.cb_group = ReentrantCallbackGroup() # Allows callbacks to run in parallel
        self.parity_queue = Queue(maxsize=1000)  # Thread-safe buffer for telemetry sync
        
        # Publishers
        self.joint_pub = self.create_publisher(Float32MultiArray, 'joint_cmd', 1)
        self.telemetry_pub = self.create_publisher(Float32MultiArray, 'telemetry', 10)

        # Subscriptions
        self.motion_sub = self.create_subscription(String, 'motion_cmd', self.motion_cb, 10, callback_group=self.cb_group)
        self.feedback_sub = self.create_subscription(Float32MultiArray, 'joint_feedback', self.feedback_cb, 10, callback_group=self.cb_group)

        # --- Motion State ---
        self.current_cmd_id = 0.0
        self.full_feedback = {sid: {"pos": 0.0, "vel": 0.0, "curr": 0.0, "volt": 0.0} for sid in self.all_ids}
        self.active_motions = {}
        self.is_moving = False
        self.total_duration = 0.0
        self.start_time = 0.0
        
        # Initialization Delay to ensure interface is ready
        time.sleep(1.5)
        self.torque_enable()
        
        # --- High-Frequency Timers ---
        # Control Loop: 1kHz (1ms) for smooth motion and stable PID
        self.control_timer = self.create_timer(0.001, self.update_motion_loop, callback_group=self.cb_group)
        self.telemetry_timer = self.create_timer(0.001, self.publish_telemetry, callback_group=self.cb_group)

    def feedback_cb(self, msg):
        """Unpacks hardware feedback into state dictionary for PID processing."""
        for i in range(0, len(msg.data), 6):
            sid = msg.data[i]
            if sid in self.full_feedback:
                self.full_feedback[sid].update({
                    "pos":  msg.data[i+2], "vel":  msg.data[i+3],
                    "curr": msg.data[i+4], "volt": msg.data[i+5]
                })

    def motion_cb(self, msg):
        """Parses high-level string commands into mathematical trajectory parameters."""
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
            self.get_logger().error(f"Failed to parse motion command: {e}")

    def update_motion_loop(self):
        """
        Primary Real-Time Task.
        1. Calculates 'Ideal' position from sine function.
        2. Computes Error between 'Ideal' and 'Actual' (feedback).
        3. Applies PID logic to generate a correction.
        4. Dispatches refined command to the hardware interface.
        """
        now = time.time()
        dt = now - self.prev_time
        self.prev_time = now

        # Default state (stationary)
        goals = {sid: 0.0 for sid in self.all_ids}
        target_modes = {sid: 3.0 for sid in self.all_ids}
        
        # Dynamic parameter sync
        mode_setting = self.get_parameter('operating_mode').value
        kp, ki, kd = self.get_parameter('kp').value, self.get_parameter('ki').value, self.get_parameter('kd').value

        # --- Trajectory Step ---
        if self.is_moving:
            elapsed = time.time() - self.start_time
            if elapsed < self.total_duration:
                for side, p in self.active_motions.items():
                    # Generate roll/pitch positions for the current millisecond
                    res = getattr(self, p["func"])(elapsed, p["freq"], p["amp"])
                    goals[self.actuators[side]["roll"]] = res["roll"]
                    goals[self.actuators[side]["pitch"]] = res["pitch"]
                    target_modes[self.actuators[side]["roll"]] = p["mode"]
                    target_modes[self.actuators[side]["pitch"]] = p["mode"]
                self.get_logger().info(f'time: {elapsed}')
            else:
                self.is_moving = False # Sequence complete

        ids = sorted(goals.keys())
        final_cmd_values = []
        
        # --- PID Loop per Actuator ---
        for sid in ids:
            actual_pos = self.full_feedback[sid]["pos"]
            ideal_goal = goals[sid]
            error = ideal_goal - actual_pos

            # Compute PID components
            self.error_sum[sid] += error * dt # Integral
            d_error = (error - self.last_error[sid]) / dt if dt > 0 else 0.0 # Derivative
            self.last_error[sid] = error
            
            # Sum terms for raw control effort
            effort = (kp * error) + (ki * self.error_sum[sid]) + (kd * d_error)

            if mode_setting == 'position':
                # Position Offset Control: Use PID to 'lead' the trajectory for better tracking
                target_modes[sid] = 3.0
                final_cmd_values.append(ideal_goal + effort + self.OFFSETS.get(sid, 0.0))
            else:
                # Direct Velocity Control: PID output is Rad/s
                target_modes[sid] = 1.0
                final_cmd_values.append(effort)

        # Dispatch MultiArray: [IDs][Modes][Values]
        cmd_msg = Float32MultiArray()
        cmd_msg.data = [float(sid) for sid in ids] + [target_modes[sid] for sid in ids] + final_cmd_values
        self.joint_pub.publish(cmd_msg)

        # Buffer data for telemetry publisher
        if not self.parity_queue.full():
            self.parity_queue.put({
                "cmd_id": self.current_cmd_id, "ts": now,
                "goals": goals, "feedback": {k: v.copy() for k, v in self.full_feedback.items()}
            })

    def publish_telemetry(self):
        """Asynchronously flushes the parity queue to the telemetry topic for logging/analysis."""
        if self.parity_queue.empty(): return
        data = self.parity_queue.get()
        telem_msg = Float32MultiArray()
        telem_data = [data["cmd_id"], data["ts"]]
        for sid in sorted(self.all_ids):
            f = data["feedback"][sid]
            # Pack Format: Goal, ActualPos, ActualVel, Current, Voltage
            telem_data.extend([data["goals"][sid], f["pos"], f["vel"], f["curr"], f["volt"]])
        telem_msg.data = telem_data
        self.telemetry_pub.publish(telem_msg)

    # --- Sine Wave Primitive Library ---
    # These functions define the fundamental flipper motion patterns
    
    def forward_paddle(self, t, f, a):
        """Paddling stroke with elliptical-like recovery."""
        theta = 2 * math.pi * f * t
        return {"roll": 1.5708 * math.sin(theta + (math.pi/2)), "pitch": a * math.sin(theta)}
    
    def backward_paddle(self, t, f, a):
        """Reverse paddling stroke."""
        theta = 2 * math.pi * f * t
        return {"roll": 1.5708 * math.sin(theta - (math.pi/2)), "pitch": a * math.sin(theta)}

    def forward_flap(self, t, f, a):  return {"roll": 1.5708, "pitch": a * math.sin(2 * math.pi * f * t)}
    def backward_flap(self, t, f, a): return {"roll": -1.5708, "pitch": a * math.sin(2 * math.pi * f * t + math.pi)}
    def up_flap(self, t, f, a):       return {"roll": 0.0, "pitch": a * math.sin(2 * math.pi * f * t)}
    def down_flap(self, t, f, a):     return {"roll": 0.0, "pitch": a * math.sin(2 * math.pi * f * t + math.pi)}

    def torque_enable(self):
        """Sends broadcast signal to lock all motors into active control."""
        msg = Float32MultiArray()
        msg.data = [1.0, 2.0, 3.0, 4.0] + [-1.0]*4 + [0.0]*4
        self.joint_pub.publish(msg)

    def destroy_node(self):
        """Safe shutdown: Release torque to prevent motor strain."""
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
    except KeyboardInterrupt: pass
    finally:
        node.destroy_node()
        rclpy.shutdown()

if __name__ == '__main__':
    main()