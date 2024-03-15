-- This file contains the SQL schema for the database tables.
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Workouts;
DROP TABLE IF EXISTS Nutrition;
DROP TABLE IF EXISTS HealthMetrics;
DROP TABLE IF EXISTS Sleep;

-- Users Table
CREATE TABLE Users (
    UserID INTEGER PRIMARY KEY, -- AUTOINCREMENT is implied for INTEGER PRIMARY KEY
    Username VARCHAR(255) NOT NULL UNIQUE,
    Email VARCHAR(255) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    Birthdate DATE,
    Gender TEXT, -- VARCHAR works too, but TEXT is more idiomatic in SQLite
    HeightCM REAL, 
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP -- Using DATETIME
);


-- Workouts Table
CREATE TABLE Workouts (
    WorkoutID INTEGER PRIMARY KEY, 
    UserID INTEGER,
    Type TEXT NOT NULL,
    DurationMinutes INTEGER NOT NULL,
    DistanceKM REAL NULL, 
    CaloriesBurned INTEGER,
    WorkoutDate DATE NOT NULL,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP, 
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);


-- Nutrition Logs Table
CREATE TABLE Nutrition (
    NutritionID INTEGER PRIMARY KEY, 
    UserID INTEGER,
    MealType TEXT, 
    FoodItem TEXT NOT NULL,
    Calories INTEGER NOT NULL,
    CarbsG INTEGER NULL, -- Using INTEGER for simplicity
    ProteinsG INTEGER NULL,
    FatsG INTEGER NULL,
    NutritionDate DATE NOT NULL,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP, 
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);


-- Health Metrics Table
CREATE TABLE HealthMetrics (
    MetricID INTEGER PRIMARY KEY,
    UserID INTEGER,
    RecordDate DATE NOT NULL,
    HeartRate INTEGER NULL,
    BloodPressure TEXT NULL, 
    WeightKG REAL NULL,
    BodyFatPercentage REAL NULL, 
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP, 
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE Sleep (
    SleepID INTEGER PRIMARY KEY, 
    UserID INTEGER,
    StartDateTime DATETIME NOT NULL,
    EndDateTime DATETIME NOT NULL,
    Quality TEXT NOT NULL, 
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP, 
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Application of indices
CREATE INDEX userid_workout_type ON Workouts (UserID, Type);

