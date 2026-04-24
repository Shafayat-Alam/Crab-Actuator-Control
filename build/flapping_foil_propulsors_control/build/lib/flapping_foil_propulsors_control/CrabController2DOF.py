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
        self.declare_parameter('control_period', 0.002) # Default 500Hz
        self.declare_parameter('telemetry_period', 0.004) # Default 250Hz

        # Fetch timing values
        control_period = self.get_parameter('control_period').value
        telemetry_period = self.get_parameter('telemetry_period').value

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
        self.control_timer = self.create_timer(0.0025, self.update_motion_loop) #400Hz
        self.telemetry_timer = self.create_timer(0.025, self.publish_telemetry) 

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

    def torque_enable(self):
        """Commands hardware interface to lock motor shafts."""
        ids = sorted(self.all_ids)
        self.broadcast_drive_cmd(ids, [-1.0]*len(ids), [0.0]*len(ids))
    
    def calibration(self, t=0, f=0, a=0):
        """
        Standardized calibration gait. 
        Instead of touching hardware, we return a 'Safe' static position.
        """
        # Return all zeros (or whatever your neutral 'home' position is)
        # This keeps the logic consistent with your other gaits
        return {"roll": 0.0, "pitch": 0.0}

    # --- Locomotion Primitives (Sine-based) ---
    def forward_paddle(self, t, f, a):
        # What it does: Coordinates roll (90-degree shifted sine) and pitch (sine) for an elliptical stroke.
        # What it tests: Multi-axis coordination, peak torque during rowing, and thrust efficiency.
        theta = 2 * math.pi * f * t
        return {"roll": 1.5708 * math.sin(theta + (math.pi/2)), "pitch": a * math.sin(theta)}

    def backward_paddle(self, t, f, a):
        # What it does: Reverses the phase of the paddle trajectory.
        # What it tests: Symmetry of the hydrodynamic thrust and reverse-torque consistency.
        theta = 2 * math.pi * f * t
        return {"roll": 1.5708 * math.sin(theta - (math.pi/2)), "pitch": a * math.sin(theta)}

    def forward_flap(self, t, f, a):  
        # What it does: Locks roll at a 90-degree angle while oscillating pitch.
        # What it tests: Pure pitch authority at a fixed hydrodynamic offset.
        return {"roll": 1.5708, "pitch": a * math.sin(2 * math.pi * f * t)}

    def backward_flap(self, t, f, a): 
        # What it does: Locks roll at a -90-degree angle while oscillating pitch.
        # What it tests: Performance and load handling in the reverse orientation.
        return {"roll": -1.5708, "pitch": a * math.sin(2 * math.pi * f * t + math.pi)}

    def up_flap(self, t, f, a):       
        # What it does: Keeps roll neutral (0.0) while oscillating pitch.
        # What it tests: Vertical lift generation and vertical symmetry.
        return {"roll": 0.0, "pitch": a * math.sin(2 * math.pi * f * t)}

    def down_flap(self, t, f, a):     
        # What it does: Neutral roll with pitch oscillation starting in the opposite direction.
        # What it tests: Downward thrust capacity and response to inverted gravity/buoyancy loads.
        return {"roll": 0.0, "pitch": a * math.sin(2 * math.pi * f * t + math.pi)}

    # --- Locomotion Primitives (Sine-based) ---

    def left_roll_sine(self, t, f, a):
        # What it does: Oscillates only the roll axis with a sine wave.
        # What it tests: Single-axis roll bandwidth, current draw, and serial update speed.
        return {"roll": a * math.sin(2 * math.pi * f * t), "pitch": 0.0}

    def right_roll_sine(self, t, f, a):
        # What it does: Oscillates only the roll axis with a sine wave.
        # What it tests: Roll axis parity and performance consistency across flippers.
        return {"roll": a * math.sin(2 * math.pi * f * t), "pitch": 0.0}

    def left_pitch_sine(self, t, f, a):
        # What it does: Oscillates only the pitch axis with a sine wave.
        # What it tests: Single-axis pitch resolution and torque against water resistance.
        return {"roll": 0.0, "pitch": a * math.sin(2 * math.pi * f * t)}

    def right_pitch_sine(self, t, f, a):
        # What it does: Oscillates only the pitch axis with a sine wave.
        # What it tests: Pitch axis parity and performance consistency across flippers.
        return {"roll": 0.0, "pitch": a * math.sin(2 * math.pi * f * t)}

    def symmetric_roll_sine(self, t, f, a):
        # What it does: Synchronized sine oscillation of roll.
        # What it tests: Total power rail stability under simultaneous roll motor load.
        return {"roll": a * math.sin(2 * math.pi * f * t), "pitch": 0.0}

    def asymmetric_roll_sine(self, t, f, a):
        # What it does: Out-of-phase oscillation of the roll motors.
        # What it tests: Frame torsional stress and differential current draw.
        return {"roll": a * math.sin(2 * math.pi * f * t), "pitch": 0.0}

    def symmetric_pitch_sine(self, t, f, a):
        # What it does: Synchronized sine oscillation of pitch.
        # What it tests: Peak vertical current draw and pitch-sync precision.
        return {"roll": 0.0, "pitch": a * math.sin(2 * math.pi * f * t)}

    def asymmetric_pitch_sine(self, t, f, a):
        # What it does: Out-of-phase oscillation of the pitch motors.
        # What it tests: Chassis sculling/rotation stability and vibration coupling.
        return {"roll": 0.0, "pitch": a * math.sin(2 * math.pi * f * t)}

    def left_flipper_coupled(self, t, f, a):
        # What it does: Combines roll (cosine) and pitch (sine) on a single flipper.
        # What it tests: Intra-flipper mechanical interference and complex trajectory control.
        return {"roll": 0.5 * a * math.cos(2 * math.pi * f * t), "pitch": a * math.sin(2 * math.pi * f * t)}

    def right_flipper_coupled(self, t, f, a):
        # What it does: Combines roll (cosine) and pitch (sine) on a single flipper.
        # What it tests: Parity for complex elliptical tip paths.
        return {"roll": 0.5 * a * math.cos(2 * math.pi * f * t), "pitch": a * math.sin(2 * math.pi * f * t)}

    def diagonal_test_a(self, t, f, a):
        # What it does: Syncs roll and pitch across diagonal axes.
        # What it tests: Cross-chassis communication latency and electrical cross-talk.
        return {"roll": a * math.sin(2 * math.pi * f * t), "pitch": a * math.sin(2 * math.pi * f * t)}

    def diagonal_test_b(self, t, f, a):
        # What it does: Syncs roll and pitch across opposite diagonal axes.
        # What it tests: Reliability of the serial bus under non-standard motor pairs.
        return {"roll": a * math.sin(2 * math.pi * f * t), "pitch": a * math.sin(2 * math.pi * f * t)}

    def four_axis_quadrature(self, t, f, a):
        # What it does: Shifts phase sequentially between axes.
        # What it tests: Serial bus packet jitter and traveling wave propagation.
        return {"roll": a * math.sin(2 * math.pi * f * t), "pitch": a * math.sin(2 * math.pi * f * t + (math.pi / 2))}

    def reverse_quadrature(self, t, f, a):
        # What it does: Shifts phase sequentially in reverse order.
        # What it tests: Communication directionality and packet sequencing.
        return {"roll": a * math.sin(2 * math.pi * f * t + math.pi), "pitch": a * math.sin(2 * math.pi * f * t + (math.pi / 2))}

    def jumbled_quadrature(self, t, f, a):
        # What it does: Applies phase shifts in a non-sequential order.
        # What it tests: Power supply resilience against non-rhythmic torque spikes.
        return {"roll": a * math.sin(2 * math.pi * f * t), "pitch": a * math.sin(2 * math.pi * f * t + math.pi)}

    def cross_axis_opposition(self, t, f, a):
        # What it does: Syncs roll and pitch in opposite directions.
        # What it tests: Maximum structural stress on the central chassis spine.
        val = a * math.sin(2 * math.pi * f * t)
        return {"roll": val, "pitch": -val}

    def random_phase_noise(self, t, f, a):
        # What it does: Assigns unique non-repeating offsets to all axes.
        # What it tests: Control logic robustness under chaotic/non-symmetrical command streams.
        return {"roll": a * math.sin(2 * math.pi * f * t + 0.1), "pitch": a * math.sin(2 * math.pi * f * t + 2.3)}

    def butterfly_pitch_roll(self, t, f, a):
        # What it does: Mirrored complex oscillation across flippers.
        # What it tests: Mapping logic and CPU load during 3D transformations.
        val = a * math.sin(2 * math.pi * f * t)
        return {"roll": -val, "pitch": val}

    def left_pitch_square(self, t, f, a):
        # What it does: Instantaneous jumps between positive and negative pitch amplitude.
        # What it tests: PID settling time, overshoot, and pitch motor responsiveness.
        val = a if (int(2 * f * t) % 2 == 0) else -a
        return {"roll": 0.0, "pitch": val}

    def right_pitch_square(self, t, f, a):
        # What it does: Instantaneous jumps between positive and negative pitch amplitude.
        # What it tests: Pitch axis response parity.
        val = a if (int(2 * f * t) % 2 == 0) else -a
        return {"roll": 0.0, "pitch": val}

    def left_roll_square(self, t, f, a):
        # What it does: Instantaneous jumps between roll extremes.
        # What it tests: High-torque roll 'snap' and motor gear backlash.
        val = a if (int(2 * f * t) % 2 == 0) else -a
        return {"roll": val, "pitch": 0.0}

    def right_roll_square(self, t, f, a):
        # What it does: Instantaneous jumps between roll extremes.
        # What it tests: Roll axis response and backlash parity.
        val = a if (int(2 * f * t) % 2 == 0) else -a
        return {"roll": val, "pitch": 0.0}

    def symmetric_roll_square(self, t, f, a):
        # What it does: Simultaneous roll jumps on both sides.
        # What it tests: Peak current spike handling of the roll power rail.
        val = a if (int(2 * f * t) % 2 == 0) else -a
        return {"roll": val, "pitch": 0.0}

    def cross_axis_square_a(self, t, f, a):
        # What it does: Simultaneous snaps on different axis types (Roll and Pitch).
        # What it tests: Rail stability when mixed motors draw peak current.
        val = a if (int(2 * f * t) % 2 == 0) else -a
        return {"roll": val, "pitch": val}

    def cross_axis_square_b(self, t, f, a):
        # What it does: Opposing snaps on mixed axis types.
        # What it tests: Oppositional shock loading and voltage sag.
        val = a if (int(2 * f * t) % 2 == 0) else -a
        return {"roll": -val, "pitch": val}

    def all_axis_jumbled_square(self, t, f, a):
        # What it does: Jumps all motors into a star configuration extremes.
        # What it tests: Total bus bandwidth and maximum distributed torque.
        val = a if (int(2 * f * t) % 2 == 0) else -a
        return {"roll": val, "pitch": -val}

    def global_step_response(self, t, f, a):
        # What it does: Forces all servos to jump the full amplitude gap simultaneously.
        # What it tests: Absolute peak power draw and Back-EMF spike tolerance.
        val = a if (int(2 * f * t) % 2 == 0) else -a
        return {"roll": val, "pitch": val}

    def dual_power_stroke(self, t, f, a):
        # What it does: Uses a cubed sine wave for rapid acceleration at the stroke peaks.
        # What it tests: Instantaneous torque delivery and 'snap' propulsion efficiency.
        val = a * (math.sin(2 * math.pi * f * t) ** 3)
        return {"roll": 0.0, "pitch": val}

    def static_load_offset(self, t, f, a):
        # What it does: Holds all motors at a constant, non-zero offset.
        # What it tests: Steady-state current draw, motor thermals, and mechanical deflection.
        return {"roll": a, "pitch": a}

    def chirp_test(self, t, f, a):
        # What it does: Linearly increases frequency from 0.1Hz up to 'f' over the command duration.
        # What it tests: Mechanical resonance frequencies and control loop bandwidth limits.
        f_t = 0.1 + (f - 0.1) * (t / self.total_duration)
        return {"roll": a * math.sin(2 * math.pi * f_t * t), "pitch": 0.0}

    def hysteresis_test(self, t, f, a):
        # What it does: Holds a static offset for 1 second, then oscillates starting from that peak.
        # What it tests: Mechanical backlash (slop) and PID recovery from a pre-loaded directional bias.
        offset = a 
        if t < 1.0:
            return {"roll": offset, "pitch": offset}
        theta = 2 * math.pi * f * (t - 1.0)
        return {"roll": a * math.cos(theta), "pitch": a * math.cos(theta)}
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