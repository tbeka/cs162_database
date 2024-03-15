-- Description: This file contains the SQL queries for the user table
-- Transactions are applied here

-- User registration
BEGIN;

INSERT OR IGNORE INTO Users (Username, Email, PasswordHash, Birthdate, Gender, HeightCM) 
VALUES ('new_user', 'new_user@example.com', 'hashed_password', '2000-01-01', 'Male', 180);

INSERT INTO HealthMetrics (UserID, RecordDate, HeartRate, BloodPressure, WeightKG, BodyFatPercentage) 
VALUES (last_insert_rowid(), date('now'), 70, '120/80', 75, 20);

COMMIT;

-- TEST: Get the last inserted user
SELECT * FROM Users ORDER BY UserID DESC LIMIT 1;


-- User profile update
UPDATE Users
SET Username = 'new_user1',
    Email = 'new_user1@example.com',
    PasswordHash = 'new_hashed_password',
    Birthdate = '1990-01-01',
    Gender = 'Male',
    HeightCM = 176
WHERE UserID = 1;

--TEST: Get the updated user
SELECT * FROM Users WHERE UserID = 1;