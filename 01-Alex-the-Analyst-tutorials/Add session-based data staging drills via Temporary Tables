-- LESSON: Temporary Tables
-- Instructor: Alex the Analyst (MySQL Advanced Series, Video 2)
-- Objective: Creating session-based temporary storage tables for staging data

-- Core Concepts:
-- 1. Temporary Tables exist only for the duration of the current active database session. 
--    They automatically drop/delete themselves the moment MySQL Workbench is closed.
-- 2. Unlike CTEs (which must be used immediately in the very next statement), Temp Tables 
--    can be queried, updated, inserted into and joined multiple times throughout a script.
-- 3. Cross-Platform Note: SQL Server uses a '#' prefix (e.g., #temp_table), whereas 
--    MySQL strictly uses the explicit 'CREATE TEMPORARY TABLE' syntax.

USE Parks_and_Recreation;

--Drill 1: Clean cleanup to ensure script can return without "Table already exists" blocks
DROP TEMPORARY TABLE IF EXISTS tenp_employee_salaries;

--Drill 2: Establish the structural blueprint of the Temporary Table
CREATE TEMPORARY TABLE temp_employee_salaries (
  employee_id INT,
  job_title VARCHAR(100),
  salary INT
)
;

--DRILL 3: Seed the temp table with structural inserts
INSERT INTO temp_employee_salaries VALUES
(1, 'Director of Parks and Rec', 75000),
(2, 'Deputy Director', 65000),
(3, 'Audit Manager', 55000)
;

--Drill 4: Staging complex data aggregations from multiple production tables
DROP TEMPORARY TABLE IF EXISTS temp_department_aggregates;

CREATE TEMPORARY TABLE temp_department_aggregates(
  job_title VARCHAR(50),
  employees_per_job INT,
  avg_age INT,
  avg_salary INT
  )
;

--Populating the staged sata from real database joins
INSERT INTO temp_department_aggregates
SELECT
  sal.occupation,
  COUNT(sal.occupation),
  AVG(dem.age),
  AVG(sal.salary)
FROM employee_demographics dem
JOIN employee_salary sal
  ON dem.employee_id = sal.employee_id
GROUP BY sal.occupation;

--Drill 5: Interrogating the staged temporary data asset
SELECT * FROM temp_department_aggregates
WHERE avg_salary > 50000
;
























