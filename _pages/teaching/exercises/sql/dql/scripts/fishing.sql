-- credits: André Restivo https://web.fe.up.pt/~arestivo

-- Different kinds of fish
CREATE TABLE fish (
  ref AUTOINCREMENT PRIMARY KEY,
  name VARCHAR NOT NULL UNIQUE,         -- name of the species
  average_weight NUMERIC(4,1) NOT NULL, -- average weight in kg
  price NUMERIC(3,1) NOT NULL           -- price on the market per kg
);

-- Boats on the fleet
CREATE TABLE boat (
  id AUTOINCREMENT PRIMARY KEY,
  name VARCHAR NOT NULL,                -- name of the boat
  max_weight INTEGER NOT NULL,          -- max weight of fish it can carry
  crew INTEGER NOT NULL,                -- max number of fishermen
  length NUMERIC(3,1) NOT NULL          -- length of the boat in meters
);

-- Fishermen
CREATE TABLE fisherman (
  cod AUTOINCREMENT PRIMARY KEY,
  name VARCHAR NOT NULL,                -- name of the fisherman
  city VARCHAR NOT NULL,                -- city of origin
  age INTEGER NOT NULL                  -- age of the fisherman
);

-- Fishing trips
CREATE TABLE trip (
  num AUTOINCREMENT PRIMARY KEY,
  date DATE NOT NULL,                   -- date of the trip
  time TIME NOT NULL,                   -- time of departure
  duration INTEGER NOT NULL,            -- duration in hours
  id INTEGER NOT NULL REFERENCES boat   -- boat used on the trip
);

-- What fishermen went on each trip
CREATE TABLE went (
  cod INTEGER REFERENCES fisherman,     -- this fishermen
  num INTEGER REFERENCES trip,          -- went on this trip
  PRIMARY KEY (cod, num)
);

-- Fishes caught on a trip
CREATE TABLE caught (
  num INTEGER REFERENCES trip,          -- on this trip
  ref INTEGER REFERENCES fish,          -- this species was caught
  weight INTEGER NOT NULL,              -- and the total weighted this much
  PRIMARY KEY (num, ref)
);

INSERT INTO fish VALUES (1, 'Anchovy', 0.2, 5);
INSERT INTO fish VALUES (2, 'Catfish', 18.5, 6);
INSERT INTO fish VALUES (3, 'Dorade', 3.5, 12.5);
INSERT INTO fish VALUES (4, 'Herring', 1.2, 7.5);
INSERT INTO fish VALUES (5, 'Mackerel', 2, 8);
INSERT INTO fish VALUES (6, 'Salmon', 12, 15);
INSERT INTO fish VALUES (7, 'Sturgeon', 100, 12);
INSERT INTO fish VALUES (8, 'Swordfish', 200, 14.5);

INSERT INTO boat VALUES (1, 'Amerlin', 100000, 2, 10);
INSERT INTO boat VALUES (2, 'Bait Master', 20000, 3, 6);
INSERT INTO boat VALUES (3, 'Chum Lord', 50000, 3, 8);
INSERT INTO boat VALUES (4, 'Debaitable', 40000, 2, 10);
INSERT INTO boat VALUES (5, 'Fishfull Thinking', 45000, 2, 6);
INSERT INTO boat VALUES (6, 'Get Reel', 30000, 3, 8);

INSERT INTO fisherman VALUES (1, 'Mark Davis', 'Mount Ida', 52);
INSERT INTO fisherman VALUES (2, 'Michael Iaconelli', 'Philadelphia', 44);
INSERT INTO fisherman VALUES (3, 'Skeet Reese', 'Auburn', 46);
INSERT INTO fisherman VALUES (4, 'Jay Yelas', 'Auburn', 45);
INSERT INTO fisherman VALUES (5, 'Takahiro Omori', 'Tokyo', 45);
INSERT INTO fisherman VALUES (6, 'Denny Brauer', 'Seward', 66);
INSERT INTO fisherman VALUES (7, 'Rick Clunn', 'Seward', 68);
INSERT INTO fisherman VALUES (8, 'Bobby Murray', 'Mount Ida', 35);

INSERT INTO trip VALUES (1, '2017-1-1', '06:00', 2, 1);
INSERT INTO trip VALUES (2, '2017-1-1', '07:30', 1, 2);
INSERT INTO trip VALUES (3, '2017-1-1', '08:00', 1, 4);
INSERT INTO trip VALUES (4, '2017-1-2', '05:00', 4, 3);
INSERT INTO trip VALUES (5, '2017-1-2', '05:30', 6, 4);
INSERT INTO trip VALUES (6, '2017-1-2', '06:00', 2, 2);
INSERT INTO trip VALUES (7, '2017-1-2', '06:30', 3, 6);
INSERT INTO trip VALUES (8, '2017-1-3', '07:00', 4, 2);
INSERT INTO trip VALUES (9, '2017-1-3', '07:30', 5, 4);
INSERT INTO trip VALUES (10, '2017-1-4', '08:00', 1, 2);
INSERT INTO trip VALUES (11, '2017-1-4', '09:30', 1, 3);
INSERT INTO trip VALUES (12, '2017-1-5', '06:00', 3, 6);

INSERT INTO went VALUES (1, 1);
INSERT INTO went VALUES (2, 1);
INSERT INTO went VALUES (3, 2);
INSERT INTO went VALUES (4, 2);
INSERT INTO went VALUES (5, 3);
INSERT INTO went VALUES (8, 3);
INSERT INTO went VALUES (6, 4);
INSERT INTO went VALUES (5, 5);
INSERT INTO went VALUES (8, 5);
INSERT INTO went VALUES (1, 5);
INSERT INTO went VALUES (2, 6);
INSERT INTO went VALUES (4, 6);
INSERT INTO went VALUES (3, 7);
INSERT INTO went VALUES (8, 8);
INSERT INTO went VALUES (6, 8);
INSERT INTO went VALUES (5, 9);
INSERT INTO went VALUES (1, 9);
INSERT INTO went VALUES (1, 10);
INSERT INTO went VALUES (3, 10);
INSERT INTO went VALUES (4, 11);
INSERT INTO went VALUES (8, 11);
INSERT INTO went VALUES (5, 12);

INSERT INTO caught VALUES (1, 1, 10000);
INSERT INTO caught VALUES (1, 5, 20000);
INSERT INTO caught VALUES (2, 6, 15000);
INSERT INTO caught VALUES (2, 4, 25000);
INSERT INTO caught VALUES (3, 2, 8000);
INSERT INTO caught VALUES (4, 8, 7000);
INSERT INTO caught VALUES (5, 7, 12000);
INSERT INTO caught VALUES (5, 8, 1000);
INSERT INTO caught VALUES (6, 4, 3000);
INSERT INTO caught VALUES (6, 2, 5000);
INSERT INTO caught VALUES (7, 1, 8500);
INSERT INTO caught VALUES (8, 6, 9000);
INSERT INTO caught VALUES (9, 6, 13000);
INSERT INTO caught VALUES (10, 4, 4000);
INSERT INTO caught VALUES (11, 7, 5000);
INSERT INTO caught VALUES (12, 8, 20000);