---
layout: page
title: Clinic SQL Solutions
permalink: /teaching/solutions/sql/dql/clinic/
crumbtitle: Clinic
---

1. List the physicians working in the clinic? (name)
```sql
SELECT name
FROM physician
```
2. List the names and addresses of the patients? (name, address)
```sql
SELECT name, address
FROM patient
```
3. List the dates of all appointments of patient 12345? (date)
```sql
SELECT DISTINCT date
FROM appointment
WHERE code = '12345'
```
4. What are the existing conditions in the database in alphabetical order? (designation)
```sql
SELECT designation
FROM condition
ORDER BY designation
```
5. What patients were seen on January 1, 2007? (number, name)
```sql
SELECT DISTINCT code, name
FROM appointment JOIN patient USING (code)
WHERE date = '2007-01-01'
```
6. What conditions were diagnosed in appointment number 456? (designation)
```sql
SELECT designation
FROM diagnosed JOIN condition USING (ref)
WHERE num = 456
```
7. How many appointments took place on January 1, 2007? (number)
```sql
SELECT COUNT(*)
FROM appointment
WHERE date = '2007-01-01'
```
8. How many times was each room used? (room, number)
```sql
SELECT room, COUNT(*)
FROM appointment
GROUP BY room
```
9. How many times was each room used by the physician with number 99030? (room, number)
```sql
SELECT room, COUNT(*)
FROM appointment
WHERE number = '99030'
GROUP BY room
```

10. How many times was each room used by the physician Luca Moore? (room, number)
```sql
SELECT room, COUNT(*) as number
FROM appointment join physician using(number)
WHERE name = 'Luca Moore'
GROUP BY room;
```

11. What rooms were used more than twice on 1 January 2007? (room)
```sql
SELECT room
FROM appointment
WHERE date = '2007-01-01'
GROUP BY room
HAVING COUNT(*) > 2
```
12. What are the three most used rooms in that same day? (room)
```sql
SELECT room
FROM appointment
WHERE date = '2007-01-01'
GROUP BY room
HAVING COUNT(*) IN (
  SELECT COUNT(*)
  FROM appointment
  WHERE date = '2007-01-01'
  GROUP BY room
  ORDER BY COUNT(*) DESC
  LIMIT 3
)
```
13. What conditions have been diagnosed for patient 12345? (designation)
```sql
SELECT DISTINCT designation
FROM appointment JOIN diagnosed USING(num) JOIN condition USING (ref)
WHERE code = '12345'
```
14. What patients have been diagnosed conditions that have also been diagnosed for patient 12345? (name)
```sql
SELECT DISTINCT name
FROM appointment JOIN diagnosed USING(num) JOIN patient USING (code)
WHERE ref IN (
  SELECT ref
  FROM appointment JOIN diagnosed USING(num)
  WHERE code = '12345'
)
```

*(Credits: André Restivo https://web.fe.up.pt/~arestivo)*