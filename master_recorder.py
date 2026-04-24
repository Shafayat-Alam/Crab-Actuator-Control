import subprocess, csv, time, re, os, sys

def main():
    if len(sys.argv) < 2:
        print("Usage: python3 master_recorder.py <folder_name>"); sys.exit(1)

    folder = sys.argv[1]
    os.makedirs(folder, exist_ok=True)
    
    print(f"Recording ROS Bag and Power to: {folder}")
    # Start ROS Bag Record (All topics)
    bag_proc = subprocess.Popen(['ros2', 'bag', 'record', '-a', '-o', folder, '-s', 'mcap'])
    
    # Start Power Logger
    p_log = open(os.path.join(folder, "power_log.csv"), 'w', newline='')
    p_writer = csv.writer(p_log)
    p_writer.writerow(["Timestamp", "Total_Power_mW", "CPU_GPU_mW", "SOC_mW"])
    
    tegrastats = subprocess.Popen(['tegrastats', '--interval', '1000'], stdout=subprocess.PIPE, text=True)

    try:
        for line in tegrastats.stdout:
            v_in = re.search(r"VDD_IN (\d+)mW", line)
            v_core = re.search(r"VDD_CPU_GPU_CV (\d+)mW", line)
            v_soc = re.search(r"VDD_SOC (\d+)mW", line)
            if v_in:
                ts = time.strftime("%H:%M:%S")
                p_writer.writerow([ts, v_in.group(1), v_core.group(1) if v_core else "0", v_soc.group(1) if v_soc else "0"])
                p_log.flush()
    except KeyboardInterrupt:
        print("\nStopping recording...")
        tegrastats.terminate()
        bag_proc.terminate()
        p_log.close()

if __name__ == "__main__":
    main()