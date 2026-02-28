#!/usr/bin/env python3

from launch import LaunchDescription
from launch_ros.actions import Node
from launch.substitutions import LaunchConfiguration
from launch.actions import DeclareLaunchArgument


def generate_launch_description():
    """
    Launch file for servo_command_node.
    
    Usage:
        ros2 launch servo_driver servo.launch.py
        ros2 launch servo_driver servo.launch.py servo_id:=1
    """
    
    # Declare launch arguments
    servo_id_arg = DeclareLaunchArgument(
        'servo_id',
        default_value='1',
        description='Servo ID (1 or 2 or etc)'
    )
    
    # Create the servo_command_node
    servo_command_node = Node(
        package='servo_driver',
        executable='servo_command_node',
        name='servo_command_node',
        parameters=[
            {'servo_id': LaunchConfiguration('servo_id')}
        ],
        output='screen'
    )
    
    # Return launch description
    return LaunchDescription([
        servo_id_arg,
        servo_command_node
    ])