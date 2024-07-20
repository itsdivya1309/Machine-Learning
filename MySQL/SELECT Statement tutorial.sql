SELECT *
FROM parks_and_recreation.employee_demographics;

SELECT first_name,
age,
age+5
FROM parks_and_recreation.employee_demographics;

# Follows PEMDAS

SELECT DISTINCT gender
FROM employee_demographics;

SELECT DISTINCT first_name,
gender
FROM employee_demographics;