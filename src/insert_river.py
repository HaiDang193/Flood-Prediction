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

# Tạo river_id tự động
df["river_id"] = range(1, len(df) + 1)

# Xóa sạch dữ liệu cũ
cursor.execute("TRUNCATE TABLE river_data")

for _, row in df.iterrows():
    cursor.execute(
        """
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
        """,
        (
            int(row["river_id"]),
            int(row["location_id"]),
            row["date"],
            float(row["river_discharge"])
        )
    )

conn.commit()

print("Insert river_data successfully")