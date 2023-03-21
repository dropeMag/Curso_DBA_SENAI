# Modelagem física SQL de 'db_biblioteca'
CREATE DATABASE IF NOT EXISTS db_biblioteca
COLLATE utf8mb4_general_ci
CHARSET utf8mb4;

USE db_biblioteca;

CREATE TABLE IF NOT EXISTS tb_autor(
	id_autor INTEGER AUTO_INCREMENT,
    nome_autor VARCHAR(50) NOT NULL,
    sobrenome_autor VARCHAR(100) NOT NULL,
    dt_nascimento DATE NOT NULL,
PRIMARY KEY(id_autor)
)AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS tb_editora(
	id_editora INTEGER AUTO_INCREMENT,
    nome_editora VARCHAR(75) NOT NULL,
PRIMARY KEY(id_editora),
CONSTRAINT uq_nome_editora UNIQUE(nome_editora)
)AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS tb_livro(
	id_livro INTEGER AUTO_INCREMENT,
    titulo_livro VARCHAR(100) NOT NULL,
    isbn INTEGER NOT NULL,
    id_autor INTEGER,
    id_editora INTEGER,
PRIMARY KEY(id_livro),
CONSTRAINT uq_isbn UNIQUE(isbn),
CONSTRAINT fk_id_autor FOREIGN KEY(id_autor) REFERENCES tb_autor(id_autor),
CONSTRAINT fk_id_editora FOREIGN KEY(id_editora) REFERENCES tb_editora(id_editora)
)AUTO_INCREMENT = 1;




# Caso haja algum conflito de dados, solucione utilizando comandos de alter sem perder os dados presentes.
ALTER TABLE tb_livro
MODIFY isbn BIGINT NOT NULL;




# Cadastre 6 editoras e 10 livros para cada editora e 8 autores.
INSERT INTO tb_editora
	(nome_editora)
VALUES
	('Rocco Jovens Leitores'),
	('Melhoramentos'),
	('Morro Branco'),
	('Trama'),
	('Editora Arqueiro'),
	('Gutenberg'),
	('Intrínseca');

INSERT INTO tb_autor
	(nome_autor, sobrenome_autor, dt_nascimento)
VALUES
	('Suzanne', 'Collins', '1962-08-10'),
	('Robbie', 'Couch', '1989-12-15'),
	('Ruth', 'Ozeki', '1956-03-12'),
	('Michael', 'Connelly', '1956-07-21'),
	('Kate', 'London', '1983-07-17'),
	('Louise', 'Penny', '1958-07-01'),
	('Robert', 'Bryndza', '1979-09-19'),
	('Sarah', 'Pearse', '1962-05-30');

INSERT INTO tb_livro
	(titulo_livro, isbn, id_autor, id_editora)
VALUES
	('Jogos vorazes', 8579800242, 1, 1),
	('Em chamas', 6555320745, 1, 1),
	('A esperança', 6555320753, 1, 1),
	('O azul daqui é mais azul', 6555393718, 2, 2),
	('Um conto para ser tempo', 6586015561, 3, 3),
	('Cai a noite em Hollywood', 6589132402, 4, 4),
	('A causa da morte', 6589132690, 5, 4),
	('Estado de terror', 6555654503, 6, 5),
	('Testemunha fatal', 8582356897, 7, 6),
	('O retiro', 6555603585, 8, 7);




# Realize uma consulta que mostre o nome dos livros, sua editora e seu autor.
SELECT
	l.titulo_livro AS livro,
    a.nome_autor AS autor,
    a.sobrenome_autor AS autor,
    e.nome_editora AS editora
FROM db_biblioteca.tb_livro AS l
	INNER JOIN db_biblioteca.tb_autor AS a
		ON l.id_autor = a.id_autor
	INNER JOIN db_biblioteca.tb_editora AS e
		ON l.id_editora = e.id_editora
UNION
SELECT
	l.titulo_livro AS livro,
    a.nome_autor AS autor,
    a.sobrenome_autor AS autor,
    e.nome_editora AS editora
FROM db_biblioteca.tb_livro AS l
	INNER JOIN db_biblioteca.tb_autor AS a
		ON l.id_autor = a.id_autor
	INNER JOIN db_biblioteca.tb_editora AS e
		ON l.id_editora = e.id_editora;




# Realize uma consulta que mostre quantos livros cada autor escreveu.
SELECT
	a.id_autor AS id_autor,
	a.nome_autor AS nome_autor,
   	a.sobrenome_autor AS sobrenome_autor,
    COUNT(l.id_livro) AS livros
FROM db_biblioteca.tb_autor AS a
	INNER JOIN db_biblioteca.tb_livro AS l
		ON a.id_autor = l.id_autor
GROUP BY id_autor;




# Crie uma consulta que identifique quantos livros uma editora publicou.
SELECT
	e.id_editora AS id_editora,
	e.nome_editora AS editora,
    COUNT(l.id_livro) AS livros
FROM db_biblioteca.tb_editora AS e
	INNER JOIN db_biblioteca.tb_livro AS l
		ON e.id_editora = l.id_editora
GROUP BY id_editora;




# Cadastre 2 editoras novas que não possuam livros relacionados.
INSERT INTO tb_editora
	(nome_editora)
VALUES
	('Alta Novel'),
	('Seguinte');




# Cadastre 3 autores que não possuam livros relacionados
INSERT INTO tb_autor
	(nome_autor, sobrenome_autor, dt_nascimento)
VALUES
	('Erin', 'Morgenstern', '1978-07-08'),
	('Isaac', 'Asimov', '1920-01-02'),
	('Anthony', 'Doerr', '1973-10-27');




# Cadastre 2 livros sem editora
INSERT INTO tb_livro
	(titulo_livro, isbn, id_autor)
VALUES
	('If I See You Again Tomorrow', '1534497498', 2),
	('Post Mortem', '1782396152', 5);




# Cadastre 4 livros sem autor
INSERT INTO tb_livro
	(id_livro, titulo_livro, isbn, id_editora)
VALUES
	(13, 'A casa no mar cerúleo', '6586015464', 3),
	(14, 'A filha do doutor Moreau', '6555395206', 2),
	(15, 'Um estranho nos meus braços', '6555654384', 5),
	(16, 'Fat Chance: A vez de Charlie Vega', '6586553997', 6);




# Crie uma consulta que mostre todos os livros, autores e editoras, mesmo que não possuam relacionamento
SELECT
	l.titulo_livro AS livro,
    a.nome_autor AS autor,
    e.nome_editora AS editora
FROM db_biblioteca.tb_editora AS e
	LEFT JOIN db_biblioteca.tb_livro AS l
		ON l.id_editora = e.id_editora
	RIGHT JOIN db_biblioteca.tb_autor AS a
		ON l.id_autor = a.id_autor
UNION
SELECT
	l.titulo_livro AS livro,
    a.nome_autor AS autor,
    e.nome_editora AS editora
FROM db_biblioteca.tb_editora AS e
	RIGHT JOIN db_biblioteca.tb_livro AS l
		ON l.id_editora = e.id_editora
	LEFT JOIN db_biblioteca.tb_autor AS a
		ON l.id_autor = a.id_autor;