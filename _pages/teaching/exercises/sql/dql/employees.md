---
layout: page
title: Employees SQL Exercises
permalink: /teaching/exercises/sql/dql/employees/
crumbtitle: Employees
---

## Support
[SQLite3 Guide](/teaching/exercises/sql/teaching/howto/sqlite/)


## Script

[Download Script Here](/teaching/exercises/sql/dql/scripts/employees.sql)

## Exercises

1. List all employees and their departments. (employee_name, department_name)

2. List all departments and their directors. (department_name, director_name)

3. List all projects and the department to which they belong. (project_name, department_name)

4. What projects are controlled by the department number 1. (project_name)

5. What projects are controlled by the Transports department. (project_name)

6. List all employees working on project XPTO and how many hours each one of them works in that project. (employee_name, hours)

7. List all employees working on project XPTO and how many hours each one of them works in that project. Order the list from the employee that works more hours to the one that works less. (employee_name, hours)

8. How many employees work in each project? (project_name, number)

9. How many hours are spent weekly in each project? (project_name, hours)

10. How many hours does each employee spends on projects every week? (employee_name, hours)

11. List all employees and their superiors. (employee_name, superior_name)

12. List all employees and their superiors. If the employee does not have a superior list it anyway with a NULL superior. (employee_name, superior_name)

13. What is the largest salary in each department? (department_name, salary)

14. What is the highest salary in the whole company? (salary)

15. What is the difference between the highest and lowest salaries in the company? (difference)

16. What is the salary difference between each employee and his superior? (employee_name, superior_name, difference)

17. What is the biggest difference between the salary of an employee and his superior? (difference)

18. List the departments where the average salary is more than 1300 euros? (department_name)

19. List the employees who work on projects external to their department? (employee_name)

20. List the employees who work on projects internal to their department? (employee_name)

21. List the employees who only work on projects internal to their department? (employee_name)