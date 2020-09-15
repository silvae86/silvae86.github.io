BEGIN TRANSACTION;
DROP TABLE IF EXISTS "FuncionarioReparacao";
CREATE TABLE IF NOT EXISTS "FuncionarioReparacao" (
	"idFuncionario"	NUMBER,
	"idReparacao"	NUMBER,
	"numHoras"	NUMBER(7 , 0) CHECK(numHoras>=0),
	CONSTRAINT "pk_funcionario_reparacao" PRIMARY KEY("idFuncionario","idReparacao"),
	FOREIGN KEY("idFuncionario") REFERENCES "Funcionario"("idFuncionario"),
	FOREIGN KEY("idReparacao") REFERENCES "Reparacao"("idReparacao")
);
DROP TABLE IF EXISTS "Funcionario";
CREATE TABLE IF NOT EXISTS "Funcionario" (
	"idFuncionario"	INTEGER PRIMARY KEY AUTOINCREMENT,
	"nome"	NVARCHAR2(50) NOT NULL,
	"morada"	NVARCHAR2(50),
	"codPostal1"	CHAR(4),
	"codPostal2"	CHAR(3),
	"telefone"	CHAR(9),
	"idEspecialidade"	NUMBER,
	FOREIGN KEY("idEspecialidade") REFERENCES "Especialidade"("idEspecialidade"),
	FOREIGN KEY("codPostal1") REFERENCES "CodPostal"("codPostal1")
);
DROP TABLE IF EXISTS "Especialidade";
CREATE TABLE IF NOT EXISTS "Especialidade" (
	"idEspecialidade"	INTEGER PRIMARY KEY AUTOINCREMENT,
	"nome"	NVARCHAR2(50) NOT NULL,
	"custoHorario"	NUMBER(9 , 3) CHECK(custoHorario>=0)
);
DROP TABLE IF EXISTS "PecaModelo";
CREATE TABLE IF NOT EXISTS "PecaModelo" (
	"idPeca"	NUMBER,
	"idModelo"	NUMBER,
	CONSTRAINT "pk_peca_modelo" PRIMARY KEY("idPeca","idModelo"),
	FOREIGN KEY("idPeca") REFERENCES "Peca"("idPeca"),
	FOREIGN KEY("idModelo") REFERENCES "Modelo"("idModelo")
);
DROP TABLE IF EXISTS "ReparacaoPeca";
CREATE TABLE IF NOT EXISTS "ReparacaoPeca" (
	"idReparacao"	NUMBER,
	"idPeca"	NUMBER,
	"quantidade"	NUMBER(7 , 0) CHECK(quantidade>=0),
	CONSTRAINT "pk_reparacao_peca" PRIMARY KEY("idReparacao","idPeca"),
	FOREIGN KEY("idReparacao") REFERENCES "Reparacao"("idReparacao"),
	FOREIGN KEY("idPeca") REFERENCES "Peca"("idPeca")
);
DROP TABLE IF EXISTS "Peca";
CREATE TABLE IF NOT EXISTS "Peca" (
	"idPeca"	INTEGER PRIMARY KEY AUTOINCREMENT,
	"codigo"	CHAR(20) UNIQUE,
	"designacao"	NVARCHAR2(50),
	"custoUnitario"	NUMBER(9 , 3) CHECK(custoUnitario>=0),
	"quantidade"	NUMBER(7 , 0) CHECK(quantidade>=0)
);
DROP TABLE IF EXISTS "Reparacao";
CREATE TABLE IF NOT EXISTS "Reparacao" (
	"idReparacao"	INTEGER PRIMARY KEY AUTOINCREMENT,
	"dataInicio"	DATE,
	"dataFim"	DATE,
	"idCliente"	NUMBER,
	"idCarro"	NUMBER,
	CONSTRAINT "ch_df_di" CHECK(dataFim>=dataInicio),
	FOREIGN KEY("idCarro") REFERENCES "Carro"("idCarro"),
	FOREIGN KEY("idCliente") REFERENCES "Cliente"("idCliente")
);
DROP TABLE IF EXISTS "Carro";
CREATE TABLE IF NOT EXISTS "Carro" (
	"idCarro"	INTEGER PRIMARY KEY AUTOINCREMENT,
	"Matricula"	CHAR(6) UNIQUE,
	"idModelo"	NUMBER,
	"idCliente"	NUMBER,
	FOREIGN KEY("idCliente") REFERENCES "Cliente"("idCliente"),
	FOREIGN KEY("idModelo") REFERENCES "Modelo"("idModelo")
);
DROP TABLE IF EXISTS "Cliente";
CREATE TABLE IF NOT EXISTS "Cliente" (
	"idCliente"	INTEGER PRIMARY KEY AUTOINCREMENT,
	"nome"	NVARCHAR2(50) NOT NULL,
	"morada"	NVARCHAR2(50),
	"codPostal1"	CHAR(4),
	"codPostal2"	CHAR(3),
	"telefone"	CHAR(9),
	FOREIGN KEY("codPostal1") REFERENCES "CodPostal"("codPostal1")
);
DROP TABLE IF EXISTS "CodPostal";
CREATE TABLE IF NOT EXISTS "CodPostal" (
	"codPostal1"	CHAR(4),
	"localidade"	NVARCHAR2(30),
	PRIMARY KEY("codPostal1")
);
DROP TABLE IF EXISTS "Modelo";
CREATE TABLE IF NOT EXISTS "Modelo" (
	"idModelo"	INTEGER PRIMARY KEY AUTOINCREMENT,
	"nome"	NVARCHAR2(50) NOT NULL,
	"idMarca"	NUMBER,
	FOREIGN KEY("idMarca") REFERENCES "Marca"("idMarca")
);
DROP TABLE IF EXISTS "Marca";
CREATE TABLE IF NOT EXISTS "Marca" (
	"idMarca"	INTEGER PRIMARY KEY AUTOINCREMENT,
	"nome"	NVARCHAR2(50) NOT NULL
);
INSERT INTO "FuncionarioReparacao" VALUES (1,1,1),
 (4,1,4),
 (1,2,1),
 (2,2,6),
 (4,2,2),
 (1,3,1),
 (1,5,1),
 (2,6,6);
INSERT INTO "Funcionario" VALUES (1,'Abel Sousa','Rua da Preciosa, 317-1� Esq','4200','137','226903271',1),
 (2,'M�rio Teixeira','Rua Seca, 17','4400','210','227519090',2),
 (3,'Rog�rio Silva','Rua dos Caldeireiros, 312, 3�F','4400','112','227403728',2),
 (4,'Lu�s Pereira','Rua Teixeira de Pascoaes, 117, 2� D','4450','117','225901707',3);
INSERT INTO "Especialidade" VALUES (1,'Electricista',15),
 (2,'Mec�nico',12),
 (3,'Chapeiro',10);
INSERT INTO "PecaModelo" VALUES (1,1),
 (2,3);
INSERT INTO "ReparacaoPeca" VALUES (2,1,8),
 (3,2,2),
 (5,2,2),
 (6,1,8);
INSERT INTO "Peca" VALUES (1,'37XX98',NULL,3,100),
 (2,'75VBO98',NULL,25,10);
INSERT INTO "Reparacao" VALUES (1,'2010-09-17','2010-09-20',1,3),
 (2,'2010-09-15','2010-09-16',4,1),
 (3,'2009-09-18','2009-09-27',4,5),
 (4,'2009-09-18','2009-10-10',4,5),
 (5,'2009-09-18','2009-09-27',4,3),
 (6,'2010-09-16','2010-09-17',4,1);
INSERT INTO "Carro" VALUES (1,'2490CV',1,4),
 (2,'36DH79',2,2),
 (3,'1127XY',3,3),
 (4,'78AB27',3,2),
 (5,'16IU02',3,4);
INSERT INTO "Cliente" VALUES (1,'Alberto Sousa','Rua Brito e Cunha, 125','4450','086','932853425'),
 (2,'Maria Francisca Pereira Nobre','Avenida Meneres, 201','4450','191','933278005'),
 (3,'Rodrigo Meireles de Aguiar','Rua da Cunha, 310 1� Dir','4200','250','928604666'),
 (4,'Ad�o Lopes S�','Rua Domingos de Matos, 200 3� Esq','4400','120','963670913');
INSERT INTO "CodPostal" VALUES ('4200','Porto'),
 ('4400','Vila Nova de Gaia'),
 ('4450','Matosinhos');
INSERT INTO "Modelo" VALUES (1,'Clio 1.9D',1),
 (2,'V50 Momentum',2),
 (3,'C30 Drive',2);
INSERT INTO "Marca" VALUES (1,'Renault'),
 (2,'Volvo');
DROP VIEW IF EXISTS "PrecoReparacao";
CREATE VIEW PrecoReparacao as
select custoPecas.idReparacao, custoTotalPecas + custoTotalMaoObra as preco
from custoPecas join custoMaoObra on custoPecas.idReparacao = custoMaoObra.idReparacao;
DROP VIEW IF EXISTS "custoPecas";
CREATE VIEW custoPecas as
  select Reparacao.idReparacao, coalesce(custoTotalPecas, 0) as custoTotalPecas
  from
  Reparacao
  left join
  (
    select ReparacaoPeca.idReparacao, sum(ReparacaoPeca.quantidade * Peca.custoUnitario) as custoTotalPecas
    from
    ReparacaoPeca
    join Peca on ReparacaoPeca.idPeca = Peca.idPeca
    group by ReparacaoPeca.idReparacao
  ) as custoPecasPorReparacao
  on Reparacao.idReparacao = custoPecasPorReparacao.idReparacao;
DROP VIEW IF EXISTS "custoMaoObra";
CREATE VIEW custoMaoObra as
  select FuncionarioReparacao.idReparacao, sum(FuncionarioReparacao.numHoras * Especialidade.custoHorario) as custoTotalMaoObra
  from
  FuncionarioReparacao
  join Funcionario on FuncionarioReparacao.idFuncionario = Funcionario.idFuncionario
  join Especialidade on Funcionario.idEspecialidade = Especialidade.idEspecialidade
  group by FuncionarioReparacao.idReparacao;
COMMIT;
