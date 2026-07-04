CREATE TABLE locations (
    location_id INT PRIMARY KEY,
    location NVARCHAR(255)    
);

CREATE TABLE weather_data (
    weather_id INT PRIMARY KEY,
    location_id INT,
    date DATE,
    rainfall REAL,
    temperature REAL,
    humidity REAL,
    pressure REAL,
    wind_speed REAL,

    FOREIGN KEY(location_id) 
    REFERENCES locations(location_id)
);

CREATE TABLE river_data (
    river_id INT PRIMARY KEY,
    location_id INT, 
    date DATE,
    river_discharge REAL,

    FOREIGN KEY(location_id) 
    REFERENCES locations(location_id)
);

CREATE TABLE flood_label (
    label_id INT PRIMARY KEY,
    location_id INT,
    date DATE,

    flood_risk INT, 
    -- 0 = Low
    -- 1 = Medium
    -- 2 = High
    water_rise REAL,

    FOREIGN KEY(location_id) 
    REFERENCES locations(location_id)
);