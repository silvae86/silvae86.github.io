-- Solution proposal by @zeornelas on github

-- Assuming the library is compiled with foreign key constraints enabled, it must still be enabled by the application at runtime
PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS center;
DROP TABLE IF EXISTS courier;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS package;
DROP TABLE IF EXISTS InternalTracking;

CREATE TABLE center (
    id integer PRIMARY KEY AUTOINCREMENT,
    name text NOT NULL UNIQUE,
    address text NOT NULL UNIQUE
);

CREATE TABLE courier (
    id integer PRIMARY KEY AUTOINCREMENT,
    name text NOT NULL,
    vat integer NOT NULL UNIQUE,
    phone text NOT NULL,
    delivery_center integer NOT NULL REFERENCES center
);

CREATE TABLE customer (
    id integer PRIMARY KEY AUTOINCREMENT,
    name text NOT NULL,
    vat integer NOT NULL UNIQUE,
    phone text NOT NULL,
    address text NOT NULL,
    delivery_center integer NOT NULL REFERENCES center
);

CREATE TABLE package (
    id integer PRIMARY KEY AUTOINCREMENT,
    weight integer NOT NULL CHECK (weight > 0),
    urgency text NOT NULL CHECK (urgency = "normal" OR urgency = "urgent"),
    dropoff_point integer NOT NULL REFERENCES center,
    sender integer NOT NULL REFERENCES customer,
    recipient integer NOT NULL REFERENCES customer,
    courier integer NOT NULL REFERENCES courier
);

CREATE TABLE InternalTracking (
    package integer REFERENCES package,
    delivery_center integer REFERENCES center,
    date_time_of_arrival text,
    date_time_of_departure text NOT NULL,
    PRIMARY KEY(package, delivery_center),
    CHECK(datetime(date_time_of_arrival) >= datetime(date_time_of_departure) OR date_time_of_arrival IS NULL)
);