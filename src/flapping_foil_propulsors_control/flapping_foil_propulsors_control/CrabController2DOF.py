import rclpy
from rclpy.node import Node
from rclpy.executors import SingleThreadedExecutor
from std_msgs.msg import Float32MultiArray, String
import time
import math
from queue import Queue

class PIDController:
    """
    Standard Parallel PID implementation for individual joint control.
    Encapsulates state to prevent cross-talk between actuators.
    """
    def __init__(self, kp, ki, kd):
        self.kp, self.ki, self.kd = kp, ki, kd
        self.error_sum = 0.0
        self.last_error = 0.0

    def update(self, error, dt):
        """Computes control effort based on instantaneous error and time delta."""
        self.error_sum += error * dt
        d_error = (error - self.last_error) / dt if dt > 0 else 0.0
        self.last_error = error
        return (self.kp * error) + (self.ki * self.error_sum) + (self.kd * d_error)

    def reset(self):
        """Zeroes integral and derivative terms to prevent windup on motion transitions."""
        self.error_sum = 0.0
        self.last_error = 0.0

class CrabController2DOF(Node):
    """
    Main Motion Engine for 2DOF Bio-inspired locomotion.
    Handles trajectory generation, PID closed-loop control, and telemetry buffering.
    """
    def __init__(self):
        super().__init__('crab_motion_engine')
        
        # --- Parameter Declaration ---
        self.declare_parameter('operating_mode', 'velocity')
        self.declare_parameter('kp', 0.75)
        self.declare_parameter('ki', 0.05)
        self.declare_parameter('kd', 0.2)

        # --- Hardware Mapping & Calibration ---
        # Servo IDs and zero-offsets
        self.actuators = {
            "left":  {"roll": {"id": 1.0, "offset": 3.60}, "pitch": {"id": 2.0, "offset": 3.30}},
            "right": {"roll": {"id": 3.0, "offset": 3.00}, "pitch": {"id": 4.0, "offset": 3.42}}
        }

        self.all_ids = []
        self.OFFSETS = {}
        self.id_map = {} 

        # Build dynamic lookup tables for runtime efficiency
        for side, joints in self.actuators.items():
            self.id_map[side] = {}
            for joint, config in joints.items():
                sid = config["id"]
                self.all_ids.append(sid)
                self.OFFSETS[sid] = config["offset"]
                self.id_map[side][joint] = sid

        # Initialize PID controllers for each discovered ID
        kp, ki, kd = [self.get_parameter(n).value for n in ['kp', 'ki', 'kd']]
        self.pids = {sid: PIDController(kp, ki, kd) for sid in self.all_ids}

        # --- ROS Communication Infrastructure ---
        self.parity_queue = Queue(maxsize=1000)
        self.joint_pub = self.create_publisher(Float32MultiArray, 'joint_cmd', 1)
        self.telemetry_pub = self.create_publisher(Float32MultiArray, 'telemetry', 10)
        self.motion_sub = self.create_subscription(String, 'motion_cmd', self.motion_cb, 10)
        self.feedback_sub = self.create_subscription(Float32MultiArray, 'joint_feedback', self.feedback_cb, 10)

        # --- Control State Variables ---
        self.current_cmd_id = 0.0
        self.full_feedback = {sid: {"pos": 0.0, "vel": 0.0, "curr": 0.0, "volt": 0.0} for sid in self.all_ids}
        self.active_motions = {}
        self.is_moving = False
        self.total_duration = 0.0
        self.start_time = 0.0
        self.prev_time = time.time()
        
        # Hardware handshake delay
        time.sleep(1.5)
        self.torque_enable()
        
        # Deterministic timing loops
        self.control_timer = self.create_timer(0.0025, self.update_motion_loop) # 400Hz
        self.telemetry_timer = self.create_timer(0.0025, self.publish_telemetry)

    def broadcast_drive_cmd(self, ids, modes, values):
        """Helper to format and dispatch raw motor commands to the hardware interface."""
        msg = Float32MultiArray()
        msg.data = [float(sid) for sid in ids] + [float(m) for m in modes] + [float(v) for v in values]
        self.joint_pub.publish(msg)

    def feedback_cb(self, msg):
        """Unpacks high-frequency telemetry from the hardware interface."""
        for i in range(0, len(msg.data), 6):
            sid = msg.data[i]
            if sid in self.full_feedback:
                self.full_feedback[sid].update({
                    "pos": msg.data[i+2], "vel": msg.data[i+3],
                    "curr": msg.data[i+4], "volt": msg.data[i+5]
                })

    def motion_cb(self, msg):
        """Parses motion strings and initializes trajectory counters."""
        try:
            parts = msg.data.lower().replace(' ', '').split(']')
            data = {p.split(':[')[0]: p.split(':[')[1].split(',') for p in parts if ':[' in p}
            
            self.current_cmd_id = float(data['cmd_id'][0])
            freq, cycles = float(data['freqs'][0]), float(data['cycles'][0])
            
            self.total_duration = cycles / freq
            self.start_time = time.time()
            self.active_motions = {
                side: {
                    "func": data['motions'][i], 
                    "mode": float(data['modes'][i]), 
                    "freq": freq, 
                    "amp": float(data['amps'][i])
                } for i, side in enumerate(data['actuators'])
            }
            # Clear historical error to prevent jumping on new command
            for pid in self.pids.values(): pid.reset()
            self.is_moving = True
        except Exception as e:
            self.get_logger().error(f"Command Parse Failure: {e}")

    def update_motion_loop(self):
        """Primary real-time control thread. Generates setpoints and runs PID."""
        now = time.time()
        dt = now - self.prev_time
        self.prev_time = now

        goals = {sid: 0.0 for sid in self.all_ids}
        mode_param = self.get_parameter('operating_mode').value

        # Step 1: Trajectory Generation
        if self.is_moving:
            elapsed = now - self.start_time
            if elapsed < self.total_duration:
                for side, p in self.active_motions.items():
                    # Dynamic dispatch of primitive motion functions
                    res = getattr(self, p["func"])(elapsed, p["freq"], p["amp"])
                    goals[self.id_map[side]["roll"]] = res["roll"]
                    goals[self.id_map[side]["pitch"]] = res["pitch"]
            else:
                self.is_moving = False

        # Step 2: PID and Calibration Offset Application
        ids = sorted(self.all_ids)
        final_values, target_modes = [], []

        for sid in ids:
            effort = self.pids[sid].update(goals[sid] - self.full_feedback[sid]["pos"], dt)
            if mode_param == 'position':
                target_modes.append(3.0) # Hardware-level Position Control
                final_values.append(goals[sid] + effort + self.OFFSETS.get(sid, 0.0))
            else:
                target_modes.append(1.0) # Hardware-level Velocity Control
                final_values.append(effort)

        self.broadcast_drive_cmd(ids, target_modes, final_values)

        # Step 3: Buffer state for telemetry (non-blocking)
        if not self.parity_queue.full():
            self.parity_queue.put({
                "id": self.current_cmd_id, "ts": now, "goals": goals, 
                "fb": {k: v.copy() for k, v in self.full_feedback.items()}
            })

    def publish_telemetry(self):
        """Asynchronously flushes the state buffer to the telemetry topic."""
        if self.parity_queue.empty(): return
        d = self.parity_queue.get()
        msg = Float32MultiArray()
        payload = [d["id"], d["ts"]]
        for sid in sorted(self.all_ids):
            f = d["fb"][sid]
            payload.extend([d["goals"][sid], f["pos"], f["vel"], f["curr"], f["volt"]])
        msg.data = payload
        self.telemetry_pub.publish(msg)

    # --- Locomotion Primitives (Sine-based) ---
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
        """Commands hardware interface to lock motor shafts."""
        ids = sorted(self.all_ids)
        self.broadcast_drive_cmd(ids, [-1.0]*len(ids), [0.0]*len(ids))

    def destroy_node(self):
        """Safe shutdown: releases torque and zeroes goal states."""
        self.get_logger().info("Shutting down: Releasing torque...")
        ids = sorted(self.all_ids)
        self.broadcast_drive_cmd(ids, [0.0]*len(ids), [0.0]*len(ids))
        super().destroy_node()

def main(args=None):
    rclpy.init(args=args)
    node = CrabController2DOF()
    executor = SingleThreadedExecutor()
    executor.add_node(node)
    try:
        executor.spin()
    except KeyboardInterrupt: pass
    finally:
        node.destroy_node()
        rclpy.shutdown()

if __name__ == '__main__':
    main()