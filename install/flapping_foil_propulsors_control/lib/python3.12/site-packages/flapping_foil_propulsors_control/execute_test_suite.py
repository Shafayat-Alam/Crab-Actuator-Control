import rclpy
from rclpy.node import Node
from std_msgs.msg import String

class TestExecutor(Node):
    def __init__(self):
        super().__init__('test_executor')
        self.robot_pub = self.create_publisher(String, 'robot_cmd', 10)
        self.motion_pub = self.create_publisher(String, 'motion_cmd', 10)
        
        # Generator for our commands to keep the timer logic clean
        self.command_generator = self.get_commands()
        
        # Timer: Every 5 seconds, send the next logical step (Pre-pos -> Test -> Calibrate)
        self.timer = self.create_timer(5.0, self.timer_callback)
        self.get_logger().info("Test Suite Node Online. Sending commands every 5s...")

    def get_commands(self):
        """Generator to yield one command at a time to the timer."""
        motions = ["forward_paddle", "backward_paddle", "forward_flap"] # Truncated for example
        params = [(1.0, 0.5, 2), (2.0, 0.8, 4)] # Truncated
        
        cmd_id = 1
        for m in motions:
            for i, (freq, amp, cyc) in enumerate(params):
                # 1. Pre-position
                yield ("robot", f"{m}, 0.0, 1.0, {amp}")
                # 2. Actual Test
                if i % 2 == 0:
                    yield ("robot", f"{m}, {cyc}, {freq}, {amp}")
                else:
                    msg_str = (f"actuators:[left,right] motions:[{m},{m}] modes:[3.0,3.0] "
                               f"freqs:[{freq},{freq}] amps:[{amp},{amp}] cycles:[{cyc},{cyc}] cmd_id:[{cmd_id}]")
                    yield ("motion", msg_str)
                # 3. Calibration
                yield ("robot", "calibration, 1.0, 1.0, 0.0")
                cmd_id += 1

    def timer_callback(self):
        try:
            cmd_type, data = next(self.command_generator)
            msg = String(data=data)
            if cmd_type == "robot":
                self.robot_pub.publish(msg)
            else:
                self.motion_pub.publish(msg)
            self.get_logger().info(f"Published: {data[:50]}...")
        except StopIteration:
            self.get_logger().info("Test Suite Complete.")
            self.timer.cancel()

def main():
    rclpy.init()
    node = TestExecutor()
    rclpy.spin(node) # This keeps the middleware alive and prevents buffering
    node.destroy_node()
    rclpy.shutdown()