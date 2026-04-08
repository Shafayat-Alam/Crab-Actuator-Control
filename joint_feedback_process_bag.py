import os
import rosbag2_py
import pandas as pd
from rclpy.serialization import deserialize_message
from std_msgs.msg import Float32MultiArray

# --- CHANGE ONLY THIS ---
TARGET_FOLDER = "flapping_test_01" 
# ------------------------

def main():
    reader = rosbag2_py.SequentialReader()
    storage_options = rosbag2_py.StorageOptions(uri=TARGET_FOLDER, storage_id='mcap')
    converter_options = rosbag2_py.ConverterOptions('', '')
    
    try:
        reader.open(storage_options, converter_options)
    except Exception:
        print(f"Error: Folder '{TARGET_FOLDER}' not found.")
        return

    data_rows = []
    while reader.has_next():
        (topic, data, t_nanos) = reader.read_next()
        
        # This script ONLY looks for your feedback topic
        if topic == '/joint_feedback':
            msg = deserialize_message(data, Float32MultiArray)
            # Row = [Timestamp, ID1, ID2..., Pos1, Pos2...]
            data_rows.append([t_nanos / 1e9] + list(msg.data))

    if not data_rows:
        print(f"No /joint_feedback data found in {TARGET_FOLDER}.")
        return

    # --- DYNAMIC COLUMN NAMING ---
    # Calculates motor count based on the data actually found in the bag
    total_data_points = len(data_rows[0]) - 1 # exclude timestamp
    num_motors = total_data_points // 2
    
    cols = ['Bag_Time']
    # Add ID columns
    for i in range(num_motors):
        cols.append(f'ID_{i+1}')
    # Add Position columns
    for i in range(num_motors):
        cols.append(f'M{i+1}_Actual')

    df = pd.DataFrame(data_rows, columns=cols)
    output_path = os.path.join(TARGET_FOLDER, "hardware_telemetry.csv")
    df.to_csv(output_path, index=False)
    
    print(f"Success! Processed {len(df)} frames for {num_motors} motors.")
    print(f"File saved to: {output_path}")

if __name__ == "__main__":
    main()