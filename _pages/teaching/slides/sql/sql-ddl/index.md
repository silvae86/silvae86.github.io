---
layout: keynote
title: SQL Data Description Language with SQLite
permalink: /teaching/slides/sql/sql-ddl/
---
{% highlight text %}
{% raw %}
name: uml
class: middle, center
template:inverse

# SQL
[Structured Querying Language] 

## Data Definition Language

<a href="http://www.fe.up.pt/~arestivo">André Restivo</a>

.footnote[(revised for SQLite by [João Rocha da Silva](https://silvae86.github.com))]

---
name: index
class: middle, center

## Index
.index[

.indexpill[[Introduction](#intro)]

.indexpill[[Table Basics](#basics)]

.indexpill[[Data Types](#types)]

.indexpill[[Affinity in SQLite](#affinity)]

.indexpill[[Defaults](#defaults)]

.indexpill[[Constraints](#constraints)]

.indexpill[[Check](#check)]

.indexpill[[Not Null](#notnull)]

.indexpill[[Primary Keys](#primary)]

.indexpill[[Unique Keys](#unique)]

.indexpill[[Foreign Keys](#foreign)]

.indexpill[[Sequences](#sequences)]
]
---
name: intro
template: inverse
class: middle, center
# Introduction

---
template: inverse
class: middle
# SQL

* **S**tructured **Q**uery **L**anguage.
* A special purpose language to manage data stored in a **relational** database.
* Based on **relational algebra**.
* Pronounced *Sequel*

---
template: inverse
class: middle

# History

* Early **70's** SEQUEL Developed at IBM
* **1986** SQL-86 and SQL-87 Ratified by ANSI and ISO.
* **1989** SQL-89
* **1992** SQL-92 Also know as SQL2.
* **1999** SQL:1999 Also known as SQL3 Includes regurlar expressions, recursive queries, triggers, non-scalar data types and some object-oriented expressions.
* **2003** SQL:2003 XML support and auto-generated values.
* **2006** SQL:2006 XQuery support.
* **2008** SQL:2008.
* **2011** SQL:2011.

---
template: inverse
class: middle
# Standard

* Although SQL is an ANSI/ISO standard, every database system implements it in a slightly different way.
* These slides will try to adhere to the standard as much as possible.
* Sometimes we'll deviate and talk specifically about **SQLite**.

---

template: inverse
class: center, middle
name: basics
# Table Basics

---

# Creating Tables

The basic structure of a table creation statement in SQL:

```sql
CREATE TABLE <table_name> (
  <column_name> <data_type>,
  <column_name> <data_type>,
  ...
  <column_name> <data_type>
);
```

.box_info[Values between <> are to be replaced.]

---

# Deleting Tables

To delete a table we do:

```sql
DROP TABLE <table_name>;
```

If there are foreign keys referencing the table we must use the *cascade* keyword:

```sql
DROP TABLE <table_name> CASCADE; 
```

---

template: inverse
name: types
class: center, middle
# Data Types

## SQLite

---

template: inverse
class: middle
# SQLite vs. most other DBMS

* Most other DBMSs use static, rigid typing. With static typing, the datatype of a value is determined by the column in which the value is stored
* SQLite uses a more dynamic system. The datatype is associated with the value itself and not the container. 
* System is backwards-compatible

---

template: inverse
class: center, middle
# Storage Classes and Datatypes 

* Each value stored in an SQLite database (or manipulated by the database engine) has one of the following storage classes:

| Storage Class | Description                                                  |
| ------------- | ------------------------------------------------------------ |
| NULL          | The value is a NULL value.                                   |
| INTEGER       | The value is a signed integer, stored in 1, 2, 3, 4, 6, or 8 bytes depending on the magnitude of the value. |
| REAL          | The value is a floating point value, stored as an 8-byte IEEE floating point number. |
| TEXT          | The value is a text string, stored using the database encoding (UTF-8, UTF-16BE or UTF-16LE). |
| BLOB          | The value is a blob of data, stored exactly as it was input. |

---
class:center, middle
template: inverse
name: affinity

# Affinity

---

template: inverse

# Affinity

* SQLite maps conventional SQL types to its 5 storage classes
  * You can use the conventional Typenames, but internally they are represented according to their *affinity*, calculated via five [rules](https://www.sqlite.org/datatype3.html#affinity_of_expressions).
  * e.g.`NUMERIC(10,2)` (found in other dialects of SQL) for 10 integer digits and 2 decimal equals just `NUMERIC` in SQLite. Qualifiers are there for "suggestive documentation". Any numeric value will be accepted.

| Typenames From The CREATE TABLE Statement or CAST Expression | Resulting Affinity |
| :----------------------------------------------------------- | :----------------- |
| INT INTEGER TINYINT SMALLINT MEDIUMINT BIGINT UNSIGNED BIG INT INT2 INT8 | INTEGER            |
| CHARACTER(20) TEXT(255) VARYING CHARACTER(255) NCHAR(55) NATIVE CHARACTER(70) NTEXT(100) TEXT CLOB | TEXT               |
| BLOB *no datatype specified*                                 | BLOB               |
| REAL DOUBLE DOUBLE PRECISION FLOAT                           | REAL               |
| NUMERIC DECIMAL(10,5) BOOLEAN DATE DATETIME                  | NUMERIC            |

---

template: inverse

# Boolean and Date

* SQLite does not have a specific storage class for Boolean (true/false) or Date/Time values. 
* Dates can be stored as one of 3 storage classes, and then handled using [specific functions](https://www.sqlite.org/lang_datefunc.html).

| Desired Type | Alternative                                                  |
| ------------ | ------------------------------------------------------------ |
| Boolean      | Store as Integer (0=false, 1=true)                           |
| Date/Time    | - **TEXT** for ISO8601 strings ("YYYY-MM-DD HH:MM:SS.SSS").<br />- **REAL** as Julian day numbers, the number of days since noon in Greenwich on November 24, 4714 B.C. according to the proleptic Gregorian calendar.<br />- **INTEGER** as Unix Time, the number of seconds since 1970-01-01 00:00:00 UTC. |

---

template:inverse

# Date functions

SQLite supports five date and time functions:

```sql
date(timestring, modifier, modifier, ...) -- Current date date in format: YYYY-MM-DD
time(timestring, modifier, modifier, ...) -- Current time as HH:MM:SS
datetime(timestring, modifier, modifier, ...) -- Current time as "YYYY-MM-DD HH:MM:SS"

julianday(timestring, modifier, modifier, ...) -- Returns the Julian day - the number of days since noon in Greenwich on November 24, 4714 B.C.
strftime(format, timestring, modifier, modifier, ...) -- Returns the date formatted according to the format string specified as the first argument
SELECT strftime('%s','now'); -- get the number of seconds since unix timestamp (1 Jan 1970)

```

* The `modifier` arguments make it possible to perform computations over the value stored in `timestring`.

---

template:inverse

# Modifiers

* The time string can be followed by zero or more modifiers that alter date and/or time.

* Each modifier is a transformation that is applied to the time value to its left. Modifiers are applied from left to right; order is important. 

  
| Modifiers can have numeric parameters | ... and also specific strings |
|:-:|:-:|
| `NNN days`       | `start of month` |
| `NNN hours`      | `start of year` |
| `NNN minutes`    | `start of day` |
| `NNN.NNNN seconds` | `unixepoch` |
| `NNN months`     | `localtime` |
| `NNN years`      | `utc` |
| `weekday N` |           |

---

template:inverse

# Working with dates

```sql
--Compute the current date.
SELECT date('now');

--Compute the last day of the current month.
SELECT date('now','start of month','+1 month','-1 day');

--Compute the number of days since the signing of the US Declaration of Independence.
SELECT julianday('now') - julianday('1776-07-04');
--Checking if one date is greater than another (without accounting for the time, because julianday gives a number of days)
CHECK (julianday(date1) > julianday(date2))
--Checking if one date/time is greater than another; comparison up to the second
CHECK (strftime('%s', date1) > strftime('%s', date2))
```

 More examples [here](https://www.sqlite.org/lang_datefunc.html).

---

template:inverse
# Auto-incrementing columns

* In SQLite there is a *pseudo-type* that can be used to define **auto-generated** identifiers or **auto-counters**.
* To define a column as an auto-counter we use the type **AUTOINCREMENT**.

## Example

```sql
CREATE TABLE employee (
  id INTEGER AUTOINCREMENT,
  name TEXT,
  address TEXT,
  birthdate TEXT,
  salary TEXT,
  taxes NUMERIC,
  card_number TEXT,
  active INTEGER
);
```

---

template: inverse
name: defaults
class: center, middle
# Defaults

---

# Default Values

For each column we can define its default value:

```sql
CREATE TABLE <table_name> (
  <column_name> <data_type> DEFAULT <default_value>, 
  <column_name> <data_type>,
  ...
  <column_name> <data_type>
);
```

.box_info[The default default value is **NULL**]

---

# Example

```sql
CREATE TABLE employee (
  id INTEGER AUTOINCREMENT,
  name TEXT,
  address TEXT,
  birthdate TEXT,
  salary NUMERIC,
  taxes NUMERIC,
  card_number INTEGER DEFAULT 0,
  active INTEGER DEFAULT 1
);
```

.box_info[Card number default value is 0.]
.box_info[Employee is active by default.]

---

template: inverse
name: constraints
class: center, middle

# Constraints

---

# Constraint Types

Several types of constraints can be defined using SQL:

* Check
* Not Null
* Unique Keys
* Primary Keys
* Foreign Key

Constraints can be **column** based or **table** based.

* **Column** constraints appear **in front** of the column they are referring to.
* **Table** constraints appear as a **separate** clause.

---

template: inverse
name: check
class: center, middle
# Check

---

# Check Constraint

**Check** contraints allows to define a constraint on the column values using an expression that the values must follow:

```sql
CREATE TABLE <table_name> (
  <column_name> <data_type> CHECK <check_expression>, 
  <column_name> <data_type>,
  ...
  <column_name> <data_type>
);
```

---

# Example

```sql
CREATE TABLE employee (
  id INTEGER AUTOINCREMENT,
  name TEXT,
  address TEXT,
  birthdate TEXT,
  salary NUMERIC CHECK (salary > 500),
  taxes NUMERIC,
  card_number INTEGER DEFAULT 0 CHECK (card_number >= 0),
  active INTEGER DEFAULT 1
);
```

.box_info[Salary must be larger than 500.]
.box_info[Card number must be larger or equal to 0.]

---

# Constraint Naming

Giving names to constraints allows us to better identify them when errors occur or when we want to refer to them.

```sql
CREATE TABLE <table_name> (
  <column_name> <data_type> CONSTRAINT <constraint_name> CHECK <check_expression>, 
  <column_name> <data_type>,
  ...
  <column_name> <data_type>
);
```

.box_info[Naming constraints is optional but is a good practice.]

---

# Example

```sql
CREATE TABLE employee (
  id INTEGER AUTOINCREMENT,
  name TEXT,
  address TEXT,
  birthdate DATE,
  salary NUMERIC 
    CONSTRAINT minimum_wage CHECK (salary > 500),
  taxes NUMERIC,
  card_number INTEGER DEFAULT 0 CHECK (card_number >= 0),
  active INTEGER DEFAULT 1
);
```

---

# Multiple Column Check

If the check constraint refers to more than one column, we must use a table based constraint:

```sql
CREATE TABLE employee (
  id INTEGER AUTOINCREMENT,
  name TEXT,
  address TEXT,
  birthdate TEXT,
  salary NUMERIC 
    CONSTRAINT minimum_wage CHECK (salary > 500),
  taxes NUMERIC,
  card_number INTEGER DEFAULT 0 CHECK (card_number >= 0),
  active INTEGER DEFAULT 1,
  CONSTRAINT taxes_lower_salary CHECK (taxes < salary)
);
```

.box_info[Taxes have to be lower than salary.]

---

template: inverse
name: notnull
class: center, middle
# Not Null

---

# Not Null Constraint

We can define that a certain column does not allow NULL values:

```sql
CREATE TABLE <table_name> (
  <column_name> <data_type> NOT NULL,
  <column_name> <data_type>,
  ...
  <column_name> <data_type>
);
```

---

# Example

```sql
CREATE TABLE employee (
  id INTEGER AUTOINCREMENT,
  name TEXT NOT NULL,
  address TEXT,
  birthdate DATE,
  salary NUMERIC 
    CONSTRAINT minimum_wage CHECK (salary > 500),
  taxes NUMERIC,
  card_number INTEGER DEFAULT 0 CHECK (card_number >= 0),
  active INTEGER DEFAULT TRUE,
  CONSTRAINT taxes_lower_salary CHECK (taxes < salary)
);
```

.box_info[Name cannot be null.]

---
class: middle, center
template: inverse
name: primary
# Primary Keys

---

# Primary Key Constraints

We can define one, and **only one**, primary key for our table:

```sql
CREATE TABLE <table_name> (
  <column_name> <data_type> PRIMARY KEY,
  <column_name> <data_type>,
  ...
  <column_name> <data_type>
);
```

---

# Example

```sql
CREATE TABLE employee (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  address TEXT,
  birthdate TEXT,
  salary NUMERIC 
    CONSTRAINT minimum_wage CHECK (salary > 500),
  taxes NUMERIC,
  card_number INTEGER DEFAULT 0 CHECK (card_number >= 0),
  active INTEGER DEFAULT 1,
  CONSTRAINT taxes_lower_salary CHECK (taxes < salary)
);
```

.box_info[Id cannot be null and cannot have repeated values.]

---

# Multiple Column Primary Key

If a primary key is composed by **more than one** column, we must use a **table based** constraint:

```sql
CREATE TABLE <table_name> (
  <column_name> <data_type>,
  <column_name> <data_type>,
  ...
  <column_name> <data_type>,
  PRIMARY KEY (<column_name>, <column_name>)
);
```

---

# Example

```sql
CREATE TABLE telephone (
  employee INTEGER,
  phone TEXT,
  PRIMARY KEY (employee, phone)
);
```

.box_info[An employee cannot have the same phone number twice.]

---
class: middle, center
template: inverse
name: unique
# Unique Keys

---

# Unique Key Contraints

Unique keys are identical to primary keys but:

* they **allow NULL** values;
* and there can be **multiple unique keys** in one table.

They are created using the same type of syntax used in primary keys.

---

# Example

```sql
CREATE TABLE employee (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  address TEXT,
  birthdate DATE,
  salary NUMERIC
    CONSTRAINT minimum_wage CHECK (salary > 500),
  taxes NUMERIC,
  card_number INTEGER 
    UNIQUE
    DEFAULT 0 CHECK (card_number >= 0),
  active INTEGER DEFAULT TRUE,
  CONSTRAINT taxes_lower_salary CHECK (taxes < salary)
);
```

.box_info[Card keys cannot have repeated values.]

---

# Multiple Column Unique Keys

If a unique key is composed by **more than one** column, we must use a **table based** constraint:

```sql
CREATE TABLE <table_name> (
  <column_name> <data_type>,
  <column_name> <data_type>,
  ...
  <column_name> <data_type>,
  UNIQUE (<column_name>, <column_name>)
);
```

---
class: middle, center
template: inverse
name: foreign
# Foreign Keys

---

# Foreign Key Constraints

* We can also declare foreign keys.
* A foreign key must always **reference a key** (primary or unique) from another (or the same) table.
* Databases don't allow columns with a foreign key containing values that do not exist in the referenced column.

```sql
CREATE TABLE <table_A> (
  <column_A> <data_type> PRIMARY KEY,
  <column_B> <data_type>,
  ...
  <column_C> <data_type>
);

CREATE TABLE <table_B> (
  <column_X> <data_type> PRIMARY KEY,
  <column_Y> <data_type>,
  ...
  <column_Z> <data_type> REFERENCES <table_A>(<column_A>)
);
```

---

# Example

```sql
CREATE TABLE employee (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  address TEXT,
  birthdate DATE,
  salary NUMERIC 
    CONSTRAINT minimum_wage CHECK (salary > 500),
  taxes NUMERIC,
  card_number INTEGER 
    UNIQUE
    DEFAULT 0 CHECK (card_number >= 0),
  active INTEGER DEFAULT 1,
  department_id INTEGER REFERENCES department(id),
  CONSTRAINT taxes_lower_salary CHECK (taxes < salary)
);
```

.box_info[The id of the department references the id column in the department table.]
.box_info[Employees cannot have a department number that doesn't exist in the department table.]

---

# Foreign Key to Primary Key

If the referenced column is the primary key of the other table, we can omit the name of the column:

```sql
CREATE TABLE employee (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  address TEXT,
  birthdate DATE,
  salary NUMERIC 
    CONSTRAINT minimum_wage CHECK (salary > 500),
  taxes NUMERIC,
  card_number INTEGER 
    UNIQUE
    DEFAULT 0 CHECK (card_number >= 0),
  active INTEGER DEFAULT 1,
  department_id INTEGER REFERENCES department,
  CONSTRAINT taxes_lower_salary CHECK (taxes < salary)
);
```

.box_info[The id of the department references the primary key in the department table.]

---

# Multiple Column Foreign Key

If the referenced table has a key with **multiple columns**, we must use a **table based** constraint to define our foreign key:

```sql
CREATE TABLE telephone (
  employee INTEGER,
  phone TEXT,
  PRIMARY KEY (employee, phone)
);

CREATE TABLE call (
  id INTEGER PRIMARY KEY,
  employee INTEGER,
  phone INTEGER,
  when DATE,
  caller INTEGER,
  FOREIGN KEY (employee, phone) REFERENCES telephone (employee, phone)
);
```

---

# Example

We can also ommit the referenced columns if they are the primary keys:

```sql
CREATE TABLE telephone (
  employee INTEGER,
  phone TEXT,
  PRIMARY KEY (employee, phone)
);

CREATE TABLE call (
  id INTEGER PRIMARY KEY,
  employee INTEGER,
  phone INTEGER,
  when DATE,
  caller INTEGER,
  FOREIGN KEY (employee, phone) REFERENCES telephone
);
```

---

# Deleting Referenced Values

* Declaring a foreign key means that values in one table must also appear in the referenced column.
* When a line having values referencing it is deleted, 5 different things can occur:
  * Nothing happens.
  * An **error** is thrown.
  * The referencing values becomes **NULL**.
  * The referencing values becomes the default value of the column.
  * All referencing **lines are deleted** (careful! this might cause a cascade effect).

---

# Updating Referenced Values

* The same problem happens when we update a line that is referenced by another column.
* When a line having values referencing it is updated, three different things can occur:
  * Nothing happens.
  * An **error** is thrown.
  * The referencing values becomes **NULL**.
  * The referencing values becomes the default value of the column.
  * All referencing **lines are deleted** (careful! this might cause a cascade effect).
  
---

# On Delete and On Update

To define the desired behavior, we should use the **ON DELETE** and **ON UPDATE** clauses with one of five possible values: 
  * **NO ACTION** (can lead to inconsistency, but can be used to deactivate the default behaviour and specify custom code for the event)
  * **RESTRICT** (throws an error)
  * **SET NULL** (values become null)
  * **SET DEFAULT** (value becomes the default value specified for the column)
  * **CASCADE** (lines are deletes or values updated)

.box_info[RESTRICT is the default value.]

---

# On Delete and On Update

```sql
CREATE TABLE <table_A> (
  <column_A> <data_type> PRIMARY KEY,
  <column_B> <data_type>,
  ...
  <column_C> <data_type>
);

CREATE TABLE <table_B> (
  <column_X> <data_type> PRIMARY KEY,
  <column_Y> <data_type>,
  ...
  <column_Z> <data_type> REFERENCES <table_A>(<column_A>)
    ON DELETE SET NULL ON UPDATE CASCADE
);
```

---

# Example

```sql
CREATE TABLE employee (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  address TEXT,
  birthdate DATE,
  salary NUMERIC 
    CONSTRAINT minimum_wage CHECK (salary > 500),
  taxes NUMERIC,
  card_number INTEGER 
    UNIQUE
    DEFAULT 0 CHECK (card_number >= 0),
  active INTEGER DEFAULT 1,
  department_id INTEGER REFERENCES department
    ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT taxes_lower_salary CHECK (taxes < salary)
);
```

.box_info.small[If a department with id 1 is deleted, all employess with department id equal to 1 will start having a null department number.]

.box_info.small[If a department with id 1 is updated to id 2, all employess with department id equal to 1 will start having a department number equal to 2.]

---
class: middle, center
template: inverse
name: sequences
# Sequences

---

# Sequences

* A sequence is a special kind of database object designed for generating unique numeric identifiers.
* They ensure that a different value is generated for every client.

---

# Sequences

```sql
CREATE SEQUENCE <name>;
```

Get the next and the current value of the sequence.

```sql
SELECT nextval('<name>');
SELECT currval('<name>');
```

Getting the current value only works if called after calling nextval and in the same transaction.

---

# The AUTOINCREMENT type

The data type `AUTOINCREMENT` is not a true type, but merely a notational convenience for setting up unique identifier columns.

```sql
CREATE TABLE <tablename> (
    <colname> INTEGER AUTOINCREMENT
);
```

Is equivalent to:

```sql
CREATE SEQUENCE <tablename_colname_seq>;
CREATE TABLE <tablename> (
    <colname> INTEGER DEFAULT nextval('<tablename_colname_seq>') NOT NULL
);
```

---

# Example

```sql
CREATE TABLE category (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT
)

CREATE TABLE product (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT,
  cat_id INTEGER REFERENCES category
);

INSERT INTO category VALUES(DEFAULT, 'Fruits');
INSERT INTO products VALUES(DEFAULT, 'Lemon', currval('category_id_seq'));
```

---

# References

- Original slides by André Restivo with examples designed for PostgreSQL available [here](https://web.fe.up.pt/~arestivo/presentation/sql-ddl/#1). These are mostly slides, but tweaked for SQlite instead of PostgreSQL.
- SQLite Datatypes [Webpage](https://www.sqlite.org/datatype3.html#affinity_name_examples)
- SQLite Date Functions [Webpage](https://www.sqlite.org/lang_datefunc.html)


{% endraw %}
{% endhighlight %}