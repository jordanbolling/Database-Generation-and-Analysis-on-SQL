-- SOUTH WEST WINDS DATABASE SCHEMA & SEED DATA

-- 1. User Table
CREATE TABLE User (
    UserID INTEGER PRIMARY KEY AUTOINCREMENT,
    Username TEXT NOT NULL UNIQUE,
    LoginPassword TEXT NOT NULL
);

-- 2. Absences Table (Consolidated into 1 table for 3NF compliance)
CREATE TABLE Absences (
    AbsenceID INTEGER PRIMARY KEY AUTOINCREMENT,
    UserID INTEGER NOT NULL,
    WeekNumber INTEGER NOT NULL,
    DaysAbsent TEXT NOT NULL,
    AbsenceInformation TEXT NOT NULL,
    FOREIGN KEY (UserID) REFERENCES User (UserID)
);

-- 3. WindData Table (Numeric types for calculations)
CREATE TABLE WindData (
    WindDataID INTEGER PRIMARY KEY AUTOINCREMENT,
    Timemarker TEXT NOT NULL UNIQUE,
    WindSpeed INTEGER NOT NULL, -- in mph
    WeatherInformation TEXT NOT NULL,
    WindDirection INTEGER NOT NULL -- in degrees
);

-- 4. WindPowerData Table (Aligned with PDF metrics)
CREATE TABLE WindPowerData (
    WindPowerDataID INTEGER PRIMARY KEY AUTOINCREMENT,
    Timemarker TEXT NOT NULL,
    ExpectedEnergyProduction INTEGER NOT NULL, -- in Watts (W)
    ActualEnergyProduction INTEGER NOT NULL,   -- in Watts (W)
    TurbineInformation TEXT NOT NULL,
    ExpectedTurbineDirection INTEGER NOT NULL, -- in degrees
    ActualTurbineDirection INTEGER NOT NULL,   -- in degrees
    FOREIGN KEY (Timemarker) REFERENCES WindData (Timemarker)
);

-- 5. PredictorModel Table
CREATE TABLE PredictorModel (
    PredictorModelID INTEGER PRIMARY KEY AUTOINCREMENT,
    PredictorInformation TEXT NOT NULL,
    TimeOfPrediction TEXT NOT NULL UNIQUE
);

-- 6. PredictionResult Table
CREATE TABLE PredictionResult (
    PredictionResultID INTEGER PRIMARY KEY AUTOINCREMENT,
    TimeOfPrediction TEXT NOT NULL,
    WindSpeedPrediction INTEGER NOT NULL,     -- in mph
    WindDirectionPrediction INTEGER NOT NULL, -- in degrees
    ResultInformation TEXT NOT NULL,
    FOREIGN KEY (TimeOfPrediction) REFERENCES PredictorModel (TimeOfPrediction)
);

-- SEED DATA INSERTIONS

INSERT INTO User (Username, LoginPassword) VALUES
('john_doe', 'P@ssw0rd1'),
('jane_smith', 'S3cur!ty21'),
('alexander89', 'Al3xandr$!'),
('emily_wong', 'W0ngEm!22'),
('sam_jackson', 'J@cks0nS@m'),
('laura_miller', 'M!ll3rL@ur@45'),
('david_green', 'Gr33n7D@v1d'),
('sarah_adams', 'Ad@m$4r@h'),
('chris_brown', 'Br0wnC@hr!s007'),
('olivia_taylor', 'T@yl0rOl!v!a');

INSERT INTO Absences (UserID, WeekNumber, DaysAbsent, AbsenceInformation) VALUES
(1, 11, 'N/A', 'No Absences'),
(6, 12, '2024-03-20', 'Maternity Leave'),
(1, 12, '2024-03-21', 'Sick Leave');

INSERT INTO WindData (Timemarker, WindSpeed, WeatherInformation, WindDirection) VALUES 
('2024-03-13 08:00:00', 14, 'Sunny', 0),
('2024-03-13 16:00:00', 20, 'Sunny', 270),
('2024-03-13 00:00:00', 18, 'Clear', 270),
('2024-03-20 16:00:00', 25, 'Windy', 55),
('2024-03-21 08:00:00', 16, 'Cloudy', 90);

INSERT INTO WindPowerData (Timemarker, ExpectedEnergyProduction, ActualEnergyProduction, TurbineInformation, ExpectedTurbineDirection, ActualTurbineDirection) VALUES 
('2024-03-13 08:00:00', 280, 280, 'Optimal condition', 0, 0),
('2024-03-20 16:00:00', 500, 425, 'Optimal condition', 55, 80),
('2024-03-21 08:00:00', 320, 160, 'Suboptimal condition', 90, 90);

INSERT INTO PredictorModel (PredictorInformation, TimeOfPrediction) VALUES 
('Future Analysis', '2024-03-23 00:00:00'),
('Future Analysis', '2024-03-23 12:00:00'),
('Future Analysis', '2024-03-31 12:00:00');

INSERT INTO PredictionResult (TimeOfPrediction, WindSpeedPrediction, WindDirectionPrediction, ResultInformation) VALUES 
('2024-03-23 00:00:00', 10, 0, 'Clear'),
('2024-03-23 12:00:00', 12, 0, 'Clear'),
('2024-03-31 12:00:00', 13, 180, 'Light rain');