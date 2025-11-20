-- =========================================
-- LESSON 5: Subqueries (SELECT, INSERT, UPDATE, DELETE)
-- Simplilearn MySQL Course Notes
-- =========================================

-- =========================
-- Setup
-- =========================
USE subqueries;
SHOW TABLES;

SELECT * FROM employees;

-- =========================
-- Subquery in SELECT
-- =========================
SELECT emp_name, dept, salary
FROM employees
WHERE salary < (
    SELECT AVG(salary)
    FROM employees
);

-- =========================
-- Subquery in INSERT
-- =========================
CREATE TABLE products (
    prod_id INT,
    item VARCHAR(30),
    sell_price FLOAT,
    product_type VARCHAR(30)
);

INSERT INTO products VALUES
(101, 'Jewellery', 1800, 'Luxury'),
(102, 'T-Shirt', 100, 'Non-Luxury'),
(103, 'Laptop', 1300, 'Luxury'),
(104, 'Table', 400, 'Non-Luxury');

SELECT * FROM products;

-- Create orders table
CREATE TABLE orders (
    order_id INT,
    product_sold VARCHAR(30),
    selling_price FLOAT
);

-- Insert using subquery
INSERT INTO orders
SELECT prod_id, item, sell_price
FROM products
WHERE prod_id IN (
    SELECT prod_id
    FROM products
    WHERE sell_price > 1000
);

SELECT * FROM orders;

-- =========================
-- Subquery in UPDATE
-- =========================
SELECT * FROM employees_b;

UPDATE employees
SET salary = salary * 0.35
WHERE age IN (
    SELECT age
    FROM employees_b
    WHERE age >= 27
);

SELECT * FROM employees;

-- =========================
-- Subquery in DELETE
-- =========================
DELETE FROM employees
WHERE age IN (
    SELECT age
    FROM employees_b
    WHERE age <= 32
);

SELECT * FROM employees;

-- =========================================
-- End of Lesson 5
-- =========================================
