CREATE DATABASE IF NOT EXISTS db_family
COLLATE utf8mb4_general_ci
CHARSET utf8mb4;

USE db_family;

CREATE TABLE IF NOT EXISTS tb_pai(
	id_pai INTEGER NOT NULL AUTO_INCREMENT,
    nome VARCHAR(30) NOT NULL,
    sobrenome VARCHAR(80) NOT NULL,
    dt_nascimento DATE NOT NULL,
    nacionalidade VARCHAR(20) DEFAULT 'Brasileiro',
PRIMARY KEY(id_pai)
);

CREATE TABLE IF NOT EXISTS tb_mae(
	id_mae INTEGER NOT NULL AUTO_INCREMENT,
    nome VARCHAR(30) NOT NULL,
    sobrenome VARCHAR(80) NOT NULL,
    dt_nascimento DATE NOT NULL,
PRIMARY KEY(id_mae)
);

CREATE TABLE IF NOT EXISTS tb_filho(
	id_filho INTEGER NOT NULL AUTO_INCREMENT,
    nome VARCHAR(30) NOT NULL,
    sobrenome VARCHAR(80) NOT NULL,
    dt_nascimento DATE NOT NULL,
    id_mae INTEGER NOT NULL DEFAULT 1,
    id_pai INTEGER,
PRIMARY KEY(id_filho),
FOREIGN KEY(id_mae) REFERENCES tb_mae(id_mae),
FOREIGN KEY(id_pai) REFERENCES tb_pai(id_pai)
);

CREATE TABLE IF NOT EXISTS tb_avo(
	id_avo INTEGER NOT NULL,
    nome VARCHAR(30),
    id_filho INTEGER,
PRIMARY KEY(id_avo),
FOREIGN KEY(id_filho) REFERENCES tb_filho(id_filho)
);

INSERT INTO tb_mae
	(id_mae, nome, sobrenome, dt_nascimento)
VALUES
    (1, 'Desconhecida', '-', '1111-11-11'),
    (2, 'Marge', 'Simpson', '1956-10-23'),
    (3, 'Shmi', 'Skywalker', '1854-04-13'),
    (4, 'Baba', 'Yaga', '1075-09-10'),
    (5, 'Vovó', 'Addams', '1005-11-28'),
    (6, 'Morticia', 'Addams', '1568-03-15'),
    (7, 'Rochelle', 'Rock', '1960-05-18'),
    (8, 'Dona', 'Florinda', '1952-10-07'),
    (9, 'Janet', 'Kyle', '1975-08-30');

INSERT INTO tb_pai
	(nome, sobrenome, dt_nascimento)
VALUES
	('Homer', 'Simpson', '1956-05-12'),
	('Cliegg', 'Lars', '1856-09-17'),
	('Gomes', 'Addams', '1567-05-25'),
	('Julius', 'Rock', '1955-01-02'),
	('Seu', 'Madruga', '1950-08-15'),
	('Capitão', 'Federico', '1945-05-20'),
	('Seu', 'Barriga', '1948-06-18'),
	('Michael', 'Kyle', '1969-07-26');

INSERT INTO tb_filho
	(id_filho, nome, sobrenome, dt_nascimento, id_mae, id_pai)
VALUES
	(1, 'Bart', 'Simpson', '1981-04-01', 2, 1),
	(2, 'Lisa', 'Simpson', '1981-05-09', 2, 1),
	(3, 'Maggie', 'Simson', '1989-06-16', 2, 1),
	(4, 'Darth', 'Vader', '1985-04-15', 3, 2),
	(5, 'Marinka', 'Yaga', '1208-09-24', 4, NULL),
	(6, 'Gomez', 'Addams', '1567-05-25', 5, NULL),
	(7, 'Chico', 'Addams', '1575-09-08', 5, NULL),
	(8, 'Itt', 'Addams', '1570-10-29', 5, NULL),
	(9, 'Vandinha', 'Addams', '1820-09-25', 6, 3),
	(10, 'Feioso', 'Addams', '1825-03-30', 6, 3),
	(11, 'Pubert', 'Addams', '1830-12-25', 6, 3),
	(12, 'Chris', 'Rock', '1970-02-02', 7, 4),
	(13, 'Drew', 'Rock', '1972-07-16', 7, 4),
	(14, 'Tonya', 'Rock', '1974-05-13', 7, 4),
	(15, 'Chiquinha', 'Madruga', '1973-09-11', DEFAULT, 5),
	(16, 'Chaves', 'do 8', '1970-01-01', DEFAULT, NULL),
	(17, 'Quico', 'Federico', '1972-06-18', 8, 6),
	(18, 'Ñoño', 'Barriga', '1971-12-12', DEFAULT, 7),
	(19, 'Junior', 'Kyle', '1990-09-09', 9, 8),
	(20, 'Claire', 'Kyle', '1995-01-31', 9, 8),
	(21, 'Kady', 'Kyle', '1999-06-11', 9, 8);

INSERT INTO tb_pai
	(nome, sobrenome, dt_nascimento)
VALUES
	('Criado', 'o Peixe', '1652-11-13');

INSERT INTO tb_filho
	(nome, sobrenome, dt_nascimento, id_mae, id_pai)
VALUES
	('Mega', 'Mente', '2001-08-29', DEFAULT, 9);
