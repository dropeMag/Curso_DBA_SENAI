# ------------------------------------------inserção de gravadoras-----------------------------------

DELIMITER $$
CREATE PROCEDURE sp_insert_gravadora(gravadora VARCHAR(255))
BEGIN
	DECLARE valida_gravadora VARCHAR(255);
    
    SET valida_gravadora = (SELECT LOWER(nome) FROM tb_gravadora WHERE nome = LOWER(gravadora));

	CASE
		WHEN (LOWER(gravadora) = valida_gravadora) 
			THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Este cadastrado já existe.';
		WHEN (LENGTH(fn_remove_acento(REPLACE(gravadora,' ',''))) <=2) OR (gravadora IS NULL)
			THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Gravadora com dados invalidos.';
	ELSE
		INSERT INTO tb_gravadora (nome) VALUES (gravadora);
    END CASE;
END $$
DELIMITER ;

DROP PROCEDURE sp_insert_gravadora;
SELECT * FROM tb_gravadora;

CALL sp_insert_gravadora('Ac Limited');
CALL sp_insert_gravadora('aC lImItED');
CALL sp_insert_gravadora('~ b ~ a ~ h ~');
CALL sp_insert_gravadora(NULL);
CALL sp_insert_gravadora('             ');
CALL sp_insert_gravadora('Olokinho Meusic');


# ------------------------------------------inserção de gravadoras-----------------------------------

DELIMITER $$
CREATE PROCEDURE sp_insert_genero(genero VARCHAR(20))
BEGIN
	DECLARE valida_genero VARCHAR(20);
    
    SET valida_genero = (SELECT LOWER(nome) FROM tb_genero WHERE nome = LOWER(genero));

	CASE
		WHEN (LOWER(genero) = valida_genero)
			THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Este cadastrado já existe.';
		WHEN (LENGTH(fn_remove_acento(REPLACE(genero,' ',''))) <=2) OR (genero IS NULL)
			THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Genero com dados invalidos.';
	ELSE
		INSERT INTO tb_genero (nome) VALUES (genero);
	END CASE;
END $$
DELIMITER ;

DROP PROCEDURE sp_insert_genero;
SELECT * FROM tb_genero;

CALL sp_insert_genero('Brega');
CALL sp_insert_genero('bREgA');
CALL sp_insert_genero('     ');
CALL sp_insert_genero(NULL);
CALL sp_insert_genero('CD');
CALL sp_insert_genero('Dark Country');


# ------------------------------------------inserção de artistas-----------------------------------

DELIMITER $$
CREATE PROCEDURE sp_insert_artista(artista VARCHAR(50), idade_artista INT)
BEGIN
	CASE
		WHEN(LENGTH(fn_remove_acento(REPLACE(artista,' ',''))) <=2) OR (artista IS NULL)
			THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Artista com dados invalidos';
		WHEN (idade_artista IS NULL) OR (idade_artista <= 0 ) OR (LENGTH(REPLACE(idade_artista,' ',''))< 1)
			THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Idade invalida';
	ELSE
		INSERT INTO tb_artista (nome, idade) VALUES (artista, idade_artista);
    END CASE;    
END $$
DELIMITER ;

DROP PROCEDURE sp_insert_artista;
SELECT * FROM tb_artista;

CALL sp_insert_artista('TESTE', 0);
CALL sp_insert_artista('TESTE', -2);
CALL sp_insert_artista('     ', NULL);
CALL sp_insert_artista(NULL, 30);
CALL sp_insert_artista('Dark Country');


# ------------------------------------------  inserção de musicsa  -----------------------------------

DELIMITER $$
CREATE PROCEDURE sp_insert_musica2(musica VARCHAR(50), duracao FLOAT, cod_disco INT)
BEGIN
	CASE
		WHEN (LENGTH(fn_remove_acento(REPLACE(musica,' ',''))) <=2) OR (musica IS NULL) 
			THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Musica com nome invalidos';
		WHEN (duracao IS NULL) OR (duracao <= 0 ) OR (duracao = '')
			THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'duracao invalida';
		WHEN NOT EXISTS (SELECT id_disco FROM tb_disco WHERE id_disco = cod_disco) 
			THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Codigo de disco invalido ou inexistente';
        WHEN EXISTS (SELECT nome, tempo_musica, id_disco FROM tb_musica WHERE LOWER(fn_remove_acento(nome)) = LOWER(fn_remove_acento(musica)) AND tempo_musica = duracao AND id_disco = cod_disco) 
			THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Musica já cadastrada para este disco';
    ELSE
		INSERT INTO tb_musica (nome, tempo_musica, id_disco) VALUES (musica, duracao, cod_disco);
    END CASE;
END $$
DELIMITER ;

# ------------------------------------------inserção de discos-----------------------------------

DELIMITER //
CREATE PROCEDURE sp_insert_disco(
	 nome_disco VARCHAR(100), 
	 duracao FLOAT, 
	 lancamento YEAR, 
	 cod_artista INT, 
	 cod_gravadora INT,
	 cod_genero INT)
BEGIN
	CASE
		WHEN (LENGTH(fn_remove_acento(REPLACE(nome_disco,' ',''))) <=2 OR nome_disco IS NULL)
			THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Disco com nome invalido';
		
        WHEN (duracao IS NULL) OR (duracao <= 0 ) OR (duracao = '')
			THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'duracao invalida';
		
        WHEN (lancamento > YEAR(NOW())) OR (lancamento IS NULL )
			THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ano de lancamento invalida';
		
        WHEN NOT EXISTS (SELECT id_genero FROM tb_genero WHERE id_genero = cod_genero)
			THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Codigo de genero invalido ou inexistente';
		
        WHEN NOT EXISTS (SELECT id_artista FROM tb_artista WHERE id_artista = cod_artista) 
			THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Codigo de artista invalido ou inexistente';
		
        WHEN NOT EXISTS (SELECT id_gravadora FROM tb_gravadora WHERE id_gravadora = cod_gravadora)
			THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Codigo de gravadora invalido ou inexistente';
		
        WHEN EXISTS (SELECT titulo_disco, tempo_disco, ano_lancamento, id_artista, id_genero, id_gravadora FROM tb_disco WHERE LOWER(fn_remove_acento(titulo_disco)) = LOWER(fn_remove_acento(nome_disco)) AND tempo_disco = duracao AND id_genero = cod_genero AND id_gravadora = cod_gravadora AND id_artista = cod_artista ) 
			THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Disco já cadastrado';
	ELSE
		INSERT INTO tb_disco (titulo_disco, tempo_disco, ano_lancamento, id_artista, id_genero, id_gravadora) VALUES (nome_disco, duracao, lancamento,  cod_artista, cod_genero, cod_gravadora);
    END CASE;
END //
DELIMITER ;
