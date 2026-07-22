CREATE TABLE location_data (
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
    REFERENCES location_data(location_id)
);

CREATE TABLE river_data (
    river_id INT PRIMARY KEY,
    location_id INT, 
    date DATE,
    river_discharge REAL,

    FOREIGN KEY(location_id) 
    REFERENCES location_data(location_id)
);

CREATE TABLE label_data(
    flood_id INT PRIMARY KEY,
    location_id INT,
    date Date,
    flood INT
    FOREIGN KEY(location_id) 
    REFERENCES location_data(location_id)
)