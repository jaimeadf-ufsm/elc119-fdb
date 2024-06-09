-- 1. Selecionar título, ano e bilheteria de filmes, em ordem descendente de bilheteria.
SELECT titulo, ano, bilheteria FROM filme ORDER BY bilheteria DESC;

-- 2. Para cada filme, exibir o título e o lucro como a proporção da bilheteria em relação ao custo.
SELECT titulo, bilheteria / custo lucro FROM filme;

-- 3. Retornar título de filmes que contaram com a participação de artistas com altura superior a 1.9 metros.
-- Mostrar o nome do artista e a altura também.
SELECT filme.titulo, ator.nome, ator.altura FROM filme, elenco, ator WHERE filme.idFilme = elenco.idFilme AND elenco.idAtor = ator.idAtor AND ator.altura > 1.9;

-- 4. Mostrar quantos filmes foram contracenados por cada sexo.
SELECT sexo, COUNT(DISTINCT filme.idFilme) FROM ator, elenco, filme WHERE ator.idAtor = elenco.idAtor AND elenco.idFilme = filme.idFilme GROUP BY ator.sexo;

-- 5. Para cada artista, retornar o nome e a quantidade de filmes dos quais ele participou.  
-- Ordenar pela contagem decrescente de filmes.
SELECT ator.nome, COUNT(*) participacoes FROM ator, elenco WHERE ator.idAtor = elenco.idAtor GROUP BY ator.idAtor ORDER BY participacoes DESC;

-- 6. Para cada filme, retornar o título e a quantidade de artistas.
-- Ordenar pela contagem crescente de artistas.
SELECT filme.titulo, COUNT(*) artistas FROM filme, elenco WHERE filme.idFilme = elenco.idFilme GROUP BY filme.idFilme ORDER BY artistas ASC;

-- 7. Mostrar título de filmes e de seus artistas.
SELECT filme.titulo, ator.nome FROM filme, elenco, ator WHERE filme.idFilme = elenco.idFilme AND elenco.idAtor = ator.idAtor;

-- 8. Retornar título e ano dos filmes estrelados por Leonardo DiCaprio.
SELECT filme.titulo, filme.ano FROM filme, elenco, ator WHERE filme.idFilme = elenco.idFilme AND elenco.idAtor = ator.idAtor AND ator.nome = 'Leonardo DiCaprio';

-- 9. Retornar a quantidade de filmes estrelados por Leonardo DiCaprio.
SELECT COUNT(*) quantidade FROM elenco, ator WHERE elenco.idAtor = ator.idAtor AND ator.nome = 'Leonardo DiCaprio';

-- 10. Retornar o título do filme, o nome do diretor e de seus artistas. 
-- Retorne ordenado, de modo que os registros referentes ao mesmo filme apareçam próximos um do outro.
SELECT filme.titulo, diretor.nome, ator.nome FROM filme, diretor, elenco, ator WHERE filme.idDiretor = diretor.idDiretor AND filme.idFilme = elenco.idFilme AND elenco.idAtor = ator.idAtor ORDER BY filme.idFilme;

-- Os próximos exercícios não serão avaliados, mas podem ser entregues junto com os demais.

-- 11. Retornar nome e idade de artistas, apenas para idades menores do que 30 ou maiores do que 70 anos.
SELECT nome, idade FROM (SELECT nome, IF(falec IS NOT NULL, TIMESTAMPDIFF(YEAR, nasc, falec), TIMESTAMPDIFF(YEAR, nasc, CURDATE())) idade FROM ator) derivada WHERE idade < 30 OR idade > 70;

-- 12. Exibir o título de filmes e o seu elenco. 
-- Os artistas devem ser exibidos juntos, separados por vírgula.
SELECT filme.titulo, GROUP_CONCAT(ator.nome) artistas FROM filme, elenco, ator WHERE filme.idFilme = elenco.idFilme AND elenco.idAtor = ator.idAtor GROUP BY filme.idFilme;

-- 13. Selecionar nomes de artistas que já trabalharam em filmes de 'Steven Spielberg'.
SELECT ator.nome FROM ator, elenco, filme, diretor WHERE ator.idAtor = elenco.idAtor AND elenco.idFilme = filme.idFilme AND filme.idDiretor = diretor.idDiretor AND diretor.nome = 'Steven Spielberg' GROUP BY ator.idAtor;

-- 14. Selecionar nomes de artistas que já trabalharam mais do que uma vez em filmes de 'Steven Spielberg'.
SELECT ator.nome FROM ator, elenco, filme, diretor WHERE ator.idAtor = elenco.idAtor AND elenco.idFilme = filme.idFilme AND filme.idDiretor = diretor.idDiretor AND diretor.nome = 'Steven Spielberg' GROUP BY ator.idAtor HAVING COUNT(*) > 1;

-- 15. Para cada diretor, exibir seu nome e o nome dos artistas que já trabalharam mais do que uma vez em seus filmes.
-- Exibir a quantidade de trabalhos de cada artista. 
SELECT diretor.nome, ator.nome, COUNT(*) trabalhos FROM diretor, filme, elenco, ator WHERE diretor.idDiretor = filme.idDiretor AND filme.idFilme = elenco.idFilme AND elenco.idAtor = ator.idAtor GROUP BY diretor.idDiretor, ator.idAtor HAVING trabalhos > 1;

-- 16 Selecione pares de filmes cujo título tenham os três primeiros caracteres iguais.
-- Para cada par encontrado, exiba os títulos.
-- Evite que o mesmo par seja retornado mais do que uma vez;
SELECT a.titulo, b.titulo FROM filme a, filme b WHERE a.idFilme < b.idFilme AND LEFT(a.titulo, 3) = LEFT(b.titulo, 3);