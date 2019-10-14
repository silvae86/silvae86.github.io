---
layout: page
title: Bicycles SQL Solutions
permalink: /teaching/solutions/sql/dql/bicycles/
crumbtitle: Bicycles
---


1. What riders belong to the team ‘Os Velozes’? (name)

```sql
SELECT name
FROM rider
WHERE team = 'Os Velozes'
```

2. What rider won the ‘Porto - Aveiro’ stage? (name)

```sql
SELECT name
FROM rider JOIN
     classification USING (ref) JOIN
     stage USING (num)
WHERE description = 'Porto - Aveiro' AND
      position = 1
```
	  
3. What riders ciclistas raced the ‘Coimbra - Lisboa’ stage and what was their final position? Order the answer by their position. (name, position)

```sql
SELECT name, position
FROM rider JOIN
     classification USING (ref) JOIN
     stage USING (num)
WHERE description = 'Coimbra - Lisboa'
ORDER BY position
```

4. How many riders are there in each team? (team, total)

```sql
SELECT team, COUNT(*)
FROM rider
GROUP BY team
```

5. What is the total sum of times of each rider? (name, total)

```sql
SELECT name, SUM(time)
FROM rider JOIN
     classification USING (ref)
GROUP BY ref
```

6. What team, or teams, has a smaller sum of its riders total times? (team)

```sql
SELECT team, SUM(time)
FROM rider JOIN
     classification USING (ref)
GROUP BY team
HAVING SUM(time) <=ALL (
  SELECT SUM(time)
  FROM rider JOIN
       classification USING (ref)
  GROUP BY team
)
```

7. What is the average time in each stage? (description, average)

```sql
SELECT description, AVG(time)
FROM stage JOIN
     classification USING (num)
GROUP BY num
```

8. What stage, or stages, had the smaller average time? (description)

```sql
SELECT description
FROM stage JOIN
     classification USING (num)
GROUP BY num
HAVING AVG(time) <= ALL (
  SELECT AVG(time)
  FROM stage JOIN
       classification USING (num)
  GROUP BY num
)
```

9. What was the time difference between the first and second rider in each stage? (description, difference)

```sql
SELECT first.description, second.time - first.time FROM
 (SELECT *
  FROM stage JOIN
       classification USING (num)
  WHERE position = 1) AS first
  JOIN
 (SELECT *
  FROM stage JOIN
       classification USING (num)
  WHERE position = 2) AS second
  USING (num)
```
  
10. What stage had the biggest time difference between the first and second rider to finish it, what rider won that stage and with how much lead time. (description, name, difference).

```sql
SELECT first.description FROM
 (SELECT *
  FROM stage JOIN
       classification USING (num)
  WHERE position = 1) AS first
  JOIN
 (SELECT *
  FROM stage JOIN
       classification USING (num)
  WHERE position = 2) AS second
  USING (num)
WHERE second.time - first.time >= ALL (
  SELECT second.time - first.time
  FROM classification AS first JOIN
       classification AS second USING (num)
  WHERE first.position = 1 AND second.position = 2
)
```

*(Credits: André Restivo https://web.fe.up.pt/~arestivo)*