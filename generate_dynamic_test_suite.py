import os
import numpy as np

# --- Configuration ---
motions = [
    "forward_flap", "backward_flap", "up_flap", 
    "down_flap", "forward_paddle", "backward_paddle"
]

# Parameters for the linear sweep (5 steps)
# Testing range: Frequency 0.5Hz to 2.5Hz, Amplitude 0.3 to 1.5
freq_steps = np.linspace(0.5, 2.5, 5)
amp_steps = np.linspace(0.3, 1.5, 5)
cycles = 4.0

output_file = "run_dynamic_test.sh"

def generate_sh_script():
    with open(output_file, "w") as f:
        f.write("#!/bin/bash\n\n")
        f.write("# --- Dynamic Testing: Linear Sweeps & Mixed Transitions ---\n")
        f.write("# No calibration in between. 4 cycles per motion.\n\n")

        cmd_id = 1000 # Starting ID for this test set

        # --- PART 1: Linear Sweep (30 Commands) ---
        # 6 motions * 5 steps = 30 commands
        f.write("# PART 1: Linear Sweeps per Motion\n")
        for m in motions:
            f.write(f"# Sweep for {m}\n")
            for i in range(5):
                freq = round(freq_steps[i], 2)
                amp = round(amp_steps[i], 2)
                
                motion_str = (
                    f"actuators:[left,right] motions:[{m},{m}] modes:[3.0,3.0] "
                    f"freqs:[{freq},{freq}] amps:[{amp},{amp}] cycles:[{cycles},{cycles}] "
                    f"cmd_id:[{cmd_id}]"
                )
                
                f.write(f'ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{{data: \\"{motion_str}\\"}}" --once\n')
                
                # Sleep exactly for the motion duration to hot-swap
                duration = cycles / freq
                f.write(f"sleep {duration}\n")
                cmd_id += 1
            f.write("\n")

        # --- PART 2: Mixed Transitions (6 Commands) ---
        # Each command contains a sequence of all 6 motions back-to-back
        f.write("# PART 2: Mixed Motion Transitions (6 repeats)\n")
        mix_freq = 1.2
        mix_amp = 1.0
        
        for repeat in range(6):
            f.write(f"# Mixed Set {repeat + 1}\n")
            for m in motions:
                motion_str = (
                    f"actuators:[left,right] motions:[{m},{m}] modes:[3.0,3.0] "
                    f"freqs:[{mix_freq},{mix_freq}] amps:[{mix_amp},{mix_amp}] "
                    f"cycles:[{cycles},{cycles}] cmd_id:[{cmd_id}]"
                )
                
                f.write(f'ros2 topic pub -1 /motion_cmd std_msgs/msg/String "{{data: \\"{motion_str}\\"}}" --once\n')
                
                duration = cycles / mix_freq
                f.write(f"sleep {duration}\n")
                cmd_id += 1
            f.write("\n")

    os.chmod(output_file, 0o755)
    print(f"Generated {output_file} with 36 total commands.")

if __name__ == "__main__":
    generate_sh_script()