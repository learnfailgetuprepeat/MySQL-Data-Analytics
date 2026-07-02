-- LESSON: JOINS (Inner vs. Outer Joins)
-- Instructor: Alex the Analyst (MySQL Intermediate Series, Video 1)
-- Objective: Linking separate tables horizontally using shared key identifiers

-- Core Concepts:
-- 1. INNER JOIN: Returns rows only when there is a perfect match in BOTH tables. 
--    Unmatched records on either side are completely dropped.
-- 2. LEFT JOIN: Takes everything from the left table. If no match exists on the right, 
--    it retains the row and fills right-side columns with NULL.
-- 3. RIGHT JOIN: Takes everything from the right table, filling missing left-side data with NULL.
-- 4. Table Aliasing: Assigning shorthand nicknames (e.g., `FROM table AS t`) keeps code clean.

USE parks_and_recreation;

-- Drill 1: INNER JOIN linking demographics and salary data via employee_id
SELECT dem.employee_id,
  dem.first_name,
  sal.occupation,
  sal.salary
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
  ON dem.employee_id = sal.employee_id
;

--Drill 2: LEFT JOIN showing all demographic records (even if payroll isn't set up yet)
SELECT dem.employee_id,
  dem.first_name,
  sal.occuppation,
  sal.salary
FROM employee_demographics AS dem
LEFT JOIN employee_salary AS sal
  ON dem.employee_id = sal.empoyee_id
;

--Drill 3: RIGHT JOIN showing all demographic records
SELECT dem.employee_id,
  dem.first_name,
  sal.occuppation,
  sal.salary
FROM employee_demographics AS dem
RIGHT JOIN employee_salary AS sal
  ON dem.employee_id = sal.empoyee_id
;




