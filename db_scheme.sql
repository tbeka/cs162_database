-- Users Table
CREATE TABLE Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(255) NOT NULL UNIQUE,
    Email VARCHAR(255) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL,
    Age INT,
    Gender VARCHAR(50),
    Height FLOAT,
    Weight FLOAT,
    FitnessGoals VARCHAR(255),
    ActivityLevel VARCHAR(255),
    DietaryRestrictions VARCHAR(255),
    PrivacySettings VARCHAR(255)
);

-- Workouts Table
CREATE TABLE Workouts (
    WorkoutID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    WorkoutType VARCHAR(255),
    Duration INT,
    Intensity VARCHAR(50),
    Date DATE,
    Notes TEXT,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Nutrition Logs Table
CREATE TABLE NutritionLogs (
    MealID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    Date DATE,
    MealType VARCHAR(255),
    FoodItems TEXT,
    Calories INT,
    Macronutrients VARCHAR(255),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Sleep Patterns Table
CREATE TABLE SleepPatterns (
    SleepID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    StartTime DATETIME,
    EndTime DATETIME,
    Quality VARCHAR(50),
    Notes TEXT,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Health Metrics Table
CREATE TABLE HealthMetrics (
    MetricID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    Date DATE,
    Weight FLOAT,
    BMI FLOAT,
    WaterIntake INT,
    OtherMetrics VARCHAR(255),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
