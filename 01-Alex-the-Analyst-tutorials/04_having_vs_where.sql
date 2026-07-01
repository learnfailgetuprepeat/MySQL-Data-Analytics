-- LESSON: HAVING vs. WHERE Clauses
-- Instructor: Alex the Analyst (MySQL Basics Series, Video 5)
-- Objective: Filtering row-level data vs. filtering aggregated group data

-- Core Concepts:
-- 1. WHERE filters raw records *before* any groupings occur. Aggregate functions are NOT allowed here.
-- 2. HAVING filters the output categories *after* the GROUP BY clause has executed.
-- 3. Execution Order: FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY.

USE parks_and_recreation;

-- Drill 1: The Crash Test (Why we need HAVING)
-- This query would FAIL if we tried to put AVG(salary) in a WHERE clause:
SELECT occcupation, AVG(salary) AS average_salary
FROM employee_salary
GROUP BY occupation
HAVING AVG(salary) > 50000
;

-- Drill 2: Combining both WHERE and HAVING in a single query
-- 1. WHERE cuts out low-level staff completely before grouping.
-- 2. GROUP BY clusters the remaining management/high-tier roles by occupation.
-- 3. HAVING filters out occupations whose average group salary doesn't clear 60,000.
SELECT occupation, AVG(salary) AS average_salary
FROM employee-salary
WHERE occupation LIKE '%manager%' -- Row-level filter
GROUP BY occupation
HAVING AVG(salary) > 60000 -- Aggregate-level filter
;
