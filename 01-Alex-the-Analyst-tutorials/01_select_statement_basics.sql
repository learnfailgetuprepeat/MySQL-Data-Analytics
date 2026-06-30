-- LESSON: The SELECT Statement Basics
-- INSTRUCTOR: Alex the Analyst (MYSQL Basics Series, Video 2)
-- Objective: Understand query execution order and column filtering mechanism

-- Core Concepts:
-- 1.SELECT determines which columns you want to view
-- 2. FROM determines which table the database engine seatches first
-- 3. BODMAS rulles apply to the calculatioms directly within a SELECT statement

USE parks_and_recreation;

-- Drill 1: Grabbing all columns from the employee_demographics table
SELECT *
FROM employee_demographics;

--Notes:
-- 1. * selects all the available data in the specified table
-- 2. ; shows the end of the command
-- 3. You can also specify the database from which the table is located as shown below
SELECT *
FROM parks_and_recreation.employee_demographics;

-- Drill 2: Selecting specific tracking columns and performing basic math on age
SELECT first_name,
  last_name,
  age,
  (age + 10) AS age_in_a_decade
FROM employee_demographics;

-- Drill 3: Exploring distinct (unique) values within a column
SELECT DISTINCT gender
FROM employee_demographics;
