-- credits: André Restivo https://web.fe.up.pt/~arestivo

CREATE TABLE patient (
	code varchar PRIMARY KEY,
	name varchar,
	address varchar
);
 
CREATE TABLE physician (
	number varchar PRIMARY KEY,
	name varchar,
	address varchar
);
 
CREATE TABLE condition (
	ref integer PRIMARY KEY,
	designation varchar
);
 
CREATE TABLE appointment (
	num integer PRIMARY KEY,
	date date,
	room integer,
	number varchar REFERENCES physician,
	code varchar REFERENCES patient
);
 
CREATE TABLE diagnosed (
	ref integer REFERENCES condition,
	num integer REFERENCES appointment,
	PRIMARY KEY (ref, num)
);
 
INSERT INTO physician VALUES ('99030', 'Luca Moore', '16 Victoria Road');
INSERT INTO physician VALUES ('12312', 'Tommy Cooke', '47 Bootham Terrace');
INSERT INTO physician VALUES ('43642', 'Joshua Bailey', '95 Nottingham Rd');
 
INSERT INTO patient VALUES ('12345', 'Xander Gibbs', '45 Petworth Rd');
INSERT INTO patient VALUES ('45643', 'Tatiana Barber', '16 Vicar Lane');
INSERT INTO patient VALUES ('23613', 'Amelie Harrison', '32 Thompsons Lane');
INSERT INTO patient VALUES ('74927', 'Kathryn Savege', '67 Cosworth Rd');
 
INSERT INTO appointment VALUES (456, '2007-01-01', 190, '99030', '12345');
INSERT INTO appointment VALUES (457, '2007-01-01', 187, '99030', '12345');
INSERT INTO appointment VALUES (458, '2007-01-01', 190, '12312', '23613');
INSERT INTO appointment VALUES (459, '2007-01-01', 190, '99030', '45643');
INSERT INTO appointment VALUES (460, '2007-01-01', 187, '99030', '45643');
INSERT INTO appointment VALUES (461, '2007-01-01', 187, '12312', '12345');
INSERT INTO appointment VALUES (462, '2007-01-01', 204, '12312', '23613');
INSERT INTO appointment VALUES (463, '2007-01-01', 187, '99030', '45643');
INSERT INTO appointment VALUES (464, '2007-01-02', 190, '12312', '12345');
INSERT INTO appointment VALUES (465, '2007-01-02', 190, '12312', '45643');
INSERT INTO appointment VALUES (466, '2007-01-03', 190, '43642', '12345');
INSERT INTO appointment VALUES (467, '2007-01-03', 190, '99030', '12345');
INSERT INTO appointment VALUES (468, '2007-01-03', 190, '43642', '74927');
 
INSERT INTO condition VALUES (1, 'Wizard Plague');
INSERT INTO condition VALUES (2, 'Arachnid Hepatitis');
INSERT INTO condition VALUES (3, 'Anxious Sleepwalking');
 
INSERT INTO diagnosed (num, ref) VALUES (456, 1);
INSERT INTO diagnosed (num, ref) VALUES (456, 2);
INSERT INTO diagnosed (num, ref) VALUES (457, 2);
INSERT INTO diagnosed (num, ref) VALUES (457, 3);
INSERT INTO diagnosed (num, ref) VALUES (458, 3);
INSERT INTO diagnosed (num, ref) VALUES (459, 2);
INSERT INTO diagnosed (num, ref) VALUES (460, 2);
INSERT INTO diagnosed (num, ref) VALUES (460, 3);
INSERT INTO diagnosed (num, ref) VALUES (460, 1);
INSERT INTO diagnosed (num, ref) VALUES (461, 2);
INSERT INTO diagnosed (num, ref) VALUES (462, 3);
INSERT INTO diagnosed (num, ref) VALUES (463, 1);
INSERT INTO diagnosed (num, ref) VALUES (464, 2);
INSERT INTO diagnosed (num, ref) VALUES (464, 3);
INSERT INTO diagnosed (num, ref) VALUES (465, 1);
INSERT INTO diagnosed (num, ref) VALUES (466, 3);
INSERT INTO diagnosed (num, ref) VALUES (467, 2);