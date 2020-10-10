-- Solution proposal by @zeornelas on github

-- Assuming the library is compiled with foreign key constraints enabled, it must still be enabled by the application at runtime
PRAGMA foreign_keys = ON;

CREATE TABLE breed (
    name varchar PRIMARY KEY
);

CREATE TABLE condition (
    name varchar PRIMARY KEY
);

CREATE TABLE owner (
    id integer PRIMARY KEY,
    name varchar NOT NULL,
    address varchar,
    phone_no varchar
);

CREATE TABLE physician (
    id integer PRIMARY KEY,
    name varchar NOT NULL,
    address varchar,
    phone_no varchar
);

CREATE TABLE animal (
  id integer PRIMARY KEY,
  name varchar NOT NULL,
  breed varchar REFERENCES breed,
  owner integer REFERENCES owner
);

CREATE TABLE appointment (
    id integer PRIMARY KEY,
    date DATE NOT NULL,
    time TIME NOT NULL,
    animal integer NOT NULL REFERENCES animal,
    physician integer NOT NULL REFERENCES physician
);

CREATE TABLE conditionsIdentified (
    condition varchar REFERENCES condition,
    appointment integer REFERENCES appointment,
    PRIMARY KEY(condition, appointment)
);

CREATE TABLE BreedConditions (
    breed varchar REFERENCES breed,
    condition varchar REFERENCES condition,
    PRIMARY KEY(breed, condition)
);