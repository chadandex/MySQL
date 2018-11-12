DROP DATABASE IF EXISTS superheroes;

CREATE DATABASE superheroes;

USE superheroes;

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
    orgPhone VARCHAR(13) NOT NULL,
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
	heroId INT NOT NULL,
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

-- User Tables/Bridges

CREATE TABLE IF NOT EXISTS Users (
	`user_id` INT NOT NULL AUTO_INCREMENT,
    `username` VARCHAR(25) NOT NULL,
    `password` VARCHAR(100) NOT NULL,
    `enabled` TINYINT(1) NOT NULL,
    PRIMARY KEY (`user_id`),
    KEY `username` (`username`)
);

CREATE TABLE IF NOT EXISTS Authorities (
	`username` VARCHAR(25) NOT NULL,
    `authority` VARCHAR(20) NOT NULL,
    KEY `username` (`username`)
);

-- Dumping into user stuff as to not be locked out during testing
-- BCrypt during website running to Hashcodes 

INSERT INTO `users` (`user_id`, `username`, `password`, `enabled`) VALUES
(1, 'admin', 'password', 1),
(2, 'user', 'password', 1);


INSERT INTO `authorities` (`username`, `authority`) VALUES
('admin', 'ROLE_ADMIN'),
('admin', 'ROLE_MOD'),
('admin', 'ROLE_USER'),
('user', 'ROLE_USER');

ALTER TABLE Authorities
ADD CONSTRAINT fk_authorities_username
FOREIGN KEY (username) REFERENCES Users(username);

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