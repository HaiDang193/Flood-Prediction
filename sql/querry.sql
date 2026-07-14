SELECT * FROM location_data

SELECT * FROM weather_data

SELECT * FROM river_data

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

INNER JOIN river_data r
ON w.location_id = r.location_id
AND CAST(w.[date] AS DATE) = CAST(r.[date] AS DATE)

INNER JOIN location_data l
ON w.location_id = l.location_id