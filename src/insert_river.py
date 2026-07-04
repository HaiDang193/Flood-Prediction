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

# Tạo river_id tự động
df["river_id"] = range(1, len(df) + 1)

# Xóa sạch dữ liệu cũ
cursor.execute("DELETE FROM river_data")

insert_river = """
        INSERT INTO river_data
        (
            river_id,
            location_id,
            [date],
            river_discharge
        )
        VALUES
        (
            ?, ?, ?, ?
        )
        """
for _, row in df.iterrows():
    cursor.execute(
        insert_river,
        int(row["river_id"]),
        int(row["location_id"]),
        row["date"],
        float(row["river_discharge"])
    )

conn.commit()

print("Insert river_data successfully")