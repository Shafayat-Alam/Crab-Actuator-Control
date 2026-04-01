import rclpy
from rclpy.node import Node
from std_msgs.msg import Float32MultiArray
from dynamixel_sdk import *
import ctypes

def cast_to_int32(value):
    """Converts 32-bit unsigned integer from Dynamixel to signed integer."""
    return ctypes.c_int32(int(value)).value

class ActuatorNode(Node):
    def __init__(self):
        super().__init__('servo_actuator')
        
        # --- Hardware Initialization ---
        self.port = PortHandler('/dev/ttyUSB0')
        self.packet_handler = PacketHandler(2.0)
        
        if not self.port.openPort() or not self.port.setBaudRate(57600):
            self.get_logger().error("Hardware Link Failed! Check U2D2 and 12V Power.")
            
        # Register Addresses
        self.ADDR_TORQUE = 64
        self.ADDR_MODE = 11
        self.ADDR_GOAL_POS = 116 
        self.ADDR_GOAL_VEL = 104
        self.ADDR_PRESENT_POS = 132
        
        self.active_ids = [1, 2, 3, 4]
        
        # Torque Enable on Start
        for sid in self.active_ids:
            self.packet_handler.write1ByteTxRx(self.port, sid, self.ADDR_TORQUE, 1)

        # --- ROS Communication ---
        # Subscribes to goals from Controller
        self.joint_sub = self.create_subscription(Float32MultiArray, 'joint_cmd', self.hw_cb, 10)
        
        # Publishes hardware state back to Controller
        self.feedback_pub = self.create_publisher(Float32MultiArray, 'joint_feedback', 10)
        
        # 20Hz Timer just to read hardware and publish (No CSV here)
        self.timer = self.create_timer(0.05, self.publish_feedback)

        self.get_logger().info("Actuator Node Online. (Pure Hardware Driver)")

    """
    def hw_cb(self, msg):
        """Processes incoming joint commands and updates hardware."""
        if not rclpy.ok(): return

        n = len(msg.data) // 3
        ids = [int(x) for x in msg.data[0:n]]
        modes = [int(x) for x in msg.data[n:2*n]]
        goals = [float(x) for x in msg.data[2*n:3*n]]

        for i in range(n):
            sid, mode, goal = ids[i], modes[i], goals[i]
            # Write mode/torque logic
            self.packet_handler.write1ByteTxRx(self.port, sid, self.ADDR_TORQUE, 0)
            self.packet_handler.write1ByteTxRx(self.port, sid, self.ADDR_MODE, mode)
            self.packet_handler.write1ByteTxRx(self.port, sid, self.ADDR_TORQUE, 1)

            addr = self.ADDR_GOAL_POS if mode == 3 else self.ADDR_GOAL_VEL
            self.packet_handler.write4ByteTxRx(self.port, sid, addr, int(goal))
    """

    def hw_cb(self, msg):
        if not rclpy.ok(): return

        n = len(msg.data) // 3
        ids = [int(x) for x in msg.data[0:n]]
        modes = [int(x) for x in msg.data[n:2*n]]
        goals = [float(x) for x in msg.data[2*n:3*n]]

        # Prepare the feedback message
        feedback_msg = Float32MultiArray()
        current_positions = []

        for i in range(n):
            sid, mode, goal = ids[i], modes[i], goals[i]

            # 1. Update Mode/Torque (Only if you need to switch modes mid-flight)
            self.packet_handler.write1ByteTxRx(self.port, sid, self.ADDR_TORQUE, 0)
            self.packet_handler.write1ByteTxRx(self.port, sid, self.ADDR_MODE, mode)
            self.packet_handler.write1ByteTxRx(self.port, sid, self.ADDR_TORQUE, 1)

            # 2. Write the Command
            addr = self.ADDR_GOAL_POS if mode == 3 else self.ADDR_GOAL_VEL
            self.packet_handler.write4ByteTxRx(self.port, sid, addr, int(goal))

            # 3.READ 
            # We read the position right after the write command finishes
            raw_pos, res, err = self.packet_handler.read4ByteTxRx(self.port, sid, self.ADDR_PRESENT_POS)
            
            if res == 0: # COMM_SUCCESS
                current_positions.append(float(raw_pos))
            else:
                current_positions.append(-1.0) # Error marker

            # 4. Publish the feedback immediately
            feedback_msg.data = current_positions
            self.feedback_pub.publish(feedback_msg)
    
    """
    def publish_feedback(self):
        
        msg = Float32MultiArray()
        positions = []
        
        for sid in self.active_ids:
            raw_pos, res, err = self.packet_handler.read4ByteTxRx(self.port, sid, self.ADDR_PRESENT_POS)
            if res == COMM_SUCCESS:
                positions.append(float(cast_to_int32(raw_pos)))
            else:
                positions.append(0.0)

        msg.data = positions
        self.feedback_pub.publish(msg)

    def destroy_node(self):
        self.get_logger().info("Shutting down Actuator Node.")
        super().destroy_node()
    """

def main(args=None):
    rclpy.init(args=args)
    node = ActuatorNode()
    try:
        rclpy.spin(node)
    except KeyboardInterrupt:
        pass
    finally:
        if rclpy.ok():
            node.destroy_node()
            rclpy.shutdown()

if __name__ == '__main__':
    main()