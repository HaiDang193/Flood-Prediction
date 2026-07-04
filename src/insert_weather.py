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

query = """
    SELECT *
    FROM locations
    """
locations = pd.read_sql(query, conn)

mapping = {}

for _, row in locations.iterrows():
    mapping[
        (
            row["location"]
        )
    ] = row["location_id"]

df["location_id"] = df.apply(
    lambda row:
    mapping[
        (
            row["location"]
        )
    ],
    axis=1
)

# Tạo weather_id tự động
df["weather_id"] = range(1, len(df) + 1)

# Xóa sạch dữ liệu cũ
cursor.execute("DELETE FROM weather_data")

insert_weather = """
        INSERT INTO weather_data
        (
            weather_id,
            location_id,
            [date],
            rainfall,
            temperature,
            humidity,
            pressure,
            wind_speed
        )
        VALUES
        (
            ?, ?, ?, ?, ?, ?, ?, ?
        )
        """
for _, row in df.iterrows():
    cursor.execute(
        insert_weather,
        int(row["weather_id"]),
        int(row["location_id"]),
        row["date"],
        float(row["rainfall"]),
        float(row["temperature"]),
        float(row["humidity"]),
        float(row["pressure"]),
        float(row["wind_speed"])
        )

conn.commit()

print("Insert weather_data successfully")