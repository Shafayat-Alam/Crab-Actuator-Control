import rclpy
from rclpy.node import Node
from rclpy.callback_groups import ReentrantCallbackGroup
from rclpy.executors import MultiThreadedExecutor
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
            self.get_logger().error("Hardware Link Failed! Check Connection and Power.")
            
        # Register Addresses
        self.ADDR_TORQUE = 64
        self.ADDR_MODE = 11
        self.ADDR_GOAL_POS = 116 
        self.ADDR_GOAL_VEL = 104
        
        # Feedback Block Addresses (Registers 126 to 144)
        self.ADDR_PRESENT_CURR = 126 
        self.ADDR_PRESENT_VEL  = 128 
        self.ADDR_PRESENT_POS  = 132 
        self.ADDR_PRESENT_VOLT = 144 
        
        # Calculation Constants
        self.TICKS_PER_RAD = 4096.0 / (2.0 * math.pi)
        self.VEL_UNIT_TO_RADS = 0.229 * (2.0 * math.pi / 60.0)

        # Configuration State
        self.active_ids = []
        self.id_modes = {} 
        self.is_configured = False
        
        self.pos_sync = None
        self.vel_sync = None
        self.feedback_read_sync = None

        # --- Multi-Threading Setup ---
        # Reentrant group allows callbacks to run in parallel without blocking each other
        self.callback_group = ReentrantCallbackGroup()

        # --- ROS Communication ---
        self.feedback_pub = self.create_publisher(Float32MultiArray, 'joint_feedback', 1)
        
        # Assign callback group to Subscriber
        self.joint_sub = self.create_subscription(
            Float32MultiArray, 
            'joint_cmd', 
            self.hw_cb, 
            1, 
            callback_group=self.callback_group) 
        
        # Assign callback group to Timer
        self.feedback_timer = self.create_timer(
            0.01, 
            self.publish_feedback, 
            callback_group=self.callback_group) # 100Hz

        self.get_logger().info("Interface Waiting for first joint_cmd to configure IDs...")

    def configure_hardware(self, ids, initial_modes):
        self.active_ids = ids
        self.get_logger().info(f"Configuring hardware for IDs: {self.active_ids}")

        self.pos_sync = GroupSyncWrite(self.port, self.packet_handler, self.ADDR_GOAL_POS, 4)
        self.vel_sync = GroupSyncWrite(self.port, self.packet_handler, self.ADDR_GOAL_VEL, 4)
        
        # Read block: Current(126) to Voltage(144) = 20 bytes
        self.feedback_read_sync = GroupSyncRead(self.port, self.packet_handler, self.ADDR_PRESENT_CURR, 20)

        for i, sid in enumerate(self.active_ids):
            mode = int(initial_modes[i])
            self.id_modes[sid] = float(mode)
            
            self.packet_handler.write1ByteTxRx(self.port, sid, 9, 0) # Set return delay to 0
            self.packet_handler.write1ByteTxRx(self.port, sid, self.ADDR_MODE, mode)
            self.feedback_read_sync.addParam(sid)

        self.is_configured = True
        self.get_logger().info("Hardware Configuration Complete. Multi-threaded feedback active.")

    def hw_cb(self, msg):
        if not rclpy.ok(): return
        
        n = len(msg.data) // 3
        incoming_ids = [int(x) for x in msg.data[0:n]]
        modes = [float(x) for x in msg.data[n:2*n]]
        goals = [float(x) for x in msg.data[2*n:3*n]]

        if not self.is_configured:
            self.configure_hardware(incoming_ids, modes)

        for i in range(n):
            sid, mode, goal = incoming_ids[i], modes[i], goals[i]
            if sid not in self.active_ids: continue

            if self.id_modes[sid] != mode:
                self.packet_handler.write1ByteTxRx(self.port, sid, self.ADDR_TORQUE, 0)
                self.packet_handler.write1ByteTxRx(self.port, sid, self.ADDR_MODE, int(mode))
                self.id_modes[sid] = mode

            if mode == 3.0:
                final_val = int(max(0, min(4095, goal * self.TICKS_PER_RAD)))
            else:
                final_val = int(goal)

            val = [DXL_LOBYTE(DXL_LOWORD(final_val)), DXL_HIBYTE(DXL_LOWORD(final_val)),
                   DXL_LOBYTE(DXL_HIWORD(final_val)), DXL_HIBYTE(DXL_HIWORD(final_val))]
            
            if mode == 3.0:
                self.pos_sync.addParam(sid, val)
            else:
                self.vel_sync.addParam(sid, val)

        if self.pos_sync: self.pos_sync.txPacket()
        if self.vel_sync: self.vel_sync.txPacket()
        self.pos_sync.clearParam()
        self.vel_sync.clearParam()

    def publish_feedback(self):
        if not self.is_configured: return

        dxl_comm_result = self.feedback_read_sync.txRxPacket()
        if dxl_comm_result != COMM_SUCCESS: return

        feedback_data = []
        for sid in self.active_ids:
            if self.feedback_read_sync.isAvailable(sid, self.ADDR_PRESENT_CURR, 20):
                curr_raw = self.feedback_read_sync.getData(sid, self.ADDR_PRESENT_CURR, 2)
                vel_raw  = self.feedback_read_sync.getData(sid, self.ADDR_PRESENT_VEL, 4)
                pos_raw  = self.feedback_read_sync.getData(sid, self.ADDR_PRESENT_POS, 4)
                volt_raw = self.feedback_read_sync.getData(sid, self.ADDR_PRESENT_VOLT, 2)

                current_amps = float(ctypes.c_int16(curr_raw).value) * 0.001
                velocity_rads = float(cast_to_int32(vel_raw)) * self.VEL_UNIT_TO_RADS
                position_rad = float(cast_to_int32(pos_raw)) / self.TICKS_PER_RAD
                voltage_v = float(volt_raw) * 0.1
                mode = self.id_modes[sid]

                feedback_data.extend([float(sid), mode, position_rad, velocity_rads, current_amps, voltage_v])

        if feedback_data:
            msg = Float32MultiArray()
            msg.data = feedback_data
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
    
    # --- Multi-threaded Executor ---
    executor = MultiThreadedExecutor()
    executor.add_node(node)
    
    try:
        executor.spin()
    except KeyboardInterrupt:
        pass
    finally:
        node.destroy_node()
        rclpy.shutdown()

if __name__ == '__main__':
    main()