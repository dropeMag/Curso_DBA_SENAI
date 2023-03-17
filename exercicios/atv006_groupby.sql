# É desejavel saber quantas gravadoras temos cadastradas
SELECT COUNT(id_gravadora) AS numero_gravadoras FROM tb_gravadora;

# identifique quantos discos tempos cadastrados
SELECT COUNT(id_disco) AS qnt_discos FROM tb_disco;

# Identifique quantas musicas temos cadastradas
SELECT COUNT(id_musica) FROM tb_musica;

# Identifique o menor e o maior id musicas
SELECT MIN(id_musica),
       MAX(id_musica) FROM tb_musica;

# Identifique quantos discos existem por gravadora ordenado por quantidade decrescente
SELECT id_gravadora, COUNT(id_disco) AS qnt_disc FROM tb_disco
GROUP BY id_gravadora
ORDER BY qnt_disc DESC;

# Identifique quantos discos existem por artista ordenado por quantidade decrescente
SELECT id_artista, COUNT(id_artista) AS num_arts FROM tb_disco
GROUP BY id_artista
ORDER BY num_arts DESC;

# Identifique quantos discos existem por genero ordenado por quantidade decrescente
SELECT id_genero, COUNT(id_genero) FROM tb_disco
GROUP BY id_genero
ORDER BY COUNT(id_genero) DESC;

# Identique qual a media de duração de cada disco ordenado de forma decrescente de media
SELECT AVG(tempo_disco) FROM tb_disco;

# Identifique soma total do tempo de musica de cada disco.
SELECT id_disco, ROUND(SUM(tempo_musica), 2) AS temp_disco FROM tb_musica
GROUP BY id_disco;

# Mostre o tempo de duração de cada disco baseado nas musicas, e mostre também quantas musicas cada disco possui,
# porem mostre somento dos discos que possuam pelo menos 1h de duração
SELECT id_disco, SUM(tempo_musica) AS tmp_disco, COUNT(id_musica) FROM tb_musica
GROUP BY id_disco
HAVING tmp_disco >= 60;

# Mostre quantos discos cada artista possui, porem apenas dos anos 2000 ate hoje e que também tenham tempo acima
# de uma hora e abaixo de uma hora e meia, deseja-se também saber somente dos artiscas que possuam mais que 5 discos
SELECT id_artista, COUNT(id_disco) AS num_disc FROM tb_disco
WHERE ano_lancamento BETWEEN 2000 AND 2023 
	  AND tempo_disco BETWEEN 61 AND 89
GROUP BY id_artista
HAVING num_disc > 5;

# Verifique se há musicas reptidas e quantas vezes elas repetem caso existam repetições
SELECT nome, COUNT(nome) AS qnt_nome FROM tb_musica
GROUP BY nome
HAVING qnt_nome > 1;

# verifique se ha discos repetidos e quantas vezes eles repetem caso existam repetições
SELECT titulo_disco, COUNT(titulo_disco) AS vzs_disco FROM tb_disco
GROUP BY titulo_disco
HAVING vzs_disco >= 2;
