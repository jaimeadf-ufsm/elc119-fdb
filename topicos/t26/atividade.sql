-- 1. Exibir dados de artistas que nasceram em países do Reino Unido.
SELECT * FROM ator WHERE pais LIKE 'Reino Unido' OR pais LIKE 'Inglaterra' OR pais LIKE 'Escócia' OR pais LIKE 'País de Gales' OR pais LIKE 'Irlanda do Norte';

-- 2. Para cada artista, exibir seu nome e o intervalo de anos entre o seu filme mais antigo e o mais recente.
-- Considerar apenas os casos em que o artista tenha realizado mais do que um filme.
SELECT nome, MAX(ano) - MIN(ano) FROM ator NATURAL JOIN elenco NATURAL JOIN filme GROUP BY idAtor HAVING COUNT(*) > 1;

-- 3. Exibir nomes de diretores que só dirigiram um filme.
SELECT nome FROM filme NATURAL JOIN diretor GROUP BY idDiretor HAVING COUNT(*) = 1;

-- 4. Exibir título, custo e bilheteria de filmes cujo custo foi menos de 20% do valor arrecadado em bilheteria.
SELECT titulo, custo, bilheteria FROM filme WHERE (custo / bilheteria) < 0.2;

-- 5. Selecione o sexo e a média de idade dos artistas, por sexo.
-- Use 'Masculino' e 'Feminimo' na resposta.
SELECT IF(sexo = 'M', 'Masculino', 'Feminimo') sexo, AVG(IF(falec IS NOT NULL, TIMESTAMPDIFF(YEAR, nasc, falec), TIMESTAMPDIFF(YEAR, nasc, CURDATE()))) idade FROM ator GROUP BY sexo;

-- 6. Retornar, para cada filme, o título e a quantidade de artistas do sexo feminino.
SELECT titulo, COUNT(ator.idAtor) artistasFeminos FROM filme NATURAL JOIN elenco LEFT JOIN ator ON elenco.idAtor = ator.idAtor AND ator.sexo = 'F' GROUP BY idFilme;

-- 7. Encontrar diretores que atuaram em seus próprios filmes.
-- Para cada ocorrência encontrada, retornar o nome do diretor e o título do filme.
SELECT diretor.nome, filme.titulo FROM filme NATURAL JOIN diretor NATURAL JOIN elenco JOIN ator ON elenco.idAtor = ator.idAtor WHERE diretor.nome LIKE ator.nome;

-- 8. Selecionar título de filmes e bilheteria para casos em que a bilheteria seja menor do que o custo de produção de todos os filmes do Cristopher Nolan.
SELECT titulo, bilheteria FROM filme WHERE bilheteria < ALL (SELECT custo FROM filme NATURAL JOIN diretor WHERE nome = 'Cristopher Nolan');

-- 9. Selecionar título de filmes que tiveram o custo maior do que a bilheteria de todos os filmes de roberto benigni.
-- O custo também deve ser exibido.
SELECT titulo, custo FROM filme WHERE custo > ALL (SELECT bilheteria FROM filme NATURAL JOIN diretor WHERE nome = 'Roberto Benigni');

-- 10. Selecionar filmes que tiveram o custo maior do que a bilheteria de todos os filmes de algum diretor.
-- Mostrar o custo também.
SELECT * FROM filme WHERE custo > SOME (SELECT MAX(bilheteria) FROM filme NATURAL JOIN diretor GROUP BY filme.idDiretor);

-- Os próximos exercícios não serão avaliados, mas podem ser entregues junto com os demais.


-- 11. Retornar o id do diretor que tenha o maior custo médio na realização de filmes.
-- Exibir esse custo também.

-- 12. Retornar o nome do diretor que tenha o maior custo médio na realização de filmes.

-- 13. Para cada filme, mostrar o título bem como a contagem de artistas americanos e não americanos.

-- 14. Selecionar artistas que trabalharam em todos os filmes do Martin Scorcese.

-- 15. Selecionar artistas que trabalharam em todos os filmes de algum diretor.
-- Exibir o nome do artista e o nome do diretor.

-- 16. Retornar em uma única coluna os nomes de artistas ou diretores que sejam dos Estados Unidos.
-- Crie uma coluna adicional indicando se a pessoa é diretor ou artista.