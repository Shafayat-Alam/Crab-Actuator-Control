#!/bin/bash

# --- Motion: forward_paddle ---
ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{data: 'forward_flap, 4.0, 1, 1'}" --once
sleep 2