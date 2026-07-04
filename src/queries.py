import pandas as pd
from db_connection import conn

query = """
SELECT
    l.location,
    w.[date],
    w.rainfall,
    w.temperature,
    w.humidity,
    w.pressure,
    w.wind_speed,
    r.river_discharge

FROM weather_data w
JOIN river_data r ON w.location_id = r.location_id
AND CAST(w.[date] AS DATE) = CAST(r.[date] AS DATE)

JOIN locations l ON w.location_id = l.location_id
"""

df = pd.read_sql(query, conn)

print(df)