---
layout: page
title: Travel Agency SQL Solutions
permalink: /teaching/solutions/sql/dql/travel/
crumbtitle: Travel Agency
---


1) What cities were visited in the 24th of May 2007 trip? (name)

```sql
SELECT DISTINCT name FROM stop WHERE day = '2007-05-24' 
```

2) What countries where visited in the 2nd of March 2008 trip? Don’t show the same country twice. (name)

```sql
SELECT DISTINCT country FROM stop JOIN city USING (name) WHERE day = '2008-03-02' 
```

3) How many cities were visited in each trip? Order the answer starting with the trip with more cities visited. If two trips have the same number of visited cities, show the most recent first. (day, number)

```sql
SELECT day, COUNT(*) FROM stop GROUP BY day ORDER BY COUNT(*) DESC, day DESC 
```

4) What is the average city score for each country? (name, average)

```sql
SELECT country, AVG(score) FROM city GROUP BY country 
```

5) What countries have cities that are not the capital but are the highest scoring city in the country? (name)

```sql
 
```

6) List all pair of cities from different countries where the spoken language is the same. Don’t show the same pair twice even if in a different order.

```sql

```

*(Credits: André Restivo https://web.fe.up.pt/~arestivo)