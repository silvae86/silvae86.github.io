---
layout: page
title: Classes SQL Exercise
permalink: /teaching/exercises/sql/dql/classes/
crumbtitle: Classes
---

## Support

[SQLite3 Guide]({% link _pages/teaching/howto/sqlite/index.md %})


## Script

[Download Script Here](/teaching/exercises/sql/dql/scripts/classes.sql)

## Exercises

1. List the students in the database. (num, name)
2. In which courses did the student with number 4 enrolled? (ref, year, name)
3. In which courses did Michael enroll? (ref, year, name)
4. How many students are enrolled in the 2007 edition of the SINF course? (total)
5. What was the average grade in the first exam of the 2008 edition of the SINF course? (average)
6. Which students went to the first SINF exam but did not go to the second one in 2007? (num, name)
7. Which students scored higher in the second exam than in the first one in the 2007 edition of the SINF course? (num, name)
8. For each course, list the average grade of both exams in all editions. (ref, name, average1, average2)
9. For each course and year, list the average grade of both exams. (ref, name, year, average1, average2)
10. What was the higher grade, considering both exams, obtained in the SINF course? (grade)
11. Who got that grade? (num, name)
