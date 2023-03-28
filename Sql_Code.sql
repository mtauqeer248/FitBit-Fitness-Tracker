--Count number of users in fitbit dailyActivity table:
SELECT
  	  COUNT(DISTINCT Id) AS Num_of_Id
FROM ggdacapstone.fitbit.dailyActivity

--Result: n = 33

--Count number of users in Fitbit Sleep dataset:
SELECT
      COUNT(DISTINCT Id) AS Num_of_Id
FROM ggdacapstone.fitbit.Sleep

--Result: n = 24

--Count number of users in Fitbit Weight dataset:
SELECT
      COUNT(DISTINCT Id) AS Num_of_Id
FROM ggdacapstone.fitbit.Weight

--Result: n = 8

--Change dataset type:
SELECT
  CAST(Id AS FLOAT64) AS New_Id,
  LEFT(Time,9) AS date,
  CAST(Value AS FLOAT64) AS New_Value
FROM
  `ggdacapstone.fitbit.heartrate`
where
  Id <> "Id"

  --Count number of users in Fitbit heartrate dataset:
SELECT
      COUNT(DISTINCT New_Id) AS Num_of_Id
FROM `ggdacapstone.fitbit.cleaned_heartrate`

-- Result: n = 14
--Calculating Avg about totalsteps,total distance, total calories
SELECT 
  DISTINCT Weekday,
  AVG(TotalSteps) AS AVG_TotalSteps,
  AVG(TotalDistance) AS AVG_TotalDistance,
  AVG(Calories) AS AVG_TotalCalories
FROM
  `ggdacapstone.fitbit.dailyActivity`
GROUP BY
  Weekday
ORDER BY
AVG_TotalSteps DESC
--To easier examine this relationship,
-- I used SQL to merge data between TotalSteps and TotalMinutesAsleep by Id level, using below code.
WITH temp_table AS (
SELECT 
  DISTINCT dailyActivity.Id AS Id,
  SUM(dailyActivity.TotalSteps) AS TotalSteps
FROM
  `ggdacapstone.fitbit.dailyActivity` AS dailyActivity
GROUP BY
  Id
ORDER BY
  TotalSteps DESC
)
SELECT 
  temp_table.Id,
  temp_table.TotalSteps,
  SUM(Sleep.TotalMinutesAsleep) AS TotalMinutesAsleep
FROM
  temp_table
INNER JOIN
  `ggdacapstone.fitbit.Sleep` AS Sleep
ON
  Sleep.Id = temp_table.Id
GROUP BY
  temp_table.Id,
  temp_table.TotalSteps
ORDER BY
  temp_table.TotalSteps DESC
--Time to get only ActivityHour which was not including the date, month and year. Then,
 --I input the data into SQL and coded as below:
  SELECT  
  ActivityHour,
  SUM(TotalIntensity) AS SUM_TotalIntensity
FROM `ggdacapstone.fitbit.hourlyIntensities1`
GROUP BY
ActivityHour