import rclpy
from rclpy.node import Node
from std_msgs.msg import String
import time

class Crab(Node):
    def __init__(self):
        super().__init__('crab_gatekeeper')
        self.state = "IDLE"
        self.command_count = 0 
        
        self.motion_pub = self.create_publisher(String, 'motion_cmd', 10)
        self.cmd_sub = self.create_subscription(String, 'robot_cmd', self.manual_cmd_cb, 10)
        self.get_logger().info("Gatekeeper Ready.")

    def manual_cmd_cb(self, msg):
        if self.state != "IDLE":
            self.get_logger().warn("Busy!")
            return

        try:
            parts = msg.data.split(',')
            self.command_count += 1
            self.execute_mission(parts[0], float(parts[1]), float(parts[2]), float(parts[3]))
        except Exception as e:
            self.get_logger().error(f"Error: {e}")

    def execute_mission(self, gait, cycles, freq, amp):
        self.state = "ACTIVE"
        
        motion_string = (
            f"actuators:[left,right] motions:[{gait},{gait}] modes:[3.0,3.0] "
            f"freqs:[{freq},{freq}] amps:[{amp},{amp}] cycles:[{cycles},{cycles}] "
            f"cmd_id:[{self.command_count}]"
        )

        msg = String()
        msg.data = motion_string
        self.motion_pub.publish(msg)
        self.get_logger().info(f"Executing Cmd #{self.command_count}: {gait}")

        time.sleep(cycles / freq) 
        
        self.state = "CALIBRATING"
        #time.sleep(0.5)
        self.state = "IDLE"
        self.get_logger().info("Ready for next command.")

def main(args=None):
    rclpy.init(args=args)
    rclpy.spin(Crab())
    rclpy.shutdown()

if __name__ == '__main__':
    main()