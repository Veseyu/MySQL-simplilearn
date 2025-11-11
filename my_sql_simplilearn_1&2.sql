-- =========================================
-- MySQL Course Notes
-- Source: Simplilearn
-- =========================================

-- =========================
-- LESSON 1: Exploring Databases
-- =========================

-- List all available databases
SHOW DATABASES;

-- Switch to the default MySQL database
USE mysql;

-- Show all tables in the current database
SHOW TABLES;


-- =========================
-- LESSON 2: Creating Databases and Tables
-- =========================

-- Drop database if it already exists (safety)
DROP DATABASE IF EXISTS sql_intro;

-- Create a new database for practice
CREATE DATABASE sql_intro;

-- Confirm creation
SHOW DATABASES;

-- Switch to the new database
USE sql_intro;

-- Drop table if it exists (safety)
DROP TABLE IF EXISTS emp_details;

-- Create a table for employee details
CREATE TABLE emp_details (
    Name VARCHAR(25),         -- Employee name
    Age INT,                  -- Employee age
    Sex CHAR(1),              -- M/F
    Doj DATE,                 -- Date of joining
    City VARCHAR(15),         -- City of residence
    Salary FLOAT              -- Salary in USD
);

-- Verify table structure
DESCRIBE emp_details;

-- Insert sample data into 'emp_details'
INSERT INTO emp_details (Name, Age, Sex, Doj, City, Salary) VALUES
("Jimmy", 35, "M", "2005-05-30", "Chicago", 70000),
("Shane", 30, "M", "1999-06-25", "Seattle", 55000),
("Dwayne", 37, "M", "2011-07-12", "Austin", 57000),
("Sara", 32, "F", "2017-10-27", "New York", 72000),
("Ammy", 35, "F", "2014-12-20", "Seattle", 80000);

-- Display all records
SELECT * FROM emp_details;


-- =========================
-- Basic Queries & Filtering
-- =========================

-- Unique cities
SELECT DISTINCT City FROM emp_details;

-- Count employees
SELECT COUNT(Name) AS count_name FROM emp_details;

-- Average salary
SELECT AVG(Salary) AS avg_salary FROM emp_details;

-- Select specific columns
SELECT Name, Age, City FROM emp_details;

-- Filter by age
SELECT * FROM emp_details WHERE Age > 30;

-- Filter by sex
SELECT Name, Sex, City FROM emp_details WHERE Sex = 'F';

-- Filter by city (multiple methods)
SELECT * FROM emp_details WHERE City = 'Chicago' OR City = 'Austin';
SELECT * FROM emp_details WHERE City IN ('Chicago', 'Austin');

-- Filter by date of joining
SELECT * FROM emp_details
WHERE Doj BETWEEN '2001-01-01' AND '2010-12-31';

-- Combining conditions (age & sex)
SELECT * FROM emp_details
WHERE Age > 30 AND Sex = 'M';


-- =========================
-- Aggregations & Sorting
-- =========================

-- Sum of salary by sex
SELECT Sex, SUM(Salary) AS total_salary
FROM emp_details
GROUP BY Sex;

-- Order by salary ascending
SELECT * FROM emp_details
ORDER BY Salary;

-- Order by salary descending
SELECT * FROM emp_details
ORDER BY Salary DESC;


-- =========================
-- Simple Arithmetic & Date Functions
-- =========================

-- Subtract
SELECT (10-20) AS subtract;

-- String length
SELECT LENGTH('India') AS total_len;

-- Repeat character
SELECT REPEAT('@', 10);

-- Uppercase / Lowercase
SELECT UPPER('India') AS upper_case;
SELECT LOWER('INDIA') AS lower_case;

-- Current date / day / time
SELECT CURDATE() AS today;
SELECT DAY(CURDATE()) AS day_today;
SELECT NOW() AS current_datetime;


-- =========================
-- String Functions (Advanced)
-- =========================

-- Character length
SELECT CHARACTER_LENGTH('India') AS total_len;

-- Concatenate strings
SELECT CONCAT("India", " is", " in Asia") AS merged;

-- Concatenate table columns (example: students table)
-- SELECT stu_id, stu_name, CONCAT(stu_name, " ", age) AS name_age
-- FROM students;

-- Reverse string
SELECT REVERSE('India');

-- Replace substring
SELECT REPLACE("Orange is a vegetable", "vegetable", "fruit");

-- Trim spaces
SELECT LTRIM("     India      ") AS left_trim;
SELECT LENGTH("     India      ") AS original_len;
SELECT LENGTH(LTRIM("     India      ")) AS left_trim_len;
SELECT LENGTH(TRIM("     India      ")) AS trim_len;

-- Position of substring
SELECT POSITION("fruit" IN "Orange is a fruit") AS substring_pos;

-- ASCII values
SELECT ASCII('a') AS ascii_a;
SELECT ASCII('4') AS ascii_4;

-- =========================================
-- End of Lessons 1 & 2
-- =========================================
