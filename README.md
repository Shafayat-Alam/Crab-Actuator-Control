# Bio-Inspired Gait Engine (In-Progress, README needs significant updating)
 
A ROS 2 control stack for a 2-DOF bio-inspired robotic system designed following the ROS2 Control Framework. The architecture enables modular decoupling between nodes to ensure that high-level behavioral logic remains independent of low-level serial communication and hardware drivers.
 
## ROS2 Control Framework Architecture
 
```
┌─────────────┐      ┌──────────────┐      ┌─────────────┐      ┌──────────────┐      ┌──────────┐
│ Application │◄────►│  Controller  │◄────►│HW Interface │◄────►│ HW Interface |◄────►│ Hardware │
└─────────────┘      └──────────────┘      └─────────────┘      └──────────────┘      └──────────┘
                              └─────────── ros2_control ──────────┘
```
 
*Architecture based on ROS2 Control Framework (Reference: The Robotics Back-End)*
 
---
 
## Node Specifications
 
### Application Layer (`crab.py`)
**The system "Brain."** Manages the state of the system.
 
- **Input:** Listens to `robot_cmd` for behavioral triggers
- **Output:** Publishes desired gait parameters to `motion_cmd`
 
### Controller Layer (`crab_controller.py`)
**The "Kinematic Engine."** Translates abstract frequencies and amplitudes into time series trajectories.
 
Implements a library of motion trajectories including:
- 3-phase paddling gait using synchronized sine/cosine coupling
- Flapping gait following sine function trajectory
- Calibration of both left and right actuators
- Feedback logging to CSV file
 
- **Input:** Listens to `motion_cmd` for gait parameters
- **Output:** Publishes to `joint_cmd` for coordinated servo goals (position/velocity)
 
### Hardware Interface (`actuator.py`)
Interfaces with the Dynamixcel SDK. Handles protocol serialization and eliminates inter-servo latency.
 
Features:
- Utilizes `GroupSyncWrite` from Dynamixel SDK to broadcast single packet to all IDs
- Integrated Torque-Enable and Operating Mode guards
- Feedback logging to CSV file
 
- **Input:** Listens to `joint_cmd` for coordinated servo goals (position/velocity)
- **Output:** Publishes to `joint_feedback` with feedback from servo encoders
 
---
 
## Topic Specifications
 
| Topic | Purpose |
|-------|---------|
| `robot_cmd` | Behavioral command triggers |
| `motion_cmd` | Gait parameters (frequency, amplitude) |
| `joint_cmd` | Coordinated servo goals (position/velocity) |
| `joint_feedback` | Encoder feedback from servos |
 
---
 
## Motion Library
 
- **Calibration** - System calibration routine
- **Flapping Forward** - Forward flapping motion
- **Flapping Backward** - Backward flapping motion
- **Paddling Forward** - Forward paddling motion
- **Paddling Backward** - Backward paddling motion
 
---
 
## Hardware Specification
 
| Component | Model | Protocol |
|-----------|-------|----------|
| **Actuators** | Dynamixel X420-T200 | Protocol 2.0 (RS-485) |
| **IMU** | MPU-6050 (6-Axis) | I2C |
| **Vision** | Fisheye USB Camera |   |
| **Compute** | Jetson Orin Nano | ROS 2 Humble |
 
---
 
## Usage
Tell robot_cmd to do something. Controller takes that information and coordinates/organizes what to send to hardware-interface which then sends signals to servos in a synchronized manner.
```
```
 
---
 
## Dependencies
 
- ROS 2 Humble
- Dynamixel SDK
- Python ...some vresion...
 
 
