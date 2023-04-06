# Quantos autores tem na tabela?
SELECT COUNT(DISTINCT autor) AS quantidade_autores
FROM tb_livros;

# Quantas editoras tem na tabela?
SELECT COUNT(DISTINCT LOWER(editora)) AS quantidade_editoras
FROM tb_livros;

# Quais são os anos registrados?
SELECT DISTINCT ano_lancamento
FROM tb_livros
ORDER BY ano_lancamento ASC;

# Quais são os livros do ano mais antigo registrado?
SELECT
	titulo,
    autor
FROM tb_livros
WHERE ano_lancamento = (SELECT MIN(ano_lancamento) FROM tb_livros)
ORDER BY ano_lancamento;

# Quantas publicações tem em cada ano? 
SELECT
	ano_lancamento,
    COUNT(isbn) AS quantidade_livro
FROM tb_livros
GROUP BY ano_lancamento
ORDER BY quantidade_livro DESC;

# Quais são os livros dos anos 1978, 1980 e 1984?
SELECT
	isbn,
    titulo,
    autor,
    ano_lancamento
FROM tb_livros
WHERE ano_lancamento IN (1978, 1980, 1984)
ORDER BY ano_lancamento, titulo;

# Quais são os autores que escreveram 20 livros ou mais?
SELECT
	autor,
    COUNT(titulo) AS quantidade_livro
FROM tb_livros
GROUP BY autor
HAVING quantidade_livro >= 20
ORDER BY quantidade_livro DESC;

# Quais editoras publicaram 80 livros ou mais?
SELECT
	editora,
    COUNT(isbn) AS livros_publicados
FROM tb_livros
GROUP BY editora
HAVING livros_publicados >= 80
ORDER BY livros_publicados DESC;

# Quais são os livros com mais de 1 autor?
SELECT
	isbn,
    titulo,
    autor AS autores
FROM tb_livros
WHERE autor LIKE '% and %' OR
	  autor LIKE '%&%'
ORDER BY titulo;

# Para quais editoras os autores trabalharam?
SELECT DISTINCT
	LOWER(autor) as autor,
	editora
FROM tb_livros
ORDER BY autor, editora;

# Quais editoras possuem autores com mais de 6 livros escritos no século 20?
SELECT
	editora,
    autor,
    COUNT(isbn) AS quantidade_livros
FROM tb_livros
WHERE ano_lancamento < 2001
GROUP BY editora, autor
	HAVING quantidade_livros > 6
ORDER BY editora, autor;

# Informe os livros dos últimos 30 anos que possuam ISBN par, com os autores com nomes de até 17 caracteres e livros de até 30 caracteres, onde os anos são bissextos, ordenando por livro
SELECT
	isbn,
    titulo,
    autor,
    ano_lancamento
FROM tb_livros
WHERE
	isbn % 2 = 0 AND
    CHARACTER_LENGTH(titulo) < 30 AND
    CHARACTER_LENGTH(autor) < 18 AND
    ano_lancamento % 4 = 0 AND
    ano_lancamento >= YEAR(NOW()) - 30
ORDER BY titulo;

# Indique os autores que começem com a letra 'A', que tenham 'H' no meio e 'A' com penúltima letra
SELECT DISTINCT autor
FROM tb_livros
WHERE autor LIKE 'A%H%A_'
ORDER BY autor;

# Mostre o autor/autores com o maior nome
SELECT
	autor,
	LENGTH(autor) AS tamanho_nome
FROM tb_livros
WHERE LENGTH(autor) = (SELECT MAX(LENGTH(autor)) FROM tb_livros);

# Quais são os livros do autor/dos autores com menor nome
SELECT
	autor,
	titulo
FROM tb_livros
WHERE LENGTH(autor) = (SELECT MIN(LENGTH(autor)) FROM tb_livros)
ORDER BY autor;