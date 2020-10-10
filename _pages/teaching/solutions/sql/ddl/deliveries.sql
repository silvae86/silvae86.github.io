-- Solution proposal by @zeornelas on github

-- Assuming the library is compiled with foreign key constraints enabled, it must still be enabled by the application at runtime
PRAGMA foreign_keys = ON;

CREATE TABLE person (
    id integer PRIMARY KEY AUTOINCREMENT,
    name varchar NOT NULL,
    vat integer NOT NULL UNIQUE,
    phone varchar NOT NULL
);

CREATE TABLE center (
    id integer PRIMARY KEY AUTOINCREMENT,
    name varchar NOT NULL,
    address varchar NOT NULL
);

CREATE TABLE courier (
    id integer PRIMARY KEY REFERENCES person,
    delivery_center NOT NULL REFERENCES center
);


CREATE TABLE customer (
    id integer PRIMARY KEY REFERENCES person,
    address varchar NOT NULL,
    delivery_center NOT NULL REFERENCES center
);

CREATE TABLE package (
    id integer PRIMARY KEY AUTOINCREMENT,
    weight integer NOT NULL CHECK (weight > 0),
    urgency varchar NOT NULL CHECK (urgency = "normal" OR urgency = "urgent"),
    dropoff_point integer NOT NULL REFERENCES center,
    sender integer NOT NULL REFERENCES customer,
    recipient integer NOT NULL REFERENCES customer,
    courier integer NOT NULL REFERENCES courier
);

CREATE TABLE InternalTracking (
    package integer REFERENCES package,
    delivery_center integer REFERENCES center,
    date_time_of_arrival DATETIME,
    date_time_of_departure DATE NOT NULL,
    CHECK(date_time_of_arrival >= date_time_of_departure OR date_time_of_arrival IS NULL)
);