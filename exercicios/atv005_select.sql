# mostre o nome das gravadores em ordem alfabética
SELECT nome FROM tb_gravadora
ORDER BY nome;

# Mostre os disco que possuem mais que uma hora de musicas em ordem do maior para o menor
SELECT * FROM tb_disco
WHERE tempo_disco > 60
ORDER BY tempo_disco;

# Mostre todas as musicas com tamanho iguais ou menor que 3.0 minutos
SELECT nome, tempo_musica FROM tb_musica
WHERE tempo_musica <= 3;

# mostre os discos que são do ano 1996, 1999, 2015 em ordem crescente
SELECT * FROM tb_disco
WHERE ano_lancamento IN (1996, 1999, 2015);

# mostre o nome e ano dos disco do ano 2000 ate 2022
SELECT titulo_disco, ano_lancamento FROM tb_disco
WHERE ano_lancamento BETWEEN 2000 AND 2022;

# mostre nome e idade dos artistas de 20 anos
SELECT nome, idade FROM tb_artista
WHERE idade = 20;

# mostre todas as gravadoras que o ID seja diferente de 6 em ordem decrescente
SELECT * FROM tb_gravadora
WHERE id_gravadora != 6
ORDER BY id_gravadora DESC;

# Mostre o nome e tempo das musicas que possuem o tempo menor ou igual 2, ou maior ou igual 4
SELECT nome, tempo_musica FROM tb_musica
WHERE tempo_musica <=2 OR tempo_musica >= 4;

# Mostre o titulo e ano dos discos entre 1997 e 2008
SELECT titulo_disco, ano_lancamento FROM tb_disco
WHERE ano_lancamento BETWEEN 1997 AND 2008;

# Quais idades estão entre 18 e 60 anos
SELECT idade FROM tb_artista
WHERE idade BETWEEN 18 AND 60
ORDER BY idade;

# Mostre o nome das gravadoras com a letra 'd' em qualquer parte do nome
SELECT nome FROM tb_gravadora
WHERE nome LIKE '%d%';

# Mostre o nome das musicas do disco 23
SELECT nome FROM tb_musica
WHERE id_musica = 23;

# Mostre os discos que tenham a letra 'S' no final
SELECT nome FROM tb_musica
WHERE nome LIKE '%s';

# Mostre em ordem decrescente o nome dos artistas que tem a segunda letra 'E' e terminem com a letra 'O'
SELECT nome FROM tb_artista
WHERE nome LIKE '_e%o'
ORDER BY nome DESC;

# Indique o nome crescente , mas apenas das musicas que possuam menos de 3.0 minutos de duração
SELECT nome FROM tb_musica
WHERE tempo_musica < 3
ORDER BY nome;

# Indique os discos que iniciam com a letra A ou terminem com a letra a sendo a penultima letra
SELECT * FROM tb_disco
WHERE titulo_disco LIKE 'A%' OR '%a_';

# Mostre o nome dos artistas que comecem com a letra C e que tenham idade superior a 23
SELECT nome FROM tb_artista
WHERE nome LIKE 'C%' AND idade > 23;

# Mostre o nome das musicas, exceto as são são dos discos 6, 12 e 34
SELECT nome FROM tb_musica
WHERE id_disco NOT IN (6, 12, 34);

# Consulte o nome apenas das gravadoras que possuam a antepenúltima letra sendo 'T' e ordene em ordem decrescente
SELECT nome FROM tb_gravadora
WHERE nome LIKE '%t__'
ORDER BY nome DESC;

# Consulte apenas os nomes e sobrenomes dos artistas que possuem 'SILVA' em qualquer qualquer lugar do nome  e que tenha idade superior a 25 e organize em ordem crescente de sobrenome
SELECT nome FROM tb_artista
WHERE nome LIKE 'SILVA' AND idade > 25
ORDER BY nome;

# Consulte apenas o nome e idade dos artistas que possuem idade entre 18 e 35 anos ou que possuam o nome iniciado com a letra 'P' e terminado com a letra 'Y' e organize em ordem crescente de idade
SELECT nome, idade FROM tb_artista
WHERE idade BETWEEN 18 AND 35 OR nome LIKE 'P%Y'
ORDER BY idade;

# Consulte o titulo dos discos do artista 5 e no resultado mostre o titulo apenas daqueles que tiverem de 20 minutos para cima e organize em ordem decrescente de minutos
SELECT titulo_disco FROM tb_disco
WHERE id_artista = 5 AND tempo_disco >= 20
ORDER BY tempo_disco DESC;

# Consulte o titulo e ano de lançamento de todos os discos exceto os que estão entre 1998 e 2006 e organize por ano
SELECT titulo_disco, ano_lancamento FROM tb_disco
WHERE ano_lancamento NOT BETWEEN 1998 AND 2006
ORDER BY ano_lancamento;

# Consulte o nome e sobrenome dos artistas que tenham o nome iniciado com 'C' e terminado com 'A', e que o sobrenome possua 'TA' em qualquer lugar, organize por ordem alfabética de nome
SELECT nome FROM tb_artista
WHERE nome LIKE 'C%ta%a'
ORDER BY nome;

# Consulte o nome e minutos de cada disco exceto dos artistas 3 e 7 e mostre no resultado apenas aqueles que possuem o tempo entre 35 e 75 minutos
SELECT titulo_disco, tempo_disco FROM tb_disco
WHERE id_artista NOT IN (3, 7) AND tempo_disco BETWEEN 35 AND 75;
