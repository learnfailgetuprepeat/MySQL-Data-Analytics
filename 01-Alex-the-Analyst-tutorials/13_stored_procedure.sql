-- =================================================================================
-- LESSON: Stored Procedures
-- Instructor: Alex the Analyst (MySQL Advanced Series, Video 3)
-- Objective: Creating reusable, parameterized query macros inside the database

-- Core Concepts:
-- 1. A Stored Procedure is a prepared SQL code block that you can save directly to 
--    the database server, allowing it to be reused over and over again.
-- 2. It saves time, prevents rewriting code, and reduces network traffic.
-- 3. Syntax: In MySQL, we use `DELIMITER //` to change the statement terminator 
--    so the engine doesn't trip over internal semicolons inside the BEGIN/END block.
-- 4. Parameters can be passed into a procedure to filter data dynamically.

USE Parks_and_Recreation;

--Drill 1: Clean cleanup if rewriting the script
DROP PROCEDURE IF EXISTS get_high_salariries;

--Drill 2: Setting up a basic static stored procedure
DELIMITER //
CREATE PROCEDURE high_salaries()
BEGIN
    SELECT *
    FROM employee_salary
    WHERE salary >= 50000
END //
DELIMETER
;
  
--How to execure it:
CALL get_high_salaries();

--Drill 3: Creating a dynamic procedure with an input parameter
DROP PROCEDURE IF EXISTS get_employee_by_occupation;

DELIMETER //
CREATE PROCEDURE get_employee_by_occupation(p_occupation VARCHAR(50))
BEGIN
  SELECT dem.first_name, dem.last_name, sal.occupation, sal.salary
  FROM employee_demographics dem
  JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id
  WHERE sal.occupation = p_occupation;
END //
DELIMETER ;

--How to execute drill 3 (Passes the string into the parameter)
CALL get_employee_by_occupation('Deputy Director');



