#!/bin/bash
# test_position_mode.sh - Position Mode Command Sequence Test
# Usage: ./test_position_mode.sh
# All position values in radians

DELAY=1

echo "========================================="
echo "Starting Position Mode Test Sequence"
echo "========================================="
echo ""

# =========================================================================
# DRIVE COMMANDS - Individual Servo Control
# =========================================================================

# Command 1: Drive servo 3 to 0.5 rad
echo "Command 1: Drive servo 3 to 0.5 rad"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[1] func:[drive] servo:[3] value:[0.5]'"
sleep $DELAY

# Command 2: Drive servo 4 to 0.5 rad
echo "Command 2: Drive servo 4 to 0.5 rad"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[2] func:[drive] servo:[4] value:[0.5]'"
sleep $DELAY

# Command 3: Drive servo 3 to -0.5 rad
echo "Command 3: Drive servo 3 to -0.5 rad"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[3] func:[drive] servo:[3] value:[-0.5]'"
sleep $DELAY

# Command 4: Drive servo 4 to -0.5 rad
echo "Command 4: Drive servo 4 to -0.5 rad"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[4] func:[drive] servo:[4] value:[-0.5]'"
sleep $DELAY

# Command 5: Drive servo 3 to 0.0 rad (zero position)
echo "Command 5: Drive servo 3 to zero"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[5] func:[drive] servo:[3] value:[0.0]'"
sleep $DELAY

# Command 6: Drive servo 4 to 0.0 rad (zero position)
echo "Command 6: Drive servo 4 to zero"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[6] func:[drive] servo:[4] value:[0.0]'"
sleep $DELAY

# =========================================================================
# SINE_FLAP GAIT - Basic Variations
# =========================================================================

# Command 7: sine_flap basic - low freq, small amp
echo "Command 7: sine_flap - 0.5 Hz, 0.2 rad, 2 cycles"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[7] func:[sine_flap] freq:[0.5] amp:[0.2] phase:[0.0] cycles:[2] sets:[1]'"
sleep $DELAY

# Command 8: sine_flap - higher frequency
echo "Command 8: sine_flap - 1.0 Hz, 0.3 rad, 3 cycles"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[8] func:[sine_flap] freq:[1.0] amp:[0.3] phase:[0.0] cycles:[3] sets:[1]'"
sleep $DELAY

# Command 9: sine_flap - larger amplitude
echo "Command 9: sine_flap - 0.5 Hz, 0.5 rad, 2 cycles"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[9] func:[sine_flap] freq:[0.5] amp:[0.5] phase:[0.0] cycles:[2] sets:[1]'"
sleep $DELAY

# =========================================================================
# SINE_FLAP GAIT - Phase Offset Variations (Up/Down Flap)
# =========================================================================

# Command 10: sine_flap - up flap (phase_offset = π/2)
echo "Command 10: sine_flap - up flap (phase_offset 1.57 rad)"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[10] func:[sine_flap] freq:[0.5] amp:[0.3] phase:[0.0] phase_offset:[1.57] cycles:[2] sets:[1]'"
sleep $DELAY

# Command 11: sine_flap - down flap (phase_offset = -π/2)
echo "Command 11: sine_flap - down flap (phase_offset -1.57 rad)"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[11] func:[sine_flap] freq:[0.5] amp:[0.3] phase:[0.0] phase_offset:[-1.57] cycles:[2] sets:[1]'"
sleep $DELAY

# Command 12: sine_flap - 180° out of phase (phase_offset = π)
echo "Command 12: sine_flap - 180° phase shift"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[12] func:[sine_flap] freq:[0.5] amp:[0.3] phase:[0.0] phase_offset:[3.14] cycles:[2] sets:[1]'"
sleep $DELAY

# =========================================================================
# SINE_FLAP GAIT - Frequency and Amplitude Ratio Tests
# =========================================================================

# Command 13: sine_flap - frequency ratio 2.0 (even servos oscillate 2x faster)
echo "Command 13: sine_flap - freq_ratio 2.0"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[13] func:[sine_flap] freq:[0.5] amp:[0.3] phase:[0.0] freq_ratio:[2.0] cycles:[2] sets:[1]'"
sleep $DELAY

# Command 14: sine_flap - amplitude ratio 0.5 (even servos half amplitude)
echo "Command 14: sine_flap - amp_ratio 0.5"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[14] func:[sine_flap] freq:[0.5] amp:[0.3] phase:[0.0] amp_ratio:[0.5] cycles:[2] sets:[1]'"
sleep $DELAY

# Command 15: sine_flap - hold mode (freq_ratio 0.0, even servos hold at +amp)
echo "Command 15: sine_flap - forward flap (freq_ratio 0.0)"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[15] func:[sine_flap] freq:[0.5] amp:[0.3] phase:[0.0] freq_ratio:[0.0] amp_ratio:[1.0] cycles:[2] sets:[1]'"
sleep $DELAY

# Command 16: sine_flap - hold mode (freq_ratio 0.0, even servos hold at -amp)
echo "Command 16: sine_flap - backward flap (amp_ratio -1.0)"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[16] func:[sine_flap] freq:[0.5] amp:[0.3] phase:[0.0] freq_ratio:[0.0] amp_ratio:[-1.0] cycles:[2] sets:[1]'"
sleep $DELAY

# =========================================================================
# SINE_PADDLE GAIT
# =========================================================================

# Command 17: sine_paddle - basic
echo "Command 17: sine_paddle - basic"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[17] func:[sine_paddle] freq:[0.5] amp:[0.3] phase:[0.0] cycles:[2] sets:[1]'"
sleep $DELAY

# Command 18: sine_paddle - with phase offset
echo "Command 18: sine_paddle - with phase offset"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[18] func:[sine_paddle] freq:[0.5] amp:[0.3] phase:[0.0] phase_offset:[1.57] cycles:[2] sets:[1]'"
sleep $DELAY

# =========================================================================
# EDGE CASE TESTS
# =========================================================================

# Command 19: Very low frequency
echo "Command 19: Very low frequency (0.2 Hz)"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[19] func:[sine_flap] freq:[0.2] amp:[0.3] phase:[0.0] cycles:[1] sets:[1]'"
sleep $DELAY

# Command 20: Very small amplitude
echo "Command 20: Very small amplitude (0.1 rad)"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[20] func:[sine_flap] freq:[0.5] amp:[0.1] phase:[0.0] cycles:[2] sets:[1]'"
sleep $DELAY

# Command 21: Near position limit (servo 3 max ~1.57 rad)
echo "Command 21: Drive servo 3 near upper limit (1.4 rad)"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[21] func:[drive] servo:[3] value:[1.4]'"
sleep $DELAY

# Command 22: Near position limit (servo 3 min ~-1.57 rad)
echo "Command 22: Drive servo 3 near lower limit (-1.4 rad)"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[22] func:[drive] servo:[3] value:[-1.4]'"
sleep $DELAY

# Command 23: Near position limit (servo 4 max ~3.14 rad)
echo "Command 23: Drive servo 4 near upper limit (3.0 rad)"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[23] func:[drive] servo:[4] value:[3.0]'"
sleep $DELAY

# Command 24: Near position limit (servo 4 min ~-3.14 rad)
echo "Command 24: Drive servo 4 near lower limit (-3.0 rad)"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[24] func:[drive] servo:[4] value:[-3.0]'"
sleep $DELAY

# =========================================================================
# RAPID COMMAND SEQUENCE - No Delay
# =========================================================================

# Command 25: Rapid command 1
echo "Command 25: Rapid command sequence - command 1"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[25] func:[drive] servo:[3] value:[0.3]'"
# NO DELAY

# Command 26: Rapid command 2
echo "Command 26: Rapid command sequence - command 2"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[26] func:[drive] servo:[4] value:[0.3]'"
# NO DELAY

# Command 27: Rapid command 3
echo "Command 27: Rapid command sequence - command 3"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[27] func:[drive] servo:[3] value:[-0.3]'"
sleep $DELAY

# =========================================================================
# RETURN TO ZERO
# =========================================================================

# Command 28: Return servo 3 to zero
echo "Command 28: Return servo 3 to zero"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[28] func:[drive] servo:[3] value:[0.0]'"
sleep $DELAY

# Command 29: Return servo 4 to zero
echo "Command 29: Return servo 4 to zero"
ros2 topic pub --once /robot_cmd std_msgs/String "data: 'cmd_id:[29] func:[drive] servo:[4] value:[0.0]'"

echo ""
echo "========================================="
echo "Position Mode Test Sequence Complete"
echo "========================================="
