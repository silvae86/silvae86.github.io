---
layout: page
title: Elections SQL Solutions
permalink: /teaching/solutions/sql/dql/elections/
crumbtitle: Elections
---


1) What candidates are running for the municipality of ‘Lisboa’?

```sql
SELECT id, name FROM candidate JOIN municipality USING(cod) WHERE designation = 'Lisboa' 
```

2) What candidates are affiliated with the ‘Left Party’?

```sql
SELECT id, candidate.name FROM candidate JOIN party USING(acronym) WHERE party.name = 'Left Party' 
```

3) How many ‘Right Party’ candidates got more than 1 vote?

```sql
SELECT COUNT(*) AS quantity FROM candidate JOIN party USING(acronym) WHERE votes > 1 AND party.name = 'Right Party' 
```

4) How many electors, older than 45, are enrolled to vote in the municipality of ‘Porto’?

```sql
SELECT COUNT(*) AS quantity FROM elector JOIN municipality USING(cod) WHERE age > 45 AND designation = 'Porto' 
```

5) What is the average age of the candidates for each party? Sort the result starting with the party with the greatest average age) If two parties have the same average age, sort them alphabetically.

```sql
SELECT party.name, AVG(age) AS average FROM candidate JOIN party USING(acronym) GROUP BY acronym, party.name ORDER BY AVG(age) DESC, party.name 
```

6) What is the age of the oldest elector in each municipality? Sort the result starting with the municipality with the oldest elector) If two municipalities have the same oldest elector age, sort them alphabetically.

```sql
SELECT designation, MAX(age) AS maximum FROM elector JOIN municipality USING(cod) GROUP BY cod, designation ORDER BY MAX(age) DESC, designation 
```

7) What parties have candidates with an average age greater than 45?

```sql
SELECT party.name FROM party JOIN candidate USING(acronym) GROUP BY acronym, party.name HAVING AVG(age) > 45 
```

8) What municipalities have electors with an average age lower than 45?

```sql
SELECT designation FROM municipality JOIN elector USING(cod) GROUP BY cod, designation HAVING AVG(age) < 45 
```

9) What municipalities did not have a candidate from the ‘Middle Party’?

```sql
SELECT cod, designation FROM municipality WHERE cod NOT IN (  SELECT cod FROM candidate JOIN party USING (acronym)  WHERE party.name = 'Middle Party' ) 
```

10) What parties were not represented in the ‘Coimbra’ elections?

```sql
SELECT name FROM party WHERE acronym NOT IN (  SELECT acronym FROM party JOIN candidate USING (acronym) JOIN municipality USING(cod)  WHERE designation = 'Coimbra' ) 
```

11) How many electors have abstained in each municipality? Note: An elector abstained if its voted column is false.

```sql
SELECT designation, COUNT(en) AS quantity FROM municipality LEFT JOIN (SELECT * FROM elector WHERE voted = 'F') AS t USING (cod) GROUP BY cod, designation 
```

12) How many women are enrolled to vote in each municipality?

```sql
SELECT designation, COUNT(en) AS quantity FROM municipality LEFT JOIN (SELECT * FROM elector WHERE gender = 'F') AS t USING (cod) GROUP BY cod, designation 
```

13) What municipalities had more enrolled voters? Note: Show all municipalities in this situation.

```sql
SELECT designation FROM municipality JOIN elector USING (cod) GROUP BY cod, designation HAVING COUNT(*) = (select max(cnt) from (  SELECT COUNT(*) as cnt  FROM elector  GROUP BY cod )) 
```

14) What municipalities had more candidates? Note: Show all municipalities in this situation.

```sql
SELECT designation FROM municipality JOIN candidate USING (cod) GROUP BY cod, designation HAVING COUNT(*) = (select max(cnt) from (  SELECT COUNT(*) as cnt FROM candidate  GROUP BY cod )) 
```

15) What are the codes of the municipalities where the party with ‘RP’ as its acronym had a majority? Note: To have a majority, a party must have more votes than the sum of the votes of all other parties in that municipality.

```sql
SELECT cod FROM ( SELECT cod, SUM(votes) AS votes FROM candidate WHERE acronym <> 'RP' GROUP BY cod ) AS t1 JOIN ( SELECT cod, votes FROM candidate WHERE acronym = 'RP' GROUP BY cod, votes ) AS t2 USING (cod) WHERE t1.votes < t2.votes 
```

16) What are the codes of the municipalities where the party with ‘LP’ as its acronym got more votes than the party with the acronym ‘RP’? Note: Do not show the cases where the two parties tied.

```sql
SELECT cod FROM ( SELECT cod, SUM(votes) AS votes FROM candidate WHERE acronym = 'LP' GROUP BY cod ) AS t1 JOIN ( SELECT cod, votes FROM candidate WHERE acronym = 'RP' GROUP BY cod, votes ) AS t2 USING (cod) WHERE t1.votes > t2.votes 
```

17) What electors vote in municipalities where the number of blank votes was greater than the number of spoiled (null) votes?

```sql
 
```

18) What candidates are running for municipalities where there wer no blank or spoiled (null) votes?

```

```

*(Credits: André Restivo https://web.fe.up.pt/~arestivo)