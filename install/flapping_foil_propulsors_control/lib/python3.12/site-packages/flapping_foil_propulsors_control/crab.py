import rclpy
from rclpy.node import Node
from std_msgs.msg import String

class Crab(Node):
    def __init__(self):
        # Initialize the ROS2 node with a specific name
        super().__init__('crab_gatekeeper')
        
        # State tracking: prevents multiple motion commands from overlapping
        self.state = "IDLE" 
        
        # Incremental counter to give every command a unique identification number
        self.command_count = 0 

        # --- ROS2 Interfaces ---
        # Publisher to send formatted gait strings to the hardware controller
        self.motion_pub = self.create_publisher(String, 'motion_cmd', 10)
        
        # Subscriber to receive manual high-level commands (e.g., from a terminal)
        self.cmd_sub = self.create_subscription(String, 'robot_cmd', self.manual_cmd_cb, 10)
        
        # Placeholder for a timer that will track when a motion mission is finished
        self.mission_timer = None 
        self.get_logger().info("Application Ready")

    def manual_cmd_cb(self, msg):
        # Gatekeeper logic: ignore new commands if the robot is already moving
        if self.state != "IDLE":
            self.get_logger().warn(f"Busy! Current State: {self.state}")
            return

        try:
            # Expected input format: "gait_name, cycles, frequency, amplitude"
            # Example: "forward_paddle, 5.0, 1.0, 0.5"
            parts = [p.strip() for p in msg.data.split(',')]
            gait = parts[0]
            cycles = float(parts[1])
            freq = float(parts[2])
            amp = float(parts[3])

            # Increment command ID for tracking and start execution
            self.command_count += 1
            self.execute_mission(gait, cycles, freq, amp)
        except Exception as e:
            # Catch parsing errors (e.g., if user forgets a comma or sends text instead of numbers)
            self.get_logger().error(f"Command Parsing Error: {e}")

    def execute_mission(self, gait, cycles, freq, amp):
        # Lock the state to ACTIVE so no other commands interfere
        self.state = "ACTIVE"
        
        # Physics calculation: time = total cycles / cycles per second (Hz)
        duration = cycles / freq

        # Construct the complex control string required by the hardware interface node
        motion_string = (
            f"actuators:[left,right] motions:[{gait},{gait}] modes:[3.0,3.0] "
            f"freqs:[{freq},{freq}] amps:[{amp},{amp}] cycles:[{cycles},{cycles}] "
            f"cmd_id:[{self.command_count}]"
        )

        # Publish the string to the hardware node
        msg = String()
        msg.data = motion_string
        self.motion_pub.publish(msg)
        self.get_logger().info(f"Published Cmd #{self.command_count}: {gait} for {duration:.2f}s")

        # Clear any existing timers just in case, then start a new one for the calculated duration
        if self.mission_timer is not None:
            self.mission_timer.cancel()
        
        # When the timer runs out, call reset_state_cb to unlock the node
        self.mission_timer = self.create_timer(duration, self.reset_state_cb)

    def reset_state_cb(self):
        # Stop the timer from repeating (timers in ROS2 repeat by default)
        if self.mission_timer:
            self.mission_timer.cancel()
            self.mission_timer = None
            
        # Unlock the gatekeeper so the robot can accept new commands
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