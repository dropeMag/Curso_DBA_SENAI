DELIMITER //
CREATE PROCEDURE sp_insert_jogo(nome_jogo VARCHAR(35))
BEGIN
	DECLARE jogo VARCHAR(35);
	
    SET jogo = (SELECT nome 
				FROM tb_jogo 
                WHERE nome = nome_jogo);

    IF (LOWER(jogo) = LOWER(nome_jogo)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Jogo já cadastrado.';
    ELSE
		IF (LENGTH(nome_jogo) < 2) OR (nome_jogo IS NULL) THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nome de jogo inválido.';
		ELSE
			INSERT INTO tb_jogo
				(nome)
			VALUES
				(nome_jogo);
        END IF;
	END IF;
END //
DELIMITER ;
