---
layout: page
title: Fishing SQL Solutions
permalink: /teaching/solutions/sql/dql/fishing/
crumbtitle: Fishing
---

1) Which fishermen went fishing on the 3rd of January 2017? (cod, name)

```sql
SELECT cod, name FROM fisherman JOIN     went USING (cod) JOIN     trip USING (num) WHERE date = '2017-1-3' 
```

2) What kinds of fish where fished on the 3rd of January 2017? (ref, name)

```sql
SELECT DISTINCT ref, name FROM fish JOIN     caught USING (ref) JOIN     trip USING (num) WHERE date = '2017-1-3' 
```

3) How many fishing trips were made on the 2nd of January 2017? (number)

```sql
SELECT COUNT(*) as numero FROM trip WHERE date = '2017-1-2'; 
```

4) How many boats can carry more than 35000kg of fish? (number)

```sql
SELECT COUNT(*) as numero FROM boat WHERE max_weight > 35000; 
```

5) How many fishermen went on each trip? Consider that there is at least one fisherman in each trip) (num, date, number)

```sql
SELECT num, date, COUNT(*) as numero FROM trip JOIN went USING (num) GROUP BY num 
```

6) How many types of fish were caught in each trip? Consider that at least one type of fish was caught in each trip) (num, date, number)

```sql
SELECT num, date, COUNT(*) as numero FROM trip JOIN caught USING (num) GROUP BY num 
```

7) In which trips the total caught fish was heavier than 10000kg? (num, date)

```sql
SELECT num, date FROM trip JOIN caught USING (num) GROUP BY num HAVING SUM(weight) > 10000 
```

8) In which trips the fishermen’s average age was above 50 years old? (num, date)

```sql
SELECT num, date FROM trip JOIN went USING (num) JOIN fisherman USING(cod) GROUP BY num HAVING AVG(age) > 50 
```

9) Which boats never caught ‘Salmon’? (id, name)

```sql
SELECT id, name FROM boat WHERE id NOT IN (  SELECT id  FROM trip JOIN caught USING (num) JOIN fish USING (ref)  WHERE name = 'Salmon' ) 
```

10) In which boats did ‘Skeet Reese’ never fish? (id, name)

```sql
SELECT id, name FROM boat WHERE id NOT IN (  SELECT id  FROM trip JOIN went USING (num) JOIN fisherman USING (cod)  WHERE name = 'Skeet Reese' ) 
```

11) How many trips did each fisherman take? Consider that some fisherman might never been on a trip) Order the result from the fisherman with less trips to the one with more trips) If two fishermen have the same number of trips, order them alphabetically) (cod, name, number)

```sql
SELECT cod, name, COUNT(num) as numero FROM fisherman LEFT JOIN went USING (cod) GROUP BY cod ORDER BY COUNT(num), name 
```

12) How many times was each type of fish caught? Consider that some types of fish might never have been caught) Order the result from the most caught type of fish to the least caught type of fish) If two types of fish have been caught the same ammount of times order them alphabetically) (ref, name, number)

```sql
SELECT ref, name, COUNT(num) as numero FROM fish LEFT JOIN caught USING (ref) GROUP BY ref ORDER BY COUNT(num) DESC, name 
```

13) Which trip, or trips, had the crew with the lower age average? (num, date, average)

```sql
SELECT num, date, AVG(age) as media FROM trip JOIN     went USING (num) JOIN     fisherman USING (cod) GROUP BY num HAVING AVG(age) <= ALL (  SELECT AVG(age)  FROM trip JOIN     went USING (num) JOIN     fisherman USING (cod)  GROUP BY num ) 
```

14) Which trip, or trips, caught the least kg of fish? (num, date, weight)

```sql
SELECT num, date, SUM(weight) AS weight FROM trip JOIN     caught USING (num) JOIN     fish USING (ref) GROUP BY num HAVING SUM(weight) <= ALL (  SELECT SUM(weight)  FROM trip JOIN     caught USING (num) JOIN     fish USING (ref)  GROUP BY num ) 
```

15) Which fishermen went on trips where the boat weight limit was exceeded? (cod, name)

```sql
SELECT DISTINCT cod, name FROM fisherman JOIN went USING (cod) WHERE num IN (  SELECT num  FROM boat JOIN trip USING (id) JOIN caught USING (num)  GROUP BY num, id  HAVING SUM(weight) > max_weight ) 
```

16) Which fishes were caught on trips where the boat weight limit was exceeded? (ref, name)

```sql
SELECT DISTINCT ref, name
FROM fish JOIN caught USING (ref)
WHERE num IN (
  SELECT num
  FROM boat JOIN trip USING (id) JOIN caught USING (num)
  GROUP BY num, id
  HAVING SUM(weight) > max_weight
)
```

*(Credits: André Restivo https://web.fe.up.pt/~arestivo)