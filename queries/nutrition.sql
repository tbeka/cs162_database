-- Description: Nutrition Queries
-- Transactions are applied here for grouped operations

-- Log a New Nutrition Entry
INSERT INTO Nutrition (UserID, MealType, FoodItem, Calories, CarbsG, ProteinsG, FatsG, NutritionDate)
VALUES (3, 'Breakfast', 'Granola with cheese', 400, 70, 40, 20, '2024-03-15');

-- TEST: Get the last inserted Nutrition entry
SELECT * FROM Nutrition ORDER BY NutritionID DESC LIMIT 1;

-- TRANSACTION: Log a Nutrition Entry for the whole day
BEGIN;

INSERT INTO Nutrition (UserID, MealType, FoodItem, Calories, CarbsG, ProteinsG, FatsG, NutritionDate)
VALUES 
    (3, 'Breakfast', 'Oatmeal', 150, 25, 5, 3, '2024-03-15'),
    (3, 'Lunch', 'Salad', 300, 10, 20, 15, '2024-03-15'),
    (3, 'Dinner', 'Chicken Rice', 500, 40, 30, 10, '2024-03-15');
    
COMMIT; -- Commits the transaction to ensure all entries are saved together.

-- TEST: Get the last inserted Nutrition entries
SELECT * FROM Nutrition ORDER BY NutritionID DESC LIMIT 3;


-- Daily Nutritional Summary
-- Calculates the total nutritional intake for a user on a specified date.
SELECT 
    SUM(Calories) AS TotalCalories,
    SUM(CarbsG) AS TotalCarbs,
    SUM(ProteinsG) AS TotalProteins,
    SUM(FatsG) AS TotalFats
FROM Nutrition
WHERE UserID = 3 
AND NutritionDate = '2024-02-12';


-- Average Daily Nutrient Intake Over a Month
-- Computes the average daily intake of nutrients for the last 30 days for a user, providing a monthly nutritional overview.
SELECT 
    AVG(DailyCalories) AS AvgCalories,
    AVG(DailyCarbs) AS AvgCarbs,
    AVG(DailyProteins) AS AvgProteins,
    AVG(DailyFats) AS AvgFats
FROM (
    SELECT 
        NutritionDate,
        SUM(Calories) AS DailyCalories,
        SUM(CarbsG) AS DailyCarbs,
        SUM(ProteinsG) AS DailyProteins,
        SUM(FatsG) AS DailyFats
    FROM Nutrition
    WHERE UserID = 3 
    AND NutritionDate BETWEEN date('now', '-30 days') AND date('now')
    GROUP BY NutritionDate
) AS DailyNutrition;
