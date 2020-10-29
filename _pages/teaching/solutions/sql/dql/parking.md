---
layout: page
title: Parking SQL Solutions
permalink: /teaching/solutions/sql/dql/parking/
crumbtitle: Parking
---

1. What is the make of all vehicles owned by the client with NIF 1232? (make)
```sql
SELECT DISTINCT make
FROM vehicle
WHERE nif = 1232
```
2. What cars have ever parked in the second floor? (plate)
```sql
SELECT DISTINCT plate
FROM parking JOIN
     spot USING (number)
WHERE floor = 2
```
3. In which days what there Ferraris in the park? Order your answer starting with the oldest day first. (day)
```sql
SELECT DISTINCT day
FROM vehicle JOIN
     parking USING(plate)
WHERE make = 'Ferrari'
ORDER BY day
```
4. Which cars parked on the 1st of January 2010? Order them by entry time. (entry, plate)
```sql
SELECT entry, plate
FROM parking
WHERE day = '2010-01-01'
ORDER BY entry
```
5. How many cars does the client with NIF 1232 own? (quantity)
```sql
SELECT COUNT(*)
FROM vehicle
WHERE nif = 1232
```
6. How many parking spots are there above the first floor? (quantity)
```sql
SELECT COUNT(*)
FROM spot
WHERE floor > 1
```
7. How many parking spots in each floor? Sort your answer by floor number. (floor, spots)
```sql
SELECT floor, COUNT(*)
FROM spot
GROUP BY floor
ORDER BY floor
```
8. How many cars does each client own? Sort your answer from the client with more cars to the one with less cars. If two clients have the same number of cars, order them by their name (nif, name, quantity)
```sql
SELECT nif, name, COUNT(*)
FROM vehicle JOIN
     client USING (nif)
GROUP BY nif, name
ORDER BY COUNT(*) DESC, name
```
9. Which clients have more than one car? (nif, name)
```sql
SELECT nif, name
FROM vehicle JOIN
     client USING (nif)
GROUP BY nif, name
HAVING COUNT(*) > 1
```
10. Which clients have more than one car with the same make? (nif, name)
```sql
SELECT DISTINCT nif, name
FROM vehicle JOIN
     client USING (nif)
GROUP BY nif, name, make
HAVING COUNT(*) > 1
```
11. What floors did not have any cars parked on the 3rd of January 2010? (floor)
```sql
SELECT DISTINCT floor
FROM spot WHERE floor NOT IN (
  SELECT floor
  FROM parking JOIN
       spot USING (number)
  WHERE day = '2010-01-03'
)
```
12. What was the first client to park in each day? Order your answer by day. (day, nif, name)
```sql
SELECT day, nif, name
FROM parking JOIN
     vehicle USING (plate) JOIN
     client USING(nif)
WHERE (day, entry) IN (
  SELECT day, MIN(entry)
  FROM parking
 GROUP BY day
)
ORDER BY day     
```
*(Credits: André Restivo https://web.fe.up.pt/~arestivo)*