import pandas as pd
from db_connection import conn, cursor

df = pd.read_csv(r"..\data\cleaned\cleaned_weather.csv")

locations = pd.read_sql(
    """
    SELECT *
    FROM locations
    """,
    conn
)

mapping = {}

for _, row in locations.iterrows():
    mapping[
        (
            row["city"],
            row["district"],
            row["ward"]
        )
    ] = row["location_id"]

df["location_id"] = df.apply(
    lambda row:
    mapping[
        (
            row["city"],
            row["district"],
            row["ward"]
        )
    ],
    axis=1
)

# Tạo weather_id tự động
df["weather_id"] = range(1, len(df) + 1)

# Xóa sạch dữ liệu cũ
cursor.execute("TRUNCATE TABLE weather_data")

for _, row in df.iterrows():
    cursor.execute(
        """
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
        """,
        (
            int(row["weather_id"]),
            int(row["location_id"]),
            row["date"],
            float(row["rainfall"]),
            float(row["temperature"]),
            float(row["humidity"]),
            float(row["pressure"]),
            float(row["wind_speed"])
        )
    )

conn.commit()

print("Insert weather_data successfully")