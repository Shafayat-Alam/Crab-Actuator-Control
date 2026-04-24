import rclpy
from rclpy.node import Node
from std_msgs.msg import String, Float32MultiArray
from collections import deque

class Crab(Node):
    def __init__(self):
        super().__init__('crab_gatekeeper')
        
        self.state = "IDLE" 
        self.command_count = 0 
        self.cmd_queue = deque()
        self.last_telemetry_ts = self.get_clock().now()

        # --- ROS2 Interfaces ---
        self.motion_pub = self.create_publisher(String, 'motion_cmd', 10)
        self.cmd_sub = self.create_subscription(String, 'robot_cmd', self.manual_cmd_cb, 10)
        
        # New: Listen to telemetry to detect motion completion
        self.tele_sub = self.create_subscription(Float32MultiArray, 'telemetry', self.telemetry_cb, 10)
        
        # Watchdog: Checks if telemetry has stopped for the current command
        self.watchdog = self.create_timer(0.1, self.completion_watchdog)
        
        self.get_logger().info("Gatekeeper Ready (Telemetry-Feedback Mode)")

    def manual_cmd_cb(self, msg):
        self.cmd_queue.append(msg.data)
        if self.state == "IDLE":
            self.process_next_command()

    def process_next_command(self):
        if not self.cmd_queue:
            self.state = "IDLE"
            return

        raw_data = self.cmd_queue.popleft()
        try:
            parts = [p.strip() for p in raw_data.split(',')]
            gait, cycles, freq, amp = parts[0], float(parts[1]), float(parts[2]), float(parts[3])

            self.command_count += 1
            self.state = "ACTIVE"
            
            # Construct hardware command
            motion_string = (
                f"actuators:[left,right] motions:[{gait},{gait}] modes:[3.0,3.0] "
                f"freqs:[{freq},{freq}] amps:[{amp},{amp}] cycles:[{cycles},{cycles}] "
                f"cmd_id:[{self.command_count}]"
            )

            self.motion_pub.publish(String(data=motion_string))
            self.last_telemetry_ts = self.get_clock().now() # Reset watchdog anchor
            self.get_logger().info(f"Sent Cmd #{self.command_count}: {gait}")
            
        except Exception as e:
            self.get_logger().error(f"Parse Error: {e}")
            self.process_next_command()

    def telemetry_cb(self, msg):
        """Update timestamp if telemetry matches current active command ID."""
        if self.state == "ACTIVE":
            incoming_id = msg.data[0]
            if incoming_id == float(self.command_count):
                self.last_telemetry_ts = self.get_clock().now()

    def completion_watchdog(self):
        """Detects completion when telemetry stream for current ID goes silent."""
        if self.state == "ACTIVE":
            elapsed = (self.get_clock().now() - self.last_telemetry_ts).nanoseconds / 1e9
            
            # If no matching telemetry for > 200ms, controller has finished trajectory
            if elapsed > 0.2:
                self.get_logger().info(f"Cmd #{self.command_count} finished.")
                self.process_next_command()

def main(args=None):
    rclpy.init(args=args)
    node = Crab()
    try:
        rclpy.spin(node)
    except KeyboardInterrupt: pass
    finally:
        node.destroy_node()
        rclpy.shutdown()

if __name__ == '__main__':
    main()