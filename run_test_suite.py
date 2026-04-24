import numpy as np

# 37 Motion Functions
motions = [
    "forward_paddle", "backward_paddle", "forward_flap", "backward_flap", "up_flap", "down_flap",
    "left_roll_sine", "right_roll_sine", "left_pitch_sine", "right_pitch_sine",
    "symmetric_roll_sine", "asymmetric_roll_sine", "symmetric_pitch_sine", "asymmetric_pitch_sine",
    "left_flipper_coupled", "right_flipper_coupled", "diagonal_test_a", "diagonal_test_b",
    "four_axis_quadrature", "reverse_quadrature", "jumbled_quadrature", "cross_axis_opposition",
    "random_phase_noise", "butterfly_pitch_roll", "left_pitch_square", "right_pitch_square",
    "left_roll_square", "right_roll_square", "symmetric_roll_square", "cross_axis_square_a",
    "cross_axis_square_b", "all_axis_jumbled_square", "global_step_response", "dual_power_stroke",
    "static_load_offset", "chirp_test", "hysteresis_test"
]

# 20 Test Parameters (Freq, Amp, Cycles, Label)
test_params = [
    # Baseline (2)
    (1.0, 1.0, 2, "baseline"), (1.0, 1.0, 2, "baseline"),
    # Linear Sweeps (10)
    (0.5, 0.3, 4, "sweep"), (0.5, 1.5, 4, "sweep"), (1.5, 0.3, 4, "sweep"), (1.5, 1.5, 4, "sweep"), (2.5, 0.3, 4, "sweep"),
    (2.5, 1.5, 4, "sweep"), (1.0, 0.7, 4, "sweep"), (1.0, 1.2, 4, "sweep"), (2.0, 0.7, 4, "sweep"), (2.0, 1.2, 4, "sweep"),
    # High-Intensity (4)
    (2.5, 1.5, 4, "stress"), (2.5, 0.3, 4, "stress"), (0.5, 1.5, 4, "stress"), (2.0, 1.5, 4, "stress"),
    # Precision (2)
    (0.1, 1.5, 2, "precision"), (0.1, 1.5, 2, "precision"),
    # Transients (2)
    (1.5, 1.2, 0.5, "transient"), (1.5, 1.2, 0.5, "transient")
]

with open("run_full_test.sh", "w") as f:
    f.write("#!/bin/bash\n\n")
    f.write("# Automated 1480-Command Test Suite\n")
    f.write("# Calibration commands sent via robot_cmd\n\n")
    
    for m in motions:
        f.write(f"# --- Starting Motion: {m} ---\n")
        for i, (freq, amp, cyc, label) in enumerate(test_params):
            # Alternate topics for motion commands
            topic = "robot_cmd" if i % 2 == 0 else "motion_cmd"
            
            # 1. The Active Test Command
            f.write(f'ros2 topic pub -1 /{topic} std_msgs/msg/String "{{data: \\"{m},{freq},{amp},{cyc}\\"}}"\n')
            
            # 2. The Hard Reset Calibration Command (now strictly robot_cmd)
            f.write(f'ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{{data: \\"calibration,1.0,1.0,0.0\\"}}"\n')
        f.write("\n")

print("Generated run_full_test.sh. Calibration set to /robot_cmd.")