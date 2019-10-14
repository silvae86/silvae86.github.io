-- credits: André Restivo https://web.fe.up.pt/~arestivo

CREATE TABLE student (
	num integer PRIMARY KEY,  -- Student number
	name varchar NOT NULL			-- Student name
);

CREATE TABLE program (
	id integer PRIMARY KEY,	  -- Program id
	name varchar NOT NULL			-- Program name (e.g. MIEIC)
);

CREATE TABLE course (
	ref integer PRIMARY KEY,		-- Course reference
	name varchar NOT NULL,			-- Course name
	id integer NOT NULL REFERENCES program
                              -- Program to which it belongs
);

CREATE TABLE enrollment (
	num integer REFERENCES student, -- This student is enrolled
	ref integer REFERENCES course,	-- in this course
	year integer,				            -- year (2007 means 2007/08)
	grade1 integer,   		 	        -- Grade after first exam
	grade2 integer, 			          -- Grade after second exam
	PRIMARY KEY (num, ref, year)     -- Students cannot enroll twice
                                  -- in the same course and year
);

INSERT INTO student VALUES (1, 'Jacob');
INSERT INTO student VALUES (2, 'William');
INSERT INTO student VALUES (3, 'Olivia');
INSERT INTO student VALUES (4, 'Alexander');
INSERT INTO student VALUES (5, 'Michael');
INSERT INTO student VALUES (6, 'Charlotte');
INSERT INTO student VALUES (7, 'Emily');
INSERT INTO student VALUES (8, 'Emma');
INSERT INTO student VALUES (9, 'Noah');
INSERT INTO student VALUES (10, 'Isabella');
INSERT INTO student VALUES (11, 'Benjamin');

INSERT INTO program VALUES(1, 'MIEEC');
INSERT INTO program VALUES(2, 'MIEIC');
INSERT INTO program VALUES(3, 'MM');

INSERT INTO course VALUES (1, 'SINF', 1);
INSERT INTO course VALUES (2, 'SIBD', 1);
INSERT INTO course VALUES (3, 'SIEM', 1);
INSERT INTO course VALUES (4, 'BDAD', 2);
INSERT INTO course VALUES (5, 'LTW',  2);
INSERT INTO course VALUES (6, 'TW',   3);

INSERT INTO enrollment VALUES (1, 1, 2007, 10, 14);
INSERT INTO enrollment VALUES (2, 1, 2007, 8, 12);
INSERT INTO enrollment VALUES (3, 1, 2007, NULL, 16);
INSERT INTO enrollment VALUES (4, 1, 2007, 14, 12);
INSERT INTO enrollment VALUES (5, 1, 2007, 15, NULL);

INSERT INTO enrollment VALUES (6, 1, 2008, 14, 14);
INSERT INTO enrollment VALUES (7, 1, 2008, 14, 12);
INSERT INTO enrollment VALUES (8, 1, 2008, 12, NULL);
INSERT INTO enrollment VALUES (9, 1, 2008, 14, 8);
INSERT INTO enrollment VALUES (10, 1, 2008, 12, 14);

INSERT INTO enrollment VALUES (1, 2, 2007, 11, NULL);
INSERT INTO enrollment VALUES (2, 2, 2007, 8, 9);
INSERT INTO enrollment VALUES (3, 2, 2007, 12, 14);
INSERT INTO enrollment VALUES (4, 2, 2007, 15, 19);
INSERT INTO enrollment VALUES (5, 2, 2007, 12, 13);
INSERT INTO enrollment VALUES (11, 2, 2007, 15, 12);

INSERT INTO enrollment VALUES (6, 2, 2008, 13, 11);
INSERT INTO enrollment VALUES (7, 2, 2008, 11, 13);
INSERT INTO enrollment VALUES (8, 2, 2008, 12, 16);
INSERT INTO enrollment VALUES (9, 2, 2008, NULL, 8);
INSERT INTO enrollment VALUES (10, 2, 2008, NULL, NULL);

INSERT INTO enrollment VALUES (6, 3, 2007, 14, 12);
INSERT INTO enrollment VALUES (2, 3, 2007, 11, 12);
INSERT INTO enrollment VALUES (4, 3, 2007, 19, NULL);
INSERT INTO enrollment VALUES (5, 3, 2007, 13, 14);
INSERT INTO enrollment VALUES (7, 3, 2007, 14, 10);
INSERT INTO enrollment VALUES (11, 3, 2007, 9, 9);

INSERT INTO enrollment VALUES (1, 3, 2008, 9, 11);
INSERT INTO enrollment VALUES (3, 3, 2008, 15, 18);
INSERT INTO enrollment VALUES (8, 3, 2008, 14, 12);
INSERT INTO enrollment VALUES (9, 3, 2008, 13, NULL);
INSERT INTO enrollment VALUES (10, 3, 2008, 12, NULL);