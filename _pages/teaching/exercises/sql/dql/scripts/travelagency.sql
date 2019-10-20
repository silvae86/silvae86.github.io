-- credits: André Restivo https://web.fe.up.pt/~arestivo
CREATE TABLE trip (
    day DATE PRIMARY KEY,
    size INTEGER NOT NULL -- how many people
);

CREATE TABLE country (
    name CHARACTER VARYING PRIMARY KEY,
    language CHARACTER VARYING,
    capital CHARACTER VARYING,
    FOREIGN KEY (capital) REFERENCES city(name)
);

CREATE TABLE city (
    name CHARACTER VARYING PRIMARY KEY,
    score INTEGER,
    country CHARACTER VARYING REFERENCES country
);

CREATE TABLE stop (
    name CHARACTER VARYING REFERENCES city,
    day DATE REFERENCES trip,
    days INTEGER,         -- number of day spent in this city
    PRIMARY KEY (name, day)
);

INSERT INTO trip VALUES ('2006-12-20', 8);
INSERT INTO trip VALUES ('2007-05-24', 12);
INSERT INTO trip VALUES ('2008-03-02', 4);
INSERT INTO trip VALUES ('2007-01-01', 3);

INSERT INTO country VALUES ('Australia', 'English', 'Canberra');
INSERT INTO country VALUES ('Brazil', 'Portugues', 'Brazilia');
INSERT INTO country VALUES ('Spain', 'Spanish', 'Madrid');
INSERT INTO country VALUES ('Turkey', 'Turkish', 'Ankara');
INSERT INTO country VALUES ('England', 'English', 'London');
INSERT INTO country VALUES ('France', 'French', 'Paris');
INSERT INTO country VALUES ('Belgium', 'French', 'Brussels');
INSERT INTO country VALUES ('Portugal', 'Portuguese', 'Lisbon');
INSERT INTO country VALUES ('United States', 'English', 'Washington');

INSERT INTO city VALUES ('Istambul', 3, 'Turkey');
INSERT INTO city VALUES ('Madrid', 4, 'Spain');
INSERT INTO city VALUES ('Lisbon', 3, 'Portugal');
INSERT INTO city VALUES ('Ankara', 5, 'Turkey');
INSERT INTO city VALUES ('Paris', 3, 'France');
INSERT INTO city VALUES ('Brussels', 2, 'Belgium');
INSERT INTO city VALUES ('Sidney', 4, 'Australia');
INSERT INTO city VALUES ('Canberra', 3, 'Australia');
INSERT INTO city VALUES ('Brazilia', 3, 'Brazil');
INSERT INTO city VALUES ('Rio de Janeiro', 5, 'Brazil');
INSERT INTO city VALUES ('Sao Paulo', 4, 'Brazil');
INSERT INTO city VALUES ('Porto', 5, 'Portugal');
INSERT INTO city VALUES ('Barcelona', 5, 'Spain');
INSERT INTO city VALUES ('London', 4, 'England');
INSERT INTO city VALUES ('Nice', 4, 'France');
INSERT INTO city VALUES ('Lyon', 4, 'France');
INSERT INTO city VALUES ('Bruges', 3, 'Belgium');
INSERT INTO city VALUES ('New York', 5, 'United States');
INSERT INTO city VALUES ('Washington', 3, 'United States');

INSERT INTO stop VALUES ('Porto', '2007-05-24', 2);
INSERT INTO stop VALUES ('Barcelona', '2007-05-24', 4);
INSERT INTO stop VALUES ('London', '2007-05-24', 3);
INSERT INTO stop VALUES ('London', '2006-12-20', 2);
INSERT INTO stop VALUES ('New York', '2006-12-20', 12);
INSERT INTO stop VALUES ('Nice', '2008-03-02', 5);
INSERT INTO stop VALUES ('Istambul', '2008-03-02', 3);
INSERT INTO stop VALUES ('Ankara', '2008-03-02', 3);
INSERT INTO stop VALUES ('Lyon', '2007-05-24', 3);
INSERT INTO stop VALUES ('Madrid', '2008-03-02', 2);
INSERT INTO stop VALUES ('Porto', '2008-03-02', 3);
INSERT INTO stop VALUES ('Brazilia', '2007-01-01', 3);
INSERT INTO stop VALUES ('Rio de Janeiro', '2007-01-01', 6);
INSERT INTO stop VALUES ('Washington', '2007-01-01', 2);