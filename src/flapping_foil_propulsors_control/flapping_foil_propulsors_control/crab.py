import rclpy
from rclpy.node import Node
from std_msgs.msg import String, Float32MultiArray

class Gatekeeper(Node):
    def __init__(self):
        super().__init__('crab_gatekeeper')
        self.sub = self.create_subscription(String, 'robot_cmd', self.str_cb, 10)
        self.pub = self.create_publisher(Float32MultiArray, 'motion_cmd', 10)

def main(args=None):
    rclpy.init(args=args)
    rclpy.spin(Gatekeeper())
    rclpy.shutdown()