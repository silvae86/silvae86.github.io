---
layout: page
title: Employees SQL Solutions
permalink: /teaching/solutions/sql/dql/employees/
crumbtitle: Employees
---


1. List all employees and their departments. (employee_name, department_name)
```sql
SELECT employee.name, department.name AS department
FROM employee JOIN department ON id_dep = department.id
```
2. List all departments and their directors. (department_name, director_name)
```sql
SELECT department.name AS department, employee.name AS director
FROM employee JOIN department ON id_dir = employee.id
```
3. List all projects and the department to which they belong. (project_name, department_name)
```sql
SELECT project.name, department.name AS department
FROM project JOIN department ON id_dep = department.id
```
4. What projects are controlled by the department number 1. (project_name)
```sql
SELECT name
FROM project WHERE id_dep = 1
```
5. What projects are controlled by the Transports department. (project_name)
```sql
SELECT project.name
FROM project JOIN department ON id_dep = department.id
WHERE department.name = 'Transports'
```
6. List all employees working on project XPTO and how many hours each one of them works in that project. (employee_name, hours)
```sql
SELECT employee.name, hours
FROM project JOIN
     works ON id_pro = id JOIN
     employee ON id_emp = employee.id
WHERE project.name = 'XPTO'
```
7. List all employees working on project XPTO and how many hours each one of them works in that project. Order the list from the employee that works more hours to the one that works less. (employee_name, hours)
```sql
SELECT employee.name, hours
FROM project JOIN
     works ON id_pro = id JOIN
     employee ON id_emp = employee.id
WHERE project.name = 'XPTO'
ORDER BY hours DESC
```
8. How many employees work in each project? (project_name, number)
```sql
SELECT name, COUNT(*)
FROM project JOIN works ON id = id_pro
GROUP BY id
```
or
```sql
SELECT name, COUNT(id_emp)
FROM project LEFT JOIN works ON id = id_pro
GROUP BY id
```
9. How many hours are spent weekly in each project? (project_name, hours)
```sql
SELECT name, SUM(hours)
FROM project JOIN works ON id = id_pro
GROUP BY id
```
or
```sql
SELECT name, SUM(hours)
FROM project LEFT JOIN works ON id = id_pro
GROUP BY id
```
10. How many hours does each employee spends on projects every week? (employee_name, hours)
```sql
SELECT name, SUM(hours)
FROM employee JOIN works ON id = id_emp
GROUP BY id
```
11. List all employees and their superiors. (employee_name, superior_name)
```sql
SELECT employee.name, superior.name AS superior
FROM employee JOIN
     employee AS superior ON employee.id_sup = superior.id
```
12. List all employees and their superiors. If the employee does not have a superior list it anyway with a NULL superior. (employee_name, superior_name)
```sql
SELECT employee.name, superior.name AS superior
FROM employee LEFT JOIN
     employee AS superior ON employee.id_sup = superior.id
```
13. What is the largest salary in each department? (department_name, salary)
```sql
SELECT department.name, MAX(salary)
FROM department JOIN employee ON department.id = id_dep
GROUP BY department.id
```
14. What is the highest salary in the whole company? (salary)
```sql
SELECT MAX(salary)
FROM employee
```
15. What is the difference between the highest and lowest salaries in the company? (difference)
```sql
SELECT MAX(salary) - MIN(salary) AS difference
FROM employee
```
16. What is the salary difference between each employee and his superior? (employee_name, superior_name, difference)
```sql
SELECT employee.name, superior.name AS superior,
       superior.salary - employee.salary  AS difference
FROM employee JOIN
     employee AS superior ON employee.id_sup = superior.id
```
17. What is the biggest difference between the salary of an employee and his superior? (difference)
```sql
SELECT MAX(difference)
FROM (
  SELECT ABS(superior.salary - employee.salary) AS difference
  FROM employee JOIN
     employee AS superior ON employee.id_sup = superior.id
) AS t
```
18. List the departments where the average salary is more than 1300 euros? (department_name)
```sql
SELECT department.name, AVG(salary)
FROM department JOIN employee ON id_dep = department.id
GROUP BY department.id
HAVING AVG(salary) > 1300
```

19. List the employees who work on projects external to their department? (employee_name)
```sql
SELECT employee.name
FROM employee JOIN
     works ON id_emp = id JOIN
     project ON id_pro = project.id
WHERE employee.id_dep <> project.id_dep
GROUP BY employee.id
```

20. List the employees who work on projects internal to their department? (employee_name)

```sql
SELECT employee.name
FROM employee JOIN
     works ON id_emp = id JOIN
     project ON id_pro = project.id
WHERE employee.id_dep = project.id_dep
GROUP BY employee.id
```

21. List the employees who only work on projects internal to their department? (employee_name)
```sql
SELECT employee.name
FROM employee JOIN
     works ON id_emp = id JOIN
     project ON id_pro = project.id
WHERE employee.id_dep = project.id_dep AND
      employee.id NOT IN (
        SELECT employee.id
        FROM employee JOIN
          works ON id_emp = id JOIN
          project ON id_pro = project.id
        WHERE employee.id_dep <> project.id_dep
      )
GROUP BY employee.id
```

*(Credits: André Restivo https://web.fe.up.pt/~arestivo)*