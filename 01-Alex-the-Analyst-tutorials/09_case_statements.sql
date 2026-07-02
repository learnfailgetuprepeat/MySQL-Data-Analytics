-- LESSON: CASE Statements
-- Instructor: Alex the Analyst (MySQL Intermediate Series, Video 4)
-- Objective: Creating conditional logical branches (IF-THEN execution) within queries

-- Core Concepts:
-- 1. CASE statements evaluate expressions sequentially and return a value when the first condition is met.
-- 2. Syntactical Structure: CASE WHEN [condition] THEN [result] ELSE [fallback] END.
-- 3. Highly used in analytics for binning continuous values (like placing ages or salaries into brackets).

USE parks_and_recreation;

-- Drill 1: Categorizing age cohorts for demographic analysis
SELECT 
    first_name, 
    last_name, 
    age,
    CASE 
        WHEN age < 30 THEN 'Young Professional'
        WHEN age BETWEEN 30 AND 45 THEN 'Mid-Career'
        ELSE 'Senior Staff'
    END AS age_bracket
FROM employee_demographics
  ;

-- Drill 2: Calculating custom corporate bonus structures based on performance/department
-- If salary is less than 50,000, get a 5% raise. If greater, get a 7% raise. 
-- Finance department personnel get an additional fixed bonus.
SELECT 
    employee_id, 
    salary,
    CASE 
        WHEN salary < 50000 THEN salary * 1.05
        WHEN salary >= 50000 THEN salary * 1.07
    END AS new_salary,
    CASE
        WHEN dept_id = 6 THEN salary * 0.10
        ELSE 0
    END AS finance_department_bonus
FROM employee_salary
;
