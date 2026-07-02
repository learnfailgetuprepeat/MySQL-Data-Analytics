-- LESSON: UNIONS
-- Instructor: Alex the Analyst (MySQL Intermediate Series, Video 2)
-- Objective: Stacking query output rows vertically on top of each other

-- Core Concepts:
-- 1. UNION stacks data vertically. To work, both queries MUST return the exact same 
--    number of columns and those columns must have compatible data types.
-- 2. By default, UNION removes duplicate rows (it performs a distinct operation).
-- 3. UNION ALL retains every single row returned by both queries, including duplicates.

USE parks_and_recreation;

-- Drill 1: Stacking distinct first names from both tables 
SELECT first_name, last_name 
FROM employee_demographics
UNION
SELECT first_name, last_name
FROM employee_salary 
;

-- Drill 2: Retaining duplicates using UNION ALL
SELECT first_name, last_name
FROM employee_demographics
UNION ALL
SELECT first_name, last_name
FROM employee_salary
;

-- Drill 3: Professional use case; Labelling automated groupings for analysis
SELECT first_name, last_name, 'Highly Paid' AS label
FROM employee_salary
WHERE salary > 70000
UNION
SELECT first_name, last_name, 'Older employees' AS label
FROM employee_demographics
WHERE age > 45
ORDER BY first_name, last_name, label
;
