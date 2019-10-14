-- credits: André Restivo https://web.fe.up.pt/~arestivo

CREATE TABLE department (
  id integer PRIMARY KEY,      -- department id
  name varchar NOT NULL UNIQUE,-- department name
  id_dir integer               -- department director employee id 
);
 
CREATE TABLE employee (
  id integer PRIMARY KEY,-- employee id
  name varchar NOT NULL, -- employee name
  salary numeric (6,2),  -- employee salary
  id_dep integer REFERENCES department NOT NULL,-- the department where he works
  id_sup integer REFERENCES employee             -- his superior
);
 
-- this foreign key has to be created separately due to a circular dependency
ALTER TABLE department ADD CONSTRAINT dir_dep_fk 
FOREIGN KEY (id_dir) REFERENCES employee ON DELETE SET NULL;
 
CREATE TABLE project (
  id integer PRIMARY KEY,       -- project id
  name varchar NOT NULL UNIQUE, -- project name
  id_dep integer REFERENCES department-- the department that controls the project
);
 
CREATE TABLE works (
  id_emp integer REFERENCES employee,-- this employee
  id_pro integer REFERENCES project, -- works in this project
  hours integer NOT NULL,            -- hours per week
  PRIMARY KEY (id_emp, id_pro)
);
 
INSERT INTO department VALUES (1, 'Logistics');
INSERT INTO department VALUES (2, 'Transports');
INSERT INTO department VALUES (3, 'Cleaning');
INSERT INTO department VALUES (4, 'Human Resources');
INSERT INTO department VALUES (5, 'Informatics');
 
INSERT INTO employee VALUES (1, 'John'     , 1500, 1, NULL);
INSERT INTO employee VALUES (2, 'Mike'     , 1200, 1, 1);
INSERT INTO employee VALUES (3, 'John'     , 1300, 1, 1);
INSERT INTO employee VALUES (4, 'Theresa'  , 1500, 2, NULL);
INSERT INTO employee VALUES (5, 'Charles'  , 1100, 2, 4);
INSERT INTO employee VALUES (6, 'Mary'     , 1000, 2, 4);
INSERT INTO employee VALUES (7, 'Beatrice' ,  800, 2, 4);
INSERT INTO employee VALUES (8, 'Brett'    , 1700, 3, NULL);
INSERT INTO employee VALUES (9, 'Alfred'   , 1200, 3, 8);
INSERT INTO employee VALUES (10, 'Barry'   , 1300, 3, 8);
INSERT INTO employee VALUES (11, 'Carrie'  , 1100, 3, 10);
INSERT INTO employee VALUES (12, 'Thomas'  , 1900, 3, 10);
INSERT INTO employee VALUES (13, 'Emily'   , 1200, 4, NULL);
INSERT INTO employee VALUES (14, 'Megan'   , 1600, 4, 13);
INSERT INTO employee VALUES (15, 'Sarah'   , 1200, 5, NULL);
INSERT INTO employee VALUES (16, 'William' , 1400, 5, 15);
INSERT INTO employee VALUES (17, 'James'   , 1100, 5, 15);
INSERT INTO employee VALUES (18, 'Harry'   , 1000, 5, 16);
INSERT INTO employee VALUES (19, 'Matthew' ,  500, 5, 16);
INSERT INTO employee VALUES (20, 'Kate'    ,  500, 5, 17);
 
UPDATE department SET id_dir = 1 WHERE id = 1;
UPDATE department SET id_dir = 4 WHERE id = 2;
UPDATE department SET id_dir = 8 WHERE id = 3;
UPDATE department SET id_dir = 13 WHERE id = 4;
UPDATE department SET id_dir = 15 WHERE id = 5;
 
INSERT INTO project VALUES (1, 'XPTO', 1);
INSERT INTO project VALUES (2, 'YPTO', 2);
INSERT INTO project VALUES (3, 'ZPTO', 5);
 
INSERT INTO works VALUES (1,  1, 4);
INSERT INTO works VALUES (2,  1, 3);
INSERT INTO works VALUES (5,  1, 4);
INSERT INTO works VALUES (7,  1, 2);
INSERT INTO works VALUES (10, 1, 1);
INSERT INTO works VALUES (11, 1, 7);
INSERT INTO works VALUES (13, 1, 3);
INSERT INTO works VALUES (14, 1, 3);
INSERT INTO works VALUES (20, 1, 6);
 
INSERT INTO works VALUES (1,  2, 8);
INSERT INTO works VALUES (2,  2, 7);
INSERT INTO works VALUES (3,  2, 7);
INSERT INTO works VALUES (4,  2, 2);
INSERT INTO works VALUES (6,  2, 3);
INSERT INTO works VALUES (11, 2, 2);
INSERT INTO works VALUES (12, 2, 1);
INSERT INTO works VALUES (14, 2, 3);
INSERT INTO works VALUES (15, 2, 5);
INSERT INTO works VALUES (17, 2, 4);
 
INSERT INTO works VALUES (5,  3, 6);
INSERT INTO works VALUES (12, 3, 3);
INSERT INTO works VALUES (17, 3, 1);
INSERT INTO works VALUES (18, 3, 2);
