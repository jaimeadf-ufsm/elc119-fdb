USE olympics;

-- Selecionar o nome de todos os atletas que participaram em olimpíadas desde 2010
SELECT DISTINCT
    athlete.name
FROM
    athlete
    NATURAL JOIN participant
    NATURAL JOIN edition
WHERE
    edition.year >= 2010;

-- Selecionar o nome de atletas que apenas participaram em olimpíadas a partir do ano 2000
SELECT
    name
FROM
    athlete
WHERE
    athleteId NOT IN (
        SELECT
            athleteId
        FROM
            athlete
            NATURAL JOIN participant
            NATURAL JOIN edition
        WHERE
            edition.year < 2000
    );

-- Selecionar atletas que ganharam medalha em 2016
SELECT DISTINCT
    name
FROM
    athlete
    NATURAL JOIN result
    NATURAL JOIN edition
WHERE
    edition.year = 2016
    AND result.medalId IS NOT NULL;

-- Selecionar todos os atletas que competiram mais de uma vez na mesma competição
SELECT
    athlete.name,
    edition.alternateTitle,
    sport.name,
    event.name
FROM
    athlete
    JOIN result ON athlete.athleteId = result.athleteId
    JOIN edition ON result.editionId = edition.editionId
    JOIN sport ON result.sportId = sport.sportId
    JOIN event ON result.eventId = event.eventId
GROUP BY
    athlete.name,
    edition.alternateTitle,
    sport.name,
    event.name
HAVING
    COUNT(*) > 1;

-- Selecionar olimpiadas cujos jogos ocorreram em mais de uma cidade
SELECT DISTINCT
    edition.alternateTitle,
    city.name
FROM
    edition
    NATURAL JOIN host
    NATURAL JOIN city
WHERE
    edition.editionId IN (
        SELECT
            editionId
        FROM
            host
        GROUP BY
            editionId
        HAVING
            COUNT(DISTINCT cityId) > 1
    );

-- Selecionar a média de altura e média de peso por gênero
SELECT
    sex,
    AVG(height) AS averageHeight,
    AVG(weight) AS averageWeight
FROM
    athlete
GROUP BY
    sex;

-- Selecionar atletas que participaram em mais de 1 esporte
SELECT
    athlete.name AS athleteName,
    COUNT(DISTINCT result.sportId) AS sportCount
FROM
    athlete
    JOIN result ON athlete.athleteId = result.athleteId
GROUP BY
    athlete.name
HAVING
    sportCount > 1
ORDER BY
    sportCount DESC;

-- Selecionar o número de medalhas por pais
SELECT
    athlete.noc AS noc,
    COUNT(result.medalId) AS medalCount
FROM
    athlete
    JOIN result ON athlete.athleteId = result.athleteId
WHERE
    result.medalId IS NOT NULL
GROUP BY
    athlete.noc
ORDER BY
    medalCount DESC;

-- Selecionar o número de atletas por país
SELECT
    noc AS country,
    COUNT(*) AS athleteCount
FROM
    athlete
GROUP BY
    noc;

-- Selecionar atletas que ganharam mais de uma medalha no mesmo esporte, modalidade e edição 
SELECT
    athlete.name AS athleteName,
    edition.year AS editionYear,
    edition.season AS editionSeason,
    sport.name AS sportName,
    event.name AS eventName,
    medal.name AS medalName
FROM
    athlete
    JOIN result ON athlete.athleteId = result.athleteId
    JOIN edition ON result.editionId = edition.editionId
    JOIN medal ON result.medalId = medal.medalId
    JOIN event ON result.eventId = event.eventId
    JOIN sport ON event.sportId = sport.sportId
WHERE
    (athlete.athleteId, edition.editionId, event.eventId) IN (
        SELECT
            athlete.athleteId,
            edition.editionId,
            event.eventId
        FROM
            athlete
            JOIN result ON athlete.athleteId = result.athleteId
            JOIN edition ON result.editionId = edition.editionId
            JOIN event ON result.eventId = event.eventId
        WHERE
            result.medalId IS NOT NULL
        GROUP BY
            athlete.athleteId,
            edition.editionId,
            event.eventId
        HAVING
            COUNT(result.medalId) > 1
    )
ORDER BY
    athlete.name,
    edition.year,
    edition.season,
    sport.name,
    event.name,
    medal.name;

-- Selecionar atletas que ganharam mmais de 1 medalha em uma edição
SELECT
    athlete.name AS athleteName,
    edition.year AS editionYear,
    edition.season AS editionSeason,
    sport.name AS sportName,
    event.name AS eventName,
    medal.name AS medalName
FROM
    athlete
    JOIN result ON athlete.athleteId = result.athleteId
    JOIN edition ON result.editionId = edition.editionId
    JOIN medal ON result.medalId = medal.medalId
    JOIN event ON result.eventId = event.eventId
    JOIN sport ON event.sportId = sport.sportId
WHERE
    (athlete.name, edition.year, edition.season) IN (
        SELECT
            athlete.name,
            edition.year,
            edition.season
        FROM
            athlete
            JOIN result ON athlete.athleteId = result.athleteId
            JOIN edition ON result.editionId = edition.editionId
        WHERE
            result.medalId IS NOT NULL
        GROUP BY
            athlete.name,
            edition.year,
            edition.season
        HAVING
            COUNT(result.medalId) > 1
    )
ORDER BY
    athlete.name,
    edition.year,
    edition.season,
    sport.name,
    event.name,
    medal.name;

-- Selecionar a relação participação e conquista por gênero
SELECT
    athlete.sex AS athleteSex,
    COUNT(DISTINCT athlete.athleteId) AS participantsCount,
    COUNT(
        DISTINCT CASE
            WHEN result.medalId IS NOT NULL THEN athlete.athleteId
        END
    ) AS medalWinnersCount,
    ROUND(
        (COUNT(DISTINCT athlete.athleteId) * 100.0) / (
            SELECT
                COUNT(DISTINCT athlete.athleteId)
            FROM
                athlete
        ),
        2
    ) AS participantionPercentage,
    ROUND(
        (
            COUNT(
                DISTINCT CASE
                    WHEN result.medalId IS NOT NULL THEN athlete.athleteId
                END
            ) * 100.0
        ) / COUNT(DISTINCT athlete.athleteId),
        2
    ) AS medalWinnersPercentage
FROM
    athlete
    LEFT JOIN result ON athlete.athleteId = result.athleteId
GROUP BY
    athlete.sex,
    result.medalId;

-- Selecionar a porcentagem de medalhas de cada tipo por gênero
SELECT
    athlete.sex,
    medal.name,
    COUNT(result.medalId) AS medalCount,
    ROUND(
        (COUNT(result.medalId) * 100.0) / NULLIF(total.medalCount, 0),
        2
    ) AS medalPercentage
FROM
    athlete
    JOIN result ON athlete.athleteId = result.athleteId
    JOIN medal ON result.medalId = medal.medalId
    JOIN (
        SELECT
            athlete.sex,
            COUNT(result.medalId) AS medalCount
        FROM
            athlete
            JOIN result ON athlete.athleteId = result.athleteId
        WHERE
            result.medalId IS NOT NULL
        GROUP BY
            athlete.sex
    ) AS total ON athlete.sex = total.sex
WHERE
    result.medalId IS NOT NULL
GROUP BY
    athlete.sex,
    medal.name,
    total.medalCount;