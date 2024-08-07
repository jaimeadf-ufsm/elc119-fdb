USE olympics;

-- Selecionar o nome de todos os atletas que participaram em olimpíadas desde 2010
SELECT
    name
FROM
    athlete
    NATURAL JOIN participant
    NATURAL JOIN edition
WHERE
    edition.year >= 2010
GROUP BY
    athleteId;

-- Selecionar atletas que ganharam medalhas em 2016
SELECT
    name
FROM
    athlete
    NATURAL JOIN result
    NATURAL JOIN edition
WHERE
    edition.year = 2016
    AND result.medalId IS NOT NULL
GROUP BY
    athleteId;

-- Selecionar todos os atletas que participaram de mais de uma olimpíada
SELECT
    athlete.name,
    edition.alternateTitle
FROM
    athlete
    NATURAL JOIN participant
    NATURAL JOIN edition
WHERE
    athlete.athleteId IN (
        SELECT
            participant.athleteId
        FROM
            participant
        GROUP BY
            participant.athleteId
        HAVING
            COUNT(DISTINCT participant.editionId) > 1
    )
GROUP BY
    athlete.athleteId,
    edition.editionId
ORDER BY
    athlete.name,
    edition.alternateTitle;

-- Selecionar olimpíadas cujos jogos ocorreram em mais de uma cidade
SELECT
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
    )
GROUP BY
    editionId,
    cityId;

-- Selecionar a média de altura e a média de peso por gênero
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
    COUNT(DISTINCT participant.sportId) AS sportCount
FROM
    athlete
    NATURAL JOIN participant
GROUP BY
    athlete.athleteId
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

-- Selecionar atletas que ganharam mais de uma medalha no mesmo esporte, mesma modalidade e mesma edição
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
            result.athleteId,
            result.editionId,
            result.eventId
        FROM
            result
        GROUP BY
            result.athleteId,
            result.editionId,
            result.eventId
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
            result.athleteId,
            result.editionId
        FROM
            result
        GROUP BY
            result.athleteId,
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

-- Selecionar a porcentagem de participantes por gênero
WITH
    allParticipants AS (
        SELECT
            COUNT(DISTINCT athlete.athleteId) totalParticipantCount
        FROM
            participant
            JOIN athlete ON athlete.athleteId = participant.athleteId
        WHERE
            athlete.sex IS NOT NULL
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
    sex IS NOT NULL
    AND athlete.athleteId IN (
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
    medal.medalId;
