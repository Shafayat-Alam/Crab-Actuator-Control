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
        
        if not self.port.openPort() or not self.port.setBaudRate(3000000):
            self.get_logger().error("Hardware Link Failed! Check Baud Rate and Power.")
            
        # Register Addresses
        self.ADDR_TORQUE = 64
        self.ADDR_MODE = 11
        self.ADDR_GOAL_POS = 116 
        self.ADDR_GOAL_VEL = 104
        self.ADDR_PRESENT_POS = 132
        
        self.TICKS_PER_RAD = 4096.0 / (2.0 * math.pi)

        # Configuration State
        self.active_ids = []
        self.is_configured = False
        
        # Sync Handlers (Will be initialized once IDs are known)
        self.pos_sync = None
        self.vel_sync = None
        self.pos_read_sync = None

        # --- ROS Communication ---
        self.feedback_pub = self.create_publisher(Float32MultiArray, 'joint_feedback', 1)
        self.joint_sub = self.create_subscription(Float32MultiArray, 'joint_cmd', self.hw_cb, 1) 
        
        # Feedback timer (only starts publishing once configured)
        self.feedback_timer = self.create_timer(0.01, self.publish_feedback)

        self.get_logger().info("Interface Waiting for first joint_cmd to configure IDs...")

    def configure_hardware(self, ids):
        """Initializes Sync Handlers and Motor Modes based on received IDs."""
        self.active_ids = ids
        self.get_logger().info(f"Configuring hardware for IDs: {self.active_ids}")

        # Initialize SyncWrite Handlers
        self.pos_sync = GroupSyncWrite(self.port, self.packet_handler, self.ADDR_GOAL_POS, 4)
        self.vel_sync = GroupSyncWrite(self.port, self.packet_handler, self.ADDR_GOAL_VEL, 4)
        
        # Initialize SyncRead Handler
        self.pos_read_sync = GroupSyncRead(self.port, self.packet_handler, self.ADDR_PRESENT_POS, 4)

        for sid in self.active_ids:
            # Set Return Delay to 0
            self.packet_handler.write1ByteTxRx(self.port, sid, 9, 0)
            # Set to Position Mode (3) as default, but leave TORQUE OFF
            self.packet_handler.write1ByteTxRx(self.port, sid, self.ADDR_MODE, 3)
            # Register ID for reading
            self.pos_read_sync.addParam(sid)

        self.is_configured = True
        self.get_logger().info("Hardware Configuration Complete. Torque remains OFF.")

    def hw_cb(self, msg):
        if not rclpy.ok(): return

        # Extract data
        n = len(msg.data) // 3
        incoming_ids = [int(x) for x in msg.data[0:n]]
        modes = [float(x) for x in msg.data[n:2*n]]
        goals = [float(x) for x in msg.data[2*n:3*n]]

        # Trigger configuration on the very first message
        if not self.is_configured:
            self.configure_hardware(incoming_ids)

        for i in range(n):
            sid, mode, goal = incoming_ids[i], modes[i], goals[i]
            
            # Safety: Ignore IDs that weren't part of the initial configuration
            if sid not in self.active_ids:
                continue

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

        # Transmit
        if self.pos_sync: self.pos_sync.txPacket()
        if self.vel_sync: self.vel_sync.txPacket()
        
        self.pos_sync.clearParam()
        self.vel_sync.clearParam()

    def publish_feedback(self):
        if not self.is_configured:
            return

        dxl_comm_result = self.pos_read_sync.txRxPacket()
        
        if dxl_comm_result == COMM_SUCCESS:
            current_positions = []
            for sid in self.active_ids:
                if self.pos_read_sync.isAvailable(sid, self.ADDR_PRESENT_POS, 4):
                    raw_pos = self.pos_read_sync.getData(sid, self.ADDR_PRESENT_POS, 4)
                    rad_pos = float(cast_to_int32(raw_pos)) / self.TICKS_PER_RAD
                    current_positions.append(rad_pos)
                else:
                    current_positions.append(0.0)

            msg = Float32MultiArray()
            msg.data = [float(s) for s in self.active_ids] + current_positions
            self.feedback_pub.publish(msg)

    def destroy_node(self):
        if self.is_configured:
            for sid in self.active_ids:
                self.packet_handler.write1ByteTxRx(self.port, sid, self.ADDR_TORQUE, 0)
        self.port.closePort()
        super().destroy_node()

def main(args=None):
    rclpy.init(args=args)
    node = Dynamixcel_WX430_T200_interface()
    try:
        rclpy.spin(node) 
    except KeyboardInterrupt:
        pass
    finally:
        node.destroy_node()
        rclpy.shutdown()

if __name__ == '__main__':
    main()