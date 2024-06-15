DROP DATABASE olympics;
CREATE DATABASE olympics;
USE olympics;

CREATE TABLE athletes (
    athleteId INT NOT NULL,
    name TEXT NOT NULL,
    sex CHAR(1) NOT NULL,
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

CREATE TABLE medalTypes (
    medalId INT NOT NULL AUTO_INCREMENT,
    name TEXT NOT NULL,
    PRIMARY KEY (medalId)
);

CREATE TABLE editions (
    editionId INT NOT NULL AUTO_INCREMENT,
    year INT NOT NULL,
    season TEXT NOT NULL,
    title TEXT NOT NULL,
    cityId INT NOT NULL,
    PRIMARY KEY (editionId),
    FOREIGN KEY (cityId) REFERENCES cities(cityId)
);

CREATE TABLE teams (
    teamId INT NOT NULL AUTO_INCREMENT,
    name TEXT NOT NULL,
    editionId INT NOT NULL,
    eventId INT NOT NULL,
    medalTypeId INT NULL,
    PRIMARY KEY (teamId),
    FOREIGN KEY (editionId) REFERENCES editions(editionId),
    FOREIGN KEY (eventId) REFERENCES events(eventId),
    FOREIGN KEY (medalTypeId) REFERENCES medalTypes(medalId)
);

CREATE TABLE memberships (
    athleteId INT NOT NULL,
    teamId INT NOT NULL,
    age INT NULL,
    height DECIMAL(5,2) NULL,
    weight DECIMAL(5,2) NULL,
    PRIMARY KEY (athleteId, teamId),
    FOREIGN KEY (athleteId) REFERENCES athletes(athleteId),
    FOREIGN KEY (teamId) REFERENCES teams(teamId)
);