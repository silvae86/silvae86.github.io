-- Solution proposal by @zeornelas on github

-- Assuming the library is compiled with foreign key constraints enabled, it must still be enabled by the application at runtime
PRAGMA foreign_keys = ON;


CREATE TABLE client (
    id integer PRIMARY KEY AUTOINCREMENT,
    nin integer NOT NULL UNIQUE,
    tin integer NOT NULL UNIQUE,
    name text NOT NULL,
    address text NOT NULL
);

CREATE TABLE store (
    name text PRIMARY KEY,
    address text NOT NULL
);

CREATE TABLE bicycleModel (
    name text PRIMARY KEY,
    type text NOT NULL CHECK (type = "bmx" OR type = "mountain" OR type = "road" OR type = "hybrid"),
    no_gears integer NOT NULL CHECK(no_gears >= 1)
);

CREATE TABLE bicycle (
    number integer PRIMARY KEY AUTOINCREMENT,
    model text NOT NULL REFERENCES bicycleModel
);

CREATE TABLE reservation (
    id integer PRIMARY KEY AUTOINCREMENT,
    pickup_day text NOT NULL,
    return_day text,
    actual_rented_bike integer NOT NULL REFERENCES bicycle,
    desired_model text NOT NULL REFERENCES bicycleModel,
    pickup_place text NOT NULL REFERENCES store,
    client integer NOT NULL REFERENCES client,
    CHECK(datetime(return_day) >= datetime(pickup_day) OR return_day IS NULL)
);