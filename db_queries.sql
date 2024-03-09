-- 1. Workout Tracking: Retrieve the last 7 days of workouts for a specific user
SELECT WorkoutType, Duration, Intensity, Date
FROM Workouts
WHERE UserID = ? -- Replace ? with the specific UserID
AND Date >= CURDATE() - INTERVAL 7 DAY
ORDER BY Date DESC;

-- 2. Nutrition Analysis: Calculate the average daily calorie intake for the past month
SELECT AVG(Calories) as AverageCalories
FROM NutritionLogs
WHERE UserID = ? -- Replace ? with the specific UserID
AND Date BETWEEN CURDATE() - INTERVAL 1 MONTH AND CURDATE();

-- 3. Sleep Pattern Assessment: Assess the average sleep duration for a user over the last month
SELECT AVG(TIMESTAMPDIFF(HOUR, StartTime, EndTime)) as AverageSleepHours
FROM SleepPatterns
WHERE UserID = ? -- Replace ? with the specific UserID
AND StartTime >= CURDATE() - INTERVAL 1 MONTH;

-- 4. User Progress Monitoring: Monitor weight change over the past 3 months
SELECT Date, Weight
FROM HealthMetrics
WHERE UserID = ? -- Replace ? with the specific UserID
AND Date BETWEEN CURDATE() - INTERVAL 3 MONTH AND CURDATE()
ORDER BY Date ASC;

-- 5. Personalized Recommendations: Find users with similar fitness goals and compare workout types
SELECT U.UserID, U.FitnessGoals, W.WorkoutType, COUNT(*) as WorkoutFrequency
FROM Users U
JOIN Workouts W ON U.UserID = W.UserID
WHERE U.FitnessGoals = (
    SELECT FitnessGoals
    FROM Users
    WHERE UserID = ? -- Replace ? with the specific UserID
)
GROUP BY U.UserID, W.WorkoutType
ORDER BY WorkoutFrequency DESC;

-- Bonus: Identify potential dietary adjustments by comparing average macronutrient intake against recommended values
SELECT 
    UserID,
    AVG(CASE WHEN Macronutrient = 'Protein' THEN Amount END) as AverageProtein,
    AVG(CASE WHEN Macronutrient = 'Fat' THEN Amount END) as AverageFat,
    AVG(CASE WHEN Macronutrient = 'Carbohydrate' THEN Amount END) as AverageCarbs
FROM (
    SELECT 
        N.UserID, 
        SUBSTRING_INDEX(SUBSTRING_INDEX(N.Macronutrients, ',', numbers.n), ',', -1) as MacronutrientPair
    FROM 
        (SELECT 1 n UNION ALL SELECT 2 UNION ALL SELECT 3) numbers INNER JOIN NutritionLogs N
        ON CHAR_LENGTH(N.Macronutrients)
           -CHAR_LENGTH(REPLACE(N.Macronutrients, ',', ''))>=numbers.n-1
    WHERE N.Date >= CURDATE() - INTERVAL 1 MONTH
) AS M
CROSS JOIN LATERAL (
    SELECT 
        SUBSTRING_INDEX(MacronutrientPair, ':', 1) as Macronutrient,
        SUBSTRING_INDEX(MacronutrientPair, ':', -1) as Amount
) AS N
GROUP BY UserID;
