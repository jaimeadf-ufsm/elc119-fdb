DROP DATABASE IF EXISTS olympics;

CREATE DATABASE olympics;
USE olympics;

CREATE TABLE athlete (
    athleteId INT NOT NULL AUTO_INCREMENT,
    name TEXT NOT NULL,
    sex CHAR(1) NULL,
    height DECIMAL(5, 2) NULL,
    weight DECIMAL(5, 2) NULL,
    dateOfBirth DATE NULL,
    dateOfDeath DATE NULL,
    hometown TEXT NULL,
    education TEXT NULL,
    noc CHAR(3) NOT NULL,
    PRIMARY KEY (athleteId)
);

CREATE TABLE city (
    cityId INT NOT NULL AUTO_INCREMENT,
    name TEXT NOT NULL,
    PRIMARY KEY (cityId)
);

CREATE TABLE sport (
    sportId INT NOT NULL AUTO_INCREMENT,
    name TEXT NOT NULL,
    PRIMARY KEY (sportId)
);

CREATE TABLE event (
    eventId INT NOT NULL AUTO_INCREMENT,
    sportId INT NOT NULL,
    name TEXT NOT NULL,
    PRIMARY KEY (eventId),
    FOREIGN KEY (sportId) REFERENCES sport(sportId)
);

CREATE TABLE medal (
    medalId INT NOT NULL AUTO_INCREMENT,
    name TEXT NOT NULL,
    PRIMARY KEY (medalId)
);

CREATE TABLE edition (
    editionId INT NOT NULL AUTO_INCREMENT,
    year INT NOT NULL,
    season TEXT NOT NULL,
    alternateTitle TEXT NOT NULL,
    officialTitle TEXT NULL,
    country TEXT NULL,
    PRIMARY KEY (editionId)
);

CREATE TABLE host (
    editionId INT NOT NULL,
    sportId INT NOT NULL,
    cityId INT NOT NULL,
    PRIMARY KEY (editionId, sportId),
    FOREIGN KEY (editionId) REFERENCES edition(editionId),
    FOREIGN KEY (sportId) REFERENCES sport(sportId),
    FOREIGN KEY (cityId) REFERENCES city(cityId)
);

CREATE TABLE participant (
    athleteId INT NOT NULL,
    editionId INT NOT NULL,
    age INT NULL,
    PRIMARY KEY (athleteId, editionId),
    FOREIGN KEY (athleteId) REFERENCES athlete(athleteId),
    FOREIGN KEY (editionId) REFERENCES edition(editionId)
);

CREATE TABLE result (
    resultId INT NOT NULL AUTO_INCREMENT,
    athleteId INT NOT NULL,
    editionId INT NULL,
    sportId INT NOT NULL,
    eventId INT NULL,
    medalId INT NULL,
    team TEXT NULL,
    PRIMARY KEY (resultId),
    FOREIGN KEY (athleteId) REFERENCES athlete(athleteId),
    FOREIGN KEY (editionId) REFERENCES edition(editionId),
    FOREIGN KEY (sportId) REFERENCES sport(sportId),
    FOREIGN KEY (eventId) REFERENCES event(eventId),
    FOREIGN KEY (medalId) REFERENCES medal(medalId)
);
