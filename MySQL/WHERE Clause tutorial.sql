-- WHERE Clause

SELECT * FROM parks_and_recreation.employee_salary;

SELECT * FROM parks_and_recreation.employee_salary
WHERE dept_id = 1;

-- LIKE Clause

SELECT * FROM parks_and_recreation.employee_salary
WHERE occupation LIKE '%Director%';

SELECT * FROM parks_and_recreation.employee_salary
WHERE first_name LIKE 'a__';

SELECT * FROM employee_salary
WHERE last_name = 'b_____';

-- AND OR NOT -- Logical Operators

SELECT first_name,
salary
FROM employee_salary
WHERE (dept_id = 3 AND salary >50000) OR
occupation LIKE '%Manager';
