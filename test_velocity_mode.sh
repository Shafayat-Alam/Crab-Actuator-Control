#!/bin/bash
# test_velocity_mode.sh - Velocity Mode Command Sequence Test
# Usage: ./test_velocity_mode.sh
# All velocity values in rad/s
# NOTE: Before running, set operating_mode to 'velocity' in crab_launch.py

DELAY=1

echo "========================================="
echo "Starting Velocity Mode Test Sequence"
echo "========================================="
echo "WARNING: Ensure operating_mode is set to 'velocity' in launch file"
echo ""

# =========================================================================
# DRIVE COMMANDS - Individual Servo Control (Velocity)
# =========================================================================

# Command 1: Drive servo 3 at 0.5 rad/s
echo "Command 1: Drive servo 3 at 0.5 rad/s"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[1] func:[drive] servo:[3] value:[0.5]'"
sleep $DELAY

# Command 2: Drive servo 4 at 0.5 rad/s
echo "Command 2: Drive servo 4 at 0.5 rad/s"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[2] func:[drive] servo:[4] value:[0.5]'"
sleep $DELAY

# Command 3: Drive servo 3 at -0.5 rad/s (reverse)
echo "Command 3: Drive servo 3 at -0.5 rad/s"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[3] func:[drive] servo:[3] value:[-0.5]'"
sleep $DELAY

# Command 4: Drive servo 4 at -0.5 rad/s (reverse)
echo "Command 4: Drive servo 4 at -0.5 rad/s"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[4] func:[drive] servo:[4] value:[-0.5]'"
sleep $DELAY

# Command 5: Stop servo 3 (0 rad/s)
echo "Command 5: Stop servo 3"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[5] func:[drive] servo:[3] value:[0.0]'"
sleep $DELAY

# Command 6: Stop servo 4 (0 rad/s)
echo "Command 6: Stop servo 4"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[6] func:[drive] servo:[4] value:[0.0]'"
sleep $DELAY

# =========================================================================
# SINE_FLAP GAIT - Basic Variations (Velocity)
# =========================================================================

# Command 7: sine_flap basic - low freq, small amp velocity
echo "Command 7: sine_flap - 0.5 Hz, 0.3 rad/s, 2 cycles"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[7] func:[sine_flap] freq:[0.5] amp:[0.3] phase:[0.0] cycles:[2] sets:[1]'"
sleep $DELAY

# Command 8: sine_flap - higher frequency
echo "Command 8: sine_flap - 1.0 Hz, 0.5 rad/s, 3 cycles"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[8] func:[sine_flap] freq:[1.0] amp:[0.5] phase:[0.0] cycles:[3] sets:[1]'"
sleep $DELAY

# Command 9: sine_flap - larger amplitude velocity
echo "Command 9: sine_flap - 0.5 Hz, 0.8 rad/s, 2 cycles"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[9] func:[sine_flap] freq:[0.5] amp:[0.8] phase:[0.0] cycles:[2] sets:[1]'"
sleep $DELAY

# =========================================================================
# SINE_FLAP GAIT - Phase Offset Variations
# =========================================================================

# Command 10: sine_flap - up flap pattern (phase_offset = π/2)
echo "Command 10: sine_flap - phase_offset 1.57 rad"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[10] func:[sine_flap] freq:[0.5] amp:[0.4] phase:[0.0] phase_offset:[1.57] cycles:[2] sets:[1]'"
sleep $DELAY

# Command 11: sine_flap - down flap pattern (phase_offset = -π/2)
echo "Command 11: sine_flap - phase_offset -1.57 rad"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[11] func:[sine_flap] freq:[0.5] amp:[0.4] phase:[0.0] phase_offset:[-1.57] cycles:[2] sets:[1]'"
sleep $DELAY

# Command 12: sine_flap - 180° out of phase (phase_offset = π)
echo "Command 12: sine_flap - 180° phase shift"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[12] func:[sine_flap] freq:[0.5] amp:[0.4] phase:[0.0] phase_offset:[3.14] cycles:[2] sets:[1]'"
sleep $DELAY

# =========================================================================
# SINE_FLAP GAIT - Frequency and Amplitude Ratio Tests
# =========================================================================

# Command 13: sine_flap - frequency ratio 2.0
echo "Command 13: sine_flap - freq_ratio 2.0"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[13] func:[sine_flap] freq:[0.5] amp:[0.4] phase:[0.0] freq_ratio:[2.0] cycles:[2] sets:[1]'"
sleep $DELAY

# Command 14: sine_flap - amplitude ratio 0.5
echo "Command 14: sine_flap - amp_ratio 0.5"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[14] func:[sine_flap] freq:[0.5] amp:[0.4] phase:[0.0] amp_ratio:[0.5] cycles:[2] sets:[1]'"
sleep $DELAY

# Command 15: sine_flap - hold mode (freq_ratio 0.0, even servos hold velocity)
echo "Command 15: sine_flap - forward pattern (freq_ratio 0.0)"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[15] func:[sine_flap] freq:[0.5] amp:[0.4] phase:[0.0] freq_ratio:[0.0] amp_ratio:[1.0] cycles:[2] sets:[1]'"
sleep $DELAY

# Command 16: sine_flap - hold mode negative velocity
echo "Command 16: sine_flap - backward pattern (amp_ratio -1.0)"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[16] func:[sine_flap] freq:[0.5] amp:[0.4] phase:[0.0] freq_ratio:[0.0] amp_ratio:[-1.0] cycles:[2] sets:[1]'"
sleep $DELAY

# =========================================================================
# SINE_PADDLE GAIT (Velocity)
# =========================================================================

# Command 17: sine_paddle - basic
echo "Command 17: sine_paddle - basic"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[17] func:[sine_paddle] freq:[0.5] amp:[0.4] phase:[0.0] cycles:[2] sets:[1]'"
sleep $DELAY

# Command 18: sine_paddle - with phase offset
echo "Command 18: sine_paddle - with phase offset"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[18] func:[sine_paddle] freq:[0.5] amp:[0.4] phase:[0.0] phase_offset:[1.57] cycles:[2] sets:[1]'"
sleep $DELAY

# =========================================================================
# VELOCITY MAGNITUDE TESTS
# =========================================================================

# Command 19: Very low velocity
echo "Command 19: Very low velocity (0.1 rad/s)"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[19] func:[drive] servo:[3] value:[0.1]'"
sleep $DELAY

# Command 20: Medium velocity
echo "Command 20: Medium velocity (1.0 rad/s)"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[20] func:[drive] servo:[3] value:[1.0]'"
sleep $DELAY

# Command 21: Higher velocity
echo "Command 21: Higher velocity (1.5 rad/s)"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[21] func:[drive] servo:[4] value:[1.5]'"
sleep $DELAY

# Command 22: Stop
echo "Command 22: Stop servo 3"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[22] func:[drive] servo:[3] value:[0.0]'"
sleep $DELAY

# Command 23: Stop servo 4
echo "Command 23: Stop servo 4"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[23] func:[drive] servo:[4] value:[0.0]'"
sleep $DELAY

# =========================================================================
# OSCILLATING VELOCITY PATTERNS
# =========================================================================

# Command 24: Low frequency velocity oscillation
echo "Command 24: Low frequency oscillation (0.2 Hz)"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[24] func:[sine_flap] freq:[0.2] amp:[0.5] phase:[0.0] cycles:[1] sets:[1]'"
sleep $DELAY

# Command 25: High frequency velocity oscillation
echo "Command 25: High frequency oscillation (2.0 Hz)"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[25] func:[sine_flap] freq:[2.0] amp:[0.3] phase:[0.0] cycles:[3] sets:[1]'"
sleep $DELAY

# =========================================================================
# RAPID COMMAND SEQUENCE - No Delay
# =========================================================================

# Command 26: Rapid velocity change 1
echo "Command 26: Rapid command sequence - command 1"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[26] func:[drive] servo:[3] value:[0.5]'"
# NO DELAY

# Command 27: Rapid velocity change 2
echo "Command 27: Rapid command sequence - command 2"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[27] func:[drive] servo:[4] value:[0.5]'"
# NO DELAY

# Command 28: Rapid velocity change 3
echo "Command 28: Rapid command sequence - command 3"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[28] func:[drive] servo:[3] value:[-0.5]'"
sleep $DELAY

# =========================================================================
# ALTERNATING DIRECTION TEST
# =========================================================================

# Command 29: Forward velocity
echo "Command 29: Forward velocity servo 3"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[29] func:[drive] servo:[3] value:[0.6]'"
sleep $DELAY

# Command 30: Reverse velocity
echo "Command 30: Reverse velocity servo 3"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[30] func:[drive] servo:[3] value:[-0.6]'"
sleep $DELAY

# =========================================================================
# RETURN TO STOP
# =========================================================================

# Command 31: Stop servo 3
echo "Command 31: Stop servo 3"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[31] func:[drive] servo:[3] value:[0.0]'"
sleep $DELAY

# Command 32: Stop servo 4
echo "Command 32: Stop servo 4"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[32] func:[drive] servo:[4] value:[0.0]'"

echo ""
echo "========================================="
echo "Velocity Mode Test Sequence Complete"
echo "========================================="
