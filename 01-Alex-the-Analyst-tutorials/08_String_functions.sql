-- LESSON: String Functions
-- Instructor: Alex the Analyst (MySQL Intermediate Series, Video 3)
-- Objective: Cleaning, transforming and manipulating text-based columns

-- Core Concepts:
-- 1. LENGTH(): Returns the character count of a string (great for checking data anomalies).
-- 2. UPPER() / LOWER(): Standardizes text casing to ensure consistent data entries.
-- 3. TRIM() / LTRIM() / RTRIM(): Truncates unwanted white spaces from data entry faults.
-- 4. LEFT() / RIGHT() / SUBSTRING(): Extracts a specific number of characters from a text field.
-- 5. REPLACE(): Swaps specific characters or substrings with an updated value.
-- 6. LOCATE(): Finds the starting position index of a specific character or pattern.

USE parks_and_recreation;

-- Drill 1: Measuring length and standardizing string casings
SELECT first_name, 
LENGTH(first_name) AS length,
UPPER(first_name) AS Capitalized,
LOWER(last_name) AS Lowercase
FROM employee_demographics
;

-- Drill 2: Trimming trailing or leading whitespaces
SELECT TRIM('        data-cleanup         ') AS Clean_string
;

-- Drill 3: Extracting substrings (Using SUBSTRING to isolate specific text segments)
-- Parameters: SUBSTRING(column, start position, length to extract)
SELECT birth_date,
  LEFT(birth_date, 4) AS birth_year,
  RIGHT(birth_date, 2) AS birth_day,
  SUBSTRING(birth_date, 6, 2) AS birth_month
FROM employee_demographics
;

-- Drill 4: Replacing characters and locating indexing points
SELECT first_name, REPLACE(first_name, 'a', 'z'), LOCATED('e', first_name)
From employee_demographics
;



