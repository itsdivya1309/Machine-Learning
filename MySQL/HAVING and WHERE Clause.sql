-- HAVING and WHERE Clause

SELECT *
FROM parks_and_recreation.employee_salary
;

# Using WHERE Clause with GROUP BY
SELECT dept_id, AVG(salary)
FROM parks_and_recreation.employee_salary
WHERE occupation LIKE '%Manager%'
GROUP BY dept_id
;

# Using Having Clause with GROUP BY
SELECT dept_id, AVG(salary)
FROM parks_and_recreation.employee_salary
GROUP BY dept_id
HAVING AVG(salary) >50000
;