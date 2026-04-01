from launch import LaunchDescription
from launch_ros.actions import Node

def generate_launch_description():
    return LaunchDescription([
        # 1. The High-Level Logic (crab.py)
        Node(
            package='actuator_driver',
            executable='crab', # Ensure this is mapped to crab.py in setup.py
            name='crab_gatekeeper',
            output='screen'
        ),
        
        # 2. The Gait Engine / Controller (crab_controller.py)
        Node(
            package='actuator_driver',
            executable='crab_controller', # Updated to match your filename
            name='crab_motion_engine',
            output='screen'
        ),
        
        # 3. The Hardware Driver (actuator.py)
        Node(
            package='actuator_driver',
            executable='actuator', # Updated to match your filename
            name='servo_actuator',
            output='screen',
            respawn=True,
            respawn_delay=2.0
        )
    ])