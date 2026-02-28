#!/usr/bin/env python3

import rclpy
from rclpy.node import Node
from std_msgs.msg import Float32MultiArray

from dynamixel_sdk import *

# DynamixelSDK constants
PROTOCOL_VERSION = 2.0
BAUDRATE = 57600
DEVICENAME = '/dev/ttyUSB0'

# Register addresses
ADDR_CONTROL_MODE = 11
ADDR_GOAL_POSITION = 116
ADDR_GOAL_VELOCITY = 104
ADDR_GOAL_CURRENT = 102
ADDR_PRESENT_POSITION = 132
ADDR_PRESENT_VELOCITY = 128
ADDR_PRESENT_CURRENT = 126

# Control modes
MODE_CURRENT = 0      
MODE_VELOCITY = 1     
MODE_POSITION = 3     

class ServoCommandNode(Node):
    def __init__(self):
        super().__init__('servo_command_node')
        
        # Declare parameter for servo ID
        self.declare_parameter('servo_id', 1)
        self.servo_id = self.get_parameter('servo_id').value
        
        # Initialize DynamixelSDK
        self.port_handler = PortHandler(DEVICENAME)
        self.packet_handler = PacketHandler(PROTOCOL_VERSION)
        
        # Open port
        if not self.port_handler.openPort():
            self.get_logger().error("Failed to open port")
            return
        
        # Set baudrate
        if not self.port_handler.setBaudRate(BAUDRATE):
            self.get_logger().error("Failed to set baud rate")
            return
        
        self.get_logger().info(f"Connected to servo ID {self.servo_id}")
        
        # Create subscriber for commands
        self.subscription = self.create_subscription(
            Float32MultiArray,
            '/servo/command',
            self.command_callback,
            10
        )
        
        # Create publisher for feedback
        self.publisher = self.create_publisher(
            Float32MultiArray,
            '/servo/status',
            10
        )
        
        self.get_logger().info("Servo command node initialized")
    
    def command_callback(self, msg):
        """
        Callback when command is received.
        msg.data must be [control_mode, goal_value]
        """
        if len(msg.data) < 2:
            self.get_logger().error("Invalid command format. Expected [mode, value]")
            return
        # Note: Assumes Float32MultiArray message contains valid numbers
        
        control_mode = int(msg.data[0])
        goal_value = int(msg.data[1])
        
        self.get_logger().info(f"Received command: mode={control_mode}, value={goal_value}")
        
        # Set control mode
        dxl_comm_result, dxl_error = self.packet_handler.write1ByteTxRx(
            self.port_handler,
            self.servo_id,
            ADDR_CONTROL_MODE,
            control_mode
        )
        
        if dxl_comm_result != COMM_SUCCESS:
            self.get_logger().error(f"Failed to set control mode: {dxl_comm_result}")
            return
        
        # Set goal value based on mode
        if control_mode == MODE_POSITION:
            dxl_comm_result, dxl_error = self.packet_handler.write4ByteTxRx(
                self.port_handler,
                self.servo_id,
                ADDR_GOAL_POSITION,
                goal_value
            )
            self.get_logger().info(f"Set position to {goal_value}")
        
        elif control_mode == MODE_VELOCITY:
            dxl_comm_result, dxl_error = self.packet_handler.write4ByteTxRx(
                self.port_handler,
                self.servo_id,
                ADDR_GOAL_VELOCITY,
                goal_value
            )
            self.get_logger().info(f"Set velocity to {goal_value}")
        
        elif control_mode == MODE_TORQUE:
            dxl_comm_result, dxl_error = self.packet_handler.write2ByteTxRx(
                self.port_handler,
                self.servo_id,
                ADDR_GOAL_CURRENT,
                goal_value
            )
            self.get_logger().info(f"Set torque to {goal_value}")
        
        else:
            self.get_logger().error(f"Unknown control mode: {control_mode}")
            return
        
        if dxl_comm_result != COMM_SUCCESS:
            self.get_logger().error(f"Failed to set goal value: {dxl_comm_result}")
            return
        
        # Read feedback
        self.publish_feedback()
    
    def publish_feedback(self):
        """
        Read servo state and publish feedback.
        Publishes [position, velocity, current]
        """
        # Read position
        position, dxl_comm_result, dxl_error = self.packet_handler.read4ByteTxRx(
            self.port_handler,
            self.servo_id,
            ADDR_PRESENT_POSITION
        )
        
        # Read velocity
        velocity, dxl_comm_result, dxl_error = self.packet_handler.read4ByteTxRx(
            self.port_handler,
            self.servo_id,
            ADDR_PRESENT_VELOCITY
        )
        
        # Read current
        current, dxl_comm_result, dxl_error = self.packet_handler.read2ByteTxRx(
            self.port_handler,
            self.servo_id,
            ADDR_PRESENT_CURRENT
        )
        
        # Create feedback message
        feedback_msg = Float32MultiArray()
        feedback_msg.data = [float(position), float(velocity), float(current)]
        
        # Publish
        self.publisher.publish(feedback_msg)
        self.get_logger().info(f"Feedback: pos={position}, vel={velocity}, cur={current}")
    
    def destroy_node(self):
        """
        Clean up: close port when node is destroyed
        """
        self.port_handler.closePort()
        super().destroy_node()


def main(args=None):
    rclpy.init(args=args)
    node = ServoCommandNode()
    
    try:
        rclpy.spin(node)
    except KeyboardInterrupt:
        pass
    finally:
        node.destroy_node()
        rclpy.shutdown()


if __name__ == '__main__':
    main()