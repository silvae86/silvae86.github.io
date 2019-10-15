---
layout: page
title: Airplanes SQL Solutions
permalink: /teaching/solutions/sql/dql/airplanes/
crumbtitle: Airplanes
---


1. What are the names and locations of all airports in Portugal? (name, city)

```sql
SELECT name, city
FROM airport
WHERE country = 'Portugal'
````

2. What are the names of all planes of the DC-10 version? (name)

```sql
SELECT name
FROM plane, model
WHERE plane.modelcod = model.modelcod AND version = 'DC-10'
```

or

```sql
SELECT name
FROM plane JOIN model ON plane.modelcod = model.modelcod
WHERE version = 'DC-10'
```

or

```sql
SELECT name
FROM plane JOIN model USING(modelcod)
WHERE version = 'DC-10'
```

3. How many engines does each plane have? (plane_name, number)

```sql
SELECT name, engines
FROM plane JOIN model USING(modelcod)
```

4. How many flights with a 2 or 3 hour duration are there in the database? (number)

```sql
SELECT COUNT(*)
FROM flight
WHERE duration = 2 or duration = 3
```

5. What plane models have a version starting with A3? (modelcod, version)

```sql
SELECT modelcod, version
FROM model
WHERE version LIKE 'A3%'
```


6. What is the code and duration of all flights. Sort the answer from longest to shortest flight. If two flights have the same duration, sort them by flight code from smallest to largest (flightcod, duration).

```sql
SELECT flightcod, duration
FROM flight
ORDER BY duration DESC, flightcod
```

7. Knowing that there are no direct flights from airport 1 (Porto) to airport 12 (London), which 2 legged flights can we use to travel between those airports? (flightcod1, flightcod2, intermediate_airport_code) Note: Use the airports codes (1 and 12) instead of the airport names in your query.

```sql
SELECT f1.flightcod, f2.flightcod, f1.toairportcod
FROM flight AS f1, flight AS f2
WHERE f1.toairportcod = f2.fromairportcod AND
      f1.fromairportcod = 1 AND f2.toairportcod = 12
```

or

```sql
SELECT f1.flightcod, f2.flightcod, f1.toairportcod
FROM flight AS f1 JOIN
     flight AS f2 ON f1.toairportcod = f2.fromairportcod
WHERE f1.fromairportcod = 1 AND f2.toairportcod = 12
```

8. How many airports are there in each country? Sort the answer in ascending order. (country, number)?

```sql
SELECT country, COUNT(*)
FROM airport
GROUP BY country
ORDER BY COUNT(*)
```

9. What is the flight code, origin city and destination city of all flights in the database? Sort the answer by flight code. (flightcod, origin, destination)

```sql
SELECT flightcod, origin.city, destination.city
FROM airport AS origin JOIN
     flight ON origin.airportcod = flight.fromairportcod JOIN
     airport AS destination ON destination.airportcod = flight.toairportcod
ORDER BY flightcod
```

10. What are the flight codes of all flights from Porto to Lisboa. (flightcod)? Note: Your query should use the city names, not the airport codes.

```sql
SELECT flightcod
FROM airport AS origin JOIN
     flight ON origin.airportcod = flight.fromairportcod JOIN
     airport AS destination ON destination.airportcod = flight.toairportcod
WHERE origin.city = 'Porto' and destination.city = 'Lisboa'
```

11. How many airports are there in each country? (country, number); show only countries with more than 2 airports.

```sql
SELECT country, COUNT(*)
FROM airport
GROUP BY country
HAVING COUNT(*) > 2

12. What country, or countries, has more airports and how many? (country, number)

```sql
SELECT country, COUNT(*)
FROM airport
GROUP BY country
HAVING COUNT(*) >= ALL (
  SELECT COUNT(*)
  FROM airport
  GROUP BY country
)
```

or

```sql
SELECT country, COUNT(*)
FROM airport
GROUP BY country
HAVING COUNT(*) IN (
  SELECT MAX(count) FROM (
    SELECT COUNT(*)
    FROM airport
    GROUP BY country
  ) AS t
)
```

or

```sql
SELECT country, COUNT(*)
FROM airport
GROUP BY country
HAVING COUNT(*) IN (
  SELECT COUNT(*)
  FROM airport
  GROUP BY country
  ORDER BY COUNT(*) DESC
  LIMIT 1
)
```

13. How many actual planes are there for each plane model. Sort the result so that least frequent models appear last (make, version, number). Note: You do not need to show models that do not have planes.

```sql
SELECT make, version, COUNT(*)
FROM model JOIN plane USING (modelcod)
GROUP BY make, version
ORDER BY COUNT(*) DESC
```

14. How many actual planes are there for each plane model. Sort the result so that least frequent models appear last (make, version, number). Note: Also show models that do not have planes.

```sql
SELECT make, version, COUNT(planecod)
FROM model LEFT JOIN plane USING (modelcod)
GROUP BY make, version
ORDER BY COUNT(planecod) DESC
```

*(Credits: André Restivo https://web.fe.up.pt/~arestivo)*