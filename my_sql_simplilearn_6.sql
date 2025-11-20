-- =========================================
-- LESSON 6: Triggers (BEFORE INSERT, AFTER INSERT, BEFORE UPDATE, BEFORE DELETE)
-- Simplilearn MySQL Course Notes
-- =========================================

-- =========================
-- Setup
-- =========================
CREATE DATABASE triggers;
USE triggers;
SHOW TABLES;

-- =========================
-- BEFORE INSERT Trigger
-- =========================
CREATE TABLE customers (
    cust_id INT,
    age INT,
    name VARCHAR(30)
);

DELIMITER //

CREATE TRIGGER age_verify
BEFORE INSERT ON customers
FOR EACH ROW
BEGIN
    IF NEW.age < 0 THEN
        SET NEW.age = 0;
    END IF;
END; //

DELIMITER ;

-- Insert sample data
INSERT INTO customers VALUES
(101, 27, "James"),
(102, -40, "Ammy"),
(103, 32, "Ben"),
(104, -39, "Angela");

SELECT * FROM customers;

-- =========================
-- AFTER INSERT Trigger
-- =========================
CREATE TABLE customers1 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(40) NOT NULL,
    email VARCHAR(30),
    birthdate DATE
);

CREATE TABLE message (
    id INT AUTO_INCREMENT,
    messageId INT,
    message VARCHAR(300) NOT NULL,
    PRIMARY KEY (id, messageId)
);

DELIMITER //

CREATE TRIGGER check_null_dob
AFTER INSERT ON customers1
FOR EACH ROW
BEGIN
    IF NEW.birthdate IS NULL THEN
        INSERT INTO message (messageId, message)
        VALUES (NEW.id, CONCAT('Hi ', NEW.name, ', please update your date of birth.'));
    END IF;
END; //

DELIMITER ;

-- Insert sample data
INSERT INTO customers1 (name, email, birthdate) VALUES
("Nancy", "nancy@abc.com", NULL),
("Ronald", "ronald@xyz.com", "1998-11-16"),
("Chris", "chris@xyz.com", "1997-08-20"),
("Alice", "alice@abc.com", NULL);

SELECT * FROM message;

-- =========================
-- BEFORE UPDATE Trigger
-- =========================
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(25),
    age INT,
    salary FLOAT
);

INSERT INTO employees VALUES
(101, "Jimmy", 35, 70000),
(102, "Laura", 29, 65000),
(103, "Michael", 41, 72000),
(104, "Sophie", 33, 68000),
(105, "Daniel", 27, 61000),
(106, "Anna", 38, 73000),
(107, "Robert", 30, 66000);

DELIMITER //

CREATE TRIGGER upd_trigger
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
    IF NEW.salary = 10000 THEN
        SET NEW.salary = 85000;
    ELSEIF NEW.salary < 10000 THEN
        SET NEW.salary = 72000;
    END IF;
END; //

DELIMITER ;

-- Update example
UPDATE employees
SET salary = 8000;

SELECT * FROM employees;

-- =========================
-- BEFORE DELETE Trigger
-- =========================
CREATE TABLE salary (
    eid INT PRIMARY KEY,
    validfrom DATE NOT NULL,
    amount FLOAT NOT NULL
);

INSERT INTO salary (eid, validfrom, amount) VALUES
(101, '2005-05-01', 55000),
(102, '2007-08-01', 68000),
(103, '2006-09-01', 75000);

SELECT * FROM salary;

CREATE TABLE salarydel (
    id INT PRIMARY KEY AUTO_INCREMENT,
    eid INT,
    validfrom DATE NOT NULL,
    amount FLOAT NOT NULL,
    deletedat TIMESTAMP DEFAULT NOW()
);

DELIMITER $$

CREATE TRIGGER salary_delete
BEFORE DELETE ON salary
FOR EACH ROW
BEGIN
    INSERT INTO salarydel(eid, validfrom, amount)
    VALUES (OLD.eid, OLD.validfrom, OLD.amount);
END$$

DELIMITER ;

-- Delete example
DELETE FROM salary
WHERE eid = 103;

SELECT * FROM salarydel;

-- =========================================
-- End of Lesson 6
-- =========================================
