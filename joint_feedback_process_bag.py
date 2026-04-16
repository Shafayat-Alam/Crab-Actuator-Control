import os
import rosbag2_py
import pandas as pd
from rclpy.serialization import deserialize_message
from std_msgs.msg import Float32MultiArray

# --- CONFIG ---
TARGET_FOLDER = "joint_feedback_data" 
NUM_MOTORS = 2
# --------------

def main():
    reader = rosbag2_py.SequentialReader()
    storage_options = rosbag2_py.StorageOptions(uri=TARGET_FOLDER, storage_id='mcap')
    converter_options = rosbag2_py.ConverterOptions('', '')
    
    try:
        reader.open(storage_options, converter_options)
    except Exception:
        print(f"Error: Bag folder '{TARGET_FOLDER}' not found.")
        return

    data_rows = []
    while reader.has_next():
        (topic, data, t_nanos) = reader.read_next()
        if topic == '/joint_feedback':
            msg = deserialize_message(data, Float32MultiArray)
            # Bag timestamp + the raw float array from the message
            data_rows.append([t_nanos / 1e9] + list(msg.data))

    if not data_rows:
        print("No hardware feedback found in the specified bag.")
        return

    # --- DEFINE LABELED COLUMNS ---
    # Based on interface: [ID, Mode, Pos, Vel, Curr, Volt] per motor
    cols = ['Bag_Time']
    for i in range(1, NUM_MOTORS + 1):
        cols += [
            f'M{i}_ID', 
            f'M{i}_Mode', 
            f'M{i}_Pos_rad', 
            f'M{i}_Vel_rads', 
            f'M{i}_Curr_Amps', 
            f'M{i}_Volt'
        ]

    # --- DATA CLEANING ---
    # Ensure every row matches the header length (1 timestamp + 6 fields * 2 motors = 13 columns)
    expected_length = 1 + (NUM_MOTORS * 6)
    cleaned_rows = [row[:expected_length] for row in data_rows if len(row) >= expected_length]

    # --- SAVE CSV ---
    df = pd.DataFrame(cleaned_rows, columns=cols)
    output_path = os.path.join(TARGET_FOLDER, "hardware_feedback.csv")
    
    # utf-8-sig ensures Excel opens the columns correctly on the first try
    df.to_csv(output_path, index=False, encoding='utf-8-sig', lineterminator='\n')
    
    print(f"Success! Processed {len(df)} feedback frames.")
    print(f"Mapped {NUM_MOTORS} motors with units: Rad, Rad/s, Amps, Volts.")
    print(f"File saved: {output_path}")

if __name__ == "__main__":
    main()