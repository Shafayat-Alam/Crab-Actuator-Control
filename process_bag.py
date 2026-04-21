import sys, os, csv
import rosbag2_py
from rclpy.serialization import deserialize_message
from rosidl_runtime_py.utilities import get_message
from rosidl_runtime_py.convert import message_to_ordereddict

# Mapping for known hardware topics
TOPIC_MAPS = {
    'joint_feedback': ['id', 'mode', 'pos_rad', 'vel_rads', 'curr_amps', 'volt_v'],
    'joint_cmd':      ['id', 'mode', 'goal'],
    'telemetry':      ['goal_rad', 'fb_pos_rad', 'fb_vel_rads', 'fb_curr_amps', 'fb_volt_v'],
    'motion_cmd':     ['command_string'] # String messages
}

def format_time(rel_nanosec):
    seconds = rel_nanosec / 1e9
    return f"{int(seconds // 60):02d}:{seconds % 60:06.3f}"

def process_bag(folder_path):
    # Ensure the path exists
    if not os.path.exists(folder_path):
        print(f"Error: Path '{folder_path}' does not exist.")
        return

    reader = rosbag2_py.SequentialReader()
    storage_options = rosbag2_py.StorageOptions(uri=folder_path, storage_id='mcap')
    converter_options = rosbag2_py.ConverterOptions(
        input_serialization_format='cdr', output_serialization_format='cdr')
    
    try:
        reader.open(storage_options, converter_options)
    except Exception as e:
        print(f"Could not open bag at {folder_path}: {e}")
        return

    topic_types = {t.name: t.type for t in reader.get_all_topics_and_types()}
    writers, files, first_ts = {}, {}, None
    msg_count = 0

    while reader.has_next():
        (topic_name, data, t) = reader.read_next()
        msg_count += 1
        topic_clean = topic_name.strip('/')
        if first_ts is None: first_ts = t
        
        try:
            msg = deserialize_message(data, get_message(topic_types[topic_name]))
            msg_dict = message_to_ordereddict(msg)
        except Exception as e:
            print(f"Skip {topic_name}: {e}")
            continue

        if topic_name not in writers:
            filename = f"{topic_clean.replace('/', '_')}.csv"
            output_file = os.path.join(folder_path, filename)
            f = open(output_file, 'w', newline='')
            writer = csv.writer(f)
            
            headers = ['readable_time']
            
            # Specialized header logic
            if topic_clean == 'telemetry' and 'data' in msg_dict:
                headers.extend(['cmd_id', 'unix_ts'])
                data_list = msg_dict['data'][2:] 
                fields = TOPIC_MAPS['telemetry']
                num_servos = len(data_list) // len(fields)
                for s in range(num_servos):
                    headers.extend([f"{f}_{s}" for f in fields])
            
            elif topic_clean == 'joint_cmd' and 'data' in msg_dict:
                n = len(msg_dict['data']) // 3
                for i in range(n): headers.append(f"id_{i}")
                for i in range(n): headers.append(f"mode_{i}")
                for i in range(n): headers.append(f"goal_{i}")
            
            else:
                # Global fallback: process all fields in the message
                for key, val in msg_dict.items():
                    if key == 'layout': continue
                    if isinstance(val, (list, tuple)):
                        if topic_clean in TOPIC_MAPS:
                            fields = TOPIC_MAPS[topic_clean]
                            num_servos = len(val) // len(fields)
                            for s in range(num_servos):
                                headers.extend([f"{f}_{s}" for f in fields])
                        else:
                            headers.extend([f"{key}_{i}" for i in range(len(val))])
                    else:
                        headers.append(key)
            
            writer.writerow(headers)
            writers[topic_name], files[topic_name] = writer, f
            print(f"Created: {filename}")

        # Row Generation
        row = [format_time(t - first_ts)]
        for key, val in msg_dict.items():
            if key == 'layout': continue
            if isinstance(val, (list, tuple)):
                row.extend(list(val))
            else:
                row.append(val)
                
        writers[topic_name].writerow(row)

    for f in files.values(): f.close()
    
    if msg_count == 0:
        print("No messages found. Is the folder path correct and does it contain .mcap files?")
    else:
        print(f"Finished. Processed {msg_count} messages across {len(writers)} topics.")

if __name__ == "__main__":
    if len(sys.argv) < 2: 
        print("Usage: python3 process_bag.py <folder_name>")
    else: 
        process_bag(sys.argv[1])