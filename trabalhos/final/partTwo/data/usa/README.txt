Projeto de Banco de Dados de Olimpíadas
Descrição do Projeto
Este projeto foi desenvolvido como parte da disciplina de Fundamentos de Bancos de Dados. O objetivo principal foi criar uma base de dados e povoá-la com dados reais sobre as Olimpíadas utilizando SQL.

---------------------------------------------------------------------------------------------------------------------------------

Estrutura do Banco de Dados
O banco de dados foi estruturado com base em quatro tabelas, sendo que uma delas representa um relacionamento muitos-para-muitos (n:n). 

As tabelas criadas são:

Olympics: Contém informações sobre as edições das Olimpíadas (verão e inverno).

Athlete: Contém informações sobre os atletas participantes.

Sports: Contém informações sobre as modalidades esportivas.

Participation: Tabela de relacionamento muitos-para-muitos entre Athlete e Olympics, registrando em quais edições de olimpiada um atleta já participou.

---------------------------------------------------------------------------------------------------------------------------------

Coleta de Dados

Edições das Olimpíadas
Os dados das edições das Olimpíadas foram extraídos da Wikipédia utilizando a biblioteca Beautiful Soup do Python. Esta biblioteca facilita a extração e o parsing de dados de páginas HTML.

Atletas
Os dados sobre os atletas foram obtidos do site teamusa.com. Ao inspecionar a página, foi identificado que o site utiliza uma API para carregar os dados dos atletas. A URL da API permite ajustar os parâmetros para selecionar diferentes quantidades de dados. Um script em Python foi desenvolvido para utilizar essa API e povoar a tabela de atletas no banco de dados.

---------------------------------------------------------------------------------------------------------------------------------

Scripts

Criação do Banco de Dados: O script SQL de criação do banco de dados contém todas as instruções DDL necessárias para criar as tabelas descritas acima.

População do Banco de Dados: O script SQL de população do banco de dados contém instruções DML para inserir dados nas tabelas. Apesar de termos automatizado a coleta e inserção de dados utilizando Python, incluímos também inserções "manuais" no arquivo SQL.

---------------------------------------------------------------------------------------------------------------------------------

Ferramentas Utilizadas

Python: Para extrair e processar os dados das fontes mencionadas.

Beautiful Soup: Biblioteca Python para web scraping, utilizada para extrair dados da Wikipédia.

API do teamusa.com: Fonte de dados sobre os atletas, acessada e manipulada via um script Python.

SQL: Linguagem utilizada para criar e povoar o banco de dados.

---------------------------------------------------------------------------------------------------------------------------------

Criação e População das Tabelas:

Execute o script start.sql para criar  as tabelas no banco de dados e inserir os dados.