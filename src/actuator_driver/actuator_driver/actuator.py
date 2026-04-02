import rclpy
from rclpy.node import Node
from std_msgs.msg import Float32MultiArray
#from dynamixel_sdk import GroupSyncWrite
from dynamixel_sdk import *
import ctypes
import math

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
        """
        # Torque Enable on Start
        for sid in self.active_ids:
            self.packet_handler.write1ByteTxRx(self.port, sid, self.ADDR_TORQUE, 1)
        """
        # --- ROS Communication ---
         # Publishes hardware state back to Controller
        self.feedback_pub = self.create_publisher(Float32MultiArray, 'joint_feedback', 10)

        # Subscribes to goals from Controller
        self.joint_sub = self.create_subscription(Float32MultiArray, 'joint_cmd', self.hw_cb, 10)
                
        # 20Hz Timer just to read hardware and publish (No CSV here)
        #self.timer = self.create_timer(0.05, self.publish_feedback)

        # Inside __init__
        self.TICKS_PER_RAD = 4096.0 / (2.0 * 3.14159265)
        self.CENTER_TICK = 2048

        self.get_logger().info("Actuator Node Online. (Pure Hardware Driver)")
    
    def hw_cb(self, msg):
        if not rclpy.ok(): return

        TICKS_PER_RAD = 4096.0 / (2.0 * math.pi)

        n = len(msg.data) // 3
        ids = [int(x) for x in msg.data[0:n]]
        modes = [int(x) for x in msg.data[n:2*n]]
        goals = [float(x) for x in msg.data[2*n:3*n]]

        # 1. Initialize SyncWrite Handlers
        pos_sync = GroupSyncWrite(self.port, self.packet_handler, self.ADDR_GOAL_POS, 4)
        vel_sync = GroupSyncWrite(self.port, self.packet_handler, self.ADDR_GOAL_VEL, 4)

        # --- LOOP 1: HARDWARE STATE GUARDS & PACK DATA ---
        for i in range(n):
            sid, mode, goal = ids[i], modes[i], goals[i]

            # --- DYNAMIC HARDWARE CHECK ---
            # Read current Torque and Mode status in one go (if possible) or sequentially
            torque_status, _, _ = self.packet_handler.read1ByteTxRx(self.port, sid, self.ADDR_TORQUE)
            current_hw_mode, _, _ = self.packet_handler.read1ByteTxRx(self.port, sid, self.ADDR_MODE)

            # 1. Mode Guard: Switch mode if it doesn't match
            if current_hw_mode != mode:
                self.packet_handler.write1ByteTxRx(self.port, sid, self.ADDR_TORQUE, 0) # Force OFF to change mode
                self.packet_handler.write1ByteTxRx(self.port, sid, self.ADDR_MODE, mode)
                self.packet_handler.write1ByteTxRx(self.port, sid, self.ADDR_TORQUE, 1) # Relock
            
            # 2. Torque Guard: Enable torque if it's currently OFF (0)
            elif torque_status == 0:
                self.packet_handler.write1ByteTxRx(self.port, sid, self.ADDR_TORQUE, 1)

            # --- DATA PROCESSING ---
            if mode == 3: # Position Mode
                tick_goal = int(goal * TICKS_PER_RAD)
                final_val = max(0, min(4095, tick_goal))
            else:         # Velocity/Extended Mode
                final_val = int(goal)

            val = [
                DXL_LOBYTE(DXL_LOWORD(final_val)),
                DXL_HIBYTE(DXL_LOWORD(final_val)),
                DXL_LOBYTE(DXL_HIWORD(final_val)),
                DXL_HIBYTE(DXL_HIWORD(final_val))
            ]
            
            if mode == 3:
                pos_sync.addParam(sid, val)
            else:
                vel_sync.addParam(sid, val)

        # --- 2. TRANSMIT ONCE ---
        pos_sync.txPacket()
        vel_sync.txPacket()

        # --- 3. CLEANUP ---
        pos_sync.clearParam()
        vel_sync.clearParam()

        # --- 4. READ FEEDBACK ---
        feedback_msg = Float32MultiArray()
        current_positions = []
        for sid in ids:
            raw_pos, res, err = self.packet_handler.read4ByteTxRx(self.port, sid, self.ADDR_PRESENT_POS)
            if res == 0:
                rad_pos = float(raw_pos) / TICKS_PER_RAD
                current_positions.append(rad_pos)
            else:
                current_positions.append(-1.0) 
        
        feedback_msg.data = [float(sid) for sid in ids] + current_positions
        self.feedback_pub.publish(feedback_msg)
    
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