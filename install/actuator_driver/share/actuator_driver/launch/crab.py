import rclpy
from rclpy.node import Node
from std_msgs.msg import String, Float32MultiArray

class Gatekeeper(Node):
    def __init__(self):
        super().__init__('crab_gatekeeper')
        self.sub = self.create_subscription(String, 'crab_str_cmd', self.str_cb, 10)
        self.pub = self.create_publisher(Float32MultiArray, 'motion_cmd', 10)

    def str_cb(self, msg):
        try:
            parts = msg.data.split()
            cmd = Float32MultiArray()
            # Default mapping: [Type, Mode, Freq, Amp]
            m_type = 1.0 if parts[0] == "forward" else 2.0
            freq = float(parts[1])
            amp = float(parts[2])
            cmd.data = [m_type, 3.0, freq, amp]
            self.pub.publish(cmd)
        except:
            self.get_logger().error("Format: 'forward/backward <freq> <amp>'")

def main(args=None):
    rclpy.init(args=args)
    rclpy.spin(Gatekeeper())
    rclpy.shutdown()