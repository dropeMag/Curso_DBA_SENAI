# Procedure para db_biblioteca

DELIMITER //
CREATE PROCEDURE sp_insert_editora(nome VARCHAR(255))
BEGIN
	INSERT INTO tb_editora
		(nome_editora)
	VALUES
		(nome);
END //
DELIMITER ;


SELECT * FROM tb_editora;
CALL sp_insert_editora('Intrínseca');





DELIMITER //
CREATE PROCEDURE sp_insert_livro(titulo VARCHAR(255), registro BIGINT, autor INTEGER, editora INTEGER)
BEGIN
	INSERT INTO tb_livro
		(titulo_livro, isbn, id_autor, id_editora)
	VALUES
		(titulo, registro, autor, editora);
END //
DELIMITER ;


SELECT * FROM tb_livro;
CALL sp_insert_livro('Piruletas de Biruletas', 1395769824, 5, 3);





# Procedure para db_game

DELIMITER //
CREATE PROCEDURE sp_insert_console(console VARCHAR(255))
BEGIN
	INSERT INTO tb_console
		(nome)
    VALUES
		(console);
END //
DELIMITER ;


SELECT * FROM tb_console;
CALL sp_insert_console('Playstation 4');





DELIMITER //
CREATE PROCEDURE sp_insert_jogo(jogo VARCHAR(255))
BEGIN
	INSERT INTO tb_jogo
		(nome)
    VALUES
		(jogo);
END //
DELIMITER ;


SELECT * FROM tb_jogo;
CALL sp_insert_jogo('24h');





DELIMITER //
CREATE PROCEDURE sp_insert_jogo_console(jogo INTEGER, console INTEGER)
BEGIN
	INSERT INTO tb_jogo_console
		(id_jogo, id_console)
    VALUES
		(jogo, console);
END //
DELIMITER ;


SELECT * FROM tb_jogo_console;
CALL sp_insert_jogo_console(49, 7);