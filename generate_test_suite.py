import numpy as np

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

test_params = [
    (1.0, 1.0, 2, "baseline"), (1.0, 1.0, 2, "baseline"),
    (0.5, 0.3, 4, "sweep"), (0.5, 1.5, 4, "sweep"), (1.5, 0.3, 4, "sweep"), (1.5, 1.5, 4, "sweep"), (2.5, 0.3, 4, "sweep"),
    (2.5, 1.5, 4, "sweep"), (1.0, 0.7, 4, "sweep"), (1.0, 1.2, 4, "sweep"), (2.0, 0.7, 4, "sweep"), (2.0, 1.2, 4, "sweep"),
    (2.5, 1.5, 4, "stress"), (2.5, 0.3, 4, "stress"), (0.5, 1.5, 4, "stress"), (2.0, 1.5, 4, "stress"),
    (0.1, 1.5, 2, "precision"), (0.1, 1.5, 2, "precision"),
    (1.5, 1.2, 0.5, "transient"), (1.5, 1.2, 0.5, "transient")
]

with open("run_full_test.sh", "w") as f:
    f.write("#!/bin/bash\n\n")
    
    cmd_id = 1
    for m in motions:
        f.write(f"# --- Motion: {m} ---\n")
        for i, (freq, amp, cyc, label) in enumerate(test_params):
            if i % 2 == 0:
                f.write(f'ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{{data: \\"{m}, {cyc}, {freq}, {amp}\\"}}" --once\n')
            else:
                motion_str = f"actuators:[left,right] motions:[{m},{m}] modes:[3.0,3.0] freqs:[{freq},{freq}] amps:[{amp},{amp}] cycles:[{cyc},{cyc}] cmd_id:[{cmd_id}]"
                f.write(f'ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{{data: \\"{motion_str}\\"}}" --once\n')
            
            f.write("sleep 1\n") # Wait for motion to finish/stabilize
            
            f.write(f'ros2 topic pub -1 /robot_cmd std_msgs/msg/String "{{data: \\"calibration, 1.0, 1.0, 0.0\\"}}" --once\n')
            
            cmd_id += 1

print("Generated run_full_test.sh with safety delays.")