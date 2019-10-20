-- credits: André Restivo https://web.fe.up.pt/~arestivo

CREATE TABLE party (
  acronym VARCHAR PRIMARY KEY,    -- e.g. LP
  name VARCHAR NOT NULL UNIQUE    -- e.g. Left Party
);

CREATE TABLE municipality (
  cod INTEGER PRIMARY KEY AUTOINCREMENT,
  designation VARCHAR NOT NULL UNIQUE,            -- e.g. Porto 
  blank INTEGER DEFAULT 0 CHECK (blank >= 0),     -- Number of blank votes
  spoiled INTEGER DEFAULT 0 CHECK (spoiled >= 0)  -- Number of spoiled (null) votes
);

CREATE TABLE elector (
  en INTEGER PRIMARY KEY AUTOINCREMENT,                          -- Elector number
  name VARCHAR NOT NULL,
  age INTEGER NOT NULL CHECK (age >= 18),
  gender CHAR(1) NOT NULL CHECK (gender IN ('M', 'F')),
  cod INTEGER NOT NULL REFERENCES municipality,   -- Municipality where this 
                                                  -- elector votes
  voted BOOLEAN NOT NULL DEFAULT 'F'              -- Did he/she vote
);

CREATE TABLE candidate (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR NOT NULL,
  age INTEGER NOT NULL CHECK (age >= 18),
  gender CHAR(1) NOT NULL CHECK (gender IN ('M', 'F')),
  cod INTEGER NOT NULL REFERENCES municipality,        -- Municipality to which 
                                                       -- he/she is a candidate
  votes INTEGER NOT NULL DEFAULT 0 CHECK (votes >= 0), -- Obtained votes
  acronym VARCHAR NOT NULL REFERENCES party,           -- Candidate party
  UNIQUE (cod, acronym)
);

INSERT INTO municipality VALUES (1, 'Porto', 0, 1);
INSERT INTO municipality VALUES (2, 'Lisboa', 0, 1);
INSERT INTO municipality VALUES (3, 'Gaia', 2, 2);
INSERT INTO municipality VALUES (4, 'Coimbra', 2, 2);
INSERT INTO municipality VALUES (5, 'Nowhere', 0, 0);

INSERT INTO party VALUES ('LP', 'Left Party');
INSERT INTO party VALUES ('RP', 'Right Party');
INSERT INTO party VALUES ('MP', 'Middle Party');
INSERT INTO party VALUES ('NCP', 'No Cause Party');

INSERT INTO candidate VALUES (1, 'Sara Barbosa', 56, 'F', 2, 2, 'RP');
INSERT INTO candidate VALUES (3, 'Leonor Leal', 70, 'M', 4, 3, 'RP');
INSERT INTO candidate VALUES (5, 'Miguel Moreira', 34, 'F', 3, 3, 'LP');
INSERT INTO candidate VALUES (6, 'Goncalo Ferreira', 32, 'F', 4, 2, 'MP');
INSERT INTO candidate VALUES (8, 'Lara Barros', 40, 'M', 2, 5, 'LP');
INSERT INTO candidate VALUES (9, 'Mariana Azevedo', 63, 'M', 3, 0, 'RP');
INSERT INTO candidate VALUES (10, 'Joao Cunha', 39, 'F', 2, 4, 'MP');
INSERT INTO candidate VALUES (11, 'Rita Castro', 52, 'F', 3, 4, 'MP');

INSERT INTO elector VALUES (1, 'Beatriz Amorim', 49, 'M', 3, false);
INSERT INTO elector VALUES (2, 'Miguel Jesus', 20, 'F', 4, true);
INSERT INTO elector VALUES (3, 'Rodrigo Henriques', 41, 'F', 1, false);
INSERT INTO elector VALUES (4, 'Goncalo Mota', 73, 'M', 2, true);
INSERT INTO elector VALUES (5, 'Rafael Antunes', 23, 'M', 4, true);
INSERT INTO elector VALUES (6, 'Mariana Miranda', 41, 'F', 4, true);
INSERT INTO elector VALUES (7, 'Madalena Figueiredo', 52, 'M', 3, true);
INSERT INTO elector VALUES (8, 'Lara Amorim', 23, 'M', 2, true);
INSERT INTO elector VALUES (9, 'Leonor Almeida', 42, 'F', 1, true);
INSERT INTO elector VALUES (10, 'Francisca Loureiro', 69, 'F', 2, true);
INSERT INTO elector VALUES (11, 'Ines Mendes', 30, 'M', 1, true);
INSERT INTO elector VALUES (12, 'Sofia Coelho', 79, 'M', 1, false);
INSERT INTO elector VALUES (13, 'Santiago Costa', 43, 'F', 2, false);
INSERT INTO elector VALUES (14, 'Andre Lima', 30, 'M', 2, true);
INSERT INTO elector VALUES (15, 'Maria Brito', 48, 'M', 1, true);
INSERT INTO elector VALUES (16, 'Gabriel Gomes', 66, 'M', 4, true);
INSERT INTO elector VALUES (17, 'Margarida Costa', 61, 'M', 2, false);
INSERT INTO elector VALUES (18, 'Joao Machado', 53, 'M', 3, true);
INSERT INTO elector VALUES (19, 'Maria Matos', 51, 'M', 3, true);
INSERT INTO elector VALUES (20, 'Maria Guerreiro', 33, 'M', 3, true);
INSERT INTO elector VALUES (21, 'David Almeida', 55, 'F', 4, true);
INSERT INTO elector VALUES (22, 'Rafael Leite', 41, 'M', 1, true);