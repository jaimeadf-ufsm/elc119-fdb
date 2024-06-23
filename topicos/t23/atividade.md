```sql
-- 1. Selecionar dados de filmes que tiveram artistas americanos (sem usar o distinct).
SELECT * FROM filme WHERE filme.idFilme IN (SELECT elenco.idFilme FROM elenco NATURAL JOIN ator WHERE ator.pais = 'EUA');

-- 2. Exibir a média de idade dos artistas que já trabalharam com Steven Spielberg.
SELECT AVG(IF(ator.falec IS NOT NULL, TIMESTAMPDIFF(YEAR, ator.nasc, ator.falec), TIMESTAMPDIFF(YEAR, ator.nasc, CURDATE()))) FROM ator WHERE ator.idAtor IN (SELECT elenco.idAtor FROM elenco NATURAL JOIN filme NATURAL JOIN diretor WHERE diretor.nome = 'Steven Spielberg');

-- 3. Exibir nome de artistas que não apareceram em nenhum dos filmes armazenados no banco,
SELECT ator.nome FROM ator WHERE ator.idAtor NOT IN (SELECT elenco.idAtor FROM elenco);

-- 4. Retornar nomes de diretores que não trabalharam com Leonardo DiCaprio.
SELECT diretor.nome FROM diretor WHERE diretor.idDiretor NOT IN (SELECT filme.idDiretor FROM filme NATURAL JOIN elenco NATURAL JOIN ator WHERE ator.nome = 'Leonardo DiCaprio');

-- 5. Retornar nomes de diretores que contaram com Leonardo DiCaprio em todos os seus filmes.
SELECT diretor.nome FROM diretor WHERE diretor.idDiretor NOT IN (SELECT filme.idDiretor FROM filme WHERE filme.idFilme NOT IN (SELECT elenco.idFilme FROM elenco NATURAL JOIN ator WHERE ator.nome = 'Leonardo DiCaprio'));

-- 6. Selecionar título de filmes que contaram com a participação do artista mais velho.
-- Mostrar também o nome do artista e a sua idade.
WITH atorComIdade AS (SELECT ator.idAtor, ator.nome, IF(ator.falec IS NOT NULL, TIMESTAMPDIFF(YEAR, ator.nasc, ator.falec), TIMESTAMPDIFF(YEAR, ator.nasc, CURDATE())) idade FROM ator)
SELECT filme.titulo, atorComIdade.nome, atorComIdade.idade FROM filme NATURAL JOIN elenco NATURAL JOIN atorComIdade WHERE atorComIdade.idade = (SELECT MAX(atorComIdade.idade) FROM atorComIdade);

-- 7. Selecionar título, ano e custo de filmes cujo custo de produção seja maior do que o custo médio de produção de todos os filmes.
SELECT filme.titulo, filme.ano, filme.custo FROM filme WHERE filme.custo > (SELECT AVG(filme.custo) FROM filme);

-- 8. Selecionar diretores cujo custo médio de produção de filmes seja maior do que o custo médio de produção de todos os filmes.
-- O custo médio de cada diretor também deve ser retornado.
SELECT diretor.nome, AVG(filme.custo) FROM diretor NATURAL JOIN filme GROUP BY diretor.idDiretor HAVING AVG(filme.custo) > (SELECT AVG(filme.custo) FROM filme);

-- 9. Selecionar o título de filmes que tiveram participação de artistas ou diretores ingleses.
SELECT filme.titulo FROM filme WHERE filme.idFilme IN (SELECT elenco.idFilme FROM elenco NATURAL JOIN ator WHERE ator.pais = 'Inglaterra') OR idDiretor IN (SELECT diretor.idDiretor FROM diretor WHERE diretor.nacionalidade = 'Inglaterra');

-- 10. Indicar, para cada país, quantas pessoas (diretores ou artistas) nasceram lá.
SELECT t.pais, COUNT(*) FROM ((SELECT ator.nome, ator.pais FROM ator) UNION (SELECT diretor.nome, diretor.nacionalidade FROM diretor)) t GROUP BY t.pais;
```