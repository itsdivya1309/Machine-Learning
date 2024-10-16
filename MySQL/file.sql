SHOW DATABASES;

USE itw2lab;

SHOW TABLES;

CREATE TABLE salesman(
salesman_id int PRIMARY KEY,
name varchar(30),
city varchar(30),
commission decimal(3,2));

DESCRIBE salesman;

INSERT INTO salesman VALUE
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11), 
(5006,         'Mc Lyon',     'Paris', 0.14), 
(5003 , 'Lauson Hen',  'San Jose', 0.12), 
(5007, 'Paul Adam','Rome', 0.13);

SELECT* FROM salesman;

CREATE TABLE orders(
ord_no int PRIMARY KEY,
purch_amt decimal(6,2),
ord_date DATE,
customer_id int,
salesman_id int,
FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id));

DESCRIBE orders;

INSERT INTO orders VALUE
(70001, 150.5, '2012-10-05', 3005, 5002), 
(70009, 270.65, '2012-09-10', 3001, 5005), 
(70002,       65.26, '2012-10-05', 3002, 5001), 
(70004,      110.5, '2012-08-17', 3009, 5003),
(70007,      948.5, '2012-09-10', 3005, 5002), 
(70005,      2400.6, '2012-07-27', 3007, 5001),
(70008,      5760, '2012-09-10', 3002, 5001), 
(70010,      1983.43, '2012-10-10', 3004, 5006), 
(70003,      2480.4, '2012-10-10', 3009, 5003), 
(70012,      250.45, '2012-06-27', 3008, 5002), 
(70011,      75.29, '2012-08-17', 3003 , 5007), 
(70013,      3045.6, '2012-04-25', 3002, 5001);

SELECT * FROM orders;

CREATE TABLE customers(
customer_id int PRIMARY KEY,
cust_name varchar(40),
city varchar(30),
grade int,
salesman_id int,
FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id));

DESCRIBE customers;

INSERT INTO customers VALUE
(3002, 'Nick Rimando', 'New York', 100, 5001), 
(3005, 'Graham Zusi', 'California', 200, 5002),
(3001, 'Brad Guzan', 'London', 100 , 5005),
(3004, 'Fabian Johns', 'Paris', 300, 5006),
(3009, 'Geoff Camero', 'Berlin', 100, 5003),
(3008, 'Julian Green', 'London', 300 , 5002),
(3003, 'Jozy Altidor', 'Moncow', 200, 5007);

SELECT * FROM customers;

SELECT o.ord_no,
o.purch_amt,
o.ord_date,
o.customer_id,
s.salesman_id
FROM orders o
JOIN salesman s
ON (o.salesman_id = s.salesman_id)
WHERE s.name = 'Paul Adam';

SELECT o.ord_no,
o.purch_amt,
o.ord_date,
o.customer_id,
o.salesman_id
FROM orders o
JOIN salesman s
ON (o.salesman_id = s.salesman_id)
WHERE s.city = 'London';

SELECT purch_amt as oder_value
FROM orders
WHERE purch_amt > (SELECT AVG(purch_amt)
FROM orders
WHERE ord_date = '2012-10-10');

SELECT s.salesman_id, s.name,
SUM(o.purch_amt * s.commission) AS commission_earned
FROM orders o
JOIN salesman s
ON (o.salesman_id = s.salesman_id)
GROUP BY s.salesman_id
ORDER BY commission_earned DESC;

SELECT salesman_id, name, city, commission
FROM salesman
WHERE city IN (SELECT city FROM customers);

SELECT s.salesman_id, s.name
FROM customers c
JOIN salesman s
ON (c.salesman_id = s.salesman_id)
GROUP BY s.salesman_id, s.name
HAVING COUNT(c.salesman_id) > 1;

SELECT s.salesman_id, s.name
FROM customers c
JOIN salesman s
ON (c.salesman_id = s.salesman_id)
GROUP BY s.salesman_id, s.name
HAVING COUNT(c.salesman_id) = 1;

SELECT s.salesman_id, s.name
FROM orders o
JOIN salesman s ON (o.salesman_id = s.salesman_id)
JOIN customers c ON (o.salesman_id = c.salesman_id)
GROUP BY o.customer_id, c.salesman_id
HAVING COUNT(o.customer_id) > 1;

SELECT 
    customer_id,
    customer_name,
    grade,
    CASE 
        WHEN grade = 100 THEN 'Category A'
        WHEN grade = 200 THEN 'Category B'
        ELSE 'Category C'
    END AS category
FROM 
    customers;
