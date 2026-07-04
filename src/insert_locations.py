import pandas as pd
from db_connection import conn, cursor
import os

#lấy đường dẫn của file hiện tại
cur_dir = os.path.dirname(os.path.abspath(__file__))

#tạo đường dẫn đến file csv
csv_path = os.path.join(cur_dir, "..", "data", "cleaned", "cleaned_weather.csv")

# chuyển đường dẫn thành đường dẫn tuyệt đối
csv_path = os.path.abspath(csv_path)

df = pd.read_csv(csv_path)

locations = (
    df[
        ["location"]
    ]
    .drop_duplicates()
    .reset_index(drop=True)
)

locations["location_id"] = locations.index + 1

insert_locations = """
    INSERT INTO locations(
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
cursor.execute("DELETE FROM locations")

for _, row in locations.iterrows():
    cursor.execute(insert_locations, int(row["location_id"]), row["location"])

conn.commit()

print("Locations inserted")