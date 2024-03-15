INSERT INTO Sleep (UserID, StartDateTime, EndDateTime, Quality)
VALUES (5, '2024-03-15 22:00:00', '2024-03-16 07:00:00', 'Good');

-- TEST: Get the last inserted Sleep entry
SELECT * FROM Sleep ORDER BY SleepID DESC LIMIT 1;


-- Average Sleep Duration Calculation
SELECT AVG(julianday(EndDateTime) - julianday(StartDateTime)) * 24 AS AvgSleepHours
FROM Sleep
WHERE UserID = 5  
AND StartDateTime >= date('now', 'start of month')
AND EndDateTime <= date('now', 'start of month', '+1 month', '-1 day');


-- Sleep Quality Analysis
SELECT Quality, COUNT(*) AS Count
FROM Sleep
WHERE UserID = 5
GROUP BY Quality
ORDER BY Count DESC;


