/*Gravadora & Genero: 
- não devem aceitar nomes repetidos, mesmo que escritos de formas diferentes;
- não devem aceitar valores nulos ou em branco com menos de 2 caracteres.*/

DELIMITER //
CREATE PROCEDURE sp_insert_gravadora(gravadora VARCHAR(255))
BEGIN
	DECLARE nome_gravadora VARCHAR(255);
	SET nome_gravadora = (SELECT nome FROM tb_gravadora WHERE nome = gravadora);
    
    IF (LOWER(nome_gravadora) = LOWER(gravadora)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nome da gravadora já existe.';
	ELSE
		IF (gravadora IS NULL) OR (CHARACTER_LENGTH(REPLACE(gravadora, ' ', '')) < 2) THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nome para gravadora é inválido.';
		ELSE
			INSERT INTO tb_gravadora
				(nome)
			VALUE
				(gravadora);
        END IF;
    END IF;
END //
DELIMITER ;

CALL sp_insert_gravadora('Auctor PC');
CALL sp_insert_gravadora('auCtOr pc');
CALL sp_insert_gravadora(' ');
CALL sp_insert_gravadora('         ');
CALL sp_insert_gravadora(NULL);
CALL sp_insert_gravadora('I');
CALL sp_insert_gravadora('Ã');
CALL sp_insert_gravadora('MK Music');







DELIMITER //
CREATE PROCEDURE sp_insert_genero(genero VARCHAR(255))
BEGIN
	DECLARE nome_genero VARCHAR(255);
	SET nome_genero = (SELECT nome FROM tb_genero WHERE nome = genero);
    
    IF (LOWER(nome_genero) = LOWER(genero)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nome do gênero já existe.';
	ELSE
		IF (genero IS NULL) OR (CHARACTER_LENGTH(REPLACE(genero, ' ', '')) < 2) THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nome para gênero é inválido.';
		ELSE
			INSERT INTO tb_genero
				(nome)
			VALUE
				(genero);
        END IF;
    END IF;
END //
DELIMITER ;

CALL sp_insert_genero('Pop');
CALL sp_insert_genero('pOP');
CALL sp_insert_genero(' ');
CALL sp_insert_genero('      ');
CALL sp_insert_genero(NULL);
CALL sp_insert_genero('O');
CALL sp_insert_genero('Country Rock');
CALL sp_insert_genero('Ó');







/*Artista:
- não deve aceitar nomes com valores nulos, em branco ou com menos de 3 caracteres;
- a idade não deve aceitar nulos, brancos ou datas futuras.*/

DELIMITER //
CREATE PROCEDURE sp_insert_artista(nome_artista VARCHAR(50), idade_artista INTEGER)
BEGIN
	IF EXISTS (SELECT nome FROM tb_artista WHERE nome = nome_artista) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'O artista já foi cadastrado.';
	ELSE
   		IF (nome_artista IS NULL) OR (CHARACTER_LENGTH(REPLACE(nome_artista, ' ', '')) < 3) THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nome para artista é inválido';
        ELSE
			IF (idade_artista IS NULL) OR (idade_artista < 1) THEN
				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Idade inválida.';
            ELSE
				INSERT INTO tb_artista
					(nome, idade)
                VALUES
					(nome_artista, idade_artista);
            END IF;
        END IF;
	END IF;
END //
DELIMITER ;

CALL sp_insert_artista('Hector Sanford', 23);
CALL sp_insert_artista('hEcToR sAnFoRD', 23);
CALL sp_insert_artista('AI', 65);
CALL sp_insert_artista('D            Ó', 39);
CALL sp_insert_artista('Vó', 78);
CALL sp_insert_artista(NULL, 29);
CALL sp_insert_artista('  ', 45);
CALL sp_insert_artista('       ', 90);
CALL sp_insert_artista('Unlike Pluto', 0);
CALL sp_insert_artista('Unlike Pluto', -30);
CALL sp_insert_artista('Unlike Pluto', NULL);
CALL sp_insert_artista('Unlike Pluto', 31);







/*Musica:
- não devem aceitar valores nulos, em branco ou nome com menos de 2 caracteres;
- o tempo não pode ser 0 ou negativo;
- só podem ser aceitos discos existentes da tabela disco;
- uma mesma música com todos os atributos iguais não deve ser possivel de cadastrar para o mesmo disco.*/

DELIMITER //
CREATE PROCEDURE sp_insert_musica(nome_musica VARCHAR(50), duracao_musica FLOAT, cod_disco INTEGER)
BEGIN
	IF EXISTS (SELECT nome, tempo_musica, id_disco FROM tb_musica WHERE nome = nome_musica AND tempo_musica = duracao_musica AND id_disco = cod_disco) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'A música já foi cadastrada.';
	ELSE
		IF (duracao_musica IS NULL) OR (duracao_musica <= 0) THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Valor para o tempo da musica é inválido';
		ELSE
			IF (cod_disco IS NULL) OR NOT EXISTS (SELECT id_disco FROM tb_disco WHERE id_disco = cod_disco) THEN
				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'O id_disco é inválido.';
            ELSE
				IF (nome_musica IS NULL) OR (CHARACTER_LENGTH(REPLACE(nome_musica, ' ', '')) < 2) THEN
					SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'O nome para música é inválido.';
				ELSE
					INSERT INTO tb_musica
						(nome, tempo_musica, id_disco)
					VALUES
						(nome_musica, duracao_musica, cod_disco);
				END IF;
			END IF;
        END IF;
	END IF;
END //
DELIMITER ;

CALL sp_insert_musica('Ferris Jordan', 1.25, 623);
CALL sp_insert_musica('FeRrIs jORdAn', 1.25, 623);
CALL sp_insert_musica('Dark Horse', 0, 623);
CALL sp_insert_musica('Dark Horse', -3.13, 623);
CALL sp_insert_musica('Dark Horse', NULL, 623);
CALL sp_insert_musica('Scrubs', 3.25, 2000);
CALL sp_insert_musica('Scrubs', 3.25, NULL);
CALL sp_insert_musica(NULL, 3.25, 500);
CALL sp_insert_musica('                Ó', 3.25, 500);
CALL sp_insert_musica('The Course Of The Fould', 4.40, 10);







/*Disco:
- artistas, gravadoras, generos devem existir em suas respectivas tabelas;
- o ano de lancamento não pode ser um ano futuro;
- não devem aceitar títulos com valores nulos, em branco, ou com menos de 3 caracteres;
- discos com todos os dados iguais não devem ser possiveis de cadastrar.*/

DELIMITER //
CREATE PROCEDURE sp_insert_disco(nome_disco VARCHAR(100), duracao_disco FLOAT, ano_disco YEAR, cod_artista INTEGER, cod_gravadora INTEGER, cod_genero INTEGER)
BEGIN
	IF EXISTS (SELECT titulo_disco, tempo_disco, ano_lancamento, id_artista, id_gravadora, id_genero FROM tb_disco 
    WHERE titulo_disco = nome_disco AND tempo_disco = duracao_disco AND ano_lancamento = ano_disco 
    AND id_artista = cod_artista AND id_gravadora = cod_gravadora AND id_genero = cod_genero) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'O disco já está cadastrado.';
	ELSE
		IF (cod_artista IS NULL) OR NOT EXISTS (SELECT id_artista FROM tb_artista WHERE id_artista = cod_artista) THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'O id_artista é inválido.';
		ELSE
			IF (cod_gravadora IS NULL) OR NOT EXISTS (SELECT id_gravadora FROM tb_gravadora WHERE id_gravadora = cod_gravadora) THEN
				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'O id_gravadora é inválido.';
			ELSE
				IF (cod_genero IS NULL) OR NOT EXISTS (SELECT id_genero FROM tb_genero WHERE id_genero = cod_genero) THEN
					SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'O id_genero é inválido.';
				ELSE
					IF (ano_disco IS NULL) OR (ano_disco >= 2024) THEN
						SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'O ano do disco é inválido.';
					ELSE
                        IF (nome_disco IS NULL) OR (CHARACTER_LENGTH(REPLACE(nome_disco, ' ', '')) < 3) THEN
							SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'O nome do disco é inválido';
						ELSE
							INSERT INTO tb_disco
								(titulo_disco, tempo_disco, ano_lancamento, id_artista, id_gravadora, id_genero)
							VALUES
								(nome_disco, duracao_disco, ano_disco, cod_artista, cod_gravadora, cod_genero);
						END IF;
                    END IF;
				END IF;
			END IF;
		END IF;
    END IF;
END //
DELIMITER ;

CALL sp_insert_disco('Davis Rodgers', 61, 2009, 168, 12, 9);
CALL sp_insert_disco('DAvIs rODgeRs', 61, 2009, 168, 12, 9);
CALL sp_insert_disco(NULL, 61, 2009, 168, 12, 9);
CALL sp_insert_disco('O            I', 61, 2009, 168, 12, 9);
CALL sp_insert_disco('Teste 2', 61, 2009, 168, 12, 9999);
CALL sp_insert_disco('Teste 2', 61, 2009, 168, 12, NULL);
CALL sp_insert_disco('Teste 2', 61, 2009, 168, 9999, 9);
CALL sp_insert_disco('Teste 2', 61, 2009, 168, NULL, 9);
CALL sp_insert_disco('Teste 2', 61, 2009, 9999, 12, 9);
CALL sp_insert_disco('Teste 2', 61, 2009, NULL, 12, 9);
CALL sp_insert_disco('Teste 2', 61, NULL, 168, 12, 9);
CALL sp_insert_disco('Teenage Dream', 46.44, 2010, 14, 8, 10);
