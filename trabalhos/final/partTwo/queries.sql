USE olympics;

-- Selecionar o nome de todos os atletas que participaram em olimpíadas desde 2010
SELECT
    name
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
    NATURAL JOIN result
GROUP BY
    athlete.name
HAVING
    sportCount > 1
ORDER BY
    sportCount DESC;

-- Selecionar o número de medalhas por país
SELECT
    athlete.noc AS noc,
    COUNT(result.medalId) AS medalCount
FROM
    athlete
    NATURAL JOIN result
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

-- Selecionar atletas que competiram mais de uma vez no mesmo esporte, mesma modalidade e mesma edição 
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

-- Selecionar atletas que ganharam mais de 1 medalha em uma edição
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
    (athlete.athleteId, edition.editionId) IN (
        SELECT
            athlete.athleteId,
            result.editionId
        FROM
            athlete
            JOIN result ON athlete.athleteId = result.athleteId
        GROUP BY
            athlete.athleteId,
            result.editionId
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

-- Selecionar a porcentagem de participantes por gênero em relação ao total
WITH
    allParticipants AS (
        SELECT
            COUNT(DISTINCT athleteId) totalParticipantCount
        FROM
            participant
    )
SELECT
    athlete.sex sex,
    COUNT(*) participantCount,
    ROUND(
        (COUNT(*) * 100.0) / allParticipants.totalParticipantCount,
        2
    ) participantPercentage
FROM
    athlete,
    allParticipants
WHERE
    athlete.athleteId IN (
        SELECT
            athleteId
        FROM
            participant
    )
GROUP BY
    athlete.sex,
    allParticipants.totalParticipantCount;

-- Selecionar a porcentagem de ganhadores de medalha por gênero
WITH
    minimumResult AS (
        SELECT
            result.athleteId,
            MIN(result.medalId) medalId
        FROM
            result
        GROUP BY
            athleteId
    )
SELECT
    athlete.sex sex,
    COUNT(minimumResult.medalId) medalWinnerCount,
    ROUND(
        (COUNT(minimumResult.medalId) * 100.0) / COUNT(*),
        2
    ) medalWinnerPercentage
FROM
    athlete
    NATURAL LEFT JOIN minimumResult
WHERE
    athlete.athleteId IN (
        SELECT
            athleteId
        FROM
            participant
    )
GROUP BY
    athlete.sex;

-- Selecionar a porcentagem de medalhas de cada tipo por gênero
SELECT
    athlete.sex,
    medal.name,
    COUNT(result.medalId) AS medalCount,
    ROUND(
        (COUNT(result.medalId) * 100.0) / total.medalCount,
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
        GROUP BY
            athlete.sex
    ) AS total ON athlete.sex = total.sex
GROUP BY
    athlete.sex,
    medal.name;
    