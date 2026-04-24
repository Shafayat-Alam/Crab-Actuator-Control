import rclpy
from rclpy.node import Node
from std_msgs.msg import String
import time

class StressTestExecutor(Node):
    def __init__(self):
        super().__init__('stress_test_executor')
        self.robot_pub = self.create_publisher(String, 'robot_cmd', 10)
        self.get_logger().info("Starting 1500-command Stress Test...")

    def run_stress_test(self):
        # Configuration as requested
        freq = 1.0
        amp = 0.5
        cycles = 2.0
        total_commands = 1500
        
        # Define the two motions to toggle between
        motions = ["symmetric_roll_sine", "symmetric_pitch_sine"]

        for i in range(total_commands):
            # Toggle motion: even index = roll, odd index = pitch
            m = motions[i % 2]
            
            self.get_logger().info(f"Command {i+1}/1500: {m} at {freq}Hz")

            # 1. SOFT START / PRE-POSITIONING
            # Move to start position at 1Hz, 0 cycles to avoid the 'jerk'
            pre_pos_msg = String(data=f"{m}, 0.0, 1.0, {amp}")
            self.robot_pub.publish(pre_pos_msg)
            time.sleep(1.5) # Wait for settling

            # 2. EXECUTE ACTUAL TEST COMMAND
            msg = String(data=f"{m}, {cycles}, {freq}, {amp}")
            self.robot_pub.publish(msg)
            
            # Wait for test duration (cycles/freq) + buffer
            wait_time = (cycles / freq) + 0.5
            time.sleep(wait_time)

            # 3. RESET / CALIBRATION 
            # Crucial for 1500 runs to clear any accumulated servo error or heat
            self.robot_pub.publish(String(data="calibration, 1.0, 1.0, 0.0"))
            time.sleep(2.0) 

def main():
    rclpy.init()
    node = StressTestExecutor()
    try:
        node.run_stress_test()
    except KeyboardInterrupt:
        node.get_logger().info("Stress test interrupted by user.")
    finally:
        node.destroy_node()
        rclpy.shutdown()

if __name__ == '__main__':
    main()