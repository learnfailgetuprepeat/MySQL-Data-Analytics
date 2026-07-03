-- LESSON: Subqueries (Nested Queries)
-- Instructor: Alex the Analyst (MySQL Intermediate Series, Video 5)
-- Objective: Nesting a SELECT statement inside another query to perform multi-stage filtering
-- =================================================================================

-- Core Concepts:
-- 1. A Subquery is a query enclosed in parentheses inside another query (Outer Query).
-- 2. Can be used in the SELECT list, the FROM clause, or the WHERE clause.
-- 3. In the WHERE clause, it acts as a dynamic hardcoded value or list for filtering.
-- 4. In the FROM clause, it acts as a virtual temporary table (often requires a table alias).

USE parks_and_recreation;

-- Drill 1: Subquery in the WHERE clause
-- Finds employees whose salary is greater than the overall company average
SELECT employee_id, first_name, salary
FROM employee_salary
WHERE salary > (
            SELECT AVG(salary)
            FROM employee_salary
  )
;

-- Drill 2: Subquery in the SELECT clause
-- Evaluates an individual's salary alongside the absolute max company salary on every row
SELECT employee_id, salary,
  (SELECT MAX(salary) FROM employee_salary) AS max_company_salary
FROM employee_salary
;

-- Drill 3: Subquery in the FROM clause (Derived Table)
-- Aggeregates raw row data insidee a subquery, then queries the resulting virtual summary table
SELECT age_group, AVG(salary)
FROM(
  SELECT age, salary,
    CASE 
      WHEN age > 35 THEN 'Senior' ELSE 'Junior'
    END AS age_group
  FROM employee_demographics AS dem
  JOIN employee_salary AS sal 
  ON dem.employee_id = sal.employee_id
) AS derived_table
GROUP BY age_group
;

