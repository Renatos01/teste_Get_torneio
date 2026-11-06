CREATE DATABASE IF NOT EXISTS gestao_torneios;
USE gestao_torneios;

CREATE TABLE Equipas (
    ID_Equipa INT AUTO_INCREMENT PRIMARY KEY,
    Nome_Equipa VARCHAR(100) NOT NULL,
    Data_Criacao DATE NOT NULL
);

CREATE TABLE Jogadores (
    ID_Jogador INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Nickname VARCHAR(50) NOT NULL,
    Data_Nascimento DATE NOT NULL,
    ID_Equipa INT NOT NULL,
    FOREIGN KEY (ID_Equipa) REFERENCES Equipas(ID_Equipa)
);

CREATE TABLE Torneios (
    ID_Torneio INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Data_Inicio DATE NOT NULL,
    Premio_Monetario DECIMAL(10, 2) NOT NULL,
    CHECK (Premio_Monetario >= 0)
);

CREATE TABLE Participacoes (
    ID_Equipa INT NOT NULL,
    ID_Torneio INT NOT NULL,
    PRIMARY KEY (ID_Equipa, ID_Torneio),
    FOREIGN KEY (ID_Equipa) REFERENCES Equipas(ID_Equipa),
    FOREIGN KEY (ID_Torneio) REFERENCES Torneios(ID_Torneio)
);

INSERT INTO Equipas (Nome_Equipa, Data_Criacao) VALUES
    ('Malfica', '2020-03-15'),
    ('Jumentus', '2019-08-22');

INSERT INTO Jogadores (Nome, Nickname, Data_Nascimento, ID_Equipa) VALUES
    ('Joao', 'JoaozinhoL2R2', '2002-05-10', 1),
    ('Manuel', 'Manu_noy._.', '2001-11-24', 2);

INSERT INTO Torneios (Nome, Data_Inicio, Premio_Monetario) VALUES
    ('WORLD COPOS', '2026-06-10', 5000.00),
    ('Copa da terrinha', '2026-07-15', 2500.00),
    ('Torneio Mundial dos Tremossos', '2026-09-01', 10000.00);

INSERT INTO Participacoes (ID_Equipa, ID_Torneio) VALUES
    (1, 1),
    (2, 1),
    (1, 2),
    (2, 3);

SELECT DISTINCT Nome
FROM Jogadores
ORDER BY Nome ASC;

SELECT j.Nome AS Jogador, e.Nome_Equipa AS Equipa
FROM Jogadores AS j
INNER JOIN Equipas AS e ON e.ID_Equipa = j.ID_Equipa
ORDER BY j.Nome ASC;

-- c. Equipas que participam na Liga Nacional
SELECT DISTINCT e.Nome_Equipa AS Equipa
FROM Equipas AS e
INNER JOIN Participacoes AS p ON p.ID_Equipa = e.ID_Equipa
INNER JOIN Torneios AS t ON t.ID_Torneio = p.ID_Torneio
WHERE t.Nome = 'Liga Nacional'
ORDER BY e.Nome_Equipa ASC;


SELECT e.Nome_Equipa AS Equipa, COUNT(j.ID_Jogador) AS Numero_Jogadores
FROM Equipas AS e
INNER JOIN Jogadores AS j ON j.ID_Equipa = e.ID_Equipa
GROUP BY e.ID_Equipa, e.Nome_Equipa
HAVING COUNT(j.ID_Jogador) > 1
ORDER BY e.Nome_Equipa ASC;

-- e. Todas as equipas e respetivo número de jogadores, incluindo equipas sem jogadores
SELECT e.Nome_Equipa AS Equipa, COUNT(j.ID_Jogador) AS Numero_Jogadores
FROM Equipas AS e
LEFT JOIN Jogadores AS j ON j.ID_Equipa = e.ID_Equipa
GROUP BY e.ID_Equipa, e.Nome_Equipa
ORDER BY Numero_Jogadores DESC, e.Nome_Equipa ASC;


SELECT t.Nome AS Torneio,
       t.Premio_Monetario AS Premio_Monetario,
       COUNT(DISTINCT p.ID_Equipa) AS Numero_Equipas
FROM Torneios AS t
INNER JOIN Participacoes AS p ON p.ID_Torneio = t.ID_Torneio
GROUP BY t.ID_Torneio, t.Nome, t.Premio_Monetario
ORDER BY t.Nome ASC;