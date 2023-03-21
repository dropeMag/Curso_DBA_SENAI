# Modelagem física SQL de 'db_game'.
CREATE DATABASE IF NOT EXISTS db_game
COLLATE utf8mb4_general_ci
CHARSET utf8mb4;

USE db_game;

CREATE TABLE IF NOT EXISTS tb_jogo(
	id_jogo INTEGER NOT NULL AUTO_INCREMENT,
    nome VARCHAR(35) NOT NULL,
PRIMARY KEY(id_jogo),
CONSTRAINT uq_nome UNIQUE(nome)
)AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS tb_console(
	id_console INTEGER NOT NULL AUTO_INCREMENT,
    nome VARCHAR(35) NOT NULL,
PRIMARY KEY(id_console),
CONSTRAINT uq_nome UNIQUE(nome)
)AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS tb_jogo_console(
	id_jogo INTEGER NOT NULL,
	id_console INTEGER NOT NULL,
PRIMARY KEY(id_jogo, id_console),
CONSTRAINT fk_id_jogo FOREIGN KEY(id_jogo) REFERENCES tb_jogo(id_jogo),
CONSTRAINT fk_id_console FOREIGN KEY(id_console) REFERENCES tb_console(id_console)
);




# Cadastre 6 consoles e 10 games para cada console, caso o game exista para mais de uma plataforma ele deve ser relacionado com seus respectivos consoles.
INSERT INTO tb_console
VALUES
	(1, 'Xbox'),
	(2, 'Xbox 360'),
	(3, 'PSP'),
	(4, 'PlayStation 3'),
	(5, 'PlayStation 2'),
	(6, 'Wii');

INSERT INTO tb_jogo
VALUES
	(1, 'Halo: Combat Evolved'),     -- x
	(2, 'Dead or Alive 3'),          -- x
	(3, 'GTA V'),                    -- 360 | p3
	(4, 'Fallout 3'),                -- 360
	(5, 'FIFA 14'),                  -- psp
	(6, 'GTA: Vice City Stories'),   -- psp
	(7, 'Minecraft'),                -- p3 | 360
	(8, 'God of War'),               -- p2
	(9, 'Final Fantasy X'),          -- p2
	(10, 'Super Mario Galaxy'),      -- wii
	(11, 'Splatoon'),                -- wii
	(12, 'Just Dance 4'),            -- wii
	(13, 'Tekken 6'),                -- psp
	(14, 'Persona 3'),               -- psp
	(15, 'Spider Man 3'),            -- psp | p2 | p3 | 360
	(16, 'Halo 2'),                  -- x | 360
	(17, 'Daxter'),                  -- psp
	(18, 'God of War: Chains of Olympus'), -- psp | p3
	(19, 'Borderlands'),             -- 360
	(20, 'Sonic Lost World'),        -- wii
	(21, 'Fable'),                   -- x
	(22, 'Dantes Inferno'),          -- psp
	(23, 'Fifa 17'),                 -- 360 | p3
	(24, 'Destiny'),                 -- 360
	(25, 'Lego O Hobbit'),           -- wii
	(26, 'Black'),                   -- x
	(27, 'Half Minute Hero'),        -- psp
	(28, 'X-Men Legends II: Rise of Apoc.'),  -- psp | p2
	(29, 'Psychonauts'),             -- x | 360 | p2
	(30, 'The Last of Us'),          -- p3
	(31, 'Lumines'),                 -- psp
	(32, 'Max Payne'),               -- x
	(33, 'Mortal Kombat'),           -- p3 | p2
	(34, 'LEGO Star Wars II'),       -- psp | p2 | 360
	(35, 'Prince of Persia The Sands of Time'),  -- x | p2 | p3
	(36, 'BioShock'),                -- p3
	(37, 'Portal 2'),                -- p3
	(38, 'Bully'),                   -- p2
	(39, 'Mario Kart Wii'),          -- wii
	(40, 'Steel Battalion'),         -- x
	(41, 'Far Cry 3'),               -- p3
	(42, 'God Hand'),                -- p2
	(43, 'Just Dance 3'),            -- wii
	(44, 'Nintendo Land'),           -- wii
	(45, 'The Legend of Zelda'),     -- wii
	(46, 'Mario Kart 8'),            -- wii
    (47, 'Lego Indiana Jones'),      -- p2 | psp | p3 | wii | 360
	(48, 'Breakdown');               -- x

INSERT INTO tb_jogo_console
VALUES
	(1, 1),
	(2, 1),
	(3, 2),
	(3, 4),
	(4, 2),
	(5, 3),
	(6, 3),
	(7, 2),
	(7, 4),
	(8, 5),
	(9, 5),
	(10, 6),
	(11, 6),
	(12, 6),
	(13, 3),
	(14, 3),
	(15, 3),
	(15, 4),
	(15, 5),
	(15, 2),
	(16, 1),
	(16, 2),
	(17, 3),
	(18, 3),
	(18, 4),
	(19, 2),
	(20, 6),
	(21, 1),
	(22, 3),
	(23, 2),
	(23, 4),
	(24, 2),
	(25, 6),
	(26, 1),
	(27, 3),
	(28, 3),
	(28, 5),
	(29, 1),
	(29, 2),
	(29, 5),
	(30, 4),
	(31, 3),
	(32, 1),
	(33, 4),
	(33, 5),
	(34, 3),
	(34, 5),
	(34, 2),
	(35, 1),
	(35, 4),
	(35, 5),
	(36, 4),
	(37, 4),
	(38, 5),
	(39, 6),
	(40, 1),
	(41, 4),
	(42, 5),
	(43, 6),
	(44, 6),
	(45, 6),
	(46, 6),
	(47, 2),
	(47, 3),
	(47, 4),
	(47, 5),
	(47, 6),
	(48, 1);




# Realize uma consulta que mostre o nome dos jogos e do console ao qual pertence.
SELECT
	j.nome AS jogo,
    c.nome AS console
FROM db_game.tb_jogo AS j
	INNER JOIN db_game.tb_jogo_console AS assoc
		ON j.id_jogo = assoc.id_jogo
	INNER JOIN db_game.tb_console AS c
		ON assoc.id_console = c.id_console;




# Realize uma consulta que mostre quantos jogos cada console possui.
SELECT
	c.nome AS console,
    COUNT(j.id_jogo) AS qnt_jogos
FROM db_game.tb_console AS c
	INNER JOIN db_game.tb_jogo_console as assoc
		ON c.id_console = assoc.id_console
	INNER JOIN db_game.tb_jogo AS j
		ON assoc.id_jogo = j.id_jogo
GROUP BY console;




# Crie uma consulta que identifique em quantos consoles um jogo esta presente.
SELECT 
	j.nome AS jogo,
    COUNT(c.id_console) AS qnt_consoles
FROM db_game.tb_jogo AS j
	INNER JOIN db_game.tb_jogo_console AS assoc
		ON j.id_jogo = assoc.id_jogo
	INNER JOIN db_game.tb_console AS c
		ON assoc.id_console = c.id_console
GROUP BY jogo;