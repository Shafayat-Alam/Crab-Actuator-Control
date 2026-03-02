#!/usr/bin/env python3
"""
Servo Command Node

ROS2 node that controls a single Dynamixel XM430-T200 servo via DynamixelSDK.

Features:
- Subscribes to /servo/command (mode, value)
- Publishes to /servo/status (position, velocity, current)
- Supports three control modes: position, velocity, torque
- Logs all commands and feedback to CSV file
- Returns servo feedback after each command

Usage:
    ros2 launch servo_driver servo.launch.py servo_id:=1
"""

import rclpy
from rclpy.node import Node
from std_msgs.msg import Float32MultiArray

from dynamixel_sdk import *

import time
import csv
import os
from datetime import datetime

# Serial Communication
PROTOCOL_VERSION = 2.0
BAUDRATE = 57600
DEVICENAME = '/dev/ttyUSB0'

# Register Addresses (from XM430-T200 Control Table)
ADDR_TORQUE_ENABLE = 64
ADDR_CONTROL_MODE = 11
ADDR_GOAL_POSITION = 116
ADDR_GOAL_VELOCITY = 104
ADDR_GOAL_CURRENT = 102
ADDR_PRESENT_POSITION = 132
ADDR_PRESENT_VELOCITY = 128
ADDR_PRESENT_CURRENT = 126

# Control Mode Values
MODE_CURRENT = 0        # Current/Torque control
MODE_VELOCITY = 1       # Velocity control
MODE_POSITION = 3       # Position control

# Torque Enable Values
TORQUE_ENABLE = 1
TORQUE_DISABLE = 0


class ServoCommandNode(Node):
    """ROS2 node for controlling a single Dynamixel servo."""
    
    def __init__(self):
        super().__init__('servo_command_node')
        
        # Get servo ID from parameter
        self.declare_parameter('servo_id', 1)
        self.servo_id = self.get_parameter('servo_id').value
        
        # Initialize logging
        self._init_logging()
        
        # Store latest command for pairing with feedback
        self.latest_command = {
            'control_mode': None,
            'goal_value': None
        }
        
        # Initialize DynamixelSDK
        self.port_handler = PortHandler(DEVICENAME)
        self.packet_handler = PacketHandler(PROTOCOL_VERSION)
        
        # Open serial port
        if not self.port_handler.openPort():
            self.get_logger().error("Failed to open serial port")
            return
        
        # Set baud rate
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
        
        self.get_logger().info("Servo command node initialized and ready")
    
    def _init_logging(self):
        """Initialize CSV logging file in current directory."""
        # Create log file in current directory (overwrite each run)
        self.log_file = f'servo_log_{self.servo_id}.csv'
        
        try:
            # Get absolute path for debugging
            abs_path = os.path.abspath(self.log_file)
            
            # Write header
            with open(self.log_file, 'w', newline='') as f:
                writer = csv.writer(f)
                writer.writerow([
                    'timestamp',
                    'control_mode',
                    'goal_value',
                    'present_position',
                    'present_velocity',
                    'present_current'
                ])
            
            self.get_logger().info(f"Logging initialized at: {abs_path}")
        except Exception as e:
            self.get_logger().error(f"Failed to initialize logging: {e}")
            self.log_file = None
    
    def _log_feedback(self, control_mode, goal_value, position, velocity, current):
        """Write feedback data to CSV file."""
        if self.log_file is None:
            return
        
        try:
            timestamp = datetime.now().isoformat()
            
            with open(self.log_file, 'a', newline='') as f:
                writer = csv.writer(f)
                writer.writerow([
                    timestamp,
                    control_mode,
                    goal_value,
                    int(position),
                    int(velocity),
                    int(current)
                ])
            
            self.get_logger().debug(f"Logged: mode={control_mode}, value={goal_value}, pos={int(position)}")
        except Exception as e:
            self.get_logger().error(f"Failed to write log: {e}")
    
    def enable_torque(self):
        """
        Enable servo torque.
        
        Servo must have torque enabled before it can move.
        Called after setting control mode.
        
        Returns:
            bool: True if successful, False otherwise
        """
        dxl_comm_result, dxl_error = self.packet_handler.write1ByteTxRx(
            self.port_handler,
            self.servo_id,
            ADDR_TORQUE_ENABLE,
            TORQUE_ENABLE
        )
        
        if dxl_comm_result != COMM_SUCCESS:
            self.get_logger().error(f"Failed to enable torque: {dxl_comm_result}")
            return False
        
        self.get_logger().info("Servo torque enabled successfully")
        return True
    
    def command_callback(self, msg):
        """
        Callback when command is received on /servo/command.
        
        Expected message format: Float32MultiArray with [control_mode, goal_value]
        - control_mode: 0 (current), 1 (velocity), or 3 (position)
        - goal_value: target value for the selected mode
        
        Args:
            msg (Float32MultiArray): Command message from /servo/command topic
        """
        # Validate message format
        if len(msg.data) < 2:
            self.get_logger().error("Invalid command format. Expected [mode, value]")
            return
        
        control_mode = int(msg.data[0])
        goal_value = int(msg.data[1])
        
        # Store command for logging
        self.latest_command['control_mode'] = control_mode
        self.latest_command['goal_value'] = goal_value
        
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

        if not self.enable_torque():
            self.get_logger().error("Failed to enable torque")
            return

        self.get_logger().info(f"Torque enabled for servo ID {self.servo_id}")
        
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
        
        elif control_mode == MODE_CURRENT:
            dxl_comm_result, dxl_error = self.packet_handler.write2ByteTxRx(
                self.port_handler,
                self.servo_id,
                ADDR_GOAL_CURRENT,
                goal_value
            )
            self.get_logger().info(f"Set current/torque to {goal_value}")
        
        else:
            self.get_logger().error(f"Unknown control mode: {control_mode}")
            return
        
        if dxl_comm_result != COMM_SUCCESS:
            self.get_logger().error(f"Failed to set goal value: {dxl_comm_result}")
            return
        
        # Read and publish feedback
        self.publish_feedback()
    
    def publish_feedback(self):
        """
        Read servo state and publish to /servo/status.
        Also logs data to CSV file.
        
        Publishes: [present_position, present_velocity, present_current]
        """
        # Read present position
        position, dxl_comm_result, dxl_error = self.packet_handler.read4ByteTxRx(
            self.port_handler,
            self.servo_id,
            ADDR_PRESENT_POSITION
        )
        
        # Read present velocity
        velocity, dxl_comm_result, dxl_error = self.packet_handler.read4ByteTxRx(
            self.port_handler,
            self.servo_id,
            ADDR_PRESENT_VELOCITY
        )
        
        # Read present current
        current, dxl_comm_result, dxl_error = self.packet_handler.read2ByteTxRx(
            self.port_handler,
            self.servo_id,
            ADDR_PRESENT_CURRENT
        )
        
        # Log feedback to CSV
        self._log_feedback(
            self.latest_command['control_mode'],
            self.latest_command['goal_value'],
            position,
            velocity,
            current
        )
        
        # Create and publish feedback message
        feedback_msg = Float32MultiArray()
        feedback_msg.data = [float(position), float(velocity), float(current)]
        
        self.publisher.publish(feedback_msg)
        self.get_logger().info(f"Feedback: pos={position}, vel={velocity}, cur={current}")
    
    def destroy_node(self):
        """
        Cleanup: Close serial port when node shuts down.
        """
        self.get_logger().info("Shutting down servo command node")
        self.port_handler.closePort()
        super().destroy_node()


def main(args=None):
    """Main entry point for the servo command node."""
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