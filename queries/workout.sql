-- Description: SQL queries for workout data
-- Indices are be applied here

-- Insert a new workout entry
INSERT INTO Workouts (UserID, Type, DurationMinutes, DistanceKM, CaloriesBurned, WorkoutDate)
VALUES (2, 'Running', 30, 5, 300, '2024-03-15');

-- TEST: Get the last inserted workout entry
SELECT * FROM Workouts ORDER BY WorkoutID DESC LIMIT 1;

-- Recent Workouts Summary
SELECT Type, DurationMinutes, DistanceKM, CaloriesBurned, WorkoutDate
FROM Workouts
WHERE UserID = 2
ORDER BY WorkoutDate DESC
LIMIT 5;

--  Workout Frequency by Type
SELECT Type, COUNT(*) AS TotalCount
FROM Workouts
WHERE UserID = 2
GROUP BY Type
ORDER BY TotalCount DESC;

-- Monthly Workout Summary
SELECT 
    strftime('%Y-%m', WorkoutDate) AS Month,
    SUM(DurationMinutes) AS TotalDuration,
    SUM(CaloriesBurned) AS TotalCalories
FROM Workouts
WHERE UserID = 2
GROUP BY Month
ORDER BY Month DESC;


-- Specific Workout Type History 
-- Created index will be applied here to optimize query performance
SELECT WorkoutDate, DurationMinutes, DistanceKM, CaloriesBurned
FROM Workouts
WHERE UserID = 2 AND Type = 'Running'
ORDER BY WorkoutDate ASC;

