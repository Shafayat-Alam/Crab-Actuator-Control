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
            output='screen'
        ),
        
        # Hardware Interface
        Node(
            package=package_name,
            executable='Dynamixcel_WX430_T200_interface', 
            name='Dynamixcel_WX430_T200_interface',
            output='screen',
            respawn=True,
            respawn_delay=2.0
        )
    ])