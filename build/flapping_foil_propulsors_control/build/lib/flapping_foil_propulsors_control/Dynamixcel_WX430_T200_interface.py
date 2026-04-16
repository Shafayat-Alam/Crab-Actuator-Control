import rclpy
from rclpy.node import Node
from std_msgs.msg import Float32MultiArray
from dynamixel_sdk import *
import ctypes
import math
import time

def cast_to_int32(value):
    return ctypes.c_int32(int(value)).value

class Dynamixcel_WX430_T200_interface(Node):
    def __init__(self):
        super().__init__('servo_actuator')
        
        self.port = PortHandler('/dev/ttyUSB0')
        self.packet_handler = PacketHandler(2.0)
        
        if not self.port.openPort() or not self.port.setBaudRate(1000000):
            self.get_logger().error("Hardware Link Failed at 4Mbps!")

        self.ADDR_TORQUE = 64
        self.ADDR_MODE = 11
        self.ADDR_PROF_ACCEL = 108
        self.ADDR_PROF_VEL = 112
        
        self.TICKS_PER_RAD = 4096.0 / (2.0 * math.pi)
        self.VEL_UNIT_TO_RADS = 0.229 * (2.0 * math.pi / 60.0)

        self.latest_command = None 
        self.active_ids = []
        self.id_modes = {}
        self.is_configured = False
        self.is_configuring = False 

        self.feedback_pub = self.create_publisher(Float32MultiArray, 'joint_feedback', 1)
        self.joint_sub = self.create_subscription(Float32MultiArray, 'joint_cmd', self.ros_cb, 1)

        # 1kHz control loop
        self.control_timer = self.create_timer(0.001, self.hardware_loop)
        self.get_logger().info("Interface Node Ready (4Mbps).")

    def ros_cb(self, msg):
        try:
            n = len(msg.data) // 3
            if n == 0: return
            self.latest_command = (
                [int(round(x)) for x in msg.data[0:n]],
                [int(round(x)) for x in msg.data[n:2*n]],
                [float(x) for x in msg.data[2*n:3*n]]
            )
        except Exception: pass

    def hardware_loop(self):
        if self.latest_command is None or self.is_configuring: 
            return
        
        ids, modes, goals = self.latest_command
        if not ids: return

        if not self.is_configured:
            self.setup_sync_io(ids, modes)
            return

        try:
            # WRITE PHASE
            for i, sid in enumerate(ids):
                if sid not in self.active_ids: continue
                mode, goal = modes[i], goals[i]

                final_val = int(goal * self.TICKS_PER_RAD) if mode == 3 else int(goal)
                
                low_word = final_val & 0xFFFF
                high_word = (final_val >> 16) & 0xFFFF
                val = [DXL_LOBYTE(low_word), DXL_HIBYTE(low_word),
                       DXL_LOBYTE(high_word), DXL_HIBYTE(high_word)]
                
                target = self.pos_sync if mode == 3 else self.vel_sync
                target.addParam(sid, val)

            self.pos_sync.txPacket()
            self.pos_sync.clearParam()
            self.vel_sync.txPacket()
            self.vel_sync.clearParam()

            # READ PHASE
            if self.feedback_read_sync.txRxPacket() == COMM_SUCCESS:
                fb_data = []
                for sid in self.active_ids:
                    if self.feedback_read_sync.isAvailable(sid, 126, 20):
                        curr = self.feedback_read_sync.getData(sid, 126, 2)
                        vel  = self.feedback_read_sync.getData(sid, 128, 4)
                        pos  = self.feedback_read_sync.getData(sid, 132, 4)
                        volt = self.feedback_read_sync.getData(sid, 144, 2)
                        fb_data.extend([
                            float(sid), float(self.id_modes[sid]),
                            float(cast_to_int32(pos)) / self.TICKS_PER_RAD,
                            float(cast_to_int32(vel)) * self.VEL_UNIT_TO_RADS,
                            float(ctypes.c_int16(curr).value) * 0.001,
                            float(volt) * 0.1
                        ])
                if fb_data:
                    msg = Float32MultiArray()
                    msg.data = fb_data
                    self.feedback_pub.publish(msg)
        
        except (ValueError, TypeError):
            pass 
        except Exception as e:
            self.get_logger().error(f"Loop Failure: {e}")

    def setup_sync_io(self, ids, modes):
        self.is_configuring = True
        self.get_logger().info("Applying Code Band-Aid (Traj Smoothing)...")
        
        self.port.clearPort()
        self.active_ids = ids
        self.pos_sync = GroupSyncWrite(self.port, self.packet_handler, 116, 4)
        self.vel_sync = GroupSyncWrite(self.port, self.packet_handler, 104, 4)
        self.feedback_read_sync = GroupSyncRead(self.port, self.packet_handler, 126, 20)
        
        for i, sid in enumerate(ids):
            m = modes[i]
            self.id_modes[sid] = m
            
            # 1. Torque Off to configure
            self.packet_handler.write1ByteTxRx(self.port, sid, self.ADDR_TORQUE, 0)
            time.sleep(0.02)
            
            # 2. Set Operating Mode
            self.packet_handler.write1ByteTxRx(self.port, sid, self.ADDR_MODE, m)
            
            #self.packet_handler.write4ByteTxRx(self.port, sid, self.ADDR_PROF_ACCEL, 50)
            #self.packet_handler.write4ByteTxRx(self.port, sid, self.ADDR_PROF_VEL, 500)
            
            # 4. Zero Return Delay for 4Mbps stability
            self.packet_handler.write1ByteTxRx(self.port, sid, 9, 0) 
            time.sleep(0.02)
            
            # 5. Torque On
            res, err = self.packet_handler.write1ByteTxRx(self.port, sid, self.ADDR_TORQUE, 1)
            
            if res == COMM_SUCCESS and err == 0:
                self.get_logger().info(f"ID {sid}: LOCKED & SMOOTHED")
                self.feedback_read_sync.addParam(sid)
            else:
                self.get_logger().error(f"ID {sid}: SETUP FAIL")
            
        self.is_configured = True
        self.is_configuring = False

    def destroy_node(self):
        for sid in self.active_ids:
            try:
                self.packet_handler.write1ByteTxRx(self.port, sid, self.ADDR_TORQUE, 0)
            except: pass
        self.port.closePort()
        super().destroy_node()

def main(args=None):
    rclpy.init(args=args)
    node = Dynamixcel_WX430_T200_interface()
    try:
        rclpy.spin(node)
    except KeyboardInterrupt: pass
    finally:
        node.destroy_node()
        rclpy.shutdown()

if __name__ == '__main__':
    main()