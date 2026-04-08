import os
import rosbag2_py
import pandas as pd
from rclpy.serialization import deserialize_message
from std_msgs.msg import Float32MultiArray

# --- CONFIGURATION ---
TARGET_FOLDER = "telemetry_test_01" 
# ---------------------

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
        
        # FIX: Look for /telemetry
        if topic == '/telemetry':
            msg = deserialize_message(data, Float32MultiArray)
            # data_rows will contain [Cmd_ID, Internal_Time, M1_Mode, M1_Target, M1_Actual, ...]
            data_rows.append(list(msg.data))

    if not data_rows:
        print("No /telemetry data found. Did you record that topic?")
        return

    # Define Columns based on your Controller's send_and_log structure
    # Header (2 values)
    cols = ['Cmd_ID', 'Controller_Time']
    
    # Motor Data (3 values per motor: Mode, Target, Actual)
    # We calculate motor count based on (Total - Header) / 3
    num_motors = (len(data_rows[0]) - 2) // 3
    
    for i in range(1, num_motors + 1):
        cols.append(f'M{i}_Mode')
        cols.append(f'M{i}_Target')
        cols.append(f'M{i}_Actual')

    df = pd.DataFrame(data_rows, columns=cols)
    
    # ADDED: Automatic Error Calculation
    for i in range(1, num_motors + 1):
        df[f'M{i}_Diff'] = df[f'M{i}_Target'] - df[f'M{i}_Actual']

    output_path = os.path.join(TARGET_FOLDER, "processed_telemetry.csv")
    df.to_csv(output_path, index=False)
    
    print(f"Success! Processed {len(df)} frames for {num_motors} motors.")
    print(f"File saved: {output_path}")

if __name__ == "__main__":
    main()