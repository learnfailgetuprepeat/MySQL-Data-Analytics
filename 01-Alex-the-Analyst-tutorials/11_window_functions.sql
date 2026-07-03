-- LESSON: Window Functions
-- Instructor: Alex the Analyst (MySQL Intermediate Series, Video 6)
-- Objective: Performing calculations across a set of rows related to the current row

-- Core Concepts:
-- 1. Unlike GROUP BY which collapses your rows, Window Functions preserve the unique row-level records.
-- 2. The OVER() clause defines the window or partition of data the function applies to.
-- 3. PARTITION BY slices the data into logical groups for the calculation (like a local GROUP BY).
-- 4. Common analytical window functions include ROW_NUMBER(), RANK() and DENSE_RANK().

USE parks_and_recreation;

-- Drill 1: Comparing Window Functions vs. standard GROUP BY behavior
-- Notice how every individual employee row is kept but their department average is appended side-by-side
SELECT
  dem.first_name,
  dem.last_name,
  sal.occupation,
  AVG(sal.salary) OVER(PARTITION BY sal.occupation) AS avg_occupation_salary
FROM employee_demographics dem
JOIN employee_salary sal 
ON dem.employee_id = sal.employee_id
;

-- Drill 2: Implementing a Running Total using ORDER BY inside the window
SELECT 
    dem.first_name, 
    sal.occupation, 
    sal.salary,
    SUM(sal.salary) OVER(PARTITION BY sal.occupation ORDER BY dem.employee_id) AS rolling_dept_total
FROM employee_demographics dem
JOIN employee_salary sal ON dem.employee_id = sal.employee_id;

-- Drill 3: Ranking employees by salary inside their specific occupational departments
SELECT 
    dem.first_name, 
    sal.occupation, 
    sal.salary,
    ROW_NUMBER() OVER(PARTITION BY sal.occupation ORDER BY sal.salary DESC) AS row_num,
    RANK() OVER(PARTITION BY sal.occupation ORDER BY sal.salary DESC) AS rank_num,
    DENSE_RANK() OVER(PARTITION BY sal.occupation ORDER BY sal.salary DESC) AS dense_rank_num
FROM employee_demographics dem
JOIN employee_salary sal ON dem.employee_id = sal.employee_id
;
