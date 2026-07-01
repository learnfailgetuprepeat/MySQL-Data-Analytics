-- LESSON: GROUP BY and ORDER BY
-- Instructor: Alex the Analyst (MySQL Basics Series, Video 4)
-- Objective: Aggregating rows into summary categories and sorting output results

-- Core Concepts:
-- 1. GROUP BY collapses multiple rows into summary categories based on matching values.
-- 2. Aggregate functions (COUNT, AVG, MIN, MAX, SUM) must be used for any columns 
--    in the SELECT statement that are not explicitly listed in the GROUP BY clause.
--    (Crucial for avoiding Error Code 1055: ONLY_FULL_GROUP_BY).
-- 3. ORDER BY sorts the final visual output layout (ASC for ascending, DESC for descending).
-- 4. Execution Order: FROM -> GROUP BY -> SELECT -> ORDER BY.

USE Parks_and_Recreation;

--Drill 1: Grouping by gender and aggregating with COUNT and AVG
SELECT gender, COUNT(gender) AS total_count, AVG(age)
FROM employee_demographics
GROUP BY gender
;

--DRILL 2: Grouping by multiple columns to see distinct combinations
SELECT occupation, salary
FROM employee_salary
GROUP BY occupation, salary
;

--DRILL 3: Sorting results using ORDER BY (Sorting by age in decending order)
SELECT *
FROM employee_demographics
ORDER BY age DESC
;

--DRILL 4: Advanced multi-column sorting
--Sorts primarily by gender alphabetically, then secondarily by age from oldest to youngest
SELECT *
FROM employee_demographics
ORDER BY gender ASC, age DESC
;
