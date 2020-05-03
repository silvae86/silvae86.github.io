---
layout: page
title: Airplanes SQL Exercises
permalink: /teaching/exercises/sql/dql/airplanes/
crumbtitle: Airplanes
---

## Support
[SQLite3 Guide](/teaching/exercises/sql/teaching/howto/sqlite/)


## Script

[Download Script Here](/teaching/exercises/sql/dql/scripts/airplanes.sql)

## Exercises

1. What are the names and locations of all airports in Portugal? (name, city)

2. What are the names of all planes of the DC-10 version? (name)

3. How many engines does each plane have? (plane_name, number)

4. How many flights with a 2 or 3 hour duration are there in the database? (number)

5. What plane models have a version starting with A3? (modelcod, version)

6. What is the code and duration of all flights. Sort the answer from longest to shortest flight. If two flights have the same duration, sort them by flight code from smallest to largest (flightcod, duration).

7. Knowing that there are no direct flights from airport 1 (Porto) to airport 12 (London), which 2 legged flights can we use to travel between those airports? (flightcod1, flightcod2, intermediate_airport_code) Note: Use the airports codes (1 and 12) instead of the airport names in your query.

8. How many airports are there in each country? Sort the answer in ascending order. (country, number)?

9. What is the flight code, origin city and destination city of all flights in the database? Sort the answer by flight code. (flightcod, origin, destination)

10. What are the flight codes of all flights from Porto to Lisboa. (flightcod)? Note: Your query should use the city names, not the airport codes.

11. How many airports are there in each country? (country, number); show only countries with more than 2 airports.

12. What country, or countries, has more airports and how many? (country, number)

13. How many actual planes are there for each plane model. Sort the result so that least frequent models appear last (make, version, number). Note: You do not need to show models that do not have planes.

14. How many actual planes are there for each plane model. Sort the result so that least frequent models appear last (make, version, number). Note: Also show models that do not have planes.
