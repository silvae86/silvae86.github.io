---
layout: page
title: Classes SQL Solutions
permalink: /teaching/solutions/sql/dql/classes/
crumbtitle: Classes
---

1. List the students in the database. (num, name)
```sql
SELECT *
FROM student
```
2. In which courses did the student with number 4 enrolled? (ref, year, name)
```sql
SELECT ref, year, name
FROM course JOIN
     enrollment USING (ref)
WHERE num = 4
```
3. In which courses did Michael enroll? (ref, year, name)
```sql
SELECT ref, year, course.name
FROM student JOIN
     enrollment USING (num) JOIN
     course USING(ref)
WHERE student.name = 'Michael'
```
4) How many students are enrolled in the 2007 edition of the SINF course? (total)
```sql
SELECT COUNT(*)
FROM enrollment JOIN
     course USING(ref)
WHERE name = 'SINF' AND year = 2007
```
5) What was the average grade in the first exam of the 2008 edition of the SINF course? (average)
```sql
SELECT ROUND(AVG(grade1), 2)
FROM enrollment JOIN
     course USING(ref)
WHERE name = 'SINF' AND year = 2008
```
6) Which students went to the first SINF exam but did not go to the second one in 2007? (num, name)
```sql
SELECT num, student.name
FROM student JOIN
     enrollment USING (num) JOIN
     course USING(ref)
WHERE course.name = 'SINF' AND
      year = 2007 AND
      grade1 IS NOT NULL AND
      grade2 IS NULL
```
7) Which students scored higher in the second exam than in the first one in the 2007 edition of the SINF course? (num, name)
```sql
SELECT num, student.name
FROM student JOIN
     enrollment USING (num) JOIN
     course USING(ref)
WHERE course.name = 'SINF' AND
      year = 2007 AND
      grade1 < grade2
```
8) For each course, list the average grade of both exams in all editions. (ref, name, average1, average2)
```sql
SELECT course.name, ROUND(AVG(grade1),2), ROUND(AVG(grade2),2)
FROM enrollment JOIN
     course USING(ref)
GROUP BY course.ref
```
9) For each course and year, list the average grade of both exams. (ref, name, year, average1, average2)
```sql
SELECT course.name, year, ROUND(AVG(grade1),2), ROUND(AVG(grade2),2)
FROM enrollment JOIN
     course USING(ref)
GROUP BY course.ref, year
```
10) What was the higher grade, considering both exams, obtained in the SINF course? (grade)
```sql
SELECT MAX(max(grade1, grade2))
FROM enrollment JOIN
     course USING(ref)
WHERE name = 'SINF'
```
11) Who got that grade? (num, name)
```sql
SELECT num, student.name
FROM student JOIN
     enrollment USING (num) JOIN
     course USING(ref)
WHERE course.name = 'SINF' AND
      max(grade1, grade2) IN (
        SELECT MAX(max(grade1, grade2))
        FROM enrollment JOIN
             course USING(ref)
        WHERE name = 'SINF'
      )
```
*(Credits: André Restivo https://web.fe.up.pt/~arestivo)*