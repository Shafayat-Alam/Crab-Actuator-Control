"""
import rclpy
from rclpy.node import Node
from std_msgs.msg import Float32MultiArray
from dynamixel_sdk import *
import ctypes
import csv
import os

def cast_to_int32(value):
    return ctypes.c_int32(int(value)).value

class ActuatorNode(Node):
    def __init__(self):
        super().__init__('servo_actuator')
        self.port = PortHandler('/dev/ttyUSB0')
        self.packet_handler = PacketHandler(2.0)
        
        if not self.port.openPort() or not self.port.setBaudRate(57600):
            self.get_logger().error("Hardware Link Failed! Check U2D2 and 12V Power.")

        self.ADDR_TORQUE = 64
        self.ADDR_MODE = 11
        self.ADDR_GOAL = 116 
        self.ADDR_PRESENT = 132
        
        self.active_ids = [1, 2, 3, 4]
        for sid in self.active_ids:
            self.packet_handler.write1ByteTxRx(self.port, sid, self.ADDR_TORQUE, 1)
        
        # Setup CSV Logging
        self.csv_filename = 'feedback.csv'
        self.csv_file = open(self.csv_filename, 'w', newline='')
        self.csv_writer = csv.writer(self.csv_file)
        self.csv_writer.writerow(['timestamp', 'id1_pos', 'id2_pos', 'id3_pos', 'id4_pos'])
        self.csv_file.flush()

        self.joint_sub = self.create_subscription(Float32MultiArray, 'joint_cmd', self.hw_cb, 10)
        self.timer = self.create_timer(0.05, self.log_feedback) # 20Hz
        
        self.get_logger().info(f"Actuator Node Online. Logging to {self.csv_filename}")

    def log_feedback(self):
        positions = []
        for sid in self.active_ids:
            pos, res, err = self.packet_handler.read4ByteTxRx(self.port, sid, self.ADDR_PRESENT)
            if res == COMM_SUCCESS:
                positions.append(cast_to_int32(pos))
            else:
                positions.append(0)

        timestamp = self.get_clock().now().to_msg().nanosec
        self.csv_writer.writerow([timestamp] + positions)
        self.csv_file.flush()

    def hw_cb(self, msg):
        # Prevent publishing if the node is shutting down
        if not rclpy.ok():
            return

        n = len(msg.data) // 3
        ids = [int(x) for x in msg.data[0:n]]
        modes = [int(x) for x in msg.data[n:2*n]]
        goals = [int(x) for x in msg.data[2*n:3*n]]

        for i in range(n):
            sid, mode, goal = ids[i], modes[i], goals[i]
            # Mode switching logic
            self.packet_handler.write1ByteTxRx(self.port, sid, self.ADDR_TORQUE, 0) 
            self.packet_handler.write1ByteTxRx(self.port, sid, self.ADDR_MODE, mode) 
            self.packet_handler.write1ByteTxRx(self.port, sid, self.ADDR_TORQUE, 1) 

            addr = 116 if mode == 3 else 104 
            self.packet_handler.write4ByteTxRx(self.port, sid, addr, int(goal))

    def destroy_node(self):
        self.csv_file.close()
        super().destroy_node()

# --- MAKE SURE THESE ARE AT THE TOP LEVEL (Zero Indentation) ---

def main(args=None):
    rclpy.init(args=args)
    node = ActuatorNode()
    try:
        rclpy.spin(node)
    except KeyboardInterrupt:
        pass
    finally:
        # Check if node exists before destroying to avoid 'invalid context'
        if rclpy.ok():
            node.destroy_node()
            rclpy.shutdown()

if __name__ == '__main__':
    main()

"""
"""
import rclpy
from rclpy.node import Node
from std_msgs.msg import Float32MultiArray
from dynamixel_sdk import *
import ctypes
import csv
import os

def cast_to_int32(value):
    
    return ctypes.c_int32(int(value)).value

class ActuatorNode(Node):
    def __init__(self):
        super().__init__('servo_actuator')
        
        # --- Hardware Initialization ---
        self.port = PortHandler('/dev/ttyUSB0')
        self.packet_handler = PacketHandler(2.0)
        
        if not self.port.openPort() or not self.port.setBaudRate(57600):
            self.get_logger().error("Hardware Link Failed! Check U2D2 and 12V Power.")

        self.feedback_pub = self.create_publisher(Float32MultiArray, 'joint_feedback', 10)

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

        # --- Data Tracking for CSV ---
        self.current_modes = {sid: 3 for sid in self.active_ids}    # Default: Position (3)
        self.goal_commands = {sid: 0.0 for sid in self.active_ids}  # Last commanded goal
        self.prev_encoder = {sid: 0.0 for sid in self.active_ids}   # Value from previous loop
        self.current_encoder = {sid: 0.0 for sid in self.active_ids}# Most recent read

        # --- CSV Setup ---
        self.csv_filename = 'robot_feedback.csv'
        self.csv_file = open(self.csv_filename, 'w', newline='')
        self.csv_writer = csv.writer(self.csv_file)
        
        # Header matching your requested format
        header = ['timestamp', 'servo_id', 'mode', 'prev_state', 'goal_cmd', 'current_state']
        self.csv_writer.writerow(header)
        self.csv_file.flush()

        # --- ROS Communication ---
        self.joint_sub = self.create_subscription(Float32MultiArray, 'joint_cmd', self.hw_cb, 10)
        self.timer = self.create_timer(0.05, self.log_loop) # 20Hz Logging

        self.get_logger().info(f"Actuator Node Online. Logging to {self.csv_filename}")

    def hw_cb(self, msg):
   
        if not rclpy.ok():
            return

        # Expected format: [IDs...], [Modes...], [Goals...]
        n = len(msg.data) // 3
        ids = [int(x) for x in msg.data[0:n]]
        modes = [int(x) for x in msg.data[n:2*n]]
        goals = [float(x) for x in msg.data[2*n:3*n]]

        for i in range(n):
            sid = ids[i]
            mode = modes[i]
            goal = goals[i]

            # 1. Update internal state for logging
            self.current_modes[sid] = mode
            self.goal_commands[sid] = goal

            # 2. Hardware Mode Switching (if mode changed)
            # Toggling torque is required to change operating mode
            self.packet_handler.write1ByteTxRx(self.port, sid, self.ADDR_TORQUE, 0)
            self.packet_handler.write1ByteTxRx(self.port, sid, self.ADDR_MODE, mode)
            self.packet_handler.write1ByteTxRx(self.port, sid, self.ADDR_TORQUE, 1)

            # 3. Write Goal State
            addr = self.ADDR_GOAL_POS if mode == 3 else self.ADDR_GOAL_VEL
            self.packet_handler.write4ByteTxRx(self.port, sid, addr, int(goal))

    def log_loop(self):
       
        timestamp = self.get_clock().now().to_msg().nanosec
        
        for sid in self.active_ids:
            # A. Shift 'current' to 'previous'
            self.prev_encoder[sid] = self.current_encoder[sid]
            
            # B. Read current state from hardware
            raw_pos, res, err = self.packet_handler.read4ByteTxRx(self.port, sid, self.ADDR_PRESENT_POS)
            
            if res == COMM_SUCCESS:
                self.current_encoder[sid] = cast_to_int32(raw_pos)
            else:
                self.get_logger().debug(f"Read failure on ID {sid}")

            # C. Write dynamic row for this specific servo
            row = [
                timestamp,
                sid,
                self.current_modes[sid],
                self.prev_encoder[sid],
                self.goal_commands[sid],
                self.current_encoder[sid]
            ]
            self.csv_writer.writerow(row)
            
        # D. Force update on disk (prevent buffering data loss)
        self.csv_file.flush()

    def destroy_node(self):
       
        self.get_logger().info("Closing CSV and shutting down Actuator Node.")
        self.csv_file.close()
        super().destroy_node()

def main(args=None):
    rclpy.init(args=args)
    node = ActuatorNode()
    try:
        rclpy.spin(node)
    except KeyboardInterrupt:
        pass
    finally:
        # Prevent 'invalid context' error by ensuring cleanup happens correctly
        if rclpy.ok():
            node.destroy_node()
            rclpy.shutdown()

if __name__ == '__main__':
    main()
"""

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

    def publish_feedback(self):
        """Reads hardware and sends it over ROS topic."""
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