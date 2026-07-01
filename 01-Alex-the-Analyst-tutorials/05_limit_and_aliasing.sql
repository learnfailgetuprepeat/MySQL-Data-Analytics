-- LESSON: LIMIT and Aliasing
-- Instructor: Alex the Analyst (MySQL Basics Series, Video 6)
-- Objective: Restricting output row counts and renaming column identifiers

-- Core Concepts:
-- 1. LIMIT caps the maximum number of rows returned by a query (crucial for performance on massive tables).
-- 2. An optional secondary parameter in LIMIT acts as an offset (e.g., LIMIT 2, 1 means skip 2 rows, take 1).
-- 3. Aliasing (using the AS keyword) renames columns or expression outputs to make them readable.

USE parks_and_recreation;

-- Drill 1: Using LIMIT to find the top 3 oldest employees
SELECT *
FROM employee_demographics
ORDER BY age DESC
LIMIT 3
;

-- Drill 2: Using an offset with LIMIT (Finding the 4th oldest employee)
SELECT *
FROM employee_demographics
ORDER BY gae DESC
LIMIT 3, 1 -- Skips the top 3, returns the next 1 row

-- Drill 3: Aliasing columns to clean up aggregate calculation headers
SELECT gender , AVG(age) AS average_age_of_group
FROM employee_demographics
GROUP BY gender
;
