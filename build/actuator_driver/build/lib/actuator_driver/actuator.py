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

        # Parse message: [IDs...], [Modes...], [Goals...]
        n = len(msg.data) // 3
        ids = [int(x) for x in msg.data[0:n]]
        modes = [float(x) for x in msg.data[n:2*n]]
        goals = [float(x) for x in msg.data[2*n:3*n]]

        # Initialize SyncWrite Handlers
        pos_sync = GroupSyncWrite(self.port, self.packet_handler, self.ADDR_GOAL_POS, 4)
        vel_sync = GroupSyncWrite(self.port, self.packet_handler, self.ADDR_GOAL_VEL, 4)

        for i in range(n):
            sid, mode, goal = ids[i], modes[i], goals[i]

            # 1. READ CURRENT STATE ONCE
            torque_status, _, _ = self.packet_handler.read1ByteTxRx(self.port, sid, self.ADDR_TORQUE)
            
            # --- 2. HANDLE TORQUE-ONLY FLAG (-1.0) ---
            if mode == -1.0:
                if torque_status == 0:
                    self.packet_handler.write1ByteTxRx(self.port, sid, self.ADDR_TORQUE, 1)
                    self.get_logger().info(f"ID {sid}: Torque ENABLED (Holding position)")
                # Skip the rest of the processing for this ID
                continue

            # --- 3. STANDARD OPERATING GUARDS (Mode/Torque) ---
            current_hw_mode, _, _ = self.packet_handler.read1ByteTxRx(self.port, sid, self.ADDR_MODE)

            # Mode Guard: Only switch if the commanded mode is a real DXL mode (like 3 or 4)
            if current_hw_mode != int(mode):
                self.packet_handler.write1ByteTxRx(self.port, sid, self.ADDR_TORQUE, 0) 
                self.packet_handler.write1ByteTxRx(self.port, sid, self.ADDR_MODE, int(mode))
                self.packet_handler.write1ByteTxRx(self.port, sid, self.ADDR_TORQUE, 1) 
                torque_status = 1 # Update local variable since we just turned it on
            
            # Torque Guard: Ensure it's on for motion
            if torque_status == 0:
                self.packet_handler.write1ByteTxRx(self.port, sid, self.ADDR_TORQUE, 1)

            # --- 4. DATA PROCESSING & PACKING ---
            if mode == 3.0: # Position Mode
                tick_goal = int(goal * TICKS_PER_RAD)
                final_val = max(0, min(4095, tick_goal))
            else:          # Velocity or other modes
                final_val = int(goal)

            val = [
                DXL_LOBYTE(DXL_LOWORD(final_val)),
                DXL_HIBYTE(DXL_LOWORD(final_val)),
                DXL_LOBYTE(DXL_HIWORD(final_val)),
                DXL_HIBYTE(DXL_HIWORD(final_val))
            ]
            
            if mode == 3.0:
                pos_sync.addParam(sid, val)
            else:
                vel_sync.addParam(sid, val)

        # 5. TRANSMIT MOTION COMMANDS
        pos_sync.txPacket()
        vel_sync.txPacket()
        pos_sync.clearParam()
        vel_sync.clearParam()

        # 6. READ FEEDBACK & PUBLISH
        feedback_msg = Float32MultiArray()
        current_positions = []
        for sid in ids:
            raw_pos, res, err = self.packet_handler.read4ByteTxRx(self.port, sid, self.ADDR_PRESENT_POS)
            if res == 0:
                # Use cast_to_int32 to handle signed overflow if in extended position mode
                rad_pos = float(cast_to_int32(raw_pos)) / TICKS_PER_RAD
                current_positions.append(rad_pos)
            else:
                current_positions.append(-999.0) # Distinguishable error value
        
        feedback_msg.data = [float(s) for s in ids] + current_positions
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