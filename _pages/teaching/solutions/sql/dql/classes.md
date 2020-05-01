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
--coalesce function will return the first non-null argument:
--https://www.sqlitetutorial.net/sqlite-functions/sqlite-coalesce/

SELECT MAX(
		MAX(COALESCE(grade1, grade2), COALESCE(grade1, grade2) )
	)
FROM enrollment JOIN
  course USING(ref)
WHERE name = 'SINF'
```
11) Who got that grade? (num, name)

Original solution:

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

2019/2020 Solutions:

```sql
-- Who got that grade? (num, name)

select student.num, student.name as name, grade1, grade2, course.name
from enrollment
join course on course.ref = enrollment.ref
join student on enrollment.num = student.num
where
course.name="SINF"
and
(
	grade1 =
		(
			select max( max(e1.grade1), max(e1.grade2))
			from enrollment e1
			join course c1
			on e1.ref = c1.ref
			where c1.name = "SINF"
		)
	or
	grade2 =
		(
			select max( max(e2.grade1), max(e2.grade2))
			from enrollment e2
			join course c2
			on e2.ref = c2.ref
			where c2.name = "SINF"
		)
);
```

or

```sql
-- Who got that grade? (num, name)
-- Credits for the query fix: Inês Soares (2019/2020 Student)
-- (Uses Views)

DROP VIEW IF EXISTS max_grade_sinf;
CREATE VIEW max_grade_sinf AS
	SELECT MAX(MAX(grade1), MAX(grade2)) as grade
		FROM
			enrollment
			JOIN course
			ON enrollment.ref = course.ref
			WHERE course.name = 'SINF';

SELECT student.num, student.name
FROM
	enrollment
	JOIN course
	ON enrollment.ref = course.ref
	JOIN student
	ON enrollment.num = student.num
	JOIN max_grade_sinf
	ON (grade1 = grade OR grade2 = grade)
	WHERE course.name = 'SINF';
```

or (ridiculously long query, just for laughs)

```sql
-- Who got that grade? (num, name)
-- "The copy-paste train"

select *
from
(
	select student.num, student.name as name, grade1, grade2
	from enrollment e1
	join course on course.ref=e1.ref
	join student on e1.num=student.num
	where
	course.name = 'SINF'
	and grade1 is not null and grade1 = (
		select max(grade)
		from
		(
			select grade1 as grade
			from enrollment e2
			join course c2
			on e2.ref=c2.ref
			where c2.name = 'SINF'

			union

			select grade2 as grade
			from enrollment e3
			join course c3
			on e3.ref=c3.ref
			where c3.name = 'SINF'
		)
	)
	union
	select student.num, student.name as name, grade1, grade2
	from enrollment e2
	join course on course.ref=e2.ref
	join student on e2.num=student.num
	where
	course.name = 'SINF'
	and grade2 is not null and grade2 = (
		select max(grade)
		from
		(
			select grade1 as grade
			from enrollment e2
			join course c2
			on e2.ref=c2.ref
			where c2.name = 'SINF'

			union

			select grade2 as grade
			from enrollment e3
			join course c3
			on e3.ref=c3.ref
			where c3.name = 'SINF'
		)
	)
);		
```

*(Credits: André Restivo https://web.fe.up.pt/~arestivo)*
