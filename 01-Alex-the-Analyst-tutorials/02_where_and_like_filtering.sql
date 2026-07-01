-- LESSON: The WHERE and LIKE Clauses
-- Instructor: Alex the Analyst (MySQL Basics Series, Video 3)
-- Objective: Row-level data filtering using comparison, logical and wildcard operators


-- Core Concepts:
-- 1. WHERE filters records (rows) based on specific conditional evaluations.
-- 2. Logical Operators (AND, OR, NOT) allow you to chain multiple conditions.
-- 3. LIKE uses wildcards to scan for text patterns:
--    - % matches any number of characters.
--    - _ matches exactly one single character.

USE parks_and_recreation;

--Drill 1: Filtering numerical data with comparison operators
SELECT *
FROM employee_salary
WHERE salary >= 50000; 

--DRILL 2: Chaining logic using AND/OR to isolate demographic groups
SELECT *
FROM employee_demographics
WHERE gender = 'Female'
AND age > 30;

--Drill 3: Pattern matching using the % wildcard (Finding names starting with 'Sc')
SELECT *
FROM employee_demographics
WHERE first_name LIKE 'Sc%';

--Drill 4: Advanced pattern matching using the _ wildcard
--Looks for a 2-character string starting with 'a' , followed by anything else
SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a__%';
