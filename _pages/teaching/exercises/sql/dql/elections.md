---
layout: page
title: Elections SQL Exercises
permalink: /teaching/exercises/sql/dql/elections/
crumbtitle: Elections
---

## Support
[SQLite3 Guide]({% link _pages/teaching/howto/sqlite/index.md %})


## Script

[Download Script Here](/teaching/exercises/sql/dql/scripts/employees.sql)

## Exercises

1. What candidates are running for the municipality of ‘Lisboa’?
2. What candidates are affiliated with the ‘Left Party’?
3. How many ‘Right Party’ candidates got more than 1 vote?
4. How many electors, older than 45, are enrolled to vote in the municipality of ‘Porto’?
5. What is the average age of the candidates for each party? Sort the result starting with the party with the greatest average age. If two parties have the same average age, sort them alphabetically.
6. What is the age of the oldest elector in each municipality? Sort the result starting with the municipality with the oldest elector. If two municipalities have the same oldest elector age, sort them alphabetically.
7. What parties have candidates with an average age greater than 45?
8. What municipalities have electors with an average age lower than 45?
9. What municipalities did not have a candidate from the ‘Middle Party’?
10. What parties were not represented in the ‘Coimbra’ elections?
11. How many electors have abstained in each municipality? Note: An elector abstained if its voted column is false.
12. How many women are enrolled to vote in each municipality?
13. What municipalities had more enrolled voters? Note: Show all municipalities in this situation.
14. What municipalities had more candidates? Note: Show all municipalities in this situation.
15. What are the codes of the municipalities where the party with ‘RP’ as its acronym had a majority? Note: To have a majority, a party must have more votes than the sum of the votes of all other parties in that municipality.
16. What are the codes of the municipalities where the party with ‘LP’ as its acronym got more votes than the party with the acronym ‘RP’? Note: Do not show the cases where the two parties tied.
17. What electors vote in municipalities where the number of blank votes was greater than the number of spoiled (null) votes?
18. What candidates are running for municipalities where there wer no blank or spoiled (null) votes?