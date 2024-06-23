```sql
-- 1. Selecionar dados de filmes que tiveram sequência.
SELECT * FROM filme WHERE idFilme IN (SELECT idFilmeAnterior FROM filme);

-- 2. Exibir a média de altura dos artistas que participaram de filmes após o ano 2000.
SELECT AVG(altura) FROM ator WHERE idAtor IN (SELECT idAtor FROM elenco WHERE idFilme IN (SELECT idFilme FROM filme WHERE ano > 2000));

-- 3. Exibir título de filmes que não tiveram nenhum artista registrado.
SELECT titulo FROM filme WHERE idFilme NOT IN (SELECT idFilme FROM elenco);

-- 4. Exibir nomes de artistas que nunca trabalharam com diretores americanos.
SELECT nome FROM ator WHERE idAtor NOT IN (SELECT idAtor FROM elenco WHERE idFilme IN (SELECT idFilme FROM filme WHERE idDiretor IN (SELECT idDiretor FROM diretor WHERE nacionalidade = 'EUA')));

-- 5. Exibir nomes de artistas que só trabalharam com diretores americanos.
SELECT nome FROM ator WHERE idAtor NOT IN (SELECT idAtor FROM elenco WHERE idFilme IN (SELECT idFilme FROM filme WHERE idDiretor NOT IN (SELECT idDiretor FROM diretor WHERE nacionalidade = 'EUA'))) AND idAtor IN (SELECT idAtor FROM elenco);

-- 6. Selecionar título de filmes que contaram com a participação do artista mais alto.
SELECT titulo FROM filme WHERE idFilme IN (SELECT idFilme FROM elenco WHERE idAtor IN (SELECT idAtor FROM ator WHERE altura = (SELECT MAX(altura) FROM ator)));

-- 7. Selecionar nome de diretores que contaram com a participacao do artista mais alto.
SELECT nome FROM diretor WHERE idDiretor IN (SELECT idDiretor FROM filme WHERE idFilme IN (SELECT idFilme FROM elenco WHERE idAtor IN (SELECT idAtor FROM ator WHERE altura = (SELECT MAX(altura) FROM ator))));

-- 8. Selecionar título e custo de filmes que tiveram o custo maior do que alguma bilheteria.
SELECT titulo, custo FROM filme WHERE custo > SOME (SELECT bilheteria FROM filme);

-- 9. Retornar uma única coluna contendo nomes de artistas ou diretores que sejam dos Estados Unidos.
(SELECT nome FROM ator WHERE pais = 'EUA') UNION (SELECT nome FROM diretor WHERE nacionalidade = 'EUA');

-- 10. Selecionar a quantidade de pessoas (diretores ou artistas) que sejam dos Estados Unidos.
SELECT COUNT(*) FROM ((SELECT nome FROM ator WHERE pais = 'EUA') UNION (SELECT nome FROM diretor WHERE nacionalidade = 'EUA')) as derivada;

-- Os próximos exercícios não serão avaliados, mas podem ser entregues junto com os demais.

-- 11. Exibir título de filmes que tiveram participantes tanto do sexo masculino quanto feminino.
SELECT titulo FROM filme WHERE idFilme IN (SELECT idFilme FROM elenco WHERE idAtor IN (SELECT idAtor FROM ator WHERE sexo = 'M')) AND idFilme IN (SELECT idFilme FROM elenco WHERE idAtor IN (SELECT idAtor FROM ator WHERE sexo = 'F'));

-- 12. Exibir filmes que não tiveram participantes tanto do sexo masculino quanto feminino.
SELECT titulo FROM filme WHERE idFilme NOT IN (SELECT idFilme FROM elenco WHERE idAtor IN (SELECT idAtor FROM ator WHERE sexo = 'M')) OR idFilme NOT IN (SELECT idFilme FROM elenco WHERE idAtor IN (SELECT idAtor FROM ator WHERE sexo = 'F'));

-- 13. Para cada filme exibir três colunas contendo o título, a quantidade de artistas do sexo feminino e a quantidade de artistas do sexo masculino.
SELECT titulo, (SELECT COUNT(*) FROM elenco WHERE idFilme = filme.idFilme AND idAtor IN (SELECT idAtor FROM ator WHERE sexo = 'F')) atoresFemininos, (SELECT COUNT(*) FROM elenco WHERE idFilme = filme.idFilme AND idAtor IN (SELECT idAtor FROM ator WHERE sexo = 'M')) atoresMasculinos FROM filme;

-- 14. Para cada diretor exibir o seu nome, a quantidade de
-- artistas do sexo feminino e a quantidade de artistas do sexo masculino com os quais ele já trabalhou.
SELECT nome, (SELECT COUNT(*) FROM ator WHERE idAtor IN (SELECT idAtor FROM elenco WHERE idFilme IN (SELECT idFilme FROM filme WHERE diretor.idDiretor = filme.idDiretor)) AND sexo = 'F') atoresFemininos, (SELECT COUNT(*) FROM ator WHERE idAtor IN (SELECT idAtor FROM elenco WHERE idFilme IN (SELECT idFilme FROM filme WHERE diretor.idDiretor = filme.idDiretor)) AND sexo = 'M') atoresMasculinos FROM diretor;

-- 15. Exibir o nome do diretor que mais trabalhou com artistas do sexo feminino.
-- Mostrar a quantidade de artistas respectiva.
SELECT * FROM (SELECT nome, (SELECT COUNT(*) FROM ator WHERE idAtor IN (SELECT idAtor FROM elenco WHERE idFilme IN (SELECT idFilme FROM filme WHERE diretor.idDiretor = filme.idDiretor)) AND sexo = 'F') qtd FROM diretor) derivada1 WHERE qtd = (SELECT MAX(qtd) FROM (SELECT nome, (SELECT COUNT(*) FROM ator WHERE idAtor IN (SELECT idAtor FROM elenco WHERE idFilme IN (SELECT idFilme FROM filme WHERE diretor.idDiretor = filme.idDiretor)) AND sexo = 'F') qtd FROM diretor) derivada2);

-- 16. Retorne quantos filmes estão catalogados considerando a primeira letra do título.
-- O resultado deve exibir a contagem para as letras de A e F, mesmo que a contage seja zero.
SELECT letra, (SELECT COUNT(*) FROM filme WHERE LEFT(titulo, 1) = letra) contagem FROM ((SELECT 'A' letra) UNION (SELECT 'B') UNION (SELECT 'C') UNION (SELECT 'D') UNION (SELECT 'E') UNION (SELECT 'F')) derivada;
```