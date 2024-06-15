-- 1. Selecionar dados de artistas que já faleceram.
SELECT * FROM ator WHERE falec IS NOT NULL;

-- 2. Retornar o nome e altura de atrizes, da mais alta para a mais baixa.
SELECT nome, altura FROM ator WHERE sexo = 'F' ORDER BY altura DESC;

-- 3. Mostrar uma contagem das alturas dos artistas.
-- Exibir a altura apenas caso ela seja compartilhada por pelo menos dois artistas.
-- Não exibir a contagem dos artistas cuja altura não foi informada.
SELECT altura, COUNT(*) contagem FROM ator WHERE altura IS NOT NULL GROUP BY altura HAVING contagem >= 2;

-- 4. Exibir o título e a média de altura dos artistas de cada filme.
SELECT filme.titulo, AVG(ator.altura) FROM filme NATURAL JOIN elenco NATURAL JOIN ator GROUP BY filme.idFilme;

-- 5. Exibir o país de origem e a quantidade de filmes que contarem com artistas daquele país.
SELECT ator.pais, COUNT(DISTINCT filme.idFilme) quantidade FROM filme NATURAL JOIN elenco NATURAL JOIN ator GROUP BY pais;

-- 6. Exibir a quantidade de filmes por nacionalidade e sexo dos artistas envolvidos.
-- Ou seja, deve ser exibida uma contagem para cada par de país e sexo.
SELECT ator.pais, ator.sexo, COUNT(DISTINCT filme.idFilme) quantidade FROM filme NATURAL JOIN elenco NATURAL JOIN ator GROUP BY pais, sexo;

-- 7. Para cada filme, retornar o título, o diretor e a quantidade de artistas.
SELECT filme.titulo, diretor.nome, COUNT(*) artistas FROM filme NATURAL JOIN diretor NATURAL JOIN elenco GROUP BY filme.idFilme;

-- 8. Retornar nome do artista e título dos filmes estrelados por artistas cujo nome comece com 'Tom'.
SELECT ator.nome, filme.titulo FROM ator NATURAL JOIN elenco NATURAL JOIN filme WHERE ator.nome LIKE 'Tom%';

-- 9. Mostrar título, ano e os artistas de cada filme produzido entre 2008 e 2009.
-- Filmes sem artistas registrados também devem ser exibidos.
SELECT filme.titulo, filme.ano, ator.nome FROM filme NATURAL LEFT JOIN elenco NATURAL LEFT JOIN ator WHERE filme.ano BETWEEN 2008 AND 2009;

-- 10. Mostrar título de filmes e a contagem de artistas.
-- Filmes sem artistas devem receber a contagem zero.
SELECT filme.titulo, COUNT(elenco.idAtor) FROM filme NATURAL LEFT JOIN elenco GROUP BY filme.idFilme;

-- Os próximos exercícios não serão avaliados, mas podem ser entregues junto com os demais.

-- 11. Retornar o título do filme, o nome do diretor e de seus artistas.
SELECT filme.titulo, diretor.nome, ator.nome FROM filme NATURAL JOIN elenco NATURAL JOIN ator JOIN diretor ON filme.idDiretor = diretor.idDiretor;

-- 12. Retornar o título do filme, o nome do diretor e de seus artistas.
-- Filmes sem artistas também devem ser retornados (no caso, Avatar).
SELECT filme.titulo, diretor.nome, ator.nome FROM filme NATURAL LEFT JOIN elenco NATURAL LEFT JOIN ator JOIN diretor ON filme.idDiretor = diretor.idDiretor;

-- 13. Retornar o título do filme, o nome do diretor.
-- Apenas filmes sem artistas devem ser retornados (no caso, Avatar).
SELECT filme.titulo, diretor.nome FROM filme NATURAL JOIN diretor NATURAL LEFT JOIN elenco WHERE elenco.idFilme IS NULL;

-- 14. Exibir duas colunas. Uma contendo o título do filme e outra exibindo a sua sequência.
-- Filmes sem sequência não precisam ser retornados.
SELECT filme_atual.titulo, filme_sequencia.titulo FROM filme filme_atual JOIN filme filme_sequencia ON filme_atual.idFilme = filme_sequencia.idFilmeAnterior;

-- 15. Exibir duas colunas. Uma contendo o título do filme e outra exibindo a sua sequência.
-- Filmes sem sequência também precisam ser retornados.
SELECT filme_atual.titulo, filme_sequencia.titulo FROM filme filme_atual LEFT JOIN filme filme_sequencia ON filme_atual.idFilme = filme_sequencia.idFilmeAnterior;

-- 16. Exibir o título do filme e o título da sua sequência.
-- O diretor de cada filme deve ser exibido.
-- Filmes sem sequência também precisam ser retornados.
SELECT filme_atual.titulo, diretor_atual.nome, filme_sequencia.titulo, diretor_sequencia.nome FROM filme filme_atual JOIN diretor diretor_atual ON filme_atual.idDiretor = diretor_atual.idDiretor LEFT JOIN filme filme_sequencia ON filme_atual.idFilme = filme_sequencia.idFilmeAnterior LEFT JOIN diretor diretor_sequencia ON filme_sequencia.idDiretor = diretor_sequencia.idDiretor;
