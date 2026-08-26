# Solving an Operational Problem For a Fictional Wind Using SQL and Python
<br>

**Problem**

Southwest Water, a renewable energy management company, owns and operates wind turbines across Devon. Due to recent unpredictable weather conditions and reactive plant operations, the Den Brook Wind Farm has been operating at a financial loss. In this project, I will create a data-driven solution to bring the plant back to profitability.
<br>
Constructing an application to achieve the following:
* Minimise Operational Costs: Build a short-term operational plan to optimise energy output and minimise manual adjustment errors.
* Guide Long-Term Investments: Evaluate historical operational data, employee absences, and weather pattern volatility to recommend long-term efficiency investments.
<br>

Application Workflow
* Authentication: Users log into the application using secure credentials (Username and LoginPassword).
* Historical Analysis: Users analyse WindData alongside WindPowerData to evaluate performance during volatile days, compare expected vs. actual energy outputs, and cross-reference operational gaps with employee absences.
* Predictive Planning: Users leverage PredictorModel timestamps and PredictionResult forecasts (wind speed, direction, and weather notes) to generate optimised blade angles and staffing plans.
<br>

Metric Definitions
* Absences: Stored in a single normalised table linked by UserID. Tracks WeekNumber (ex: Week 11 or 12), DaysAbsent, and AbsenceInformation (reason for absence).
* Wind Data: Recorded every 8 hours. Tracks WindSpeed in mph (INTEGER), WindDirection in degrees (INTEGER, where 0° = North, 90° = East), and WeatherInformation.
* Wind Power Data: Measures power generation in Watts (W). Tracks ExpectedEnergyProduction, ActualEnergyProduction, TurbineInformation (ex: Optimal/Suboptimal), ExpectedTurbineDirection, and ActualTurbineDirection. Shares the standard Timemarker timestamp with WindData.
* Prediction Model & Results: Tracks 12-hour forecast intervals (TimeOfPrediction) predicting WindSpeedPrediction (mph), WindDirectionPrediction (degrees), and ResultInformation.
<br>

Data Dictionary in 3NF 
1. User Table
* UserID (PK, INTEGER, AUTOINCREMENT)
* Username (TEXT, UNIQUE, NOT NULL)
* LoginPassword (TEXT, NOT NULL)
* Sample Entry: 1 | john_doe | P@ssw0rd1 (10 total user rows)
<br>

2. Absences Table
* AbsenceID (PK, INTEGER, AUTOINCREMENT)
* UserID (FK, INTEGER, NOT NULL)
* WeekNumber (INTEGER, NOT NULL)
* DaysAbsent (TEXT, NOT NULL)
* AbsenceInformation (TEXT, NOT NULL)
* Sample Entry: 1 | 6 | 12 | 2024-03-20 | Maternity Leave
<br>

3. WindData Table
* WindDataID (PK, INTEGER, AUTOINCREMENT)
* Timemarker (TEXT, UNIQUE, NOT NULL)
* WindSpeed (INTEGER, NOT NULL)
* WeatherInformation (TEXT, NOT NULL)
* WindDirection (INTEGER, NOT NULL)
* Sample Entry: 1 | 2024-03-13 08:00:00 | 14 | Sunny | 0 (30 total rows)
<br>

4. WindPowerData Table
* WindPowerDataID (PK, INTEGER, AUTOINCREMENT)
* Timemarker (FK, TEXT, NOT NULL)
* ExpectedEnergyProduction (INTEGER, NOT NULL)
* ActualEnergyProduction (INTEGER, NOT NULL)
* TurbineInformation (TEXT, NOT NULL)
* ExpectedTurbineDirection (INTEGER, NOT NULL)
* ActualTurbineDirection (INTEGER, NOT NULL)
* Sample Entry: 1 | 2024-03-13 08:00:00 | 280 | 280 | Optimal condition | 0 | 0 (30 total rows)
<br>

5. PredictorModel Table
* PredictorModelID (PK, INTEGER, AUTOINCREMENT)
* PredictorInformation (TEXT, NOT NULL)
* TimeOfPrediction (TEXT, UNIQUE, NOT NULL)
* Sample Entry: 1 | Future Analysis | 2024-03-23 00:00:00 (20 total rows)
<br>

6. PredictionResult Table
* PredictionResultID (PK, INTEGER, AUTOINCREMENT)
* TimeOfPrediction (FK, TEXT, NOT NULL)
* WindSpeedPrediction (INTEGER, NOT NULL)
* WindDirectionPrediction (INTEGER, NOT NULL)
* ResultInformation (TEXT, NOT NULL)
* Sample Entry: 1 | 2024-03-23 00:00:00 | 10 | 0 | Clear (20 total rows)
<br>

Normalisation Proof
* 1NF: All column values are atomic (ex: integer degrees instead of degree strings), with no multi-valued attributes or repeating groups.
* 2NF: All non-key fields depend entirely on single-column primary keys.
* 3NF: Eliminates transitive dependencies by replacing duplicate weekly tables with a unified Absences entity linked via foreign keys (UserID). Validated all date strings to adhere strictly to standardised calendar limits.
<br>

**ERD**

<img src="https://i.ibb.co/FLtptzR1/ERD.jpg"/>
<br>

**Analysis**
Historical Analysis Key Findings

* Optimal Operations: Peak recorded wind speed of 30 mph produced 600 W when the turbine was aligned with the wind direction (0°) and in optimal condition. Minimum wind speed of 5 mph generated 100 W.
* Direction Misalignment: On 2024-03-20 at 16:00:00, wind direction shifted to 55°. The turbine direction was incorrectly set to 80°, dropping power output from an expected 500 W to an actual 425 W.
* Suboptimal Maintenance: On 2024-03-21 at 08:00:00, mechanical degradation cut expected output in half from 320 W down to 160 W due to delayed maintenance.
* Correlation: A strong positive correlation exists between wind speed and energy output (approximately 1 mph ≈ 20 W generated). Mean wind speed across sample records was calculated via Python (numpy) as 15.13 mph, translating to an expected baseline output of 302.6 W.
* Root Cause of Operational Losses: Misalignments coincided directly with staff shortages recorded in the Absences table. Laura Miller's extended absence (maternity leave) combined with short-term sick leave during volatile weather days (changes > 10 mph or > 60° direction shift) left remaining operators unable to handle manual recalibrations.
<br>

Long-Term Recommendations
* Strategic Staffing: Recruit replacement operators to cover extended leave (ex:Laura Miller's maternity leave) to ensure adequate coverage during shifts with rapid weather shifts.
* Targeted Innovation: Invest in real-time automated yaw-control systems and predictive health monitoring sensors. Automating direction adjustments directly eliminates manual operator errors during volatile shifts and reduces ongoing labor overhead.
<br>
Short-Term Recommendations
<img src="https://i.ibb.co/vntkLns/Screenshot-2026-08-26-at-13-35-31.png"/>
