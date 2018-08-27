DROP DATABASE IF EXISTS HotelReservation2;

CREATE DATABASE HotelReservation2;

USE HotelReservation2;

-- Table Creation

CREATE TABLE IF NOT EXISTS Reservation (
	ReservationID INT NOT NULL AUTO_INCREMENT,
    StartDate DATE NOT NULL, 
    EndDate DATE NOT NULL,
    TotalCost DEC NOT NULL,
    customerid INT NOT NULL DEFAULT 0,
    taxid INT NOT NULL DEFAULT 0,
    promotionid INT NOT NULL DEFAULT 0,
    PRIMARY KEY(ReservationID)
);	
CREATE TABLE IF NOT EXISTS Customer (
	CustomerID INT NOT NULL AUTO_INCREMENT,
    FirstName VARCHAR(30) NOT NULL, 
    LastName VARCHAR(30) NOT NULL,
    Phone VARCHAR(30) NOT NULL,
    Email VARCHAR(30) NOT NULL,
    Age INT(10) NOT NULL,
    PRIMARY KEY(CustomerID)
);	
CREATE TABLE IF NOT EXISTS Tax (
	TaxID INT NOT NULL AUTO_INCREMENT,
    TaxRate DEC(10,2) NOT NULL,
    Location VARCHAR(30),
    PRIMARY KEY(TaxID)
);	
CREATE TABLE IF NOT EXISTS Promotion (
	PromotionID INT NOT NULL AUTO_INCREMENT,
    StartDate DATE NOT NULL, 
    EndDate DATE NOT NULL,
    PercentageDiscount DEC(10,2) NULL,
	DollarDiscount DEC(10,2) NULL,
    PRIMARY KEY(PromotionID)
);	
ALTER TABLE Reservation
ADD CONSTRAINT fk_reservation_customer
FOREIGN KEY (customerid) REFERENCES customer(customerid);
ALTER TABLE Reservation
ADD CONSTRAINT fk_reservation_tax
FOREIGN KEY (taxid) REFERENCES tax(taxid);
ALTER TABLE Reservation
ADD CONSTRAINT fk_reservation_promotion
FOREIGN KEY (promotionid) REFERENCES promotion(promotionid);

-- Data dump
/*
INSERT INTO Reservation (StartDate, EndDate, TotalCost)
VALUES ('2018/01/01', '2018/01/05', 100),
('2018/03/01', '2018/03/02', 90),
('2018/04/01', '2018/04/15', 300),
('2018/05/01', '2018/05/30', 500);

INSERT INTO Customer (FirstName, LastName, Phone, Email, Age)
VALUES ('Bob', 'Smith', '555-555-5555', 'bob@smith.xyz', 30),
('Todd', 'Smuthers', '555-555-1234', 'todd@some.xyz', 25),
('Jenn', 'Efer', '555-555-4321', 'jenn@geemail.xyz', 18),
('Ben', 'Condor', '555-555-1122', 'ben@birds.xyz', 21);

INSERT INTO Tax (TaxRate, Location)
VALUES (.02, OHIO),
(.01, PENN);

INSERT INTO Promotion (StartDate, EndDate, PercentageDiscount, DollarDiscount)
VALUES ('2018/01/01', '2018/01/03', NULL, 50),
('2018/03/01', '2018/03/20', .2, NULL);
*/
-- Table Creation

CREATE TABLE IF NOT EXISTS AddOns (
	AddOnsID INT NOT NULL AUTO_INCREMENT,
    AddOnPrice DEC(10,2) NOT NULL,
	AddOnType VARCHAR(30) NOT NULL,
    PRIMARY KEY(AddOnsID)
);	
CREATE TABLE IF NOT EXISTS CustomerAddons(
	CustomerID INT NOT NULL,
	AddonID INT NOT NULL,
    PRIMARY KEY(CustomerID, AddonID)
);
ALTER TABLE CustomerAddons
ADD CONSTRAINT fk_CustomerAddons_Customer
FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID);
ALTER TABLE CustomerAddons
ADD CONSTRAINT fk_CustomerAddons_AddOns
FOREIGN KEY (AddOnID) REFERENCES AddOns(AddOnsID);

-- Data Dump
/*
INSERT INTO AddOns (AddOnPrice, AddOnType)
VALUES (20, 'Room Service'),
(15, 'Breakfast'),
(24, 'Movies');

INSERT INTO CustomerAddons (CustomerID, AddOnID)
VALUES (1, 1),
(1, 2),
(3, 3);*/

-- Table Creation

CREATE TABLE IF NOT EXISTS RoomType(
	RoomTypeID INT NOT NULL AUTO_INCREMENT,
    TypeOfRoom VARCHAR(30) NOT NULL,
    Price DEC NOT NULL,
    PRIMARY KEY(RoomTypeID)
);
CREATE TABLE IF NOT EXISTS Room(
	RoomID INT NOT NULL AUTO_INCREMENT,
    RoomNumber INT NOT NULL,
    FloorNumber INT NOT NULL,
    OccupancyLimit INT NOT NULL,
    RoomTypeID INT NOT NULL,
    ReservationID INT NULL,
    PRIMARY KEY(RoomID)
);
ALTER TABLE room
ADD CONSTRAINT fk_room_roomtypeid
FOREIGN KEY (roomtypeid) REFERENCES roomtype(roomtypeid);
ALTER TABLE room 
ADD CONSTRAINT fk_room_reservationid
FOREIGN KEY (reservationid) REFERENCES reservation(reservationid);

-- Data Dumping
/*
INSERT INTO RoomType (TypeOfRoom, Price)
VALUES ('Single', 100),
('Double', 150),
('King', 200),
('VIP', 500);

INSERT INTO Room (RoomNumber, FloorNumber, OccupancyLimit)
VALUES (100,1,4),
(101,1,4),
(102,1,2),
(103,1,1),
(104,1,4),
(105,1,2),
(200,2,4);
*/
-- Table Creation

CREATE TABLE IF NOT EXISTS Amenity(
	AmenityID INT NOT NULL AUTO_INCREMENT,
    Description VARCHAR(30) NOT NULL,
    Price DEC NOT NULL,
    PRIMARY KEY(AmenityID)
);
CREATE TABLE IF NOT EXISTS RoomAmenities(
    RoomID INT NOT NULL,
    AmenityID INT NOT NULL,
    PRIMARY KEY(roomid, amenityid)
);
ALTER TABLE roomamenities
ADD CONSTRAINT fk_roomamenities_roomid
FOREIGN KEY (roomid) REFERENCES room(roomid);
ALTER TABLE roomamenities
ADD CONSTRAINT fk_roomamanities_amenityid
FOREIGN KEY (amenityid) REFERENCES amenity(amenityid);

-- Data Dumping
/*
INSERT INTO Amenity (Description, Price)
VALUES ('Fridge', 20),
('Spa Bath', 30),
('Television', 10);

INSERT INTO RoomAmenities (RoomID, AmenityID)
VALUES (1, 1),
(1,3),
(2, 1),
(2, 2),
(2, 3);*/