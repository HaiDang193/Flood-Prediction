import pandas as pd
from db_connection import conn, cursor
import os

#lấy đường dẫn của file hiện tại
cur_dir = os.path.dirname(os.path.abspath(__file__))

#tạo đường dẫn đến file csv
csv_path = os.path.join(cur_dir, "..", "data", "cleaned", "weather_cleaned.csv")

# chuyển đường dẫn thành đường dẫn tuyệt đối
csv_path = os.path.abspath(csv_path)

df = pd.read_csv(csv_path)

location_data = (
    df[
        ["location"]
    ]
    .drop_duplicates()
    .reset_index(drop=True)
)

location_data["location_id"] = location_data.index + 1

insert_location_data = """
    INSERT INTO location_data(
        location_id,
        location
    )
    VALUES
    (
        ?, ?
    )
    """

# Xóa sạch dữ liệu cũ
cursor.execute("DELETE FROM weather_data")
cursor.execute("DELETE FROM river_data")
cursor.execute("DELETE FROM label_data")
cursor.execute("DELETE FROM location_data")

for _, row in location_data.iterrows():
    cursor.execute(insert_location_data, int(row["location_id"]), row["location"])

conn.commit()

print("location_data inserted")