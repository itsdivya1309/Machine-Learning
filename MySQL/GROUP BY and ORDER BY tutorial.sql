-- ORDER BY
SELECT *
FROM parks_and_recreation.employee_demographics;

SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY birth_date;

SELECT last_name, gender, age
FROM parks_and_recreation.employee_demographics
ORDER BY gender DESC, age DESC;

-- GROUP BY
SELECT *
FROM parks_and_recreation.employee_salary;

# If not using aggregate functions, group by columns should be same as select query
SELECT occupation
FROM parks_and_recreation.employee_salary
GROUP BY dept_id;

SELECT dept_id
FROM parks_and_recreation.employee_salary
GROUP BY dept_id;

SELECT dept_id, AVG(salary)
FROM parks_and_recreation.employee_salary
GROUP BY dept_id
ORDER BY AVG(salary);