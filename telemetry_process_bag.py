import os
import rosbag2_py
import pandas as pd
from rclpy.serialization import deserialize_message
from std_msgs.msg import Float32MultiArray

# --- CONFIG ---
TARGET_FOLDER = "telemetry_data" 
# --------------

def main():
    reader = rosbag2_py.SequentialReader()
    storage_options = rosbag2_py.StorageOptions(uri=TARGET_FOLDER, storage_id='mcap')
    converter_options = rosbag2_py.ConverterOptions('', '')
    
    try:
        reader.open(storage_options, converter_options)
    except Exception:
        print(f"Error: Bag '{TARGET_FOLDER}' not found.")
        return

    data_rows = []
    while reader.has_next():
        (topic, data, t_nanos) = reader.read_next()
        if topic == '/telemetry':
            msg = deserialize_message(data, Float32MultiArray)
            # Bag_Time + [cmd_id, ts, M1_Goal, M1_Pos, M1_Vel, M1_Curr, M1_Volt, M2...]
            data_rows.append([t_nanos / 1e9] + list(msg.data))

    if not data_rows:
        print("No telemetry found.")
        return

    # 1. Identify Structure
    # Controller sends: [cmd_id, ts] + (Goal, Pos, Vel, Curr, Volt) * NUM_MOTORS
    msg_width = len(data_rows[0]) - 1 # Remove Bag_Time
    num_motors = (msg_width - 2) // 5
    
    # 2. Map Raw Columns
    raw_cols = ['Bag_Time', 'Cmd_ID', 'Controller_Time']
    for i in range(1, num_motors + 1):
        raw_cols += [f'M{i}_Goal', f'M{i}_Pos', f'M{i}_Vel', f'M{i}_Curr', f'M{i}_Volt']
    
    # Handle any unexpected extra bytes
    leftover = len(data_rows[0]) - len(raw_cols)
    for i in range(leftover):
        raw_cols.append(f'Extra_Metric_{i+1}')

    df = pd.DataFrame(data_rows, columns=raw_cols)

    # 3. Calculate Errors and Reorganize for Readability
    # Goal: Bag_Time -> Header -> [Goal, Pos, Error, Vel, Curr, Volt] per motor
    ordered_cols = ['Bag_Time', 'Cmd_ID', 'Controller_Time']
    for i in range(1, num_motors + 1):
        # Calculate tracking error: Goal - Actual Position
        df[f'M{i}_Error'] = df[f'M{i}_Goal'] - df[f'M{i}_Pos']
        
        # Group all data for this motor together
        ordered_cols += [
            f'M{i}_Goal', 
            f'M{i}_Pos', 
            f'M{i}_Error', 
            f'M{i}_Vel', 
            f'M{i}_Curr', 
            f'M{i}_Volt'
        ]
    
    # Add any extra metrics to the end
    ordered_cols += [c for c in raw_cols if "Extra" in c]
    
    # Finalize DataFrame
    df = df[ordered_cols]

    # 4. Save with Excel-friendly encoding
    output_path = os.path.join(TARGET_FOLDER, "processed_telemetry.csv")
    df.to_csv(output_path, index=False, encoding='utf-8-sig', lineterminator='\n')
    
    print(f"Success! Detected {num_motors} motors.")
    print(f"Columns correctly mapped: Goal, Pos, Error, Vel, Curr, Volt.")
    print(f"File saved: {output_path}")

if __name__ == "__main__":
    main()