-- LESSON: Common Table Expressions (CTEs)
-- Instructor: Alex the Analyst (MySQL Advanced Series, Video 1)
-- Objective: Creating temporary, named virtual result sets for modular queries

-- Core Concepts:
-- 1. A CTE acts like a temporary "prep bowl." It holds a query's results in memory 
--    strictly during the execution of a single command script.
-- 2. It dramatically improves code readability compared to deeply nested subqueries.
-- 3. Syntax: Must start with `WITH [CTE_Name] AS (...)` and be followed IMMEDIATELY
--    by a query that references that CTE name.

USE Parks_and_Recreation;

--Drill 1: Buildingb and querying a CTE with advanced Window Functions
WITH CTE_Employee AS 
(SELECT 
  emp.employee_id, 
  emp.first_name,
  emp.last_name,
  emp.gender,
  sal.salary
  COUNT(emp.gender) OVER(PARTITION BY emp.gender) AS total_gender,
  AVG(sal.salary) OVER(PARTITION BY emp.gender) AS avg_salary
FROM employee_demographics emp
JOIN employee_salary sal
  ON emp.employee_id = sal.employee_id
WHERE sal.salary > 45000)

SELECT first_name, last_name, salary, avg_salary
FROM CTE_Employee
WHERE total_gender > 2
;

