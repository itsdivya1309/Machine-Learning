SHOW databases;
USE itw2lab;
show tables;

-- Delete the Employees table if it exists
DROP TABLE IF EXISTS Employees;

-- Delete the Dept table if it exists
DROP TABLE IF EXISTS Dept;

-- Delete the Salary_Grade table if it exists
DROP TABLE IF EXISTS Salary_Grade;


CREATE TABLE Dept (
    dep_id INT PRIMARY KEY,
    dep_name VARCHAR(50),
    dep_location VARCHAR(50)
);

-- Insert values into Dept table
INSERT INTO Dept (dep_id, dep_name, dep_location) VALUES
(1001, 'FINANCE', 'SYDNEY'),
(2001, 'AUDIT', 'MELBOURNE'),
(3001, 'MARKETING', 'PERTH'),
(4001, 'PRODUCTION', 'BRISBANE');

CREATE TABLE Salary_Grade (
    grade INT PRIMARY KEY,
    min_sal DECIMAL(10, 2),
    max_sal DECIMAL(10, 2)
);

-- Insert values into Salary_Grade table
INSERT INTO Salary_Grade (grade, min_sal, max_sal) VALUES
(1, 800, 1300),
(2, 1301, 1500),
(3, 1501, 2100),
(4, 2101, 3100),
(5, 3101, 9999);

CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    job_name VARCHAR(50),
    manager_id INT,
    hire_date DATE,
    salary DECIMAL(10, 2),
    commission DECIMAL(10, 2),
    dep_id INT,
    FOREIGN KEY (manager_id) REFERENCES Employees(emp_id),
    FOREIGN KEY (dep_id) REFERENCES Dept(dep_id)
);

-- Insert values into Employees table
INSERT INTO Employees (emp_id, emp_name, job_name, manager_id, hire_date, salary, commission, dep_id) VALUES
(68319, 'KAYLING', 'PRESIDENT', NULL, '2011-11-18', 6000.00, NULL, 1001),
(66928, 'BLAZE', 'MANAGER', 68319, '2011-05-01', 2750.00, NULL, 3001),
(67832, 'CLARE', 'MANAGER', 68319, '2011-06-09', 2550.00, NULL, 1001),
(65646, 'JONAS', 'MANAGER', 68319, '2011-04-02', 2957.00, NULL, 2001),
(67858, 'SCARLET', 'ANALYST', 65646, '2017-04-19', 3100.00, NULL, 2001),
(69062, 'FRANK', 'ANALYST', 65646, '2011-12-03', 3100.00, NULL, 2001),
(63679, 'SANDRINE', 'CLERK', 69062, '2010-12-18', 900.00, NULL, 2001),
(64989, 'ADELYN', 'SALESMAN', 66928, '2011-02-20', 1700.00, 400.00, 3001),
(65271, 'WADE', 'SALESMAN', 66928, '2021-02-22', 1350.00, 600.00, 3001),
(66564, 'MADDEN', 'SALESMAN', 66928, '2021-09-28', 1350.00, 1500.00, 3001),
(68454, 'TUCKER', 'SALESMAN', 66928, '2021-09-08', 1600.00, 0.00, 3001),
(68736, 'ANDREAS', 'CLERK', 67858, '2023-05-23', 1200.00, NULL, 2001),
(69000, 'JULIUS', 'CLERK', 66928, '2023-12-03', 1050.00, NULL, 3001),
(69324, 'MARKER', 'CLERK', 67832, '2023-01-23', 1400.00, NULL, 1001);


-- Question 1
SELECT emp_id, 
       emp_name, 
       job_name, 
       hire_date, 
       CONCAT(
            TIMESTAMPDIFF(YEAR, hire_date, CURDATE()), ' years ',
            TIMESTAMPDIFF(MONTH, hire_date, CURDATE()) % 12, ' months ',
            DATEDIFF(CURDATE(), DATE_ADD(hire_date, INTERVAL TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) YEAR)) % 30, ' days'
       ) AS experience
FROM Employees
WHERE job_name = 'MANAGER';

-- Question 2
SELECT e.*
FROM Employees e
JOIN Salary_Grade sg ON e.salary BETWEEN sg.min_sal AND sg.max_sal
WHERE sg.grade IN (4, 5) 
  AND e.job_name IN ('ANALYST', 'MANAGER');
  
-- Question 3
SELECT emp_name, 
       salary, 
       COALESCE(commission, 0) AS commission 
FROM Employees e1
WHERE (salary + COALESCE(commission, 0)) >= ALL (SELECT salary FROM Employees e2 WHERE e1.emp_id != e2.emp_id);

-- Question 4
SELECT e.*
FROM Employees e
JOIN Dept d ON e.dep_id = d.dep_id
JOIN Salary_Grade sg ON e.salary BETWEEN sg.min_sal AND sg.max_sal
WHERE d.dep_location = 'PERTH'
  AND e.hire_date < (SELECT MIN(hire_date)
                     FROM Employees e2
                     JOIN Salary_Grade sg2 ON e2.salary BETWEEN sg2.min_sal AND sg2.max_sal
                     WHERE sg2.grade = 2)
ORDER BY e.salary DESC
LIMIT 1;

-- Question 5
SELECT e.*
FROM Employees e
JOIN Dept d ON e.dep_id = d.dep_id
JOIN Salary_Grade sg ON e.salary BETWEEN sg.min_sal AND sg.max_sal
WHERE (sg.grade = (SELECT sg.grade 
                   FROM Employees e3 
                   JOIN Salary_Grade sg ON e3.salary BETWEEN sg.min_sal AND sg.max_sal 
                   WHERE e3.emp_name = 'TUCKER') 
       OR hire_date < (SELECT hire_date 
                       FROM Employees e4 
                       WHERE e4.emp_name = 'SANDRINE'))
  AND d.dep_location IN ('SYDNEY', 'PERTH');
  
-- Question 6
SELECT e.*
FROM Employees e
JOIN Salary_Grade sg ON e.salary BETWEEN sg.min_sal AND sg.max_sal
WHERE sg.grade > (SELECT sg.grade 
                  FROM Employees e2 
                  JOIN Salary_Grade sg ON e2.salary BETWEEN sg.min_sal AND sg.max_sal 
                  WHERE e2.emp_name = 'MARKER');

-- Question 7
SELECT e.*
FROM Employees e
WHERE e.manager_id IN (
    SELECT manager_id
    FROM Employees
    GROUP BY manager_id
    HAVING COUNT(emp_id) = 1
);

-- Question 8
SELECT e.*
FROM Employees e
WHERE e.emp_id NOT IN (SELECT DISTINCT manager_id FROM Employees WHERE manager_id IS NOT NULL);

-- Question 9
SELECT emp_id, 
       emp_name, 
       job_name, 
       hire_date,
       CASE 
            WHEN TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) < 2 THEN 'New Hire'
            WHEN TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) BETWEEN 2 AND 5 THEN 'Experienced'
            ELSE 'Veterans'
       END AS experience_category
FROM Employees;

-- Question 10
-- Update salary of salesmen by 500
UPDATE Employees
SET salary = salary + 500
WHERE job_name = 'SALESMAN';

-- Delete all clerks whose manager manages only one employee
DELETE FROM Employees 
WHERE job_name = 'CLERK'
AND manager_id IN (
    SELECT manager_id
    FROM Employees
    GROUP BY manager_id
    HAVING COUNT(*) = 1
);








