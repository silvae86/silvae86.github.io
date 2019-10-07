--
-- File generated with SQLiteStudio v3.2.1 on Mon Oct 7 15:41:43 2019
--
-- Text encoding used: UTF-8
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: animals
DROP TABLE IF EXISTS animals;
CREATE TABLE animals(
	id integer primary key autoincrement,
	name text,
	breed text not null references breeds,
	owner not null references owners
);
INSERT INTO animals (id, name, breed, owner) VALUES (1, 'Tareco', 'Golden Retriever', 1);

-- Table: appointments
DROP TABLE IF EXISTS appointments;
CREATE TABLE appointments (id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT NOT NULL, time INTEGER NOT NULL, animal CONSTRAINT appointments_animals_fk REFERENCES animals (id) NOT NULL, price REAL CHECK (price > 0));

-- Table: breeds
DROP TABLE IF EXISTS breeds;
CREATE TABLE breeds(
	name text primary key
);
INSERT INTO breeds (name) VALUES ('Golden Retriever');

-- Table: conditions
DROP TABLE IF EXISTS conditions;
CREATE TABLE conditions (name TEXT PRIMARY KEY);

-- Table: conditionsIdentified
DROP TABLE IF EXISTS conditionsIdentified;
CREATE TABLE conditionsIdentified (condition TEXT REFERENCES conditions (name), appointment INTEGER REFERENCES appointments (id), PRIMARY KEY (condition, appointment));

-- Table: owners
DROP TABLE IF EXISTS owners;
CREATE TABLE owners(
	id integer primary key autoincrement,
	name text not null,
	address text,
	phone_no text
);
INSERT INTO owners (id, name, address, phone_no) VALUES (1, 'José Pires', 'Rua das Flores', '9191919191');

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
