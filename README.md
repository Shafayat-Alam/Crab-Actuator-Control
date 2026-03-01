# servo_driver

ROS2 node for controlling a Dynamixel XM430-T200 servo motor.

## What

Controls one servo. You send commands to move it to angles, spin it, or apply torque. It sends back what the servo is doing - position, speed, current.

## Hardware

Need a XM430-T200 servo and U2D2 USB adapter. Servo connects on `/dev/ttyUSB0`.

## Install

```
sudo apt-get install ros-jazzy-dynamixel-sdk
cd ~/your-workspace
colcon build
source install/setup.bash
```

## Run

```
ros2 launch servo_driver servo.launch.py servo_id:=1
```

## Commands

Send to `/servo/command` as `Float32MultiArray [mode, value]`

Position control (mode 3) - move to angle 0-4095

```
ros2 topic pub /servo/command std_msgs/Float32MultiArray "data: [3, 2048]"
```

Velocity control (mode 1) - spin at speed -1023 to 1023

```
ros2 topic pub /servo/command std_msgs/Float32MultiArray "data: [1, 300]"
```

Current/torque control (mode 0) - apply force -2048 to 2048 mA

```
ros2 topic pub /servo/command std_msgs/Float32MultiArray "data: [0, 500]"
```

## Feedback

Check servo state on `/servo/status`

```
ros2 topic echo /servo/status
```

Returns position, velocity, current.

## How it works

Sets control mode, enables torque (this has to happen after mode change), sets goal value, reads state back.

## Issues

Serial port permission denied - if you get "Permission denied: /dev/ttyUSB0", add yourself to the dialout group
```
sudo usermod -a -G dialout $USER
```

Then log out and back in.

Servo not responding - check power, cables, servo ID, baud rate 57600.

## Next

Multi-servo, motion profiles, IMU integration.