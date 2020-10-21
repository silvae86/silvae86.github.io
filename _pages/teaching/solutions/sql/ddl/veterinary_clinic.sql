-- Solution proposal by @zeornelas on github

-- Assuming the library is compiled with foreign key constraints enabled, it must still be enabled by the application at runtime
PRAGMA foreign_keys = ON;

CREATE TABLE breed (
    name text PRIMARY KEY
);

CREATE TABLE condition (
    name text PRIMARY KEY,
    s_name text NOT NULL UNIQUE
);

CREATE TABLE owner (
    id integer PRIMARY KEY AUTOINCREMENT,
    name text NOT NULL,
    address text,
    phone_no integer
);

CREATE TABLE physician (
    id integer PRIMARY KEY AUTOINCREMENT,
    name text NOT NULL,
    address text,
    phone_no text
);

CREATE TABLE animal (
  id integer PRIMARY KEY AUTOINCREMENT,
  name text NOT NULL,
  breed text NOT NULL REFERENCES breed,
  owner integer REFERENCES owner
);

CREATE TABLE appointment (
    id integer PRIMARY KEY AUTOINCREMENT,
    date  text NOT NULL,
    time text NOT NULL,
    animal integer NOT NULL REFERENCES animal,
    physician integer NOT NULL REFERENCES physician
);

CREATE TABLE conditionsIdentified (
    condition text REFERENCES condition,
    appointment integer REFERENCES appointment,
    PRIMARY KEY(condition, appointment)
);

CREATE TABLE BreedConditions (
    breed text REFERENCES breed,
    condition text REFERENCES condition,
    PRIMARY KEY(breed, condition)
);