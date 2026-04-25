from launch import LaunchDescription
from launch_ros.actions import Node

package_name = 'flapping_foil_propulsors_control'

def generate_launch_description():
    return LaunchDescription([
        # Application
        Node(
            package=package_name,
            executable='crab', 
            name='crab',
            output='screen'
        ),
        
        # Gait Engine / Controller 
        Node(
            package=package_name,
            executable='CrabController2DOF', 
            name='CrabController2DOF',
            output='screen',
            parameters=[{
                'operating_mode': 'position', # 'velocity' or 'position'
                'kp': 0.0,
                'ki': 0.0,
                'kd': 0.0,
                'control_period': 0.0025,    
                'telemetry_period': 0.04    
            }]
        ),
        
        # Dynamixcel XW430-T200 Hardware Interface
       Node(
            package=package_name, 
            executable='Dynamixcel_XW430_T200_interface', 
            name='servo_actuator',
            output='screen',
            parameters=[{
                'baudrate': 1000000,
                'control_loop_rate': 0.002,
                'current_limit': 800
            }]
        )
    ])