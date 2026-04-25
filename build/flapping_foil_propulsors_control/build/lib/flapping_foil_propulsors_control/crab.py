import rclpy
from rclpy.node import Node
from std_msgs.msg import String, Float32MultiArray
from sensor_msgs.msg import Image
from cv_bridge import CvBridge, CvBridgeError
import cv2
import os
from collections import deque
import time
import numpy as np

class Crab(Node):
    def __init__(self):
        super().__init__('crab_gatekeeper')
        
        self.state = "IDLE" 
        self.command_count = 0 
        self.cmd_queue = deque()
        
        # --- Camera & Recording Setup ---
        self.bridge = CvBridge()
        self.video_writer = None
        self.save_directory = os.path.expanduser('~/Desktop/flipper_code/flapping-foil-propulsors-control/videos/')
        os.makedirs(self.save_directory, exist_ok=True)
        
        self.current_cmd_duration = 0.0
        self.current_cmd_start_time = 0.0
        self.current_video_path = None
        self.frame_count = 0
        self.last_error_time = 0
        self.error_cooldown = 5.0  # Seconds between error logs

        # --- ROS2 Interfaces ---
        self.motion_pub = self.create_publisher(String, 'motion_cmd', 10)
        self.cmd_sub = self.create_subscription(String, 'robot_cmd', self.manual_cmd_cb, 10)
        self.tele_sub = self.create_subscription(Float32MultiArray, 'telemetry', self.telemetry_cb, 10)
        self.cam_sub = self.create_subscription(Image, '/image_raw', self.camera_cb, 10)
        
        self.get_logger().info(f"Gatekeeper Online. Saving videos to: {self.save_directory}")

    def safe_convert_image(self, msg):
        """Safely convert ROS Image message to OpenCV image."""
        try:
            # Print encoding for debugging (once)
            if not hasattr(self, '_encoding_logged'):
                self.get_logger().info(f"Image encoding: {msg.encoding}")
                self._encoding_logged = True
            
            # Handle different encodings
            if msg.encoding in ['yuv422_yuy2', 'yuv422']:
                return self.bridge.imgmsg_to_cv2(msg, desired_encoding='bgr8')
            elif msg.encoding == 'mjpeg':
                # For MJPG, we need to decode the JPEG data
                import cv2
                import numpy as np
                # Convert to numpy array and decode
                np_arr = np.frombuffer(msg.data, np.uint8)
                img = cv2.imdecode(np_arr, cv2.IMREAD_COLOR)
                if img is None:
                    raise ValueError("Failed to decode MJPG image")
                return img
            elif msg.encoding == 'rgb8':
                return self.bridge.imgmsg_to_cv2(msg, desired_encoding='bgr8')
            else:
                # Try default conversion
                return self.bridge.imgmsg_to_cv2(msg, desired_encoding='bgr8')
                
        except CvBridgeError as e:
            current_time = time.time()
            if current_time - self.last_error_time > self.error_cooldown:
                self.get_logger().error(f"CvBridge Error: {e}")
                self.last_error_time = current_time
            return None
        except Exception as e:
            current_time = time.time()
            if current_time - self.last_error_time > self.error_cooldown:
                self.get_logger().error(f"Image conversion error: {e}")
                self.last_error_time = current_time
            return None

    def camera_cb(self, msg):
        """Captures frames and dynamically initializes the writer."""
        if self.state != "ACTIVE":
            return
            
        cv_img = self.safe_convert_image(msg)
        if cv_img is None:
            return
        
        try:
            # Dynamic Initialization
            if self.video_writer is None:
                h, w = cv_img.shape[:2]
                
                # Create filename with timestamp
                timestamp = time.strftime("%Y%m%d_%H%M%S")
                self.current_video_path = os.path.join(
                    self.save_directory, 
                    f"cmd_{self.command_count}_{timestamp}.avi"  # Use AVI for better compatibility
                )
                
                # Use MJPG codec inside AVI container
                fourcc = cv2.VideoWriter_fourcc(*'MJPG')
                self.video_writer = cv2.VideoWriter(
                    self.current_video_path, fourcc, 30.0, (w, h)
                )
                
                if not self.video_writer.isOpened():
                    # Fallback to raw AVI
                    fourcc = cv2.VideoWriter_fourcc(*'XVID')
                    self.video_writer = cv2.VideoWriter(
                        self.current_video_path, fourcc, 30.0, (w, h)
                    )
                
                self.frame_count = 0
                self.get_logger().info(
                    f"RECORDING START: {self.current_video_path} at {w}x{h}"
                )

            if self.video_writer and self.video_writer.isOpened():
                self.video_writer.write(cv_img)
                self.frame_count += 1
                
        except Exception as e:
            current_time = time.time()
            if current_time - self.last_error_time > self.error_cooldown:
                self.get_logger().error(f"Video Write Error: {e}")
                self.last_error_time = current_time

    def finalize_video(self):
        """Properly close and flush the video file."""
        if self.video_writer is not None:
            self.video_writer.release()
            if self.frame_count > 0:
                self.get_logger().info(
                    f"Finalized video for Cmd #{self.command_count} "
                    f"({self.frame_count} frames written to {self.current_video_path})"
                )
            else:
                self.get_logger().warn(f"No frames recorded for Cmd #{self.command_count}")
                # Delete empty video file
                if self.current_video_path and os.path.exists(self.current_video_path):
                    os.remove(self.current_video_path)
            
            self.video_writer = None
            self.current_video_path = None
            self.frame_count = 0

    def manual_cmd_cb(self, msg):
        self.cmd_queue.append(msg.data)
        if self.state == "IDLE":
            self.process_next_command()

    def process_next_command(self):
        # Finalize previous video
        self.finalize_video()

        if not self.cmd_queue:
            self.state = "IDLE"
            return

        raw_data = self.cmd_queue.popleft()
        try:
            parts = [p.strip() for p in raw_data.split(',')]
            gait, cycles, freq, amp = parts[0], float(parts[1]), float(parts[2]), float(parts[3])

            self.command_count += 1
            self.state = "ACTIVE"
            self.current_cmd_duration = cycles / freq
            self.current_cmd_start_time = time.time()
            
            motion_string = (
                f"actuators:[left,right] motions:[{gait},{gait}] modes:[3.0,3.0] "
                f"freqs:[{freq},{freq}] amps:[{amp},{amp}] cycles:[{cycles},{cycles}] "
                f"cmd_id:[{self.command_count}]"
            )

            self.motion_pub.publish(String(data=motion_string))
            self.get_logger().info(f"Executing Cmd #{self.command_count} ({gait})")
            
        except Exception as e:
            self.get_logger().error(f"Parse Error: {e}")
            self.process_next_command()

    def telemetry_cb(self, msg):
        if self.state == "ACTIVE":
            if len(msg.data) > 0 and msg.data[0] == float(self.command_count):
                elapsed = time.time() - self.current_cmd_start_time
                if elapsed > (self.current_cmd_duration + 0.1):
                    self.process_next_command()

    def destroy_node(self):
        self.finalize_video()
        super().destroy_node()

def main(args=None):
    rclpy.init(args=args)
    node = Crab()
    try:
        rclpy.spin(node)
    except KeyboardInterrupt: 
        pass
    finally:
        node.destroy_node()
        rclpy.shutdown()

if __name__ == '__main__':
    main()