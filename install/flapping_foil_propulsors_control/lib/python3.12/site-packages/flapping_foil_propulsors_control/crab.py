import rclpy
from rclpy.node import Node
from std_msgs.msg import String, Float32MultiArray
from collections import deque
import time

class Crab(Node):
    def __init__(self):
        super().__init__('crab_gatekeeper')
        
        self.state = "IDLE" 
        self.command_count = 0 
        self.cmd_queue = deque()
        
        # Tracking variables for conditional completion
        self.current_cmd_duration = 0.0
        self.current_cmd_start_time = 0.0

        # --- ROS2 Interfaces ---
        self.motion_pub = self.create_publisher(String, 'motion_cmd', 10)
        self.cmd_sub = self.create_subscription(String, 'robot_cmd', self.manual_cmd_cb, 10)
        self.tele_sub = self.create_subscription(Float32MultiArray, 'telemetry', self.telemetry_cb, 10)
        
        self.get_logger().info("Gatekeeper Ready (Event-Driven Mode)")

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
            
            # Calculate expected duration to use in telemetry check
            self.current_cmd_duration = cycles / freq
            self.current_cmd_start_time = time.time()
            
            motion_string = (
                f"actuators:[left,right] motions:[{gait},{gait}] modes:[3.0,3.0] "
                f"freqs:[{freq},{freq}] amps:[{amp},{amp}] cycles:[{cycles},{cycles}] "
                f"cmd_id:[{self.command_count}]"
            )

            self.motion_pub.publish(String(data=motion_string))
            self.get_logger().info(f"Sent Cmd #{self.command_count}: {gait}")
            
        except Exception as e:
            self.get_logger().error(f"Parse Error: {e}")
            self.process_next_command()

    def telemetry_cb(self, msg):
        """
        Checks completion conditionally based on incoming telemetry packets.
        """
        if self.state == "ACTIVE":
            incoming_id = msg.data[0]
            
            # Check 1: Ensure we are looking at the telemetry for the active command
            if incoming_id == float(self.command_count):
                elapsed = time.time() - self.current_cmd_start_time
                
                # Check 2: Conditional completion check
                # We add a small buffer (0.1s) to ensure the controller has finished its last loop
                if elapsed > (self.current_cmd_duration + 0.1):
                    self.get_logger().info(f"Cmd #{self.command_count} finished (Detected via Telemetry).")
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