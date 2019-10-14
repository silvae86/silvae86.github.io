-- credits: André Restivo https://web.fe.up.pt/~arestivo

CREATE TABLE stage (
    num INTEGER PRIMARY KEY,
    description CHARACTER VARYING,
    day DATE
);

CREATE TABLE rider (
    ref INTEGER PRIMARY KEY,
    name CHARACTER VARYING,
    team CHARACTER VARYING
);

CREATE TABLE classification (
    num INTEGER REFERENCES stage,
    ref INTEGER REFERENCES rider,
    position INTEGER,
    time TIME,
    PRIMARY KEY (num, ref),
    UNIQUE (num, position)
);

INSERT INTO stage VALUES (1, 'Porto - Aveiro', '2009-04-24');
INSERT INTO stage VALUES (2, 'Aveiro - Coimbra', '2009-04-25');
INSERT INTO stage VALUES (3, 'Coimbra - Lisboa', '2009-04-26');

INSERT INTO rider VALUES (1, 'João Meireles', 'Os Velozes');
INSERT INTO rider VALUES (2, 'Carlos Meireles', 'Os Velozes');
INSERT INTO rider VALUES (3, 'Miguel Meireles', 'Os Velozes');
INSERT INTO rider VALUES (4, 'Tiago Meireles', 'Os Velozes');
INSERT INTO rider VALUES (5, 'Bernardo Barbosa', 'Os Rápidos');
INSERT INTO rider VALUES (7, 'Henrique Barbosa', 'Os Rápidos');
INSERT INTO rider VALUES (8, 'Filipe Barbosa', 'Os Rápidos');
INSERT INTO rider VALUES (9, 'Francisco Lopes da Silva', 'Os Melhores');
INSERT INTO rider VALUES (10, 'Joaquim Lopes da Silva', 'Os Melhores');

INSERT INTO classification VALUES (1, 7, 1, '01:24:11');
INSERT INTO classification VALUES (1, 4, 2, '01:24:17');
INSERT INTO classification VALUES (1, 8, 3, '01:24:34');
INSERT INTO classification VALUES (1, 9, 4, '01:24:56');
INSERT INTO classification VALUES (1, 10, 5, '01:25:00');
INSERT INTO classification VALUES (1, 5, 6, '01:25:19');
INSERT INTO classification VALUES (1, 1, 7, '01:26:13');
INSERT INTO classification VALUES (1, 2, 8, '01:27:37');
INSERT INTO classification VALUES (1, 3, 9, '01:27:42');
INSERT INTO classification VALUES (2, 7, 1, '01:13:54');
INSERT INTO classification VALUES (2, 4, 2, '01:14:23');
INSERT INTO classification VALUES (2, 5, 3, '01:14:45');
INSERT INTO classification VALUES (2, 3, 4, '01:15:12');
INSERT INTO classification VALUES (2, 1, 5, '01:17:43');
INSERT INTO classification VALUES (2, 2, 6, '01:17:56');
INSERT INTO classification VALUES (2, 8, 7, '01:18:42');
INSERT INTO classification VALUES (2, 9, 8, '01:19:13');
INSERT INTO classification VALUES (2, 10, 9, '01:19:14');
INSERT INTO classification VALUES (3, 3, 1, '02:34:43');
INSERT INTO classification VALUES (3, 7, 2, '02:34:44');
INSERT INTO classification VALUES (3, 4, 3, '02:35:14');
INSERT INTO classification VALUES (3, 8, 4, '02:35:26');
INSERT INTO classification VALUES (3, 9, 5, '02:35:51');
INSERT INTO classification VALUES (3, 1, 6, '02:36:28');
INSERT INTO classification VALUES (3, 5, 7, '02:36:55');
INSERT INTO classification VALUES (3, 2, 8, '02:36:58');
INSERT INTO classification VALUES (3, 10, 9, '02:36:59');