#!/bin/bash

# --- Motion: forward_paddle ---
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"forward_paddle, 2, 1.0, 1.0\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[forward_paddle,forward_paddle] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.0,1.0] cycles:[2,2] cmd_id:[2]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"forward_paddle, 4, 0.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[forward_paddle,forward_paddle] modes:[3.0,3.0] freqs:[0.5,0.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[4]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"forward_paddle, 4, 1.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[forward_paddle,forward_paddle] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[6]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"forward_paddle, 4, 2.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[forward_paddle,forward_paddle] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[8]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"forward_paddle, 4, 1.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[forward_paddle,forward_paddle] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[10]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"forward_paddle, 4, 2.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[forward_paddle,forward_paddle] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[12]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"forward_paddle, 4, 2.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[forward_paddle,forward_paddle] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[0.3,0.3] cycles:[4,4] cmd_id:[14]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"forward_paddle, 4, 0.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[forward_paddle,forward_paddle] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.5,1.5] cycles:[4,4] cmd_id:[16]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"forward_paddle, 2, 0.1, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[forward_paddle,forward_paddle] modes:[3.0,3.0] freqs:[0.1,0.1] amps:[1.5,1.5] cycles:[2,2] cmd_id:[18]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"forward_paddle, 0.5, 1.5, 1.2\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[forward_paddle,forward_paddle] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.2,1.2] cycles:[0.5,0.5] cmd_id:[20]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
# --- Motion: backward_paddle ---
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"backward_paddle, 2, 1.0, 1.0\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[backward_paddle,backward_paddle] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.0,1.0] cycles:[2,2] cmd_id:[22]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"backward_paddle, 4, 0.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[backward_paddle,backward_paddle] modes:[3.0,3.0] freqs:[0.5,0.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[24]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"backward_paddle, 4, 1.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[backward_paddle,backward_paddle] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[26]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"backward_paddle, 4, 2.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[backward_paddle,backward_paddle] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[28]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"backward_paddle, 4, 1.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[backward_paddle,backward_paddle] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[30]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"backward_paddle, 4, 2.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[backward_paddle,backward_paddle] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[32]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"backward_paddle, 4, 2.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[backward_paddle,backward_paddle] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[0.3,0.3] cycles:[4,4] cmd_id:[34]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"backward_paddle, 4, 0.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[backward_paddle,backward_paddle] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.5,1.5] cycles:[4,4] cmd_id:[36]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"backward_paddle, 2, 0.1, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[backward_paddle,backward_paddle] modes:[3.0,3.0] freqs:[0.1,0.1] amps:[1.5,1.5] cycles:[2,2] cmd_id:[38]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"backward_paddle, 0.5, 1.5, 1.2\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[backward_paddle,backward_paddle] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.2,1.2] cycles:[0.5,0.5] cmd_id:[40]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
# --- Motion: forward_flap ---
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"forward_flap, 2, 1.0, 1.0\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[forward_flap,forward_flap] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.0,1.0] cycles:[2,2] cmd_id:[42]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"forward_flap, 4, 0.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[forward_flap,forward_flap] modes:[3.0,3.0] freqs:[0.5,0.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[44]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"forward_flap, 4, 1.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[forward_flap,forward_flap] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[46]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"forward_flap, 4, 2.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[forward_flap,forward_flap] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[48]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"forward_flap, 4, 1.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[forward_flap,forward_flap] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[50]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"forward_flap, 4, 2.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[forward_flap,forward_flap] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[52]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"forward_flap, 4, 2.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[forward_flap,forward_flap] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[0.3,0.3] cycles:[4,4] cmd_id:[54]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"forward_flap, 4, 0.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[forward_flap,forward_flap] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.5,1.5] cycles:[4,4] cmd_id:[56]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"forward_flap, 2, 0.1, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[forward_flap,forward_flap] modes:[3.0,3.0] freqs:[0.1,0.1] amps:[1.5,1.5] cycles:[2,2] cmd_id:[58]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"forward_flap, 0.5, 1.5, 1.2\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[forward_flap,forward_flap] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.2,1.2] cycles:[0.5,0.5] cmd_id:[60]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
# --- Motion: backward_flap ---
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"backward_flap, 2, 1.0, 1.0\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[backward_flap,backward_flap] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.0,1.0] cycles:[2,2] cmd_id:[62]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"backward_flap, 4, 0.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[backward_flap,backward_flap] modes:[3.0,3.0] freqs:[0.5,0.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[64]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"backward_flap, 4, 1.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[backward_flap,backward_flap] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[66]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"backward_flap, 4, 2.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[backward_flap,backward_flap] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[68]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"backward_flap, 4, 1.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[backward_flap,backward_flap] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[70]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"backward_flap, 4, 2.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[backward_flap,backward_flap] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[72]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"backward_flap, 4, 2.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[backward_flap,backward_flap] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[0.3,0.3] cycles:[4,4] cmd_id:[74]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"backward_flap, 4, 0.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[backward_flap,backward_flap] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.5,1.5] cycles:[4,4] cmd_id:[76]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"backward_flap, 2, 0.1, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[backward_flap,backward_flap] modes:[3.0,3.0] freqs:[0.1,0.1] amps:[1.5,1.5] cycles:[2,2] cmd_id:[78]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"backward_flap, 0.5, 1.5, 1.2\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[backward_flap,backward_flap] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.2,1.2] cycles:[0.5,0.5] cmd_id:[80]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
# --- Motion: up_flap ---
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"up_flap, 2, 1.0, 1.0\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[up_flap,up_flap] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.0,1.0] cycles:[2,2] cmd_id:[82]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"up_flap, 4, 0.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[up_flap,up_flap] modes:[3.0,3.0] freqs:[0.5,0.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[84]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"up_flap, 4, 1.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[up_flap,up_flap] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[86]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"up_flap, 4, 2.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[up_flap,up_flap] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[88]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"up_flap, 4, 1.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[up_flap,up_flap] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[90]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"up_flap, 4, 2.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[up_flap,up_flap] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[92]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"up_flap, 4, 2.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[up_flap,up_flap] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[0.3,0.3] cycles:[4,4] cmd_id:[94]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"up_flap, 4, 0.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[up_flap,up_flap] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.5,1.5] cycles:[4,4] cmd_id:[96]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"up_flap, 2, 0.1, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[up_flap,up_flap] modes:[3.0,3.0] freqs:[0.1,0.1] amps:[1.5,1.5] cycles:[2,2] cmd_id:[98]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"up_flap, 0.5, 1.5, 1.2\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[up_flap,up_flap] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.2,1.2] cycles:[0.5,0.5] cmd_id:[100]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
# --- Motion: down_flap ---
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"down_flap, 2, 1.0, 1.0\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[down_flap,down_flap] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.0,1.0] cycles:[2,2] cmd_id:[102]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"down_flap, 4, 0.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[down_flap,down_flap] modes:[3.0,3.0] freqs:[0.5,0.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[104]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"down_flap, 4, 1.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[down_flap,down_flap] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[106]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"down_flap, 4, 2.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[down_flap,down_flap] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[108]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"down_flap, 4, 1.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[down_flap,down_flap] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[110]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"down_flap, 4, 2.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[down_flap,down_flap] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[112]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"down_flap, 4, 2.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[down_flap,down_flap] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[0.3,0.3] cycles:[4,4] cmd_id:[114]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"down_flap, 4, 0.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[down_flap,down_flap] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.5,1.5] cycles:[4,4] cmd_id:[116]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"down_flap, 2, 0.1, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[down_flap,down_flap] modes:[3.0,3.0] freqs:[0.1,0.1] amps:[1.5,1.5] cycles:[2,2] cmd_id:[118]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"down_flap, 0.5, 1.5, 1.2\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[down_flap,down_flap] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.2,1.2] cycles:[0.5,0.5] cmd_id:[120]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
# --- Motion: left_roll_sine ---
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"left_roll_sine, 2, 1.0, 1.0\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[left_roll_sine,left_roll_sine] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.0,1.0] cycles:[2,2] cmd_id:[122]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"left_roll_sine, 4, 0.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[left_roll_sine,left_roll_sine] modes:[3.0,3.0] freqs:[0.5,0.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[124]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"left_roll_sine, 4, 1.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[left_roll_sine,left_roll_sine] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[126]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"left_roll_sine, 4, 2.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[left_roll_sine,left_roll_sine] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[128]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"left_roll_sine, 4, 1.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[left_roll_sine,left_roll_sine] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[130]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"left_roll_sine, 4, 2.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[left_roll_sine,left_roll_sine] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[132]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"left_roll_sine, 4, 2.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[left_roll_sine,left_roll_sine] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[0.3,0.3] cycles:[4,4] cmd_id:[134]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"left_roll_sine, 4, 0.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[left_roll_sine,left_roll_sine] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.5,1.5] cycles:[4,4] cmd_id:[136]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"left_roll_sine, 2, 0.1, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[left_roll_sine,left_roll_sine] modes:[3.0,3.0] freqs:[0.1,0.1] amps:[1.5,1.5] cycles:[2,2] cmd_id:[138]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"left_roll_sine, 0.5, 1.5, 1.2\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[left_roll_sine,left_roll_sine] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.2,1.2] cycles:[0.5,0.5] cmd_id:[140]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
# --- Motion: right_roll_sine ---
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"right_roll_sine, 2, 1.0, 1.0\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[right_roll_sine,right_roll_sine] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.0,1.0] cycles:[2,2] cmd_id:[142]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"right_roll_sine, 4, 0.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[right_roll_sine,right_roll_sine] modes:[3.0,3.0] freqs:[0.5,0.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[144]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"right_roll_sine, 4, 1.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[right_roll_sine,right_roll_sine] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[146]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"right_roll_sine, 4, 2.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[right_roll_sine,right_roll_sine] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[148]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"right_roll_sine, 4, 1.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[right_roll_sine,right_roll_sine] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[150]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"right_roll_sine, 4, 2.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[right_roll_sine,right_roll_sine] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[152]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"right_roll_sine, 4, 2.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[right_roll_sine,right_roll_sine] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[0.3,0.3] cycles:[4,4] cmd_id:[154]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"right_roll_sine, 4, 0.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[right_roll_sine,right_roll_sine] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.5,1.5] cycles:[4,4] cmd_id:[156]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"right_roll_sine, 2, 0.1, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[right_roll_sine,right_roll_sine] modes:[3.0,3.0] freqs:[0.1,0.1] amps:[1.5,1.5] cycles:[2,2] cmd_id:[158]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"right_roll_sine, 0.5, 1.5, 1.2\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[right_roll_sine,right_roll_sine] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.2,1.2] cycles:[0.5,0.5] cmd_id:[160]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
# --- Motion: left_pitch_sine ---
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"left_pitch_sine, 2, 1.0, 1.0\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[left_pitch_sine,left_pitch_sine] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.0,1.0] cycles:[2,2] cmd_id:[162]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"left_pitch_sine, 4, 0.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[left_pitch_sine,left_pitch_sine] modes:[3.0,3.0] freqs:[0.5,0.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[164]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"left_pitch_sine, 4, 1.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[left_pitch_sine,left_pitch_sine] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[166]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"left_pitch_sine, 4, 2.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[left_pitch_sine,left_pitch_sine] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[168]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"left_pitch_sine, 4, 1.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[left_pitch_sine,left_pitch_sine] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[170]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"left_pitch_sine, 4, 2.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[left_pitch_sine,left_pitch_sine] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[172]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"left_pitch_sine, 4, 2.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[left_pitch_sine,left_pitch_sine] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[0.3,0.3] cycles:[4,4] cmd_id:[174]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"left_pitch_sine, 4, 0.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[left_pitch_sine,left_pitch_sine] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.5,1.5] cycles:[4,4] cmd_id:[176]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"left_pitch_sine, 2, 0.1, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[left_pitch_sine,left_pitch_sine] modes:[3.0,3.0] freqs:[0.1,0.1] amps:[1.5,1.5] cycles:[2,2] cmd_id:[178]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"left_pitch_sine, 0.5, 1.5, 1.2\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[left_pitch_sine,left_pitch_sine] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.2,1.2] cycles:[0.5,0.5] cmd_id:[180]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
# --- Motion: right_pitch_sine ---
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"right_pitch_sine, 2, 1.0, 1.0\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[right_pitch_sine,right_pitch_sine] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.0,1.0] cycles:[2,2] cmd_id:[182]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"right_pitch_sine, 4, 0.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[right_pitch_sine,right_pitch_sine] modes:[3.0,3.0] freqs:[0.5,0.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[184]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"right_pitch_sine, 4, 1.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[right_pitch_sine,right_pitch_sine] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[186]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"right_pitch_sine, 4, 2.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[right_pitch_sine,right_pitch_sine] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[188]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"right_pitch_sine, 4, 1.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[right_pitch_sine,right_pitch_sine] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[190]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"right_pitch_sine, 4, 2.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[right_pitch_sine,right_pitch_sine] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[192]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"right_pitch_sine, 4, 2.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[right_pitch_sine,right_pitch_sine] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[0.3,0.3] cycles:[4,4] cmd_id:[194]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"right_pitch_sine, 4, 0.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[right_pitch_sine,right_pitch_sine] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.5,1.5] cycles:[4,4] cmd_id:[196]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"right_pitch_sine, 2, 0.1, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[right_pitch_sine,right_pitch_sine] modes:[3.0,3.0] freqs:[0.1,0.1] amps:[1.5,1.5] cycles:[2,2] cmd_id:[198]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"right_pitch_sine, 0.5, 1.5, 1.2\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[right_pitch_sine,right_pitch_sine] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.2,1.2] cycles:[0.5,0.5] cmd_id:[200]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
# --- Motion: symmetric_roll_sine ---
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"symmetric_roll_sine, 2, 1.0, 1.0\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[symmetric_roll_sine,symmetric_roll_sine] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.0,1.0] cycles:[2,2] cmd_id:[202]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"symmetric_roll_sine, 4, 0.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[symmetric_roll_sine,symmetric_roll_sine] modes:[3.0,3.0] freqs:[0.5,0.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[204]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"symmetric_roll_sine, 4, 1.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[symmetric_roll_sine,symmetric_roll_sine] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[206]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"symmetric_roll_sine, 4, 2.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[symmetric_roll_sine,symmetric_roll_sine] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[208]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"symmetric_roll_sine, 4, 1.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[symmetric_roll_sine,symmetric_roll_sine] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[210]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"symmetric_roll_sine, 4, 2.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[symmetric_roll_sine,symmetric_roll_sine] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[212]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"symmetric_roll_sine, 4, 2.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[symmetric_roll_sine,symmetric_roll_sine] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[0.3,0.3] cycles:[4,4] cmd_id:[214]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"symmetric_roll_sine, 4, 0.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[symmetric_roll_sine,symmetric_roll_sine] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.5,1.5] cycles:[4,4] cmd_id:[216]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"symmetric_roll_sine, 2, 0.1, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[symmetric_roll_sine,symmetric_roll_sine] modes:[3.0,3.0] freqs:[0.1,0.1] amps:[1.5,1.5] cycles:[2,2] cmd_id:[218]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"symmetric_roll_sine, 0.5, 1.5, 1.2\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[symmetric_roll_sine,symmetric_roll_sine] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.2,1.2] cycles:[0.5,0.5] cmd_id:[220]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
# --- Motion: asymmetric_roll_sine ---
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"asymmetric_roll_sine, 2, 1.0, 1.0\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[asymmetric_roll_sine,asymmetric_roll_sine] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.0,1.0] cycles:[2,2] cmd_id:[222]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"asymmetric_roll_sine, 4, 0.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[asymmetric_roll_sine,asymmetric_roll_sine] modes:[3.0,3.0] freqs:[0.5,0.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[224]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"asymmetric_roll_sine, 4, 1.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[asymmetric_roll_sine,asymmetric_roll_sine] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[226]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"asymmetric_roll_sine, 4, 2.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[asymmetric_roll_sine,asymmetric_roll_sine] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[228]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"asymmetric_roll_sine, 4, 1.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[asymmetric_roll_sine,asymmetric_roll_sine] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[230]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"asymmetric_roll_sine, 4, 2.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[asymmetric_roll_sine,asymmetric_roll_sine] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[232]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"asymmetric_roll_sine, 4, 2.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[asymmetric_roll_sine,asymmetric_roll_sine] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[0.3,0.3] cycles:[4,4] cmd_id:[234]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"asymmetric_roll_sine, 4, 0.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[asymmetric_roll_sine,asymmetric_roll_sine] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.5,1.5] cycles:[4,4] cmd_id:[236]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"asymmetric_roll_sine, 2, 0.1, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[asymmetric_roll_sine,asymmetric_roll_sine] modes:[3.0,3.0] freqs:[0.1,0.1] amps:[1.5,1.5] cycles:[2,2] cmd_id:[238]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"asymmetric_roll_sine, 0.5, 1.5, 1.2\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[asymmetric_roll_sine,asymmetric_roll_sine] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.2,1.2] cycles:[0.5,0.5] cmd_id:[240]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
# --- Motion: symmetric_pitch_sine ---
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"symmetric_pitch_sine, 2, 1.0, 1.0\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[symmetric_pitch_sine,symmetric_pitch_sine] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.0,1.0] cycles:[2,2] cmd_id:[242]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"symmetric_pitch_sine, 4, 0.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[symmetric_pitch_sine,symmetric_pitch_sine] modes:[3.0,3.0] freqs:[0.5,0.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[244]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"symmetric_pitch_sine, 4, 1.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[symmetric_pitch_sine,symmetric_pitch_sine] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[246]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"symmetric_pitch_sine, 4, 2.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[symmetric_pitch_sine,symmetric_pitch_sine] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[248]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"symmetric_pitch_sine, 4, 1.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[symmetric_pitch_sine,symmetric_pitch_sine] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[250]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"symmetric_pitch_sine, 4, 2.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[symmetric_pitch_sine,symmetric_pitch_sine] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[252]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"symmetric_pitch_sine, 4, 2.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[symmetric_pitch_sine,symmetric_pitch_sine] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[0.3,0.3] cycles:[4,4] cmd_id:[254]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"symmetric_pitch_sine, 4, 0.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[symmetric_pitch_sine,symmetric_pitch_sine] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.5,1.5] cycles:[4,4] cmd_id:[256]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"symmetric_pitch_sine, 2, 0.1, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[symmetric_pitch_sine,symmetric_pitch_sine] modes:[3.0,3.0] freqs:[0.1,0.1] amps:[1.5,1.5] cycles:[2,2] cmd_id:[258]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"symmetric_pitch_sine, 0.5, 1.5, 1.2\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[symmetric_pitch_sine,symmetric_pitch_sine] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.2,1.2] cycles:[0.5,0.5] cmd_id:[260]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
# --- Motion: asymmetric_pitch_sine ---
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"asymmetric_pitch_sine, 2, 1.0, 1.0\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[asymmetric_pitch_sine,asymmetric_pitch_sine] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.0,1.0] cycles:[2,2] cmd_id:[262]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"asymmetric_pitch_sine, 4, 0.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[asymmetric_pitch_sine,asymmetric_pitch_sine] modes:[3.0,3.0] freqs:[0.5,0.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[264]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"asymmetric_pitch_sine, 4, 1.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[asymmetric_pitch_sine,asymmetric_pitch_sine] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[266]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"asymmetric_pitch_sine, 4, 2.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[asymmetric_pitch_sine,asymmetric_pitch_sine] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[268]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"asymmetric_pitch_sine, 4, 1.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[asymmetric_pitch_sine,asymmetric_pitch_sine] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[270]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"asymmetric_pitch_sine, 4, 2.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[asymmetric_pitch_sine,asymmetric_pitch_sine] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[272]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"asymmetric_pitch_sine, 4, 2.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[asymmetric_pitch_sine,asymmetric_pitch_sine] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[0.3,0.3] cycles:[4,4] cmd_id:[274]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"asymmetric_pitch_sine, 4, 0.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[asymmetric_pitch_sine,asymmetric_pitch_sine] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.5,1.5] cycles:[4,4] cmd_id:[276]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"asymmetric_pitch_sine, 2, 0.1, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[asymmetric_pitch_sine,asymmetric_pitch_sine] modes:[3.0,3.0] freqs:[0.1,0.1] amps:[1.5,1.5] cycles:[2,2] cmd_id:[278]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"asymmetric_pitch_sine, 0.5, 1.5, 1.2\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[asymmetric_pitch_sine,asymmetric_pitch_sine] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.2,1.2] cycles:[0.5,0.5] cmd_id:[280]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
# --- Motion: left_flipper_coupled ---
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"left_flipper_coupled, 2, 1.0, 1.0\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[left_flipper_coupled,left_flipper_coupled] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.0,1.0] cycles:[2,2] cmd_id:[282]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"left_flipper_coupled, 4, 0.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[left_flipper_coupled,left_flipper_coupled] modes:[3.0,3.0] freqs:[0.5,0.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[284]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"left_flipper_coupled, 4, 1.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[left_flipper_coupled,left_flipper_coupled] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[286]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"left_flipper_coupled, 4, 2.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[left_flipper_coupled,left_flipper_coupled] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[288]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"left_flipper_coupled, 4, 1.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[left_flipper_coupled,left_flipper_coupled] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[290]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"left_flipper_coupled, 4, 2.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[left_flipper_coupled,left_flipper_coupled] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[292]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"left_flipper_coupled, 4, 2.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[left_flipper_coupled,left_flipper_coupled] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[0.3,0.3] cycles:[4,4] cmd_id:[294]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"left_flipper_coupled, 4, 0.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[left_flipper_coupled,left_flipper_coupled] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.5,1.5] cycles:[4,4] cmd_id:[296]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"left_flipper_coupled, 2, 0.1, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[left_flipper_coupled,left_flipper_coupled] modes:[3.0,3.0] freqs:[0.1,0.1] amps:[1.5,1.5] cycles:[2,2] cmd_id:[298]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"left_flipper_coupled, 0.5, 1.5, 1.2\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[left_flipper_coupled,left_flipper_coupled] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.2,1.2] cycles:[0.5,0.5] cmd_id:[300]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
# --- Motion: right_flipper_coupled ---
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"right_flipper_coupled, 2, 1.0, 1.0\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[right_flipper_coupled,right_flipper_coupled] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.0,1.0] cycles:[2,2] cmd_id:[302]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"right_flipper_coupled, 4, 0.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[right_flipper_coupled,right_flipper_coupled] modes:[3.0,3.0] freqs:[0.5,0.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[304]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"right_flipper_coupled, 4, 1.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[right_flipper_coupled,right_flipper_coupled] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[306]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"right_flipper_coupled, 4, 2.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[right_flipper_coupled,right_flipper_coupled] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[308]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"right_flipper_coupled, 4, 1.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[right_flipper_coupled,right_flipper_coupled] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[310]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"right_flipper_coupled, 4, 2.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[right_flipper_coupled,right_flipper_coupled] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[312]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"right_flipper_coupled, 4, 2.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[right_flipper_coupled,right_flipper_coupled] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[0.3,0.3] cycles:[4,4] cmd_id:[314]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"right_flipper_coupled, 4, 0.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[right_flipper_coupled,right_flipper_coupled] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.5,1.5] cycles:[4,4] cmd_id:[316]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"right_flipper_coupled, 2, 0.1, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[right_flipper_coupled,right_flipper_coupled] modes:[3.0,3.0] freqs:[0.1,0.1] amps:[1.5,1.5] cycles:[2,2] cmd_id:[318]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"right_flipper_coupled, 0.5, 1.5, 1.2\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[right_flipper_coupled,right_flipper_coupled] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.2,1.2] cycles:[0.5,0.5] cmd_id:[320]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
# --- Motion: diagonal_test_a ---
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"diagonal_test_a, 2, 1.0, 1.0\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[diagonal_test_a,diagonal_test_a] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.0,1.0] cycles:[2,2] cmd_id:[322]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"diagonal_test_a, 4, 0.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[diagonal_test_a,diagonal_test_a] modes:[3.0,3.0] freqs:[0.5,0.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[324]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"diagonal_test_a, 4, 1.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[diagonal_test_a,diagonal_test_a] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[326]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"diagonal_test_a, 4, 2.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[diagonal_test_a,diagonal_test_a] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[328]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"diagonal_test_a, 4, 1.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[diagonal_test_a,diagonal_test_a] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[330]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"diagonal_test_a, 4, 2.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[diagonal_test_a,diagonal_test_a] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[332]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"diagonal_test_a, 4, 2.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[diagonal_test_a,diagonal_test_a] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[0.3,0.3] cycles:[4,4] cmd_id:[334]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"diagonal_test_a, 4, 0.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[diagonal_test_a,diagonal_test_a] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.5,1.5] cycles:[4,4] cmd_id:[336]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"diagonal_test_a, 2, 0.1, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[diagonal_test_a,diagonal_test_a] modes:[3.0,3.0] freqs:[0.1,0.1] amps:[1.5,1.5] cycles:[2,2] cmd_id:[338]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"diagonal_test_a, 0.5, 1.5, 1.2\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[diagonal_test_a,diagonal_test_a] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.2,1.2] cycles:[0.5,0.5] cmd_id:[340]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
# --- Motion: diagonal_test_b ---
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"diagonal_test_b, 2, 1.0, 1.0\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[diagonal_test_b,diagonal_test_b] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.0,1.0] cycles:[2,2] cmd_id:[342]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"diagonal_test_b, 4, 0.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[diagonal_test_b,diagonal_test_b] modes:[3.0,3.0] freqs:[0.5,0.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[344]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"diagonal_test_b, 4, 1.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[diagonal_test_b,diagonal_test_b] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[346]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"diagonal_test_b, 4, 2.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[diagonal_test_b,diagonal_test_b] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[348]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"diagonal_test_b, 4, 1.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[diagonal_test_b,diagonal_test_b] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[350]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"diagonal_test_b, 4, 2.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[diagonal_test_b,diagonal_test_b] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[352]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"diagonal_test_b, 4, 2.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[diagonal_test_b,diagonal_test_b] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[0.3,0.3] cycles:[4,4] cmd_id:[354]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"diagonal_test_b, 4, 0.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[diagonal_test_b,diagonal_test_b] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.5,1.5] cycles:[4,4] cmd_id:[356]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"diagonal_test_b, 2, 0.1, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[diagonal_test_b,diagonal_test_b] modes:[3.0,3.0] freqs:[0.1,0.1] amps:[1.5,1.5] cycles:[2,2] cmd_id:[358]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"diagonal_test_b, 0.5, 1.5, 1.2\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[diagonal_test_b,diagonal_test_b] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.2,1.2] cycles:[0.5,0.5] cmd_id:[360]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
# --- Motion: four_axis_quadrature ---
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"four_axis_quadrature, 2, 1.0, 1.0\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[four_axis_quadrature,four_axis_quadrature] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.0,1.0] cycles:[2,2] cmd_id:[362]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"four_axis_quadrature, 4, 0.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[four_axis_quadrature,four_axis_quadrature] modes:[3.0,3.0] freqs:[0.5,0.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[364]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"four_axis_quadrature, 4, 1.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[four_axis_quadrature,four_axis_quadrature] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[366]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"four_axis_quadrature, 4, 2.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[four_axis_quadrature,four_axis_quadrature] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[368]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"four_axis_quadrature, 4, 1.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[four_axis_quadrature,four_axis_quadrature] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[370]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"four_axis_quadrature, 4, 2.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[four_axis_quadrature,four_axis_quadrature] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[372]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"four_axis_quadrature, 4, 2.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[four_axis_quadrature,four_axis_quadrature] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[0.3,0.3] cycles:[4,4] cmd_id:[374]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"four_axis_quadrature, 4, 0.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[four_axis_quadrature,four_axis_quadrature] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.5,1.5] cycles:[4,4] cmd_id:[376]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"four_axis_quadrature, 2, 0.1, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[four_axis_quadrature,four_axis_quadrature] modes:[3.0,3.0] freqs:[0.1,0.1] amps:[1.5,1.5] cycles:[2,2] cmd_id:[378]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"four_axis_quadrature, 0.5, 1.5, 1.2\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[four_axis_quadrature,four_axis_quadrature] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.2,1.2] cycles:[0.5,0.5] cmd_id:[380]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
# --- Motion: reverse_quadrature ---
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"reverse_quadrature, 2, 1.0, 1.0\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[reverse_quadrature,reverse_quadrature] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.0,1.0] cycles:[2,2] cmd_id:[382]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"reverse_quadrature, 4, 0.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[reverse_quadrature,reverse_quadrature] modes:[3.0,3.0] freqs:[0.5,0.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[384]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"reverse_quadrature, 4, 1.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[reverse_quadrature,reverse_quadrature] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[386]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"reverse_quadrature, 4, 2.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[reverse_quadrature,reverse_quadrature] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[388]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"reverse_quadrature, 4, 1.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[reverse_quadrature,reverse_quadrature] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[390]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"reverse_quadrature, 4, 2.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[reverse_quadrature,reverse_quadrature] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[392]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"reverse_quadrature, 4, 2.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[reverse_quadrature,reverse_quadrature] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[0.3,0.3] cycles:[4,4] cmd_id:[394]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"reverse_quadrature, 4, 0.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[reverse_quadrature,reverse_quadrature] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.5,1.5] cycles:[4,4] cmd_id:[396]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"reverse_quadrature, 2, 0.1, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[reverse_quadrature,reverse_quadrature] modes:[3.0,3.0] freqs:[0.1,0.1] amps:[1.5,1.5] cycles:[2,2] cmd_id:[398]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"reverse_quadrature, 0.5, 1.5, 1.2\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[reverse_quadrature,reverse_quadrature] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.2,1.2] cycles:[0.5,0.5] cmd_id:[400]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
# --- Motion: jumbled_quadrature ---
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"jumbled_quadrature, 2, 1.0, 1.0\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[jumbled_quadrature,jumbled_quadrature] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.0,1.0] cycles:[2,2] cmd_id:[402]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"jumbled_quadrature, 4, 0.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[jumbled_quadrature,jumbled_quadrature] modes:[3.0,3.0] freqs:[0.5,0.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[404]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"jumbled_quadrature, 4, 1.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[jumbled_quadrature,jumbled_quadrature] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[406]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"jumbled_quadrature, 4, 2.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[jumbled_quadrature,jumbled_quadrature] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[408]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"jumbled_quadrature, 4, 1.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[jumbled_quadrature,jumbled_quadrature] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[410]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"jumbled_quadrature, 4, 2.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[jumbled_quadrature,jumbled_quadrature] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[412]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"jumbled_quadrature, 4, 2.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[jumbled_quadrature,jumbled_quadrature] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[0.3,0.3] cycles:[4,4] cmd_id:[414]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"jumbled_quadrature, 4, 0.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[jumbled_quadrature,jumbled_quadrature] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.5,1.5] cycles:[4,4] cmd_id:[416]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"jumbled_quadrature, 2, 0.1, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[jumbled_quadrature,jumbled_quadrature] modes:[3.0,3.0] freqs:[0.1,0.1] amps:[1.5,1.5] cycles:[2,2] cmd_id:[418]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"jumbled_quadrature, 0.5, 1.5, 1.2\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[jumbled_quadrature,jumbled_quadrature] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.2,1.2] cycles:[0.5,0.5] cmd_id:[420]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
# --- Motion: cross_axis_opposition ---
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"cross_axis_opposition, 2, 1.0, 1.0\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[cross_axis_opposition,cross_axis_opposition] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.0,1.0] cycles:[2,2] cmd_id:[422]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"cross_axis_opposition, 4, 0.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[cross_axis_opposition,cross_axis_opposition] modes:[3.0,3.0] freqs:[0.5,0.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[424]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"cross_axis_opposition, 4, 1.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[cross_axis_opposition,cross_axis_opposition] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[426]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"cross_axis_opposition, 4, 2.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[cross_axis_opposition,cross_axis_opposition] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[428]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"cross_axis_opposition, 4, 1.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[cross_axis_opposition,cross_axis_opposition] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[430]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"cross_axis_opposition, 4, 2.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[cross_axis_opposition,cross_axis_opposition] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[432]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"cross_axis_opposition, 4, 2.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[cross_axis_opposition,cross_axis_opposition] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[0.3,0.3] cycles:[4,4] cmd_id:[434]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"cross_axis_opposition, 4, 0.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[cross_axis_opposition,cross_axis_opposition] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.5,1.5] cycles:[4,4] cmd_id:[436]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"cross_axis_opposition, 2, 0.1, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[cross_axis_opposition,cross_axis_opposition] modes:[3.0,3.0] freqs:[0.1,0.1] amps:[1.5,1.5] cycles:[2,2] cmd_id:[438]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"cross_axis_opposition, 0.5, 1.5, 1.2\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[cross_axis_opposition,cross_axis_opposition] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.2,1.2] cycles:[0.5,0.5] cmd_id:[440]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
# --- Motion: random_phase_noise ---
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"random_phase_noise, 2, 1.0, 1.0\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[random_phase_noise,random_phase_noise] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.0,1.0] cycles:[2,2] cmd_id:[442]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"random_phase_noise, 4, 0.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[random_phase_noise,random_phase_noise] modes:[3.0,3.0] freqs:[0.5,0.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[444]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"random_phase_noise, 4, 1.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[random_phase_noise,random_phase_noise] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[446]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"random_phase_noise, 4, 2.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[random_phase_noise,random_phase_noise] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[448]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"random_phase_noise, 4, 1.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[random_phase_noise,random_phase_noise] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[450]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"random_phase_noise, 4, 2.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[random_phase_noise,random_phase_noise] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[452]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"random_phase_noise, 4, 2.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[random_phase_noise,random_phase_noise] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[0.3,0.3] cycles:[4,4] cmd_id:[454]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"random_phase_noise, 4, 0.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[random_phase_noise,random_phase_noise] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.5,1.5] cycles:[4,4] cmd_id:[456]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"random_phase_noise, 2, 0.1, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[random_phase_noise,random_phase_noise] modes:[3.0,3.0] freqs:[0.1,0.1] amps:[1.5,1.5] cycles:[2,2] cmd_id:[458]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"random_phase_noise, 0.5, 1.5, 1.2\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[random_phase_noise,random_phase_noise] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.2,1.2] cycles:[0.5,0.5] cmd_id:[460]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
# --- Motion: butterfly_pitch_roll ---
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"butterfly_pitch_roll, 2, 1.0, 1.0\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[butterfly_pitch_roll,butterfly_pitch_roll] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.0,1.0] cycles:[2,2] cmd_id:[462]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"butterfly_pitch_roll, 4, 0.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[butterfly_pitch_roll,butterfly_pitch_roll] modes:[3.0,3.0] freqs:[0.5,0.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[464]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"butterfly_pitch_roll, 4, 1.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[butterfly_pitch_roll,butterfly_pitch_roll] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[466]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"butterfly_pitch_roll, 4, 2.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[butterfly_pitch_roll,butterfly_pitch_roll] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[468]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"butterfly_pitch_roll, 4, 1.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[butterfly_pitch_roll,butterfly_pitch_roll] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[470]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"butterfly_pitch_roll, 4, 2.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[butterfly_pitch_roll,butterfly_pitch_roll] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[472]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"butterfly_pitch_roll, 4, 2.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[butterfly_pitch_roll,butterfly_pitch_roll] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[0.3,0.3] cycles:[4,4] cmd_id:[474]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"butterfly_pitch_roll, 4, 0.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[butterfly_pitch_roll,butterfly_pitch_roll] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.5,1.5] cycles:[4,4] cmd_id:[476]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"butterfly_pitch_roll, 2, 0.1, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[butterfly_pitch_roll,butterfly_pitch_roll] modes:[3.0,3.0] freqs:[0.1,0.1] amps:[1.5,1.5] cycles:[2,2] cmd_id:[478]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"butterfly_pitch_roll, 0.5, 1.5, 1.2\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[butterfly_pitch_roll,butterfly_pitch_roll] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.2,1.2] cycles:[0.5,0.5] cmd_id:[480]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
# --- Motion: left_pitch_square ---
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"left_pitch_square, 2, 1.0, 1.0\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[left_pitch_square,left_pitch_square] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.0,1.0] cycles:[2,2] cmd_id:[482]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"left_pitch_square, 4, 0.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[left_pitch_square,left_pitch_square] modes:[3.0,3.0] freqs:[0.5,0.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[484]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"left_pitch_square, 4, 1.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[left_pitch_square,left_pitch_square] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[486]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"left_pitch_square, 4, 2.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[left_pitch_square,left_pitch_square] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[488]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"left_pitch_square, 4, 1.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[left_pitch_square,left_pitch_square] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[490]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"left_pitch_square, 4, 2.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[left_pitch_square,left_pitch_square] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[492]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"left_pitch_square, 4, 2.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[left_pitch_square,left_pitch_square] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[0.3,0.3] cycles:[4,4] cmd_id:[494]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"left_pitch_square, 4, 0.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[left_pitch_square,left_pitch_square] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.5,1.5] cycles:[4,4] cmd_id:[496]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"left_pitch_square, 2, 0.1, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[left_pitch_square,left_pitch_square] modes:[3.0,3.0] freqs:[0.1,0.1] amps:[1.5,1.5] cycles:[2,2] cmd_id:[498]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"left_pitch_square, 0.5, 1.5, 1.2\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[left_pitch_square,left_pitch_square] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.2,1.2] cycles:[0.5,0.5] cmd_id:[500]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
# --- Motion: right_pitch_square ---
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"right_pitch_square, 2, 1.0, 1.0\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[right_pitch_square,right_pitch_square] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.0,1.0] cycles:[2,2] cmd_id:[502]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"right_pitch_square, 4, 0.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[right_pitch_square,right_pitch_square] modes:[3.0,3.0] freqs:[0.5,0.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[504]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"right_pitch_square, 4, 1.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[right_pitch_square,right_pitch_square] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[506]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"right_pitch_square, 4, 2.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[right_pitch_square,right_pitch_square] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[508]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"right_pitch_square, 4, 1.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[right_pitch_square,right_pitch_square] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[510]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"right_pitch_square, 4, 2.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[right_pitch_square,right_pitch_square] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[512]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"right_pitch_square, 4, 2.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[right_pitch_square,right_pitch_square] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[0.3,0.3] cycles:[4,4] cmd_id:[514]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"right_pitch_square, 4, 0.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[right_pitch_square,right_pitch_square] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.5,1.5] cycles:[4,4] cmd_id:[516]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"right_pitch_square, 2, 0.1, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[right_pitch_square,right_pitch_square] modes:[3.0,3.0] freqs:[0.1,0.1] amps:[1.5,1.5] cycles:[2,2] cmd_id:[518]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"right_pitch_square, 0.5, 1.5, 1.2\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[right_pitch_square,right_pitch_square] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.2,1.2] cycles:[0.5,0.5] cmd_id:[520]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
# --- Motion: left_roll_square ---
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"left_roll_square, 2, 1.0, 1.0\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[left_roll_square,left_roll_square] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.0,1.0] cycles:[2,2] cmd_id:[522]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"left_roll_square, 4, 0.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[left_roll_square,left_roll_square] modes:[3.0,3.0] freqs:[0.5,0.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[524]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"left_roll_square, 4, 1.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[left_roll_square,left_roll_square] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[526]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"left_roll_square, 4, 2.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[left_roll_square,left_roll_square] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[528]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"left_roll_square, 4, 1.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[left_roll_square,left_roll_square] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[530]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"left_roll_square, 4, 2.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[left_roll_square,left_roll_square] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[532]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"left_roll_square, 4, 2.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[left_roll_square,left_roll_square] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[0.3,0.3] cycles:[4,4] cmd_id:[534]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"left_roll_square, 4, 0.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[left_roll_square,left_roll_square] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.5,1.5] cycles:[4,4] cmd_id:[536]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"left_roll_square, 2, 0.1, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[left_roll_square,left_roll_square] modes:[3.0,3.0] freqs:[0.1,0.1] amps:[1.5,1.5] cycles:[2,2] cmd_id:[538]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"left_roll_square, 0.5, 1.5, 1.2\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[left_roll_square,left_roll_square] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.2,1.2] cycles:[0.5,0.5] cmd_id:[540]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
# --- Motion: right_roll_square ---
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"right_roll_square, 2, 1.0, 1.0\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[right_roll_square,right_roll_square] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.0,1.0] cycles:[2,2] cmd_id:[542]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"right_roll_square, 4, 0.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[right_roll_square,right_roll_square] modes:[3.0,3.0] freqs:[0.5,0.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[544]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"right_roll_square, 4, 1.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[right_roll_square,right_roll_square] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[546]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"right_roll_square, 4, 2.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[right_roll_square,right_roll_square] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[548]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"right_roll_square, 4, 1.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[right_roll_square,right_roll_square] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[550]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"right_roll_square, 4, 2.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[right_roll_square,right_roll_square] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[552]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"right_roll_square, 4, 2.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[right_roll_square,right_roll_square] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[0.3,0.3] cycles:[4,4] cmd_id:[554]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"right_roll_square, 4, 0.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[right_roll_square,right_roll_square] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.5,1.5] cycles:[4,4] cmd_id:[556]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"right_roll_square, 2, 0.1, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[right_roll_square,right_roll_square] modes:[3.0,3.0] freqs:[0.1,0.1] amps:[1.5,1.5] cycles:[2,2] cmd_id:[558]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"right_roll_square, 0.5, 1.5, 1.2\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[right_roll_square,right_roll_square] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.2,1.2] cycles:[0.5,0.5] cmd_id:[560]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
# --- Motion: symmetric_roll_square ---
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"symmetric_roll_square, 2, 1.0, 1.0\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[symmetric_roll_square,symmetric_roll_square] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.0,1.0] cycles:[2,2] cmd_id:[562]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"symmetric_roll_square, 4, 0.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[symmetric_roll_square,symmetric_roll_square] modes:[3.0,3.0] freqs:[0.5,0.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[564]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"symmetric_roll_square, 4, 1.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[symmetric_roll_square,symmetric_roll_square] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[566]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"symmetric_roll_square, 4, 2.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[symmetric_roll_square,symmetric_roll_square] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[568]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"symmetric_roll_square, 4, 1.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[symmetric_roll_square,symmetric_roll_square] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[570]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"symmetric_roll_square, 4, 2.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[symmetric_roll_square,symmetric_roll_square] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[572]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"symmetric_roll_square, 4, 2.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[symmetric_roll_square,symmetric_roll_square] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[0.3,0.3] cycles:[4,4] cmd_id:[574]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"symmetric_roll_square, 4, 0.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[symmetric_roll_square,symmetric_roll_square] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.5,1.5] cycles:[4,4] cmd_id:[576]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"symmetric_roll_square, 2, 0.1, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[symmetric_roll_square,symmetric_roll_square] modes:[3.0,3.0] freqs:[0.1,0.1] amps:[1.5,1.5] cycles:[2,2] cmd_id:[578]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"symmetric_roll_square, 0.5, 1.5, 1.2\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[symmetric_roll_square,symmetric_roll_square] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.2,1.2] cycles:[0.5,0.5] cmd_id:[580]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
# --- Motion: cross_axis_square_a ---
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"cross_axis_square_a, 2, 1.0, 1.0\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[cross_axis_square_a,cross_axis_square_a] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.0,1.0] cycles:[2,2] cmd_id:[582]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"cross_axis_square_a, 4, 0.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[cross_axis_square_a,cross_axis_square_a] modes:[3.0,3.0] freqs:[0.5,0.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[584]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"cross_axis_square_a, 4, 1.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[cross_axis_square_a,cross_axis_square_a] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[586]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"cross_axis_square_a, 4, 2.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[cross_axis_square_a,cross_axis_square_a] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[588]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"cross_axis_square_a, 4, 1.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[cross_axis_square_a,cross_axis_square_a] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[590]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"cross_axis_square_a, 4, 2.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[cross_axis_square_a,cross_axis_square_a] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[592]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"cross_axis_square_a, 4, 2.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[cross_axis_square_a,cross_axis_square_a] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[0.3,0.3] cycles:[4,4] cmd_id:[594]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"cross_axis_square_a, 4, 0.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[cross_axis_square_a,cross_axis_square_a] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.5,1.5] cycles:[4,4] cmd_id:[596]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"cross_axis_square_a, 2, 0.1, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[cross_axis_square_a,cross_axis_square_a] modes:[3.0,3.0] freqs:[0.1,0.1] amps:[1.5,1.5] cycles:[2,2] cmd_id:[598]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"cross_axis_square_a, 0.5, 1.5, 1.2\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[cross_axis_square_a,cross_axis_square_a] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.2,1.2] cycles:[0.5,0.5] cmd_id:[600]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
# --- Motion: cross_axis_square_b ---
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"cross_axis_square_b, 2, 1.0, 1.0\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[cross_axis_square_b,cross_axis_square_b] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.0,1.0] cycles:[2,2] cmd_id:[602]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"cross_axis_square_b, 4, 0.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[cross_axis_square_b,cross_axis_square_b] modes:[3.0,3.0] freqs:[0.5,0.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[604]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"cross_axis_square_b, 4, 1.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[cross_axis_square_b,cross_axis_square_b] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[606]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"cross_axis_square_b, 4, 2.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[cross_axis_square_b,cross_axis_square_b] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[608]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"cross_axis_square_b, 4, 1.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[cross_axis_square_b,cross_axis_square_b] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[610]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"cross_axis_square_b, 4, 2.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[cross_axis_square_b,cross_axis_square_b] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[612]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"cross_axis_square_b, 4, 2.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[cross_axis_square_b,cross_axis_square_b] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[0.3,0.3] cycles:[4,4] cmd_id:[614]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"cross_axis_square_b, 4, 0.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[cross_axis_square_b,cross_axis_square_b] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.5,1.5] cycles:[4,4] cmd_id:[616]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"cross_axis_square_b, 2, 0.1, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[cross_axis_square_b,cross_axis_square_b] modes:[3.0,3.0] freqs:[0.1,0.1] amps:[1.5,1.5] cycles:[2,2] cmd_id:[618]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"cross_axis_square_b, 0.5, 1.5, 1.2\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[cross_axis_square_b,cross_axis_square_b] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.2,1.2] cycles:[0.5,0.5] cmd_id:[620]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
# --- Motion: all_axis_jumbled_square ---
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"all_axis_jumbled_square, 2, 1.0, 1.0\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[all_axis_jumbled_square,all_axis_jumbled_square] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.0,1.0] cycles:[2,2] cmd_id:[622]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"all_axis_jumbled_square, 4, 0.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[all_axis_jumbled_square,all_axis_jumbled_square] modes:[3.0,3.0] freqs:[0.5,0.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[624]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"all_axis_jumbled_square, 4, 1.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[all_axis_jumbled_square,all_axis_jumbled_square] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[626]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"all_axis_jumbled_square, 4, 2.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[all_axis_jumbled_square,all_axis_jumbled_square] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[628]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"all_axis_jumbled_square, 4, 1.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[all_axis_jumbled_square,all_axis_jumbled_square] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[630]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"all_axis_jumbled_square, 4, 2.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[all_axis_jumbled_square,all_axis_jumbled_square] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[632]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"all_axis_jumbled_square, 4, 2.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[all_axis_jumbled_square,all_axis_jumbled_square] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[0.3,0.3] cycles:[4,4] cmd_id:[634]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"all_axis_jumbled_square, 4, 0.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[all_axis_jumbled_square,all_axis_jumbled_square] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.5,1.5] cycles:[4,4] cmd_id:[636]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"all_axis_jumbled_square, 2, 0.1, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[all_axis_jumbled_square,all_axis_jumbled_square] modes:[3.0,3.0] freqs:[0.1,0.1] amps:[1.5,1.5] cycles:[2,2] cmd_id:[638]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"all_axis_jumbled_square, 0.5, 1.5, 1.2\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[all_axis_jumbled_square,all_axis_jumbled_square] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.2,1.2] cycles:[0.5,0.5] cmd_id:[640]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
# --- Motion: global_step_response ---
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"global_step_response, 2, 1.0, 1.0\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[global_step_response,global_step_response] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.0,1.0] cycles:[2,2] cmd_id:[642]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"global_step_response, 4, 0.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[global_step_response,global_step_response] modes:[3.0,3.0] freqs:[0.5,0.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[644]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"global_step_response, 4, 1.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[global_step_response,global_step_response] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[646]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"global_step_response, 4, 2.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[global_step_response,global_step_response] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[648]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"global_step_response, 4, 1.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[global_step_response,global_step_response] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[650]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"global_step_response, 4, 2.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[global_step_response,global_step_response] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[652]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"global_step_response, 4, 2.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[global_step_response,global_step_response] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[0.3,0.3] cycles:[4,4] cmd_id:[654]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"global_step_response, 4, 0.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[global_step_response,global_step_response] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.5,1.5] cycles:[4,4] cmd_id:[656]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"global_step_response, 2, 0.1, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[global_step_response,global_step_response] modes:[3.0,3.0] freqs:[0.1,0.1] amps:[1.5,1.5] cycles:[2,2] cmd_id:[658]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"global_step_response, 0.5, 1.5, 1.2\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[global_step_response,global_step_response] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.2,1.2] cycles:[0.5,0.5] cmd_id:[660]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
# --- Motion: dual_power_stroke ---
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"dual_power_stroke, 2, 1.0, 1.0\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[dual_power_stroke,dual_power_stroke] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.0,1.0] cycles:[2,2] cmd_id:[662]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"dual_power_stroke, 4, 0.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[dual_power_stroke,dual_power_stroke] modes:[3.0,3.0] freqs:[0.5,0.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[664]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"dual_power_stroke, 4, 1.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[dual_power_stroke,dual_power_stroke] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[666]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"dual_power_stroke, 4, 2.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[dual_power_stroke,dual_power_stroke] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[668]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"dual_power_stroke, 4, 1.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[dual_power_stroke,dual_power_stroke] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[670]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"dual_power_stroke, 4, 2.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[dual_power_stroke,dual_power_stroke] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[672]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"dual_power_stroke, 4, 2.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[dual_power_stroke,dual_power_stroke] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[0.3,0.3] cycles:[4,4] cmd_id:[674]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"dual_power_stroke, 4, 0.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[dual_power_stroke,dual_power_stroke] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.5,1.5] cycles:[4,4] cmd_id:[676]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"dual_power_stroke, 2, 0.1, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[dual_power_stroke,dual_power_stroke] modes:[3.0,3.0] freqs:[0.1,0.1] amps:[1.5,1.5] cycles:[2,2] cmd_id:[678]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"dual_power_stroke, 0.5, 1.5, 1.2\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[dual_power_stroke,dual_power_stroke] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.2,1.2] cycles:[0.5,0.5] cmd_id:[680]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
# --- Motion: static_load_offset ---
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"static_load_offset, 2, 1.0, 1.0\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[static_load_offset,static_load_offset] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.0,1.0] cycles:[2,2] cmd_id:[682]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"static_load_offset, 4, 0.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[static_load_offset,static_load_offset] modes:[3.0,3.0] freqs:[0.5,0.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[684]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"static_load_offset, 4, 1.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[static_load_offset,static_load_offset] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[686]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"static_load_offset, 4, 2.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[static_load_offset,static_load_offset] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[688]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"static_load_offset, 4, 1.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[static_load_offset,static_load_offset] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[690]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"static_load_offset, 4, 2.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[static_load_offset,static_load_offset] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[692]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"static_load_offset, 4, 2.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[static_load_offset,static_load_offset] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[0.3,0.3] cycles:[4,4] cmd_id:[694]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"static_load_offset, 4, 0.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[static_load_offset,static_load_offset] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.5,1.5] cycles:[4,4] cmd_id:[696]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"static_load_offset, 2, 0.1, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[static_load_offset,static_load_offset] modes:[3.0,3.0] freqs:[0.1,0.1] amps:[1.5,1.5] cycles:[2,2] cmd_id:[698]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"static_load_offset, 0.5, 1.5, 1.2\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[static_load_offset,static_load_offset] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.2,1.2] cycles:[0.5,0.5] cmd_id:[700]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
# --- Motion: chirp_test ---
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"chirp_test, 2, 1.0, 1.0\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[chirp_test,chirp_test] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.0,1.0] cycles:[2,2] cmd_id:[702]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"chirp_test, 4, 0.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[chirp_test,chirp_test] modes:[3.0,3.0] freqs:[0.5,0.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[704]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"chirp_test, 4, 1.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[chirp_test,chirp_test] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[706]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"chirp_test, 4, 2.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[chirp_test,chirp_test] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[708]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"chirp_test, 4, 1.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[chirp_test,chirp_test] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[710]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"chirp_test, 4, 2.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[chirp_test,chirp_test] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[712]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"chirp_test, 4, 2.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[chirp_test,chirp_test] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[0.3,0.3] cycles:[4,4] cmd_id:[714]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"chirp_test, 4, 0.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[chirp_test,chirp_test] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.5,1.5] cycles:[4,4] cmd_id:[716]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"chirp_test, 2, 0.1, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[chirp_test,chirp_test] modes:[3.0,3.0] freqs:[0.1,0.1] amps:[1.5,1.5] cycles:[2,2] cmd_id:[718]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"chirp_test, 0.5, 1.5, 1.2\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[chirp_test,chirp_test] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.2,1.2] cycles:[0.5,0.5] cmd_id:[720]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
# --- Motion: hysteresis_test ---
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"hysteresis_test, 2, 1.0, 1.0\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[hysteresis_test,hysteresis_test] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.0,1.0] cycles:[2,2] cmd_id:[722]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"hysteresis_test, 4, 0.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[hysteresis_test,hysteresis_test] modes:[3.0,3.0] freqs:[0.5,0.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[724]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"hysteresis_test, 4, 1.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[hysteresis_test,hysteresis_test] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[726]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"hysteresis_test, 4, 2.5, 0.3\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[hysteresis_test,hysteresis_test] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[1.5,1.5] cycles:[4,4] cmd_id:[728]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"hysteresis_test, 4, 1.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[hysteresis_test,hysteresis_test] modes:[3.0,3.0] freqs:[1.0,1.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[730]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"hysteresis_test, 4, 2.0, 0.7\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[hysteresis_test,hysteresis_test] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.2,1.2] cycles:[4,4] cmd_id:[732]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"hysteresis_test, 4, 2.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[hysteresis_test,hysteresis_test] modes:[3.0,3.0] freqs:[2.5,2.5] amps:[0.3,0.3] cycles:[4,4] cmd_id:[734]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"hysteresis_test, 4, 0.5, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[hysteresis_test,hysteresis_test] modes:[3.0,3.0] freqs:[2.0,2.0] amps:[1.5,1.5] cycles:[4,4] cmd_id:[736]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"hysteresis_test, 2, 0.1, 1.5\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[hysteresis_test,hysteresis_test] modes:[3.0,3.0] freqs:[0.1,0.1] amps:[1.5,1.5] cycles:[2,2] cmd_id:[738]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"hysteresis_test, 0.5, 1.5, 1.2\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{data: \"actuators:[left,right] motions:[hysteresis_test,hysteresis_test] modes:[3.0,3.0] freqs:[1.5,1.5] amps:[1.2,1.2] cycles:[0.5,0.5] cmd_id:[740]\"}" --once
sleep 2
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: \"calibration, 1.0, 1.0, 0.0\"}" --once
sleep 1
