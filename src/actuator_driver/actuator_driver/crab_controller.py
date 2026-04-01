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