"""
import rclpy
from rclpy.node import Node
from std_msgs.msg import Float32MultiArray

class CrabController(Node):
    def __init__(self):
        super().__init__('crab_motion_engine')
        self.joint_pub = self.create_publisher(Float32MultiArray, 'joint_cmd', 10)
        self.motion_sub = self.create_subscription(Float32MultiArray, 'motion_cmd', self.motion_cb, 10)
        
        self.CENTER = 2048.0
        self.DEG_TO_TICK = 4096.0 / 360.0
        self.step = 1
        self.timer = None
        self.params = None 

    def motion_cb(self, msg):
        if len(msg.data) < 4: return
        self.params = msg.data
        self.step = 1 # Reset gait on new command
        
        if self.timer: self.timer.cancel()
        
        freq = self.params[2]
        if freq > 0:
            self.timer = self.create_timer((1.0/freq)/4.0, self.execute_cycle)

    def execute_cycle(self):
        if not self.params: return
        m_type, mode, freq, amp_deg = self.params
        amp = amp_deg * self.DEG_TO_TICK
        roll_90 = 90.0 * self.DEG_TO_TICK

        # Mapping: IDs 1 & 3 = Roll | IDs 2 & 4 = Flap
        if self.step == 1:   # Flap Up
            r, f = 0.0, amp
        elif self.step == 2: # Twist Up
            r, f = -roll_90, amp
        elif self.step == 3: # Flap Down
            r, f = -roll_90, -amp
        else:                # Untwist
            r, f = 0.0, -amp

        msg = Float32MultiArray()
        # [IDs] + [Modes] + [Goal Ticks]
        msg.data = [1.0, 2.0, 3.0, 4.0] + [float(mode)]*4 + \
                   [self.CENTER+r, self.CENTER+f, self.CENTER+r, self.CENTER+f]
        self.joint_pub.publish(msg)

        self.step = (self.step + 1) if m_type == 1.0 else (self.step - 1)
        if self.step > 4: self.step = 1
        if self.step < 1: self.step = 4

def main(args=None):
    rclpy.init(args=args)
    rclpy.spin(CrabController())
    rclpy.shutdown()
"""

"""

import rclpy
from rclpy.node import Node
from std_msgs.msg import Float32MultiArray
import math
import time

class CrabController(Node):
    def __init__(self):
        super().__init__('crab_motion_engine')
        self.joint_pub = self.create_publisher(Float32MultiArray, 'joint_cmd', 10)
        self.motion_sub = self.create_subscription(Float32MultiArray, 'motion_cmd', self.motion_cb, 10)
        
        # New 90-degree Homing (1024.0 = 90 deg for XW430)
        self.CENTER = 1024.0 
        self.DEG_TO_TICK = 4096.0 / 360.0
        
        self.timer = None
        self.start_time = 0.0
        self.duration = 0.0
        self.freq = 0.0
        self.amplitude = 0.0
        self.mode = 3.0 # Defaulting to Position Mode
        # OLD: self.CENTER = 2048.0  (This was 180 degrees)
        # NEW:
        # Replace self.CENTER = 1024.0 with this:
        self.centers = {
            1: 280.0,
            2: 1120.0,
            3: 900.0,
            4: 1200.0
        }

    def motion_cb(self, msg):
        if len(msg.data) < 4: return
        
        # Extract params: [motion_type, mode, frequency, amplitude_deg]
        _, self.mode, self.freq, amp_deg = msg.data
        
        if self.freq <= 0:
            self.stop_and_home()
            return

        self.amplitude = amp_deg * self.DEG_TO_TICK
        self.duration = 1.0 / self.freq
        self.start_time = self.get_clock().now().nanoseconds / 1e9
        
        if self.timer:
            self.timer.cancel()
            
        # Run at 50Hz for smooth sine transitions
        self.timer = self.create_timer(0.02, self.execute_sine_stroke)

    def execute_sine_stroke(self):
        now = self.get_clock().now().nanoseconds / 1e9
        elapsed = now - self.start_time
        
        # Check if we have completed one full period (2*PI)
        if elapsed >= self.duration:
            self.stop_and_home()
            return

        # Calculate phase (0 to 2*PI)
        phase = (elapsed / self.duration) * 2.0 * math.pi
        
        # Sine calculation: starts at 0, peaks at +Amp, crosses 0, peaks at -Amp, ends at 0
        offset = self.amplitude * math.sin(phase)
        target_pos = self.CENTER + offset

        self.publish_joints(target_pos)

    def stop_and_home(self):
        
        if self.timer:
            self.timer.cancel()
            self.timer = None
        
        self.publish_joints(self.CENTER)
        self.get_logger().info(f"Stroke Complete. Homing to {self.CENTER}")

    def publish_joints(self, flap_pos):
        msg = Float32MultiArray()
        # [IDs] + [Modes] + [Goal Ticks]
        # Keeping Roll servos at CENTER (1024) and moving Flap servos (2 & 4)
        msg.data = [1.0, 2.0, 3.0, 4.0] + [float(self.mode)]*4 + \
                   [self.CENTER, flap_pos, self.CENTER, flap_pos]
        self.joint_pub.publish(msg)

def main(args=None):
    rclpy.init(args=args)
    node = CrabController()
    try:
        rclpy.spin(node)
    except KeyboardInterrupt:
        pass
    finally:
        node.stop_and_home()
        rclpy.shutdown()
"""

"""
import rclpy
from rclpy.node import Node
from std_msgs.msg import Float32MultiArray
import csv

class CrabController(Node):
    def __init__(self):
        super().__init__('crab_motion_engine')
        
        # Publishers & Subscribers
        self.joint_pub = self.create_publisher(Float32MultiArray, 'joint_cmd', 10)
        self.motion_sub = self.create_subscription(Float32MultiArray, 'motion_cmd', self.motion_cb, 10)
        self.feedback_sub = self.create_subscription(Float32MultiArray, 'joint_feedback', self.feedback_cb, 10)

        # Robot Constants
        self.active_ids = [1.0, 2.0, 3.0, 4.0]
        self.centers = {1: 280.0, 2: 1120.0, 3: 900.0, 4: 1200.0}
        
        # State Tracking
        self.current_feedback = [0.0] * 4
        self.prev_feedback = [0.0] * 4
        self.last_goals = [self.centers[1], self.centers[2], self.centers[3], self.centers[4]]
        self.current_mode = 3.0 # Default to Position

        # CSV Setup
        self.csv_filename = 'robot_experiment_log.csv'
        self.csv_file = open(self.csv_filename, 'w', newline='')
        self.csv_writer = csv.writer(self.csv_file)
        
        header = ['timestamp', 'servo_id', 'mode', 'prev_state', 'goal_cmd', 'current_state']
        self.csv_writer.writerow(header)
        self.csv_file.flush()

        self.get_logger().info("Controller Online. Waiting for motion_cmd...")

    def motion_cb(self, msg):
        if len(msg.data) < 6:
            return

        self.current_mode = msg.data[1]
        self.last_goals = list(msg.data[2:6])
        
        cmd_msg = Float32MultiArray()
        # Format: [IDs] + [Modes] + [Goals]
        cmd_msg.data = self.active_ids + [self.current_mode]*4 + self.last_goals
        self.joint_pub.publish(cmd_msg)

    def feedback_cb(self, msg):
        if len(msg.data) < 4:
            return

        self.prev_feedback = list(self.current_feedback)
        self.current_feedback = list(msg.data)
        self.log_to_csv()

    def log_to_csv(self):
        timestamp = self.get_clock().now().to_msg().nanosec
        for i in range(4):
            sid = int(self.active_ids[i])
            row = [
                timestamp,
                sid,
                int(self.current_mode),
                self.prev_feedback[i],
                self.last_goals[i],
                self.current_feedback[i]
            ]
            self.csv_writer.writerow(row)
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
        node.destroy_node()
        if rclpy.ok():
            rclpy.shutdown()

if __name__ == '__main__':
    main()

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

        # --- Constants & State ---
        self.active_ids = [1.0, 2.0, 3.0, 4.0]
        self.current_feedback = [0.0] * 4
        self.current_mode = 3.0
        
        # --- CSV Setup ---
        self.csv_filename = 'robot_snapshots.csv'
        # 'a' (append) so you don't overwrite previous move data
        self.csv_file = open(self.csv_filename, 'a', newline='') 
        self.csv_writer = csv.writer(self.csv_file)
        
        # Write header only if file is brand new
        if self.csv_file.tell() == 0:
            self.csv_writer.writerow(['timestamp', 'event', 'servo_id', 'mode', 'pos'])
        self.csv_file.flush()

        self.get_logger().info("Controller Online. Snapshot mode active.")

    def feedback_cb(self, msg):
        """Updates internal state with latest hardware data (No logging here)."""
        if len(msg.data) >= 4:
            self.current_feedback = list(msg.data)

    def motion_cb(self, msg):
        """Logs PRE-move, sends command, waits, then logs POST-move."""
        if len(msg.data) < 6:
            return
        
        self.current_mode = msg.data[1]
        goals = list(msg.data[2:6])

        # 1. Capture "Before"
        self.log_snapshot("PRE_MOVE")

        # 2. Send command to Driver
        cmd_msg = Float32MultiArray()
        cmd_msg.data = self.active_ids + [self.current_mode]*4 + goals
        self.joint_pub.publish(cmd_msg)
        self.get_logger().info(f"Moving to: {goals}")

        # 3. Wait for servos to reach target (adjust 0.5s if move is large)
        time.sleep(0.5) 

        # 4. Capture "After"
        self.log_snapshot("POST_MOVE")
        self.get_logger().info("Move recorded.")

    def log_snapshot(self, event_label):
        ts = self.get_clock().now().to_msg().nanosec
        for i in range(4):
            sid = int(self.active_ids[i])
            row = [ts, event_label, sid, int(self.current_mode), self.current_feedback[i]]
            self.csv_writer.writerow(row)
        self.csv_file.flush()

    def destroy_node(self):
        self.csv_file.close()
        super().destroy_node()

# --- THE MAIN FUNCTION (MUST BE OUTSIDE THE CLASS) ---
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