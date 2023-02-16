DROP DATABASE sql_workshop ;
CREATE DATABASE sql_workshop;

USE sql_workshop;

-- DROP TABLE iss_status;
CREATE TABLE iss_status (
	iss_timestamp DATETIME,
    activity_status VARCHAR(50),
    PRIMARY KEY (iss_timestamp)
);

-- DROP TABLE iss_logs;
CREATE TABLE iss_logs (
	id INT AUTO_INCREMENT, 
    latitude FLOAT(6), 
    longitude FLOAT(6), 
    iss_timestamp DATETIME,
    PRIMARY KEY (id),
    FOREIGN KEY (iss_timestamp) REFERENCES iss_status(iss_timestamp)
);

-- INSERT INTO iss_logs (latitude, longitude, iss_timestamp)
-- VALUES (42.3, 10.23, "2020-07-22 10:30:10");

-- INSERT INTO iss_status (iss_timestamp, activity_status)
-- VALUES ("2020-07-22 10:30:10","active");

-- SELECT * FROM iss_logs JOIN iss_status ON iss_logs.iss_timestamp = iss_status.iss_timestamp;
