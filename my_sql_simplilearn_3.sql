show databases;

use sql_intro;

show tables;

create table employees (Emp_Id int primary key, Emp_name varchar(25),
Age int, Gender char(1), Doj date, Dept varchar(20), City varchar(15), Salary float);

describe employees;

insert into employees values
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

select * from employees;

select distinct city from employees;

select distinct dept from employees;

select avg(age) from employees;

#avg age in each dept

select dept, avg(age) from employees group by dept;

select dept, round(avg(age), 1) as average_age from employees 
group by dept;

select dept, sum(salary) from employees
group by dept;

select count(emp_id), city from employees
group by city
order by count(emp_id) desc;

select year(doj) as year, count(emp_id)
from employees
group by year(doj);

select dept, sum(salary) as total_salary from employees
group by dept;

create table sales (product_id int, sell_price float, quantity int, state varchar(20));

insert into sales values 
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

select * from sales;

select product_id, sum(sell_price *	quantity) as revenue
from sales group by product_id;

create table c_product (product_id int, cost_price float);

insert into c_product
values(121, 270.0),
(123, 250.0);

select c.product_id, sum((s.sell_price - c.cost_price) * s.quantity) as profit
from sales as s inner join c_product as c
where s.product_id = c.product_id
group by c.product_id;	

select * from employees;

select dept, avg(salary) as avg_salary
from employees
group by dept
having avg(salary) > 75000;	

select city, sum(salary) as total
from employees
group by city
having sum(salary) > 20000;

select dept, count(*) as emp_count
from employees
group by dept
having count(*)>2;

select city, count(*) as emp_count
from employees
where city != "Houston"
group by city 
having count(*) > 2;

select dept, count(*) as emp_count
from employees
group by dept
having avg(salary) > 75000;