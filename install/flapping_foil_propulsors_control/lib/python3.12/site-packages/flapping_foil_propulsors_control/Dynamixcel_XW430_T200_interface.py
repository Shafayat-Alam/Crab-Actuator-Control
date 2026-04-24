import rclpy
from rclpy.node import Node
from std_msgs.msg import Float32MultiArray
from dynamixel_sdk import *
import ctypes
import math
import time

def cast_to_int32(value):
    """Converts unsigned raw bytes from Dynamixel registers to signed 32-bit integers."""
    return ctypes.c_int32(int(value)).value

class Dynamixel_XW430_T200_interface(Node):
    """
    Low-level Hardware Interface for Dynamixel XW430 servos.
    Handles the translation between ROS2 engineering units (Radians, Rad/s) 
    and hardware-specific ticks/register values using GroupSyncRead/Write.
    """
    def __init__(self):
        super().__init__('servo_actuator')
        
        # --- Hardware Communication Layer ---
        self.port = PortHandler('/dev/ttyUSB0')
        self.packet_handler = PacketHandler(2.0) # Using Protocol 2.0
        
        if not self.port.openPort() or not self.port.setBaudRate(1000000):
            self.get_logger().error("Hardware Link Failed! Check U2D2 connection and latency timer.")

        # --- Control Table Addresses (XW430 Reference) ---
        self.ADDR_TORQUE       = 64
        self.ADDR_MODE         = 11   # 1: Velocity, 3: Position, 4: Extended Position
        self.ADDR_GOAL_VEL     = 104  # 4-byte write
        self.ADDR_GOAL_POS     = 116  # 4-byte write
        self.ADDR_PRESENT_DATA = 126  # Starting address for bulk feedback (Curr, Vel, Pos)

        # --- Unit Conversion Constants ---
        self.TICKS_PER_RAD = 4096.0 / (2.0 * math.pi)
        self.RADS_TO_VEL_UNIT = 1.0 / (0.229 * (2.0 * math.pi / 60.0))
        self.VEL_UNIT_TO_RADS = 0.229 * (2.0 * math.pi / 60.0)

        # --- Internal State & Configuration Flags ---
        self.latest_command = None 
        self.active_ids = []
        self.id_modes = {}      
        self.is_configured = False
        self.is_configuring = False 

        # --- ROS2 Interfaces ---
        self.feedback_pub = self.create_publisher(Float32MultiArray, 'joint_feedback', 1)
        self.joint_sub = self.create_subscription(Float32MultiArray, 'joint_cmd', self.ros_cb, 1)

        # 0.002 (500Hz) 
        self.control_timer = self.create_timer(0.002, self.hardware_loop)
        self.get_logger().info("XW430 Interface Node Online (1.0 Mbps @ 1000Hz).")

    def ros_cb(self, msg):
        """Processes and validates incoming joint commands."""
        try:
            n = len(msg.data) // 3 #split up data in 3 chunks
            if n == 0: return
            #setup latest_command variable for to capture what data to use
            self.latest_command = (
                [int(round(x)) for x in msg.data[0:n]],
                [int(round(x)) for x in msg.data[n:2*n]],
                [float(x) for x in msg.data[2*n:3*n]]
            )
        except Exception as e:
            self.get_logger().warn(f"Invalid joint command received: {e}")

    def hardware_loop(self):
        """Execute the Write-Read cycle on the RS485 bus."""
        if self.latest_command is None or self.is_configuring: return #If there is no incoming data (latest_command) or its configuring, don't write/read to/from hardware
        
        ids, modes, goals = self.latest_command #Extract data chunks from latest_command into variables
        if not ids: return

        #if not configured indicated by variables is_configured, call function to condigure
        if not self.is_configured or self.check_mode_change(ids, modes):
            self.setup_sync_io(ids, modes)
            return

        try:
            # --- PHASE 1: SYNC WRITE ---
            for i, sid in enumerate(ids):
                if sid not in self.active_ids: continue
                mode, goal = modes[i], goals[i]

                #Convert radians to raw tick values 
                raw_val = int(goal * self.TICKS_PER_RAD) if mode == 3 else int(goal * self.RADS_TO_VEL_UNIT)
                
                #split 32 bit integer from packet into 4 bytes to send to port
                byte_array = [DXL_LOBYTE(DXL_LOWORD(raw_val)), DXL_HIBYTE(DXL_LOWORD(raw_val)),
                             DXL_LOBYTE(DXL_HIWORD(raw_val)), DXL_HIBYTE(DXL_HIWORD(raw_val))]
                
                #Setup addParams for GroupSyncWrite 
                if mode == 3: 
                    self.pos_sync.addParam(sid, byte_array)
                else: 
                    self.vel_sync.addParam(sid, byte_array)

            #Send 1 byte at a time data to port 
            self.pos_sync.txPacket()
            self.pos_sync.clearParam()
            self.vel_sync.txPacket()
            self.vel_sync.clearParam()

            # --- PHASE 2: SYNC READ ---
            if self.feedback_read_sync.txRxPacket() == COMM_SUCCESS:
                fb_data = []
                for sid in self.active_ids:
                    if self.feedback_read_sync.isAvailable(sid, self.ADDR_PRESENT_DATA, 20):
                        # Use ADDR_PRESENT_DATA as base for relative offsets
                        curr = self.feedback_read_sync.getData(sid, self.ADDR_PRESENT_DATA, 2)
                        vel  = self.feedback_read_sync.getData(sid, self.ADDR_PRESENT_DATA + 2, 4)
                        pos  = self.feedback_read_sync.getData(sid, self.ADDR_PRESENT_DATA + 6, 4)
                        volt = self.feedback_read_sync.getData(sid, self.ADDR_PRESENT_DATA + 18, 2)
                        
                        #Add all feedback values from addresses to array
                        fb_data.extend([
                            float(sid), 
                            float(self.id_modes[sid]),
                            float(cast_to_int32(pos)) / self.TICKS_PER_RAD,
                            float(cast_to_int32(vel)) * self.VEL_UNIT_TO_RADS,
                            float(ctypes.c_int16(curr).value) * 0.00269, # Correct scaling for X-series
                            float(volt) * 0.1                            # 0.1V units
                        ])
                
                #publish data to joint_feedback topic
                if fb_data:
                    msg = Float32MultiArray()
                    msg.data = fb_data
                    self.feedback_pub.publish(msg)
                    
        
        except Exception as e:
            self.get_logger().error(f"Critical error in hardware loop: {e}")

    def check_mode_change(self, ids, modes):
        """Compares current hardware state vs requested mode to trigger reconfiguration."""
        for i, sid in enumerate(ids):
            if sid in self.id_modes and self.id_modes[sid] != modes[i]:
                return True
        return False

    def setup_sync_io(self, ids, modes):
        """Sets hardware Operating Modes and resets sync handlers."""
        self.is_configuring = True
        self.get_logger().info("Configuring Servo Operating Modes...")
        
        self.port.clearPort()
        self.active_ids = ids
        
        #Initialize GroupSyncrWrite and GroupSyncrRead
        self.pos_sync = GroupSyncWrite(self.port, self.packet_handler, self.ADDR_GOAL_POS, 4)
        self.vel_sync = GroupSyncWrite(self.port, self.packet_handler, self.ADDR_GOAL_VEL, 4)
        self.feedback_read_sync = GroupSyncRead(self.port, self.packet_handler, self.ADDR_PRESENT_DATA, 20)
        
        #Set the correct mode received 
        for i, sid in enumerate(ids):
            m = modes[i]
            self.id_modes[sid] = m
            
            self.packet_handler.write1ByteTxRx(self.port, sid, self.ADDR_TORQUE, 0)
            time.sleep(0.02) 
            self.packet_handler.write1ByteTxRx(self.port, sid, self.ADDR_MODE, int(m))
            self.packet_handler.write1ByteTxRx(self.port, sid, self.ADDR_TORQUE, 1)
            
            self.feedback_read_sync.addParam(sid)
            
        #set state of configuration true/false using variables
        self.is_configured = True
        self.is_configuring = False
        self.get_logger().info("Hardware Reconfiguration Complete.")

    def destroy_node(self):
        """Releases torque on all active joints during shutdown."""
        self.get_logger().info("Shutting down: Releasing torque...")
        for sid in self.active_ids:
            try: 
                self.packet_handler.write1ByteTxRx(self.port, sid, self.ADDR_TORQUE, 0)
            except: 
                pass
        self.port.closePort()
        super().destroy_node()

def main(args=None):
    rclpy.init(args=args)
    node = Dynamixel_XW430_T200_interface()
    try:
        rclpy.spin(node)
    except KeyboardInterrupt: 
        pass
    finally:
        node.destroy_node()
        rclpy.shutdown()

if __name__ == '__main__':
    main()