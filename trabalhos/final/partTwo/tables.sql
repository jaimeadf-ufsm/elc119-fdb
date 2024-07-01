DROP DATABASE IF EXISTS olympics;

CREATE DATABASE olympics;
USE olympics;

CREATE TABLE athletes (
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

CREATE TABLE cities (
    cityId INT NOT NULL AUTO_INCREMENT,
    name TEXT NOT NULL,
    PRIMARY KEY (cityId)
);

CREATE TABLE sports (
    sportId INT NOT NULL AUTO_INCREMENT,
    name TEXT NOT NULL,
    PRIMARY KEY (sportId)
);

CREATE TABLE events (
    eventId INT NOT NULL AUTO_INCREMENT,
    sportId INT NOT NULL,
    name TEXT NOT NULL,
    PRIMARY KEY (eventId),
    FOREIGN KEY (sportId) REFERENCES sports(sportId)
);

CREATE TABLE medals (
    medalId INT NOT NULL AUTO_INCREMENT,
    name TEXT NOT NULL,
    PRIMARY KEY (medalId)
);

CREATE TABLE editions (
    editionId INT NOT NULL AUTO_INCREMENT,
    year INT NOT NULL,
    season TEXT NOT NULL,
    title TEXT NOT NULL,
    PRIMARY KEY (editionId)
);

CREATE TABLE hosts (
    editionId INT NOT NULL,
    sportId INT NOT NULL,
    cityId INT NOT NULL,
    PRIMARY KEY (editionId, sportId),
    FOREIGN KEY (editionId) REFERENCES editions(editionId),
    FOREIGN KEY (sportId) REFERENCES sports(sportId),
    FOREIGN KEY (cityId) REFERENCES cities(cityId)
);

CREATE TABLE participants (
    athleteId INT NOT NULL,
    editionId INT NOT NULL,
    age INT NULL,
    PRIMARY KEY (athleteId, editionId),
    FOREIGN KEY (athleteId) REFERENCES athletes(athleteId),
    FOREIGN KEY (editionId) REFERENCES editions(editionId)
);

CREATE TABLE results (
    resultId INT NOT NULL AUTO_INCREMENT,
    athleteId INT NOT NULL,
    editionId INT NULL,
    sportId INT NOT NULL,
    eventId INT NULL,
    medalId INT NULL,
    team TEXT NULL,
    PRIMARY KEY (resultId),
    FOREIGN KEY (athleteId) REFERENCES athletes(athleteId),
    FOREIGN KEY (editionId) REFERENCES editions(editionId),
    FOREIGN KEY (sportId) REFERENCES sports(sportId),
    FOREIGN KEY (eventId) REFERENCES events(eventId),
    FOREIGN KEY (medalId) REFERENCES medals(medalId)
);
