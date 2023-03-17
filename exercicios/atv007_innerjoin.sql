# Mostre o nome do disco e quantas musicas ele possui
SELECT
	d.titulo_disco AS disco,
    COUNT(m.id_musica) AS musicas
FROM db_discoteca2.tb_disco AS d
INNER JOIN db_discoteca2.tb_musica AS m
	ON d.id_disco = m.id_disco
GROUP BY disco;

# Mostre o nome das musicas e o nome do disco dessas musicas
SELECT
	m.nome AS msc,
    d.titulo_disco AS disco
FROM db_discoteca2.tb_musica AS m
	INNER JOIN db_discoteca2.tb_disco AS d
		ON m.id_disco = d.id_disco;

# Mostre o nome disco e o nome do artista ordenado por artista
SELECT
	d.titulo_disco AS disco,
    a.nome AS artista
FROM db_discoteca2.tb_disco AS d
	INNER JOIN db_discoteca2.tb_artista AS a
		ON d.id_artista = a.id_artista
ORDER BY artista;

# Mostre o nome do disco, da gravadora e do artista ordenado por gravadora
SELECT
	d.titulo_disco AS disco,
    g.nome AS gravadora,
    a.nome AS artista
FROM db_discoteca2.tb_disco AS d
	INNER JOIN db_discoteca2.tb_gravadora AS g
		ON d.id_gravadora = g.id_gravadora
	INNER JOIN db_discoteca2.tb_artista AS a
		ON d.id_artista = a.id_artista
ORDER BY gravadora;

# Mostre nome do disco, ano de lancamento, tempo, nome da gravadora e nome do artista, junto a sua idade, ordenado por nome do artista
SELECT
	d.titulo_disco AS disco,
    d.ano_lancamento AS ano,
    d.tempo_disco AS tempo,
    g.nome AS gravadora,
    a.nome AS artista,
    a.idade AS idade_artista
FROM db_discoteca2.tb_disco AS d
	INNER JOIN db_discoteca2.tb_gravadora AS g
		ON d.id_gravadora = g.id_gravadora
	INNER JOIN db_discoteca2.tb_artista AS a
		ON d.id_artista = a.id_artista
ORDER BY artista;

# Mostre o nome do disco e todos os dados das musicas desse disco, exeto fk, porem somente dos  discos 4, 11, 25, 33, 111, 150 ordenado por disco
SELECT
	d.titulo_disco AS nome,
    m.id_musica AS id,
    m.nome AS nome,
    m.tempo_musica AS tempo
FROM db_discoteca2.tb_disco AS d
	INNER JOIN db_discoteca2.tb_musica AS m
		ON d.id_disco = m.id_disco
WHERE d.id_disco IN (4, 11, 25, 33, 111, 150);

# Mostre nome da gravadora, todos os dados do artista, execeto fk, todos os dados do disco exceto fk, e todos os dados das musicas relacionados, ordenado por artista porem mostre apenas dos disco de 10 a 15
SELECT
	g.nome,
    a.id_artista,
    a.nome,
    a.idade,
    d.id_disco,
    d.titulo_disco,
    d.tempo_disco,
    d.ano_lancamento,
    m.id_musica,
    m.nome,
    m.tempo_musica
FROM db_discoteca2.tb_gravadora AS g
	INNER JOIN db_discoteca2.tb_disco AS d
		ON g.id_gravadora = d.id_gravadora
	INNER JOIN db_discoteca2.tb_artista AS a
		ON a.id_artista = d.id_artista
	INNER JOIN db_discoteca2.tb_musica AS m
		ON m.id_disco = d.id_disco
WHERE d.id_disco BETWEEN 10 AND 15
ORDER BY a.nome;

# Mostre quantas musicas estão cadastradas
SELECT COUNT(m.id_musica)
FROM db_discoteca2.tb_musica AS m;

# Mostre a maior musica
SELECT MAX(m.id_musica)
FROM db_discoteca2.tb_musica AS m;

# Mostre o menor disco
SELECT MIN(d.id_disco)
FROM db_discoteca2.tb_disco AS d;

# Mostre quantas musicas cada disco possui em ordem decrescente de quantidade, sendo que do disco se deseja saber o titulo
SELECT
	d.titulo_disco AS titulo,
    COUNT(m.id_musica) AS musicas
FROM db_discoteca2.tb_disco AS d
	INNER JOIN db_discoteca2.tb_musica AS m
		ON d.id_disco = m.id_disco
GROUP BY titulo
ORDER BY musicas DESC;

# Mostre o tempo total de cada disco, porém mostre apenas os que posuem tempo superior a 20, ordenado de forma decrescente (faça usando a tabela musica).
SELECT
	d.titulo_disco AS titulo,
	ROUND(SUM(m.tempo_musica), 2) AS tempo
FROM db_discoteca2.tb_disco AS d
	INNER JOIN db_discoteca2.tb_musica AS m
		ON d.id_disco = m.id_disco
GROUP BY titulo
ORDER BY tempo DESC;

# Mostre quantos discos cada gravadora possui, mostre apenas as que possuem mais que 2 discos e que o ano de lancamento seja de 2000 pra frente ordenado de forma crescente de ano. deseja-se saber o nome da gravadora
SELECT
	g.nome AS gravadora,
    COUNT(d.id_gravadora) AS qnt
FROM db_discoteca2.tb_gravadora AS g
	INNER JOIN db_discoteca2.tb_disco AS d
		ON g.id_gravadora = d.id_gravadora
WHERE
	d.ano_lancamento >= 2000
GROUP BY gravadora
	HAVING qnt > 2;

# Mostre quantos discos cada artista possui filtrando apenas os que tem mais que 3 e não estejam presentes os anos 1985, 1998 e 2002. deseja-se saber o nome do artista
SELECT 
	a.nome AS artista,
    COUNT(d.id_disco) AS discos
FROM db_discoteca2.tb_artista AS a
	INNER JOIN db_discoteca2.tb_disco AS d
		ON a.id_artista = d.id_artista
WHERE
	d.ano_lancamento NOT IN (1985, 1998, 2002)
GROUP BY artista
	HAVING discos > 3;