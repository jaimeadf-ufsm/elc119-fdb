```sql
CREATE TABLE Juiz(
    idJuiz INT,
    nome VARCHAR,
    pais VARCHAR,
    PRIMARY KEY (idJuiz)
);

CREATE TABLE Jogador(
    idJogador INT,
    nome VARCHAR,
    time VARCHAR,
    PRIMARY KEY (idJogador)
);

CREATE TABLE TipoCartao(
    data DATE,
    tempo TIME,
    idJogador INT,
    cartao VARCHAR,
    idJuiz INT,
    PRIMARY KEY (data, tempo, idJogador),
    FOREIGN KEY (idJogador) REFERENCES Jogador(idJogador),
    FOREIGN KEY (idJuiz) REFERENCES Juiz(idJuiz)
);

INSERT INTO Juiz(idJuiz, nome, pais)
VALUES
(1, 'Meira Ricci', 'Brasil'),
(2, 'Óscar Ruiz', 'Colômbia'),
(3, 'Amarilla', 'Paraguai');

INSERT INTO Jogador(idJogador, nome, time)
VALUES
(1, 'Higuita', 'Colômbia'),
(2, 'Maradona', 'Argentina'),
(3, 'Messi', 'Argentina'),
(4, 'F. Melo', 'Brasil');

INSERT INTO TipoCartao(data, tempo, idJogador, cartao, idJuiz)
VALUES
('2014-06-15', '00:23:00', 1, 'amarelo', 1),
('2014-06-15', '00:11:00', 2, 'vermelho', 2),
('2014-06-16', '01:00:00', 3, 'amarelo', 3),
('2014-06-16', '00:14:00', 4, 'amarelo', 2),
('2014-06-16', '00:24:00', 4, 'vermelho', 2),
('2014-06-16', '00:23:00', 3, 'amarelo', 3);
```