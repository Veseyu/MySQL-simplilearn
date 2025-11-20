-- =========================================
-- LESSON 4: JOINs, UNION, Self-Join
-- Simplilearn MySQL Course Notes
-- =========================================

-- =========================
-- Setup
-- =========================
CREATE DATABASE sql_joins;
SHOW DATABASES;
USE sql_joins;

-- =========================
-- Creating Cricket & Football Tables
-- =========================
CREATE TABLE cricket (
    cricket_id INT AUTO_INCREMENT,
    name VARCHAR(30),
    PRIMARY KEY (cricket_id)
);

CREATE TABLE football (
    football_id INT AUTO_INCREMENT,
    name VARCHAR(30),
    PRIMARY KEY (football_id)
);

-- Insert sample data
INSERT INTO cricket (name) 
VALUES ('Stuart'), ('Michael'), ('Johnson'), ('Hayden'), ('Fleming');

SELECT * FROM cricket;

INSERT INTO football (name)
VALUES ('Stuart'), ('Johnson'), ('Hayden'), ('Langer'), ('Astle');

SELECT * FROM football;

-- =========================
-- INNER JOIN Examples
-- =========================
SELECT *
FROM cricket AS c
INNER JOIN football AS f
ON c.name = f.name;

SELECT c.cricket_id, c.name,
       f.football_id, f.name
FROM cricket AS c
INNER JOIN football AS f
ON c.name = f.name;

-- =========================
-- Classic Models Database
-- =========================
USE classicmodels;
SHOW TABLES;

-- JOIN: Products + ProductLines
SELECT * FROM products;
SELECT * FROM productlines;

SELECT productcode, productname, textdescritpion
FROM products
INNER JOIN productlines
USING (productline);

-- JOIN: Orders + OrderDetails + Products
SELECT * FROM orders;
SELECT * FROM orderdetails;

SELECT 
    o.ordernumber,
    o.status,
    p.productname,
    SUM(quantityordered * priceeach) AS revenue
FROM orders AS o
INNER JOIN orderdetails AS od
    ON o.ordernumber = od.ordernumber
INNER JOIN products AS p
    ON p.productcode = od.productcode
GROUP BY ordernumber;

-- =========================
-- LEFT JOIN: Customers without Orders
-- =========================
SELECT * FROM customers;
SELECT * FROM orders;

SELECT 
    c.customernumber,
    c.customername,
    ordernumber,
    status
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customernumber = o.customernumber  -- FIXED
WHERE ordernumber IS NULL;

-- =========================
-- RIGHT JOIN: Customers + Employees
-- =========================
SELECT * FROM customers;
SELECT * FROM employees;

SELECT 
    c.customername,
    c.phone,
    e.employeenumber,
    e.email
FROM customers AS c
RIGHT JOIN employees AS e
    ON e.employeenumber = c.salesrepemployeenumber
ORDER BY employeenumber;

-- =========================
-- SELF JOIN: Employee Reporting Structure
-- =========================
SELECT * FROM employees;

SELECT 
    CONCAT(m.lastname, ', ', m.firstname) AS manager,
    CONCAT(e.lastname, ', ', e.firstname) AS employee
FROM employees AS e
INNER JOIN employees AS m
    ON m.employeenumber = e.reportsto
ORDER BY manager;

-- =========================
-- FULL OUTER JOIN (using UNION)
-- =========================
SELECT 
    c.customername,
    o.ordernumber
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customernumber = o.customernumber

UNION

SELECT 
    c.customername,
    o.ordernumber
FROM customers AS c
RIGHT JOIN orders AS o
    ON c.customernumber = o.customernumber;

-- =========================================
-- End of Lesson 4
-- =========================================
