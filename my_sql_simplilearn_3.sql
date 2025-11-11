-- =========================================
-- MySQL Course Notes
-- Source: Simplilearn
-- =========================================

-- =========================
-- LESSON 3: Advanced Employee and Sales Data
-- =========================

-- Switch to practice database
SHOW DATABASES;
USE sql_intro;
SHOW TABLES;

-- =========================
-- Creating Employees Table
-- =========================

-- Drop table if it exists (safety)
DROP TABLE IF EXISTS employees;

-- Create employees table with ID and department
CREATE TABLE employees (
    Emp_Id INT PRIMARY KEY,     -- Employee ID
    Emp_name VARCHAR(25),       -- Employee name
    Age INT,                    -- Age
    Gender CHAR(1),             -- M/F
    Doj DATE,                   -- Date of joining
    Dept VARCHAR(20),           -- Department
    City VARCHAR(15),           -- City
    Salary FLOAT                -- Salary
);

-- Verify table structure
DESCRIBE employees;

-- Insert sample data
INSERT INTO employees VALUES
(101, "William", 36, "M", "2016-04-20", "IT", "Chicago", 83000),
(102, "Olivia", 29, "F", "2018-09-12", "HR", "New York", 65000),
(103, "James", 42, "M", "2010-06-05", "Finance", "Seattle", 95000),
(104, "Emma", 31, "F", "2017-11-23", "Marketing", "Chicago", 72000),
(105, "Michael", 38, "M", "2012-02-17", "IT", "Austin", 88000),
(106, "Sophia", 27, "F", "2019-01-30", "HR", "New York", 60000),
(107, "Daniel", 35, "M", "2014-05-14", "Finance", "Seattle", 79000),
(108, "Isabella", 33, "F", "2015-08-22", "Marketing", "Chicago", 71000),
(109, "Matthew", 40, "M", "2009-03-10", "IT", "Austin", 92000),
(110, "Mia", 30, "F", "2016-12-05", "HR", "New York", 67000),
(111, "David", 37, "M", "2011-07-18", "Finance", "Chicago", 85000),
(112, "Ava", 28, "F", "2018-04-01", "Marketing", "Seattle", 63000),
(113, "Joseph", 34, "M", "2013-09-19", "IT", "New York", 81000),
(114, "Charlotte", 32, "F", "2015-06-27", "HR", "Austin", 69000),
(115, "Ethan", 39, "M", "2008-11-02", "Finance", "Chicago", 97000);

-- Display all employees
SELECT * FROM employees;

-- =========================
-- Basic Queries and Aggregation
-- =========================

-- Distinct cities
SELECT DISTINCT City FROM employees;

-- Distinct departments
SELECT DISTINCT Dept FROM employees;

-- Average age of all employees
SELECT AVG(Age) AS avg_age FROM employees;

-- Average age per department
SELECT Dept, ROUND(AVG(Age), 1) AS average_age
FROM employees
GROUP BY Dept;

-- Total salary per department
SELECT Dept, SUM(Salary) AS total_salary
FROM employees
GROUP BY Dept;

-- Employee count per city
SELECT COUNT(Emp_Id) AS emp_count, City
FROM employees
GROUP BY City
ORDER BY emp_count DESC;

-- Employees joined per year
SELECT YEAR(Doj) AS join_year, COUNT(Emp_Id) AS num_employees
FROM employees
GROUP BY join_year;

-- =========================
-- Creating Sales Table
-- =========================

-- Drop table if exists
DROP TABLE IF EXISTS sales;

-- Create sales table
CREATE TABLE sales (
    product_id INT,       -- Product ID
    sell_price FLOAT,     -- Selling price per unit
    quantity INT,         -- Quantity sold
    state VARCHAR(20)     -- Region/State
);

-- Insert sample sales data
INSERT INTO sales VALUES
(121, 320.0, 3, 'California'),
(122, 450.0, 1, 'New York'),
(123, 150.0, 5, 'Texas'),
(124, 700.0, 2, 'Florida'),
(125, 500.0, 4, 'Illinois'),
(126, 300.0, 6, 'Washington'),
(127, 620.0, 3, 'Nevada'),
(128, 410.0, 7, 'New York'),
(129, 380.0, 2, 'Texas'),
(130, 540.0, 5, 'California'),
(131, 275.0, 8, 'Oregon'),
(132, 610.0, 9, 'Florida'),
(133, 430.0, 10, 'Illinois'),
(134, 200.0, 11, 'Washington'),
(135, 720.0, 12, 'Nevada');

-- Display all sales
SELECT * FROM sales;

-- Revenue per product
SELECT product_id, SUM(sell_price * quantity) AS revenue
FROM sales
GROUP BY product_id;

-- =========================
-- Joining Tables and Profit Calculation
-- =========================

-- Create cost price table
DROP TABLE IF EXISTS c_product;
CREATE TABLE c_product (
    product_id INT,
    cost_price FLOAT
);

-- Insert sample cost data
INSERT INTO c_product VALUES
(121, 270.0),
(123, 250.0);

-- Calculate profit per product
SELECT c.product_id, SUM((s.sell_price - c.cost_price) * s.quantity) AS profit
FROM sales AS s
INNER JOIN c_product AS c
ON s.product_id = c.product_id
GROUP BY c.product_id;

-- =========================
-- Advanced Queries with HAVING
-- =========================

-- Average salary per department (filter > 75000)
SELECT Dept, AVG(Salary) AS avg_salary
FROM employees
GROUP BY Dept
HAVING AVG(Salary) > 75000;

-- Total salary per city (filter > 20000)
SELECT City, SUM(Salary) AS total_salary
FROM employees
GROUP BY City
HAVING SUM(Salary) > 20000;

-- Employee count per department (filter > 2)
SELECT Dept, COUNT(*) AS emp_count
FROM employees
GROUP BY Dept
HAVING COUNT(*) > 2;

-- Employee count per city excluding Houston (filter > 2)
SELECT City, COUNT(*) AS emp_count
FROM employees
WHERE City != 'Houston'
GROUP BY City
HAVING COUNT(*) > 2;

-- Employee count per department with average salary > 75000
SELECT Dept, COUNT(*) AS emp_count
FROM employees
GROUP BY Dept
HAVING AVG(Salary) > 75000;

-- =========================================
-- End of Lesson 3
-- =========================================
