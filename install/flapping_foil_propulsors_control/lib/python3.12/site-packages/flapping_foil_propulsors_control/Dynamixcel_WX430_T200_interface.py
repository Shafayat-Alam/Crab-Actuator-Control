import rclpy
from rclpy.node import Node
from std_msgs.msg import Float32MultiArray
from dynamixel_sdk import *
import ctypes
import math

def cast_to_int32(value):
    return ctypes.c_int32(int(value)).value

class Dynamixcel_WX430_T200_interface(Node):
    def __init__(self):
        super().__init__('servo_actuator')
        
        # --- Hardware Initialization ---
        self.port = PortHandler('/dev/ttyUSB0')
        self.packet_handler = PacketHandler(2.0)
        
        if not self.port.openPort() or not self.port.setBaudRate(1000000):
            self.get_logger().error("Hardware Link Failed! Check Baud Rate and Power.")
            
        # Register Addresses
        self.ADDR_TORQUE = 64
        self.ADDR_MODE = 11
        self.ADDR_GOAL_POS = 116 
        self.ADDR_GOAL_VEL = 104
        self.ADDR_PRESENT_POS = 132
        
        self.active_ids = [1, 2, 3, 4]
        self.TICKS_PER_RAD = 4096.0 / (2.0 * math.pi)

        # Initialize Sync Handlers once to save memory/overhead
        self.pos_sync = GroupSyncWrite(self.port, self.packet_handler, self.ADDR_GOAL_POS, 4)
        self.vel_sync = GroupSyncWrite(self.port, self.packet_handler, self.ADDR_GOAL_VEL, 4)
        
        # NEW: SyncRead handler to pull all positions in ONE packet
        self.pos_read_sync = GroupSyncRead(self.port, self.packet_handler, self.ADDR_PRESENT_POS, 4)
        for sid in self.active_ids:
            self.pos_read_sync.addParam(sid)

        # INITIAL SETUP: Set modes and torque ONCE here, not in the loop.
        for sid in self.active_ids:
            self.packet_handler.write1ByteTxRx(self.port, sid, self.ADDR_TORQUE, 0)
            self.packet_handler.write1ByteTxRx(self.port, sid, self.ADDR_MODE, 3) # Default Position Mode
            self.packet_handler.write1ByteTxRx(self.port, sid, self.ADDR_TORQUE, 1)

        # --- ROS Communication ---
        self.feedback_pub = self.create_publisher(Float32MultiArray, 'joint_feedback', 1)
        self.joint_sub = self.create_subscription(Float32MultiArray, 'joint_cmd', self.hw_cb, 1) 
        
       
        self.create_timer(0.01, self.publish_feedback) # 50Hz feedback

        self.get_logger().info("Actuator Node Online. Jitter-optimized with SyncRead/Write.")

    def hw_cb(self, msg):
        """Pure Write-Only Callback: No blocking reads allowed here."""
        if not rclpy.ok(): return

        n = len(msg.data) // 3
        ids = [int(x) for x in msg.data[0:n]]
        modes = [float(x) for x in msg.data[n:2*n]]
        goals = [float(x) for x in msg.data[2*n:3*n]]

        for i in range(n):
            sid, mode, goal = ids[i], modes[i], goals[i]

            if mode == 3.0: # Position Mode
                final_val = int(max(0, min(4095, goal * self.TICKS_PER_RAD)))
            else:
                final_val = int(goal)

            val = [
                DXL_LOBYTE(DXL_LOWORD(final_val)),
                DXL_HIBYTE(DXL_LOWORD(final_val)),
                DXL_LOBYTE(DXL_HIWORD(final_val)),
                DXL_HIBYTE(DXL_HIWORD(final_val))
            ]
            
            if mode == 3.0:
                self.pos_sync.addParam(sid, val)
            else:
                self.vel_sync.addParam(sid, val)

        # Transmit immediately. No waiting for motor responses.
        self.pos_sync.txPacket()
        self.vel_sync.txPacket()
        self.pos_sync.clearParam()
        self.vel_sync.clearParam()

    def publish_feedback(self):
        """Asynchronous feedback using SyncRead to prevent blocking motion."""
        dxl_comm_result = self.pos_read_sync.txRxPacket()
        if dxl_comm_result != COMM_SUCCESS:
            return

        current_positions = []
        for sid in self.active_ids:
            if self.pos_read_sync.isAvailable(sid, self.ADDR_PRESENT_POS, 4):
                raw_pos = self.pos_read_sync.getData(sid, self.ADDR_PRESENT_POS, 4)
                rad_pos = float(cast_to_int32(raw_pos)) / self.TICKS_PER_RAD
                current_positions.append(rad_pos)
            else:
                current_positions.append(-999.0)

        msg = Float32MultiArray()
        msg.data = [float(s) for s in self.active_ids] + current_positions
        self.feedback_pub.publish(msg)   

    def destroy_node(self):
        for sid in self.active_ids:
            self.packet_handler.write1ByteTxRx(self.port, sid, self.ADDR_TORQUE, 0)
        super().destroy_node()

def main(args=None):
    rclpy.init(args=args)
    node = Dynamixcel_WX430_T200_interface()
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