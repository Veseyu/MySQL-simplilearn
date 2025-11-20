-- =========================================
-- LESSON 7: Subqueries, Stored Procedures, Triggers, Views, Window Functions
-- Simplilearn MySQL Course Notes
-- =========================================

-- =========================
-- Subqueries
-- =========================
USE sql_intro;
SELECT * FROM employees;

-- Employees with salary above average
SELECT emp_name, dept, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- Employees with salary above a specific employee
SELECT emp_name, gender, dept, salary
FROM employees
WHERE salary > (SELECT salary FROM employees WHERE emp_name = 'John');

-- Products with price conditions from orderdetails
USE classicmodels;
SELECT * FROM products;
SELECT * FROM orderdetails;

SELECT productcode, productname, msrp
FROM products
WHERE productcode IN (
    SELECT productcode
    FROM orderdetails
    WHERE priceeach < 100
);

-- =========================
-- Stored Procedures
-- =========================
USE sql_iq;
SELECT * FROM players;

DELIMITER &&
CREATE PROCEDURE top_player()
BEGIN
    SELECT name, country, goals
    FROM players
    WHERE goals > 6;
END &&
DELIMITER ;

CALL top_player();

-- Stored procedure with IN parameter
DELIMITER //
CREATE PROCEDURE sp_sortBySalary(IN var INT)
BEGIN
    SELECT name, age, salary
    FROM emp_details
    ORDER BY salary DESC
    LIMIT var;
END //
DELIMITER ;

CALL sp_sortBySalary(3);

-- Update salary using IN parameter
DELIMITER //
CREATE PROCEDURE update_salary(IN temp_name VARCHAR(20), IN new_salary FLOAT)
BEGIN
    UPDATE emp_details
    SET salary = new_salary
    WHERE name = temp_name;
END //
DELIMITER ;

SELECT * FROM emp_details;
CALL update_salary('Marry', 80000);

-- Stored procedure with OUT parameter
DELIMITER //
CREATE PROCEDURE sp_CountEmployees(OUT Total_Emps INT)
BEGIN
    SELECT COUNT(name) INTO Total_Emps
    FROM emp_details
    WHERE sex = 'F';
END //
DELIMITER ;

CALL sp_CountEmployees(@F_emp);
SELECT @F_emp AS female_emps;

-- =========================
-- Trigger Example
-- =========================
CREATE TABLE student (
    st_roll INT,
    age INT,
    name VARCHAR(30),
    marks FLOAT
);

DELIMITER //
CREATE TRIGGER marks_verify
BEFORE INSERT ON student
FOR EACH ROW
BEGIN
    IF NEW.marks < 0 THEN
        SET NEW.marks = 50;
    END IF;
END //
DELIMITER ;

INSERT INTO student VALUES
(501, 10, 'Ruth', 75.0),
(502, 12, 'Mike', -20.5),
(503, 13, 'Dave', 90.0),
(504, 10, 'Jacobs', -12.5);

SELECT * FROM student;

-- Drop trigger example
DROP TRIGGER IF EXISTS marks_verify;

-- =========================
-- Views in SQL
-- =========================
USE classicmodels;
SELECT * FROM customers;

-- Create view
CREATE VIEW cust_details AS
SELECT customerName, phone, city
FROM customers;

SELECT * FROM cust_details;

SELECT * FROM products;
SELECT * FROM productlines;

CREATE VIEW product_description AS
SELECT p.productName, p.quantityInStock, p.msrp, pl.textDescription
FROM products AS p
INNER JOIN productlines AS pl
ON p.productline = pl.productline;

SELECT * FROM product_description;

-- Rename view
RENAME TABLE product_description TO vehicle_description;

-- Display views
SHOW FULL TABLES
WHERE TABLE_TYPE = 'VIEW';

-- Delete view
DROP VIEW cust_details;

-- =========================
-- Window Functions
-- =========================
USE sql_intro;
SELECT * FROM employees;

-- SUM over partition
SELECT emp_name, age, dept,
       SUM(salary) OVER (PARTITION BY dept) AS total_salary
FROM employees;

-- ROW_NUMBER
SELECT ROW_NUMBER() OVER (ORDER BY salary) AS row_num,
       emp_name, salary
FROM employees
ORDER BY salary;

-- Demo table for ROW_NUMBER partition
CREATE TABLE demo (st_id INT, st_name VARCHAR(20));

INSERT INTO demo VALUES
(101, 'Shane'),
(102, 'Bradley'),
(103, 'Herath'),
(103, 'Herath'),
(104, 'Nathan'),
(105, 'Kevin'),
(105, 'Kevin');

SELECT * FROM demo;

SELECT st_id, st_name,
       ROW_NUMBER() OVER (PARTITION BY st_id, st_name ORDER BY st_id) AS row_num
FROM demo;

-- Rank function
CREATE TABLE demo1 (var_a INT);

INSERT INTO demo1 VALUES (101),(102),(103),(103),(104),(105),(106),(107);

SELECT var_a,
       RANK() OVER (ORDER BY var_a) AS test_rank
FROM demo1;

-- FIRST_VALUE function
SELECT emp_name, age, salary,
       FIRST_VALUE(emp_name) OVER (ORDER BY salary DESC) AS highest_salary
FROM employees;

SELECT emp_name, dept, salary,
       FIRST_VALUE(emp_name) OVER (PARTITION BY dept ORDER BY salary DESC) AS highest_salary
FROM employees;

-- =========================================
-- End of Lesson 7
-- =========================================
