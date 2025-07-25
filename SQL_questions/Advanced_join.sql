-- You are given a table, Projects, containing three columns: Task_ID, Start_Date and End_Date. It is guaranteed that the difference between the End_Date and the Start_Date is equal to 1 day for each row in the table.
-- If the End_Date of the tasks are consecutive, then they are part of the same project. Samantha is interested in finding the total number of different projects completed.
-- Write a query to output the start and end dates of projects listed by the number of days it took to complete the project in ascending order. If there is more than one project that have the same number of completion days, then order by the start date of the project.

WITH CTE AS (SELECT Start_Date, End_Date, - row_number() over (ORDER BY End_Date) AS date_lag, End_Date - row_number() over (ORDER BY End_Date) AS date_lag_2 FROM projects ORDER BY Start_Date ASC)
, CTE2 AS (SELECT MIN(Start_Date) min_date, MAX(End_Date) max_date, count(*) total_days FROM CTE GROUP BY date_lag_2)

SELECT min_date, max_date FROM CTE2 ORDER BY total_days ASC, min_date ASC
