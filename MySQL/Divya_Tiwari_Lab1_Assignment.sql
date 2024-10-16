SHOW DATABASES;

USE itw2lab;

SHOW TABLES;

-- Question 1
-- Create table named jobs with columns job_id, job_title, min_salary and max_salary.
-- Default value for job_title is 'Other', for max_salary is 20000 and min_salary is NULL.
-- Also ensure that max_salary entered is less than 100000.
CREATE TABLE jobs(
job_id int AUTO_INCREMENT PRIMARY KEY,
job_title varchar(50) DEFAULT 'Other',
min_salary int,
max_salary int DEFAULT 20000,
CONSTRAINT salary_limit CHECK(max_salary<100000)
);

DESCRIBE jobs;

INSERT INTO jobs
VALUES (1, 'Teacher', 5000, 60000);

INSERT INTO jobs (min_salary)
VALUES (500);

SELECT * FROM jobs;

-- Question 2
-- Create a table employees including columns  employee_id, first_name, last_name, 
-- email, phone_no, hire_date, job_id, salary, commission, manager_id, department_id. employee_id 
-- column does not contain any duplicate value and the foreign key columns combined by 
-- department_id and manager_id columns contain only those unique combination values,
-- which combinations exist in the departments table.

-- First create the departments table
CREATE TABLE departments(
department_id decimal(4,0) NOT NULL,
department_name varchar(30) NOT NULL,
manager_id decimal(6,0) NOT NULL,
location_id decimal(4,0),
PRIMARY KEY(department_id, manager_id)
);

DESCRIBE departments;

-- Now we create the employees table
CREATE TABLE employees(
employee_id int NOT NULL UNIQUE,
first_name varchar(30),
last_name varchar(30),
email varchar(60),
phone_no int(10),
hire_date date,
job_id int NOT NULL,
salary int,
commission int,
manager_id decimal(6,0),
department_id decimal(4,0),
FOREIGN KEY(department_id, manager_id) REFERENCES departments(department_id, manager_id)
);

DESCRIBE employees;

-- Question 3
-- Insert 5 entries in Jobs, 20 entries in Employees and 5 entries in Departments.
INSERT INTO departments VALUES
(0001.0, 'Research and Development', 100001, 1234),
(0010.0, 'Finance', 100010, 1234),
(0011.0, 'Human Resource', 100100, 1234),
(0101.0, 'Marketing and Sales', 101000, 1234),
(0110.0, 'Information Technology', 110000, 1234);

SELECT * FROM departments;

INSERT INTO jobs (job_title, min_salary, max_salary) VALUES
('Accountant', 13000, 45000),
('Executive', 24000, 75000),
('Team Leader', 45000, 95000),
('APM', 30000, 60000); 

SELECT * FROM jobs;

INSERT INTO employees (employee_id, first_name, last_name, email, phone_no, hire_date, job_id, salary, commission, manager_id, department_id) VALUES
(1, 'Arjun', 'Sharma', 'arjun.sharma@example.com', 123456789, '2023-01-01', 1, 60000, 5000, 100001, 1),
(2, 'Aditi', 'Patel', 'aditi.patel@example.com', 234567890, '2023-02-01', 2, 45000, 4000, 100010, 10),
(3, 'Rahul', 'Verma', 'rahul.verma@example.com', 345678901, '2023-03-01', 3, 50000, 4500, 100100, 11),
(4, 'Priya', 'Reddy', 'priya.reddy@example.com', 456789012, '2023-04-01', 4, 30000, 2000, 101000, 101),
(5, 'Vikram', 'Singh', 'vikram.singh@example.com', 567890123, '2023-05-01', 5, 95000, 8000, 110000, 110),
(6, 'Anjali', 'Nair', 'anjali.nair@example.com', 678901234, '2023-06-01', 1, 60000, 5000, 100001, 1),
(7, 'Aman', 'Gupta', 'aman.gupta@example.com', 789012345, '2023-07-01', 2, 45000, 4000, 100010, 10),
(8, 'Neha', 'Kapoor', 'neha.kapoor@example.com', 890123456, '2023-08-01', 3, 50000, 4500, 100100, 11),
(9, 'Rohan', 'Iyer', 'rohan.iyer@example.com', 901234567, '2023-09-01', 4, 30000, 2000, 101000, 101),
(10, 'Sneha', 'Jain', 'sneha.jain@example.com', 234567891, '2023-10-01', 5, 95000, 8000, 110000, 110),
(11, 'Karan', 'Mehta', 'karan.mehta@example.com', 234567890, '2023-11-01', 1, 60000, 5000, 100001, 1),
(12, 'Simran', 'Chopra', 'simran.chopra@example.com', 345678901, '2023-12-01', 2, 45000, 4000, 100010, 10),
(13, 'Rakesh', 'Deshmukh', 'rakesh.deshmukh@example.com', 456789012, '2024-01-01', 6, 50000, 4500, 110000, 110),
(14, 'Pooja', 'Mishra', 'pooja.mishra@example.com', 567890123, '2024-02-01', 4, 30000, 2000, 101000, 101),
(15, 'Nikhil', 'Kumar', 'nikhil.kumar@example.com', 678901234, '2024-03-01', 5, 95000, 8000, 110000, 110),
(16, 'Sana', 'Rao', 'sana.rao@example.com', 789012345, '2024-04-01', 1, 60000, 5000, 100010, 10),
(17, 'Raj', 'Shah', 'raj.shah@example.com', 890123456, '2024-05-01', 2, 45000, 4000, 100100, 11),
(18, 'Tanya', 'Bose', 'tanya.bose@example.com', 901234567, '2024-06-01', 3, 50000, 4500, 100010, 10),
(19, 'Aditya', 'Chatterjee', 'aditya.chatterjee@example.com', 123456782, '2024-07-01', 6, 30000, 2000, 101000, 101),
(20, 'Meera', 'Agarwal', 'meera.agarwal@example.com', 234567893, '2024-08-01', 5, 95000, 8000, 110000, 110);

SELECT* FROM employees;

-- Question 4
-- Write a query to change the email and commission column of employees table with 'not available' and 0.10 for those employees who. Belong to second department.

SELECT * FROM departments;

SELECT * FROM jobs;

SELECT * FROM employees;

UPDATE employees
SET email = 'not available', commission = 0.10
WHERE department_id = 2.0;

-- Question 5
-- Write a query to increase the maximum salary of 2nd entry in the Jobs table by 2000 as well as the salary for those employees by 100 and commission by 0.1.
UPDATE jobs
SET max_salary = max_salary + 2000
WHERE job_id = 2;

UPDATE employees
SET salary = salary + 100, commission = commission + 0.1
WHERE job_id = 2;

-- Question 6
-- Delete All employees who belong to the 5th department and also Delete the 5th department 
DELETE FROM employees
WHERE department_id = 110;

DELETE FROM departments
WHERE department_id = 110;

-- Question 7
-- Delete the commision column from the employee table and add DOB column with date variable type. 

ALTER TABLE employees
DROP COLUMN commission;

ALTER TABLE employees
ADD COLUMN DOB DATE;

-- Question 8
-- Create a table with columns location_id, city, state, country.
-- Apply the UNIQUE and NOT NULL constraints on the location_id.
-- Populate it with 5 entries. Add location_id to the departments table.
CREATE TABLE locations (
location_id decimal(4,0) UNIQUE NOT NULL,
city varchar(30),
state varchar(30),
country varchar(30));

INSERT INTO locations (location_id, city, state, country) VALUES 
(1234, 'Mumbai', 'Maharashtra', 'India'),
(1233, 'Bangalore', 'Karnataka', 'India'),
(1232, 'Chennai', 'Tamil Nadu', 'India'),
(1231, 'Kolkata', 'West Bengal', 'India'),
(1230, 'Delhi', 'Delhi', 'India');

-- departments table already has location_id column.

-- Question 9
-- Add primary key constraint to the location_id column in the locations table and 
-- foreign key constraint in the departments table.
ALTER TABLE locations
ADD PRIMARY KEY(location_id);

DESCRIBE locations;

ALTER TABLE departments
ADD FOREIGN KEY(location_id) REFERENCES locations(location_id);

-- Question 10
-- Rename country column to 'country_name', email to 'email_id',
-- and rename the location table to address.
ALTER TABLE locations
RENAME COLUMN country TO country_name,
RENAME COLUMN email TO email_id;

DESCRIBE locations;

RENAME TABLE locations TO address;
DESCRIBE address; 