-- Description: SQL queries for the HealthMetrics table

-- Add new entries
INSERT INTO HealthMetrics (UserID, RecordDate, HeartRate, BloodPressure, WeightKG, BodyFatPercentage)
VALUES (4, "2024-03-15", 73, 140/85, 66, 21.02);  

-- TEST: Get the last inserted HealthMetrics entry
SELECT * FROM HealthMetrics ORDER BY MetricID DESC LIMIT 1;


-- Health Metrics Trend Over the Last 30 Days
SELECT RecordDate, WeightKG -- Add more columns as needed
FROM HealthMetrics
WHERE UserID = 4
AND RecordDate BETWEEN date('now', '-30 days') AND date('now')
ORDER BY RecordDate;
