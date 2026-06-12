import pandas as pd
from db_connection import conn, cursor

df = pd.read_csv(r"..\data\cleaned\cleaned_weather.csv")

locations = (
    df[
        ["city","district","ward"]
    ]
    .drop_duplicates()
    .reset_index(drop=True)
)

locations["location_id"] = locations.index + 1

# Xóa sạch dữ liệu cũ
cursor.execute("TRUNCATE TABLE locations")

for _, row in locations.iterrows():

    cursor.execute("""
    INSERT INTO locations
    (
        location_id,
        city,
        district,
        ward
    )
    VALUES
    (
        ?, ?, ?, ?
    )
    """,
    int(row["location_id"]),
    row["city"],
    row["district"],
    row["ward"])

conn.commit()

print("Locations inserted")