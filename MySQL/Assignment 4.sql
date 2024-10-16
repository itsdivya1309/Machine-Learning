USE itw2lab;

SHOW tables;

DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS orders;

CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    enrollment_year INT
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    student_id INT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

INSERT INTO Students (student_id, student_name, enrollment_year) VALUES
(1, 'Alice', 2020),
(2, 'Bob', 2021),
(3, 'Charlie', 2022);

INSERT INTO Courses (course_id, course_name, student_id) VALUES
(101, 'Mathematics', 1),
(102, 'Physics', 1),
(103, 'Chemistry', 2),
(104, 'Biology', 3),
(105, 'Computer Science', 3);

INSERT INTO Students (student_id, student_name, enrollment_year) VALUES
(4, 'Darcy', 2023),
(5, 'Jane', 2023);

-- Task 1
SELECT student_name, course_name, enrollment_year
	FROM Students
    LEFT JOIN Courses
    ON Students.student_id = Courses.student_id
    WHERE enrollment_year = 2023 OR course_name IS NULL;

-- Task 2
CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    product_id INT,
    sales_amount DECIMAL(10, 2)
);
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50)
);

INSERT INTO Sales (sale_id, product_id, sales_amount) VALUES
(1, 101, 250.00),
(2, 102, 150.50),
(3, 103, 300.75),
(4, 104, 450.00),
(5, 101, 220.00);

INSERT INTO Products (product_id, product_name, category) VALUES
(101, 'Laptop', 'Electronics'),
(102, 'Tablet', 'Electronics'),
(103, 'Chair', 'Furniture'),
(104, 'Desk', 'Furniture'),
(105, 'Headphones', 'Electronics');

SELECT category, AVG(sales_amount) AS average_sales
FROM (
    SELECT p.category, s.sales_amount
    FROM Sales s
    JOIN Products p ON s.product_id = p.product_id
) AS derived_table
GROUP BY category;

-- Task 3
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    department_id INT,
    salary DECIMAL(10, 2)
);
INSERT INTO Employees (employee_id, employee_name, department_id, salary) VALUES
(1, 'Alice', 101, 80000.00),
(2, 'Bob', 101, 90000.00),
(3, 'Charlie', 102, 85000.00),
(4, 'David', 102, 95000.00),
(5, 'Eve', 103, 70000.00),
(6, 'Frank', 103, 72000.00);

CREATE VIEW highest_paid_employee(department, name, salary) AS
(SELECT e.department_id, e.employee_name, e.salary
FROM Employees e
JOIN (
    SELECT department_id, MAX(salary) AS max_salary
    FROM Employees
    GROUP BY department_id
) AS max_salaries
ON e.department_id = max_salaries.department_id AND e.salary = max_salaries.max_salary);

SELECT * FROM highest_paid_employee;

-- Task 4
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    amount DECIMAL(10, 2)
);
INSERT INTO Orders (order_id, customer_id, order_date, amount) VALUES
(1, 101, '2023-08-15', 150.00),
(2, 102, '2023-07-22', 200.00),
(3, 103, '2023-05-10', 120.00),
(4, 101, '2023-06-20', 300.00),
(5, 102, '2023-01-30', 180.00),
(6, 104, '2023-08-05', 220.00),
(7, 105, '2022-12-01', 250.00),
(8, 103, '2023-03-15', 400.00);

SELECT * FROM Orders;

WITH yearly_customers AS
(SELECT YEAR(order_date) AS order_year, 
customer_id AS customer,
SUM(amount) AS annual_spending
FROM Orders
GROUP BY order_year, customer
ORDER BY order_year DESC, annual_spending DESC)
SELECT * FROM yearly_customers
LIMIT 3;

-- Task 5
ALTER TABLE Employees
ADD bonus DECIMAL(10, 2);

SELECT * FROM Employees;

UPDATE Employees
SET bonus = 7000.00
WHERE employee_id = 2;

UPDATE Employees
SET bonus = 6000.00
WHERE employee_id = 3;

UPDATE Employees
SET bonus = 8000.00
WHERE employee_id = 4;

UPDATE Employees
SET bonus = 4000.00
WHERE employee_id = 5;

SELECT SUM(ifnull(bonus, 0)) AS total_bonus
FROM Employees;