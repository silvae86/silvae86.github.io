-- credits: André Restivo https://web.fe.up.pt/~arestivo

CREATE TABLE client (
  nif integer PRIMARY KEY,
  name varchar
);

CREATE TABLE vehicle (
  plate varchar PRIMARY KEY,
  make varchar,
  nif integer NOT NULL REFERENCES client
);

CREATE TABLE spot (           -- represents a parking spot
  number serial PRIMARY KEY,
  floor integer
);

CREATE TABLE parking (
  ref serial PRIMARY KEY,
  day date,                  -- the day in which the car parked
  entry time,                -- entry time
  exit time,                 -- exit time
  number integer NOT NULL REFERENCES spot,   -- where did it park
  plate varchar NOT NULL REFERENCES vehicle  -- which car parked
);


INSERT INTO client
  VALUES (1231, 'Pearl Vance');
INSERT INTO client
  VALUES (1232, 'Nita Daubney');
INSERT INTO client
  VALUES (1233, 'Mariabella Witherspoon');
INSERT INTO client
  VALUES (1234, 'Eldred Alvey');
INSERT INTO client
  VALUES (1235, 'Cherry Owston');
INSERT INTO client
  VALUES (1236, 'Allycia Reynell');
INSERT INTO client
  VALUES (1237, 'Rosemarie Bloxam');
INSERT INTO client
  VALUES (1238, 'Serenity Holmwood');
INSERT INTO client
  VALUES (1239, 'Malcom Millward');

INSERT INTO vehicle
  VALUES ('JS-12-34', 'Honda', 1231);
INSERT INTO vehicle
  VALUES ('34-JS-65', 'Mercedes', 1231);
INSERT INTO vehicle
  VALUES ('54-MT-97', 'Fiat', 1232);
INSERT INTO vehicle
  VALUES ('43-MT-12', 'Fiat', 1232);
INSERT INTO vehicle
  VALUES ('MT-43-32', 'Volvo', 1232);
INSERT INTO vehicle
  VALUES ('11-45-MA', 'Ford', 1233);
INSERT INTO vehicle
  VALUES ('MA-83-28', 'Ford', 1233);
INSERT INTO vehicle
  VALUES ('58-TC-85', 'Peugeot', 1234);
INSERT INTO vehicle
  VALUES ('TC-59-99', 'Peugeot', 1234);
INSERT INTO vehicle
  VALUES ('12-TC-16', 'Lancia', 1234);
INSERT INTO vehicle
  VALUES ('MP-11-11', 'Lancia', 1235);
INSERT INTO vehicle
  VALUES ('BS-87-16', 'Nissan', 1236);
INSERT INTO vehicle
  VALUES ('13-73-BS', 'Toyota', 1236);
INSERT INTO vehicle
  VALUES ('CP-53-73', 'Ferrari', 1237);
INSERT INTO vehicle
  VALUES ('84-RM-65', 'Citroen', 1238);
INSERT INTO vehicle
  VALUES ('27-FM-62', 'Volkswagen', 1239);

INSERT INTO spot
  VALUES (DEFAULT, 1);
INSERT INTO spot
  VALUES (DEFAULT, 1);
INSERT INTO spot
  VALUES (DEFAULT, 1);
INSERT INTO spot
  VALUES (DEFAULT, 1);
INSERT INTO spot
  VALUES (DEFAULT, 1);
INSERT INTO spot
  VALUES (DEFAULT, 1);

INSERT INTO spot
  VALUES (DEFAULT, 2);
INSERT INTO spot
  VALUES (DEFAULT, 2);
INSERT INTO spot
  VALUES (DEFAULT, 2);
INSERT INTO spot
  VALUES (DEFAULT, 2);
INSERT INTO spot
  VALUES (DEFAULT, 2);

INSERT INTO spot
  VALUES (DEFAULT, 3);
INSERT INTO spot
  VALUES (DEFAULT, 3);
INSERT INTO spot
  VALUES (DEFAULT, 3);

INSERT INTO spot
  VALUES (DEFAULT, 4);
INSERT INTO spot
  VALUES (DEFAULT, 4);

INSERT INTO parking
  VALUES (DEFAULT, '2010-01-01', '10:00', '12:41', 1, '27-FM-62');
INSERT INTO parking
  VALUES (DEFAULT, '2010-01-01', '15:34', '18:45', 2, '27-FM-62');
INSERT INTO parking
  VALUES (DEFAULT, '2010-01-01', '10:19', '22:42', 3, 'JS-12-34');
INSERT INTO parking
  VALUES (DEFAULT, '2010-01-01', '11:37', '18:15', 4, 'CP-53-73');
INSERT INTO parking
  VALUES (DEFAULT, '2010-01-01', '07:32', '09:41', 5, 'TC-59-99');
INSERT INTO parking
  VALUES (DEFAULT, '2010-01-02', '10:45', '15:43', 1, '84-RM-65');
INSERT INTO parking
  VALUES (DEFAULT, '2010-01-02', '10:14', '12:36', 2, 'BS-87-16');
INSERT INTO parking
  VALUES (DEFAULT, '2010-01-02', '09:49', '12:58', 3, '12-TC-16');
INSERT INTO parking
  VALUES (DEFAULT, '2010-01-02', '11:51', '14:34', 4, '58-TC-85');
INSERT INTO parking
  VALUES (DEFAULT, '2010-01-02', '10:33', '12:35', 5, 'MA-83-28');
INSERT INTO parking
  VALUES (DEFAULT, '2010-01-02', '11:14', '16:34', 8, 'MT-43-32');
INSERT INTO parking
  VALUES (DEFAULT, '2010-01-02', '17:44', '18:54', 12, '43-MT-12');
INSERT INTO parking
  VALUES (DEFAULT, '2010-01-02', '10:22', '14:43', 13, '54-MT-97');
INSERT INTO parking
  VALUES (DEFAULT, '2010-01-03', '09:01', '14:37', 1, '27-FM-62');
INSERT INTO parking
  VALUES (DEFAULT, '2010-01-03', '13:45', '21:11', 2, '84-RM-65');
INSERT INTO parking
  VALUES (DEFAULT, '2010-01-03', '08:23', '15:55', 6, 'CP-53-73');
INSERT INTO parking
  VALUES (DEFAULT, '2010-01-03', '11:53', '14:11', 7, 'MP-11-11');
INSERT INTO parking
  VALUES (DEFAULT, '2010-01-03', '06:46', '08:26', 8, '12-TC-16');
INSERT INTO parking
  VALUES (DEFAULT, '2010-01-03', '09:39', '17:15', 10, 'MA-83-28');
INSERT INTO parking
  VALUES (DEFAULT, '2010-01-03', '07:25', '08:12', 11, '43-MT-12');
INSERT INTO parking
  VALUES (DEFAULT, '2010-01-03', '09:16', '11:21', 12, '43-MT-12');
INSERT INTO parking
  VALUES (DEFAULT, '2010-01-03', '11:21', '13:42', 13, '34-JS-65');
INSERT INTO parking
  VALUES (DEFAULT, '2010-01-03', '14:47', '18:12', 14, '34-JS-65');