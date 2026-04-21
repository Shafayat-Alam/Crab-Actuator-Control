import rclpy
from rclpy.node import Node
from std_msgs.msg import String
from collections import deque

class Crab(Node):
    def __init__(self):
        # Initialize the ROS2 node with a specific name
        super().__init__('crab_gatekeeper')
        
        # State tracking: prevents multiple motion commands from overlapping
        self.state = "IDLE" 
        
        # Incremental counter to give every command a unique identification number
        self.command_count = 0 

        # FIFO Queue to store incoming motion requests when the robot is busy
        self.cmd_queue = deque()

        # --- ROS2 Interfaces ---
        # Publisher to send formatted gait strings to the hardware controller
        self.motion_pub = self.create_publisher(String, 'motion_cmd', 10)
        
        # Subscriber to receive manual high-level commands (e.g., from a terminal)
        self.cmd_sub = self.create_subscription(String, 'robot_cmd', self.manual_cmd_cb, 10)
        
        # Placeholder for a timer that will track when a motion mission is finished
        self.mission_timer = None 
        self.get_logger().info("Application Ready (Queue System Active)")

    def manual_cmd_cb(self, msg):
        """Buffers incoming raw commands and triggers processing if idle."""
        # Add new command string to the end of the queue
        self.cmd_queue.append(msg.data)
        self.get_logger().info(f"Command queued. Total in queue: {len(self.cmd_queue)}")

        # If the gatekeeper is IDLE, start processing the queue immediately
        if self.state == "IDLE":
            self.process_next_command()

    def process_next_command(self):
        """Pops the next command from the queue and executes it."""
        if not self.cmd_queue:
            self.state = "IDLE"
            self.get_logger().info("All motions complete. Standing by.")
            return

        raw_data = self.cmd_queue.popleft()
        
        try:
            # Expected input format: "gait_name, cycles, frequency, amplitude"
            parts = [p.strip() for p in raw_data.split(',')]
            gait = parts[0]
            cycles = float(parts[1])
            freq = float(parts[2])
            amp = float(parts[3])

            # Increment command ID and hand off to execution logic
            self.command_count += 1
            self.execute_mission(gait, cycles, freq, amp)
            
        except Exception as e:
            self.get_logger().error(f"Command Parsing Error: {e}")
            # If parsing fails, try to move to the next item in the queue
            self.process_next_command()

    def execute_mission(self, gait, cycles, freq, amp):
        """Formats hardware command, publishes it, and starts the duration timer."""
        # Lock the state to ACTIVE to signal current motion execution
        self.state = "ACTIVE"
        
        # Physics calculation: time = total cycles / cycles per second (Hz)
        duration = cycles / freq

        # Construct the complex control string required by the hardware interface node
        motion_string = (
            f"actuators:[left,right] motions:[{gait},{gait}] modes:[3.0,3.0] "
            f"freqs:[{freq},{freq}] amps:[{amp},{amp}] cycles:[{cycles},{cycles}] "
            f"cmd_id:[{self.command_count}]"
        )

        # Publish the string to the hardware engine
        msg = String()
        msg.data = motion_string
        self.motion_pub.publish(msg)
        self.get_logger().info(f"Executing Cmd #{self.command_count}: {gait} ({duration:.2f}s)")

        # Clear existing timers and set a new one for the calculated motion duration
        if self.mission_timer is not None:
            self.mission_timer.cancel()
        
        # When duration expires, call the sequence handler
        self.mission_timer = self.create_timer(duration, self.reset_state_cb)

    def reset_state_cb(self):
        """Cleanup current timer and check queue for subsequent motions."""
        if self.mission_timer:
            self.mission_timer.cancel()
            self.mission_timer = None
            
        # Instead of just going IDLE, check if there are more commands waiting
        self.process_next_command()

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