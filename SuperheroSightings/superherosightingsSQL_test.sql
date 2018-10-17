DROP DATABASE IF EXISTS superheroes_test;

CREATE DATABASE superheroes_test;

USE superheroes_test;

-- Table Creation

CREATE TABLE IF NOT EXISTS Heroes (
	heroId INT NOT NULL AUTO_INCREMENT,
    heroName VARCHAR(30) NOT NULL, 
    heroDescr VARCHAR(100) NOT NULL,
    heroPower VARCHAR(30) NOT NULL,
    PRIMARY KEY(heroId)
);	

CREATE TABLE IF NOT EXISTS Organization (
	orgId INT NOT NULL AUTO_INCREMENT,
    orgName VARCHAR(30) NOT NULL,
    orgDescr VARCHAR(100) NOT NULL,
    orgAddress VARCHAR(45) NOT NULL,
    orgPhone VARCHAR(10) NOT NULL,
    orgEmail VARCHAR(30) NOT NULL,
    PRIMARY KEY(orgId)
);

CREATE TABLE IF NOT EXISTS Location (
	locationId INT NOT NULL AUTO_INCREMENT,
    locationName VARCHAR(50) NOT NULL,
    locationDescr VARCHAR(100) NOT NULL,
    locationAddress VARCHAR(45) NOT NULL,
    locationLat VARCHAR(45) NOT NULL,
    locationLong VARCHAR(45) NOT NULL,
    PRIMARY KEY(locationId)
);

-- Bridges

CREATE TABLE IF NOT EXISTS Sighting (
	sightingId INT NOT NULL AUTO_INCREMENT,
	locationId INT NOT NULL,
	sightingDate DATE NOT NULL,
	heroID INT NOT NULL,
	PRIMARY KEY(sightingId)
);

CREATE TABLE IF NOT EXISTS HeroOrg (
	orgId INT NOT NULL,
    heroId INT NOT NULL,
    PRIMARY KEY(orgId, heroId)
);

CREATE TABLE IF NOT EXISTS HeroLocation (
	heroId INT NOT NULL,
    locationId INT NOT NULL,
    PRIMARY KEY(heroId, locationId)
);

ALTER TABLE Sighting
ADD CONSTRAINT fk_sighting_locationId
FOREIGN KEY (locationId) REFERENCES Location(locationId);
ALTER TABLE Sighting
ADD CONSTRAINT fk_sighting_heroId
FOREIGN KEY (heroId) REFERENCES Heroes(heroId);

ALTER TABLE HeroOrg
ADD CONSTRAINT fk_heroOrg_orgId
FOREIGN KEY (orgId) REFERENCES Organization(orgId);
ALTER TABLE HeroOrg
ADD CONSTRAINT fk_heroOrg_heroId
FOREIGN KEY (heroId) REFERENCES Heroes(heroId);

ALTER TABLE HeroLocation
ADD CONSTRAINT fk_heroLocation_heroId
FOREIGN KEY (heroId) REFERENCES Heroes(heroId);
ALTER TABLE HeroLocation
ADD CONSTRAINT fk_heroLocation_locationId
FOREIGN KEY (locationId) REFERENCES Location(locationId);