import sys, os, csv
import rosbag2_py
from rclpy.serialization import deserialize_message
from rosidl_runtime_py.utilities import get_message

def format_time(rel_nanosec):
    seconds = rel_nanosec / 1e9
    return f"{int(seconds // 60):02d}:{seconds % 60:06.3f}"

def process_bag(folder_path):
    reader = rosbag2_py.SequentialReader()
    storage_options = rosbag2_py.StorageOptions(uri=folder_path, storage_id='mcap')
    converter_options = rosbag2_py.ConverterOptions(
        input_serialization_format='cdr', output_serialization_format='cdr')
    reader.open(storage_options, converter_options)

    topic_types = {t.name: t.type for t in reader.get_all_topics_and_types()}
    writers, files, first_ts = {}, {}, None

    while reader.has_next():
        (topic, data, t) = reader.read_next()
        if first_ts is None: first_ts = t
        
        if topic not in writers:
            filename = f"{topic.replace('/', '_').strip('_')}.csv"
            f = open(os.path.join(folder_path, filename), 'w', newline='')
            writer = csv.writer(f)
            # Dynamic header based on message attributes
            msg_type = get_message(topic_types[topic])
            msg_instance = msg_type()
            headers = ['readable_time'] + [attr for attr in msg_instance.__slots__ if not attr.startswith('_')]
            writer.writerow(headers)
            writers[topic], files[topic] = writer, f

        msg = deserialize_message(data, get_message(topic_types[topic]))
        row = [format_time(t - first_ts)]
        for attr in msg.__slots__:
            if not attr.startswith('_'):
                val = getattr(msg, attr)
                row.append(list(val) if hasattr(val, '__iter__') and not isinstance(val, str) else val)
        writers[topic].writerow(row)

    for f in files.values(): f.close()
    print(f"Extraction complete in {folder_path}")

if __name__ == "__main__":
    if len(sys.argv) < 2: print("Usage: python3 process_bag.py <folder_name>")
    else: process_bag(sys.argv[1])