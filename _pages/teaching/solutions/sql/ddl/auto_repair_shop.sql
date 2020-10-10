-- Assuming the library is compiled with foreign key constraints enabled, it must still be enabled by the application at runtime
PRAGMA foreign_keys = ON;

CREATE TABLE person (
    id integer PRIMARY KEY,
    name varchar NOT NULL,
    address varchar
);

CREATE TABLE employee (
    id integer REFERENCES person,
    PRIMARY KEY(id)
);

CREATE TABLE owner (
    id integer REFERENCES person,
    phone varchar,
    PRIMARY KEY(id)
);

CREATE TABLE make (
    name varchar PRIMARY KEY
);

CREATE TABLE model (
    id integer PRIMARY KEY,
    name varchar NOT NULL,
    make varchar NOT NULL REFERENCES make
);

CREATE TABLE car (
    plate varchar PRIMARY KEY,
    color varchar NOT NULL,
    owner integer NOT NULL REFERENCES owner,
    model integer NOT NULL REFERENCES model
);

CREATE TABLE partCategory (
    id integer PRIMARY KEY,
    name varchar NOT NULL
);

CREATE TABLE part (
    id integer PRIMARY KEY,
    serial_no integer NOT NULL,
    price integer NOT NULL CHECK(price > 0),
    category integer NOT NULL REFERENCES partCategory
);

CREATE TABLE modelParts (
    car_model integer REFERENCES model,
    category integer REFERENCES partCategory,
    PRIMARY KEY(car_model, category)
);

CREATE TABLE service (
    id integer PRIMARY KEY,
    km integer,
    hours_spent integer CHECK(hours_spent >= 1),
    adm_date DATE NOT NULL,
    finish_date DATE CHECK(strftime('%s', finish_date) >= strftime('%s', adm_date) OR finish_date IS NULL),
    employee integer NOT NULL REFERENCES employee,
    car integer NOT NULL REFERENCES car
);

CREATE TABLE partsInService (
    partId integer REFERENCES part,
    serviceId integer REFERENCES service,
    quantity integer NOT NULL CHECK(quantity > 0),
    PRIMARY KEY(partId, serviceId)
);