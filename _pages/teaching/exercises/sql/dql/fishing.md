---
layout: page
title: Fishing SQL Exercises
permalink: /teaching/exercises/sql/dql/fishing/
crumbtitle: Fishing
---

## Support
[SQLite3 Guide](/teaching/exercises/sql/sqlite/)


## Script

[Download Script Here](/teaching/exercises/sql/dql/scripts/employees.sql)

## Exercises

1. Which fishermen went fishing on the 3rd of January 2017? (cod, name)
2. What kinds of fish where fished on the 3rd of January 2017? (ref, name)
3. How many fishing trips were made on the 2nd of January 2017? (number)
4. How many boats can carry more than 35000kg of fish? (number)
5. How many fishermen went on each trip? Consider that there is at least one fisherman in each trip. (num, date, number)
6. How many types of fish were caught in each trip? Consider that at least one type of fish was caught in each trip. (num, date, number)
7. In which trips the total caught fish was heavier than 10000kg? (num, date)
8. In which trips the fishermen’s average age was above 50 years old? (num, date)
9. Which boats never caught ‘Salmon’? (id, name)
10. In which boats did ‘Skeet Reese’ never fish? (id, name)
11. How many trips did each fisherman take? Consider that some fisherman might never been on a trip. Order the result from the fisherman with less trips to the one with more trips. If two fishermen have the same number of trips, order them alphabetically. (cod, name, number)
12. How many times was each type of fish caught? Consider that some types of fish might never have been caught. Order the result from the most caught type of fish to the least caught type of fish. If two types of fish have been caught the same ammount of times order them alphabetically. (ref, name, number)
13. Which trip, or trips, had the crew with the lower age average? (num, date, average)
14. Which trip, or trips, caught the least kg of fish? (num, date, weight)
15. Which fishermen went on trips where the boat weight limit was exceeded? (cod, name)
16. Which fishes were caught on trips where the boat weight limit was exceeded? (ref, name)