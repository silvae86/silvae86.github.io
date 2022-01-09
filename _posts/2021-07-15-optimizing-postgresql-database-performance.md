---
layout: post
title:  "3287% performance boost with 1 line of code? The impact of indexes in PostgreSQL performance!"
date: 2021-07-15 22:07:000 +0100
tags: postgresql databases indexes optimization performance
published: true
comments_id: 28
---

Slow queries are usually easy to identify, since they take at least seconds or minutes to run. Here I show a **different type of optimization** procedure for queries that are **not expensive when ran once or twice**, but that can really take a toll on a system if **ran many times**. We need to determine the total cost of these small queries so that we can optimize them.

## Tutorial contents

Here I will use PostgreSQL, by following these steps:

1. Set up a custom `postgresql.conf` configuration file to enable the necessary statistics extension
2. Boot up a PostgreSQL Docker container 
3. Enable the statistics extension using the command line
4. Add some dummy records to the database
5. Measuring overall impact of a query in the system
   - The credits for what can arguably be considered the "the best query in the world" go to [Hans-Jurgen Schonig](https://www.cybertec-postgresql.com/en/postgresql-detecting-slow-queries-quickly/).
6. Analyse results
7. Spot expensive operations and design the appropriate indices to speed up the queries
8. Results analysis

We will be using Docker and Docker Compose for this example, so please [install it](https://hub.docker.com/editions/community/docker-ce-desktop-mac) if you did not do so already.

## Set up a custom configuration file for PostgreSQL

1. Place [this customized postgresql.conf file](/assets/files/post-files/2021-07-15-optimizing-postgresql-database-performance/postgresql.conf) in a directory of your choice.

- These two options at the end of the file are the primary changes:

```sql
# Add settings for extensions here
shared_preload_libraries = 'pg_stat_statements'               # (change requires restart)
pg_stat_statements.track = all
# enable tracking of time spent by the Operating System in I/O operations
track_io_timing = on
```

2. Place this example [docker-compose.yml](/assets/files/post-files/2021-07-15-optimizing-postgresql-database-performance/docker-compose.yml) file in the same directory. It includes some comments to explain what each line does.
3. Start the containers: `docker-compose up -d`

## Enable statistics extension using the `psql` command line 

 ```shell
 psql -U postgres -h localhost test
 ```

The CLI will prompt you for a password, use `root` as specified in the `docker-compose.yml` file.

```sql
CREATE EXTENSION IF NOT EXISTS pg_stat_statements;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
```

### Validate that the pg_stat_statements extension is active

```sql
SELECT count(*)
from pg_stat_statements;
```

```shell
 count
-------
     27
(1 row)
```

A count of  `1` and no errors means that the extension is enabled.

### Restart the containers

```shell
docker-compose restart
```



## Set up PgAdmin connection

Access PgAdmin at [http://localhost:5051](http://localhost:5051) and connect to the `testpostgres` database. Select "Servers" at the left explorer tree, Right Click &rarr; Create &rarr; Server... and then follow these steps:

![Configuring PostgreSQL database connection - Part 1](/assets/images/post-images/2021-07-15-optimizing-postgresql-database-performance/pgadmin-1.png){:class="img-center width66"}

![Configuring PostgreSQL database connection - Part 2](/assets/images/post-images/2021-07-15-optimizing-postgresql-database-performance/pgadmin-2.png){:class="img-center width66"}

The default credentials are, according to the `docker-compose.yml`file:

- user: admin@test.com
- password: admin

## Add some dummy records to the database for testing

 Let's now start a new SQL Query Tool, add a very simple schema:

![PgAdmin Query Tool](/assets/images/post-images/2021-07-15-optimizing-postgresql-database-performance/query-tool.png){:class="img-center width66"}

### Import the database schema

- Download this [sql schema file](/assets/files/post-files/2021-07-15-optimizing-postgresql-database-performance/test_dump.sql).

- Import the SQL into the database

  ```shell
  psql -U postgres -h localhost test < schema-dump.sql
  ```

  Password: `root`

- If you ever need to dump the database, run:

  ```sql
  pg_dump -U postgres -h localhost --create test > test_dump.sql
  ```

### Add dummy data

Copy and paste this code in the SQL Query Tool. At the bottom there is a command to insert a certain number of random records into the database. Feel free to adjust for more or less records.

```sql
-- activate extension for generating uuids
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- generate a random date
create or replace function random_date() returns date
    language plpgsql
    as $$
  declare
    generatedDate       date;
  begin
  	generatedDate := (
		select NOW() + (random() * (NOW()+'90 days' - NOW())) + '30 days'
	);
    return generatedDate;
  end;
$$;

-- generate lorem ipsum random strings
-- from https://stackoverflow.com/questions/35068285/how-to-create-a-huge-string-in-postgresql/43743174
create or replace function lipsum( quantity_ integer ) returns character varying
    language plpgsql
    as $$
  declare
    words_       text[];
    returnValue_ text := '';
    random_      integer;
    ind_         integer;
  begin
  words_ := array['lorem', 'ipsum', 'dolor', 'sit', 'amet', 'consectetur', 'adipiscing', 'elit', 'a', 'ac', 'accumsan', 'ad', 'aenean', 'aliquam', 'aliquet', 'ante', 'aptent', 'arcu', 'at', 'auctor', 'augue', 'bibendum', 'blandit', 'class', 'commodo', 'condimentum', 'congue', 'consequat', 'conubia', 'convallis', 'cras', 'cubilia', 'cum', 'curabitur', 'curae', 'cursus', 'dapibus', 'diam', 'dictum', 'dictumst', 'dignissim', 'dis', 'donec', 'dui', 'duis', 'egestas', 'eget', 'eleifend', 'elementum', 'enim', 'erat', 'eros', 'est', 'et', 'etiam', 'eu', 'euismod', 'facilisi', 'facilisis', 'fames', 'faucibus', 'felis', 'fermentum', 'feugiat', 'fringilla', 'fusce', 'gravida', 'habitant', 'habitasse', 'hac', 'hendrerit', 'himenaeos', 'iaculis', 'id', 'imperdiet', 'in', 'inceptos', 'integer', 'interdum', 'justo', 'lacinia', 'lacus', 'laoreet', 'lectus', 'leo', 'libero', 'ligula', 'litora', 'lobortis', 'luctus', 'maecenas', 'magna', 'magnis', 'malesuada', 'massa', 'mattis', 'mauris', 'metus', 'mi', 'molestie', 'mollis', 'montes', 'morbi', 'mus', 'nam', 'nascetur', 'natoque', 'nec', 'neque', 'netus', 'nibh', 'nisi', 'nisl', 'non', 'nostra', 'nulla', 'nullam', 'nunc', 'odio', 'orci', 'ornare', 'parturient', 'pellentesque', 'penatibus', 'per', 'pharetra', 'phasellus', 'placerat', 'platea', 'porta', 'porttitor', 'posuere', 'potenti', 'praesent', 'pretium', 'primis', 'proin', 'pulvinar', 'purus', 'quam', 'quis', 'quisque', 'rhoncus', 'ridiculus', 'risus', 'rutrum', 'sagittis', 'sapien', 'scelerisque', 'sed', 'sem', 'semper', 'senectus', 'sociis', 'sociosqu', 'sodales', 'sollicitudin', 'suscipit', 'suspendisse', 'taciti', 'tellus', 'tempor', 'tempus', 'tincidunt', 'torquent', 'tortor', 'tristique', 'turpis', 'ullamcorper', 'ultrices', 'ultricies', 'urna', 'ut', 'varius', 'vehicula', 'vel', 'velit', 'venenatis', 'vestibulum', 'vitae', 'vivamus', 'viverra', 'volutpat', 'vulputate'];
    for ind_ in 1 .. quantity_ loop
      ind_ := ( random() * ( array_upper( words_, 1 ) - 1 ) )::integer + 1;
      returnValue_ := returnValue_ || ' ' || words_[ind_];
    end loop;
    return returnValue_;
  end;
$$;

-- insert a recordCount number of records into the orders and clients tables
create or replace procedure insert_random_records( recordCount integer )
language plpgsql
as $$
declare
    client_id uuid;
begin
for r in 1..recordCount 
loop
	client_id := (
		select uuid_generate_v4()
	);
	
	insert into public.clients(id, name, dob) 
	values(
		client_id
		,
		(
			select lipsum(10)
		), 
		(
			select random_date()
		)
	);
	
	insert into public.orders(id, client_id, created) 
	values(
		uuid_generate_v4()
		,
		client_id, 
		(
			select random_date()
		)
	);
end loop;
end;
$$;

-- add a certain number of generated records (1 client + 1 order each)
call insert_random_records(50000);

```

## Running a query with EXPLAIN

The[ `EXPLAIN` ](https://www.postgresql.org/docs/9.4/using-explain.html) command allows you to view the query plan designed by the DBMS, and determine if it will be efficient or not, and identify potential needs for indexes.

```sql
explain
select * 
from orders 
where created 
between 
	(CURRENT_DATE - INTERVAL '10 days') 
	and 
	(CURRENT_DATE + INTERVAL '10 days');
```

```shell
                                                     QUERY PLAN
---------------------------------------------------------------------------------------------------------------------
 Seq Scan on orders  (cost=0.00..1700.00 rows=1 width=36)
   Filter: ((created >= (CURRENT_DATE - '10 days'::interval)) AND (created <= (CURRENT_DATE + '10 days'::interval)))
```

Notice that here we have a *sequential scan* (i.e. a complete loop) on the `orders` table. This is very expensive (between 0 and 1700.00 [cost units](https://www.postgresql.org/docs/9.3/sql-explain.html)), so let's add some indexes. 

## Different index types for different queries

As a rule of thumb:

- If you have queries for exact matches ( `=` operator) , a `hash` index should be used.
- If you have queries with range criteria ( `>`or `<` -like operators), an `btree`index should be used.

### Adding an index to accelerate our query

In our query we have a range criteria on the `created`field, so let's create a `btree` index on that field:

```sql
-- create the index
CREATE INDEX orders_created_idx ON public.orders USING btree (created DESC NULLS LAST);

-- reindex the table so that the index is updated
REINDEX TABLE orders;
```

Let's take a look at the `CREATE INDEX` command: 

- `using btree`: Uses a BTREE index, since we are using a range comparison in our query
- `DESC`: Useful when we want to sort our query results after retrieving them. If in descending order
	- For example, if your system needs to get the most recent orders first for a paged view, for example the order of the index shoud be descending as well.
- `NULLS LAST`: optimizes the index for sorting tuples with NULL values on the target columns at the end. 

### Re-run the same query

```sql
explain
select * 
from orders 
where created 
between 
	(CURRENT_DATE - INTERVAL '10 days') 
	and 
	(CURRENT_DATE + INTERVAL '10 days');
```

```shell
-------------------------------------------------------------------------------------------------------------------------
 Index Scan using orders_created_idx on orders  (cost=0.30..8.32 rows=1 width=36)
   Index Cond: ((created >= (CURRENT_DATE - '10 days'::interval)) AND (created <= (CURRENT_DATE + '10 days'::interval)))
(2 rows)
```

Now we have a an index scan on the `orders` table! This is much more efficient (0.30 to 8.32 [cost units](https://www.postgresql.org/docs/9.3/sql-explain.html) vs the initial 1700).

## Measuring overall impact of a query

Which queries are consuming the most CPU as a whole, i.e. (times called * time taken)?

```sql
SELECT substring(query, 1, 40) AS query,
      calls,
      round(total_time::numeric, 2) AS total_time,
      round(mean_time::numeric, 2) AS mean_time,
      round((100 * total_time / sum(total_time) OVER ())::numeric, 2) AS percentage
FROM pg_stat_statements
ORDER BY total_time DESC
LIMIT 10;
```

```shell
                  query                   | calls | total_time | mean_time | percentage
------------------------------------------+-------+------------+-----------+------------
 ALTER TABLE ONLY public.orders          +|     1 |    4786.04 |   4786.04 |      19.38
     ADD C                                |       |            |           |
 COPY public.clients (id, name, dob) FROM |     1 |    4380.50 |   4380.50 |      17.74
 ALTER TABLE ONLY public.clients         +|     1 |    4198.65 |   4198.65 |      17.00
     ADD                                  |       |            |           |
 CREATE DATABASE "test"                   |     1 |    2985.64 |   2985.64 |      12.09
 COPY public.orders (id, client_id, creat |     1 |    2461.64 |   2461.64 |       9.97
 COPY public.clients (id, name, dob) TO s |     2 |    1543.10 |    771.55 |       6.25
 COPY public.orders (id, client_id, creat |     2 |     926.27 |    463.14 |       3.75
 CREATE INDEX fki_orders_clientid_client_ |     1 |     756.58 |    756.58 |       3.06
 SELECT c.tableoid, c.oid, c.relname, (SE |     3 |     605.46 |    201.82 |       2.45
 CREATE EXTENSION IF NOT EXISTS pg_stat_s |     1 |     381.34 |    381.34 |       1.54
(10 rows)
```

Here we can see the most time-consuming queries so far. We only created the database, so it is not very interesting. Let's run a quick query multiple times:

### Run a query many times to update the statistic

Here we simulate the load on a server by running our query 500 times:

```sql
create or replace procedure run_simple_query_many_times( nTimes integer )
language plpgsql
as $$
declare 
	pastOrders int;
begin
for r in 1..nTimes
loop
	pastOrders := (
		select count(*)
		from orders 
		where created 
		between 
			(CURRENT_DATE - INTERVAL '10 days') 
		and 
			(CURRENT_DATE + INTERVAL '10 days')
	);
end loop;
end;
$$;

call run_simple_query_many_times(500);
```

## Results

Let us use our statistics package to measure the impact of the addition of this simple index. 

### Running the test without the index  (baseline)

```shell
test=# SELECT substring(query, 1, 40) AS query,                                                                                                                                         calls,                                                                                                                                                                            round(total_time::numeric, 2) AS total_time,                                                                                                                                      round(mean_time::numeric, 2) AS mean_time,                                                                                                                                        round((100 * total_time / sum(total_time) OVER ())::numeric, 2) AS percentage                                                                                               FROM pg_stat_statements                                                                                                                                                           ORDER BY total_time DESC                                                                                                                                                          LIMIT 10;
                  query                   | calls | total_time | mean_time | percentage
------------------------------------------+-------+------------+-----------+------------
 call run_simple_query_many_times(500)    |     1 |   64861.13 |  64861.13 |      48.87
 SELECT (                                +|   500 |   64740.01 |    129.48 |      48.78
         select count(*)                 +|       |            |           |
                                          |       |            |           |
 /*pga4dash*/                            +|    90 |    3103.17 |     34.48 |       2.34
 SELECT $1 AS chart_name, ro              |       |            |           |
 SELECT pg_stat_statements_reset()        |     1 |       7.41 |      7.41 |       0.01
 create or replace procedure run_simple_q |     2 |       6.54 |      3.27 |       0.00
(5 rows)

test=#
```

Notice how now, we have 1 call to our `run_simple_query_many_times` procedure, and 500 calls to our query. 48% of the CPU time was spent in this query, and a **total of 64740 milliseconds in total were spent running the query across the 500 calls**.

#### Resetting statistics

To reset the statistics between test runs you may use this command in a `psql` prompt:

```sql
SELECT pg_stat_statements_reset();
```

### Running the test with the index (alternative scenario)

```sql
test=# SELECT substring(query, 1, 40) AS query,                                                                                                                                         calls,                                                                                                                                                                            round(total_time::numeric, 2) AS total_time,                                                                                                                                      round(mean_time::numeric, 2) AS mean_time,                                                                                                                                        round((100 * total_time / sum(total_time) OVER ())::numeric, 2) AS percentage                                                                                               FROM pg_stat_statements                                                                                                                                                           ORDER BY total_time DESC                                                                                                                                                          LIMIT 10;
                  query                   | calls | total_time | mean_time | percentage
------------------------------------------+-------+------------+-----------+------------
 call run_simple_query_many_times(500)    |     1 |     102.01 |    102.01 |      58.75
 /*pga4dash*/                            +|     1 |      34.29 |     34.29 |      19.75
 SELECT $1 AS chart_name, ro              |       |            |           |
 SELECT (                                +|   500 |      19.67 |      0.04 |      11.33
         select count(*)                 +|       |            |           |
                                          |       |            |           |
 SELECT pg_stat_statements_reset()        |     1 |      10.54 |     10.54 |       6.07
 create or replace procedure run_simple_q |     1 |       7.11 |      7.11 |       4.10
(5 rows)
```

This time, a total of just **19.67 milliseconds in total** were spent running the query. 

**That is a performance increase of 3287%!** 

So, next time you write a query in your system, double check if any indexes should be updated /added as well...

