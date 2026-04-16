import rclpy
from rclpy.node import Node
from std_msgs.msg import String

class Crab(Node):
    def __init__(self):
        super().__init__('crab_gatekeeper')
        self.state = "IDLE"
        self.command_count = 0 
        
        self.motion_pub = self.create_publisher(String, 'motion_cmd', 10)
        self.cmd_sub = self.create_subscription(String, 'robot_cmd', self.manual_cmd_cb, 10)
        
        self.mission_timer = None
        self.get_logger().info("Gatekeeper Ready.")

    def manual_cmd_cb(self, msg):
        if self.state != "IDLE":
            self.get_logger().warn(f"Busy! Current State: {self.state}")
            return

        try:
            # Expected format: "forward_paddle, 5.0, 1.0, 0.5" (gait, cycles, freq, amp)
            parts = [p.strip() for p in msg.data.split(',')]
            gait = parts[0]
            cycles = float(parts[1])
            freq = float(parts[2])
            amp = float(parts[3])

            self.command_count += 1
            self.execute_mission(gait, cycles, freq, amp)
        except Exception as e:
            self.get_logger().error(f"Command Parsing Error: {e}")

    def execute_mission(self, gait, cycles, freq, amp):
        self.state = "ACTIVE"
        duration = cycles / freq

        motion_string = (
            f"actuators:[left,right] motions:[{gait},{gait}] modes:[3.0,3.0] "
            f"freqs:[{freq},{freq}] amps:[{amp},{amp}] cycles:[{cycles},{cycles}] "
            f"cmd_id:[{self.command_count}]"
        )

        msg = String()
        msg.data = motion_string
        self.motion_pub.publish(msg)
        self.get_logger().info(f"Published Cmd #{self.command_count}: {gait} for {duration:.2f}s")

        if self.mission_timer is not None:
            self.mission_timer.cancel()
        
        self.mission_timer = self.create_timer(duration, self.reset_state_cb)

    def reset_state_cb(self):
        # Stop the timer from repeating
        if self.mission_timer:
            self.mission_timer.cancel()
            self.mission_timer = None
            
        self.state = "IDLE"
        self.get_logger().info("Motion complete. Ready for next command.")

def main(args=None):
    rclpy.init(args=args)
    node = Crab()
    try:
        rclpy.spin(node)
    except KeyboardInterrupt:
        pass
    finally:
        node.destroy_node()
        rclpy.shutdown()

if __name__ == '__main__':
    main()