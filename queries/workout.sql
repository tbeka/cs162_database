-- Description: SQL queries for workout data
-- Indices will be applied here to optimize query performance

-- Insert a new workout entry
INSERT INTO Workouts (UserID, Type, DurationMinutes, DistanceKM, CaloriesBurned, WorkoutDate)
VALUES (2, 'Running', 30, 5, 300, '2024-03-15');

-- TEST: Get the last inserted workout entry
SELECT * FROM Workouts ORDER BY WorkoutID DESC LIMIT 1;

-- Recent Workouts Summary
-- Fetches the last 5 workouts for a specific user, ordered by the most recent.
SELECT Type, DurationMinutes, DistanceKM, CaloriesBurned, WorkoutDate
FROM Workouts
WHERE UserID = 2
ORDER BY WorkoutDate DESC
LIMIT 5;

-- Workout Frequency by Type
-- Counts how many workouts of each type the specified user has logged, ordered by the total count in descending order.
SELECT Type, COUNT(*) AS TotalCount
FROM Workouts
WHERE UserID = 2
GROUP BY Type
ORDER BY TotalCount DESC;

-- Monthly Workout Summary
-- Aggregates workout data by month for the specified user, 
-- summing up total duration and calories burned for each month and ordering by the most recent month first.
SELECT 
    strftime('%Y-%m', WorkoutDate) AS Month,
    SUM(DurationMinutes) AS TotalDuration,
    SUM(CaloriesBurned) AS TotalCalories
FROM Workouts
WHERE UserID = 2
GROUP BY Month
ORDER BY Month DESC;

-- Specific Workout Type History
-- Leverages the created index to efficiently fetch all instances of a specific workout type ('Running' in this case) for the user,
-- ordered by date to show the progression over time.
SELECT WorkoutDate, DurationMinutes, DistanceKM, CaloriesBurned
FROM Workouts
WHERE UserID = 2 AND Type = 'Running'
ORDER BY WorkoutDate ASC;


