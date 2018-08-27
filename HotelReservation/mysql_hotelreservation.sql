DROP DATABASE IF EXISTS HotelReservation;

CREATE DATABASE HotelReservation;

USE HotelReservation;

CREATE TABLE IF NOT EXISTS `addons` (
  `AddOnsID` int(11) NOT NULL,
  `Item` varchar(45) NOT NULL,
  `DateStart` datetime NOT NULL,
  `DateEnd` datetime DEFAULT NULL,
  `Price` varchar(45) NOT NULL,
  PRIMARY KEY (`AddOnsID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data

/*
INSERT INTO Addons (AddOnsID, Item, DateStart, Price)
VALUES (1, 'Room Service', '2018/01/01', 25.00),
(2, 'Movies', '2018/01/01', 15.00);*/

CREATE TABLE IF NOT EXISTS `billing` (
  `BillingID` int(11) NOT NULL,
  `Tax` double NOT NULL,
  `Total` double NOT NULL,
  `CustomerID` int(11) NOT NULL,
  PRIMARY KEY (`BillingID`),
  KEY `fk_HotelReservation_CustomerBillID` (`CustomerID`),
  CONSTRAINT `fk_HotelReservation_CustomerBillID` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data
/*
INSERT INTO Billing (BillingID, Tax, Total)
VALUES (1, .1, 125.00),
(2, .1, 500.00);*/

CREATE TABLE IF NOT EXISTS `customer` (
  `CustomerID` int(11) NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(30) NOT NULL,
  `LastName` varchar(30) NOT NULL,
  `PhoneNumber` varchar(30) NOT NULL,
  `Email` varchar(40) NOT NULL,
  `CCInfo` varchar(16) NOT NULL,
  `Age` int(11) NOT NULL,
  `ReservationID` int(11) NOT NULL,
  PRIMARY KEY (`CustomerID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Dumping data
/*
INSERT INTO Customer (FirstName, LastName, PhoneNumber, Email, CCInfo, Age, ReservationID)
VALUES ('Bob', 'Smith', '555-555-5555', 'bob@xyz.com', '1234123412341234', '18', 1),
('Billy', 'Smith', '555-555-1234', 'billy@xyz.com', '1234123412341234', '37', 1),
('Tam', 'Smoth', '555-555-4321', 'tam@z.com', '1234123412341234', '28', 2),
('Bob', 'Smqi', '555-555-1243', 'bob@yz.com', '1234123412341234', '24', 3),
('Bub', 'Shoe', '555-555-1324', 'bub@xy.com', '1234123412341234', '32', 4);*/

CREATE TABLE IF NOT EXISTS `customerrooms` (
  `CustomerID` int(11) NOT NULL,
  `RoomID` int(11) NOT NULL,
  `ReservationID` int(11) NOT NULL,
  PRIMARY KEY (`CustomerID`,`RoomID`),
  KEY `fk_HotelReservation_CustomerHotelRoom` (`RoomID`),
  KEY `fk_HotelReservation_CustReservation` (`ReservationID`),
  CONSTRAINT `fk_HotelReservation_CustReservation` FOREIGN KEY (`ReservationID`) REFERENCES `reservation` (`ReservationID`),
  CONSTRAINT `fk_HotelReservation_Customer` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`),
  CONSTRAINT `fk_HotelReservation_CustomerHotelRoom` FOREIGN KEY (`RoomID`) REFERENCES `hotelroom` (`RoomID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data
/*
INSERT INTO CustomerRooms (CustomerID, RoomID, ReservationID)
VALUES (1, 1, 1),
(1, 1, 1),
(3, 2, 2),
(4, 3, 3),
(5, 4, 4);*/

CREATE TABLE IF NOT EXISTS `hotelroom` (
  `RoomID` int(11) NOT NULL AUTO_INCREMENT,
  `RoomFloor` int(11) NOT NULL,
  `RoomLimit` int(11) NOT NULL,
  `RoomNumber` int(11) NOT NULL,
  PRIMARY KEY (`RoomID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

-- Dumping data
/*
INSERT INTO HotelRoom (RoomFloor, RoomLimit, RoomNumber)
VALUES (1, 4, 100),
(1, 4, 101),
(1, 2, 102),
(1, 4, 103),
(1, 4, 104),
(1, 1, 105),
(2, 4, 200);*/

CREATE TABLE IF NOT EXISTS `promotioncodes` (
  `PromotionID` int(11) NOT NULL,
  `DateStart` date DEFAULT NULL,
  `DateEnd` date DEFAULT NULL,
  `DollarDiscount` double DEFAULT NULL,
  `PercentDiscount` double DEFAULT NULL,
  PRIMARY KEY (`PromotionID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data

/*
INSERT INTO PromotionCodes(PromotionID, DateStart, DateEnd, DollarDiscount, PercentDiscount)
VALUES (1, '2018/01/01', '2018/01/05', 50, NULL),
(2, '2018/03/01', '2018/03/31', NULL, .2);*/

CREATE TABLE IF NOT EXISTS `reservation` (
  `ReservationID` int(11) NOT NULL AUTO_INCREMENT,
  `CheckInDate` date NOT NULL DEFAULT '0000-00-00',
  `CheckOutDate` date NOT NULL DEFAULT '0000-00-00',
  PRIMARY KEY (`ReservationID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Dumping data

/*
INSERT INTO Reservation (CheckInDate, CheckOutDate)
VALUES ('2018/01/01','2018/01/10'),
('2018/01/01','2018/01/30'),
('2018/03/05','2018/03/10'),
('2018/04/02','2018/04/25');*/

CREATE TABLE IF NOT EXISTS `roomamenities` (
  `RoomAmenID` int(11) NOT NULL AUTO_INCREMENT,
  `Amenities` varchar(30) NOT NULL,
  PRIMARY KEY (`RoomAmenID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Dumping data
/*
INSERT INTO RoomAmenities (Amenities)
VALUES ('Fridge'),
('TV'),
('Microwave'),
('Bath'),
('Lights');*/

CREATE TABLE IF NOT EXISTS `roomtype` (
  `RoomTypeID` int(11) NOT NULL AUTO_INCREMENT,
  `RoomType` varchar(30) NOT NULL,
  PRIMARY KEY (`RoomTypeID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Dumping data
/*
INSERT INTO RoomType (RoomType)
VALUES ('Single'),
('Double'),
('King');*/

CREATE TABLE IF NOT EXISTS `roomtypeamenities` (
  `RoomID` int(11) NOT NULL,
  `RoomTypeID` int(11) NOT NULL,
  `RoomAmenID` int(11) NOT NULL,
  PRIMARY KEY (`RoomID`,`RoomTypeID`,`RoomAmenID`),
  KEY `fk_HotelReservation_RoomType` (`RoomTypeID`),
  KEY `fk_HotelReservation_RoomAmenities` (`RoomAmenID`),
  CONSTRAINT `fk_HotelReservation_HotelRoom` FOREIGN KEY (`RoomID`) REFERENCES `hotelroom` (`RoomID`),
  CONSTRAINT `fk_HotelReservation_RoomAmenities` FOREIGN KEY (`RoomAmenID`) REFERENCES `roomamenities` (`RoomAmenID`),
  CONSTRAINT `fk_HotelReservation_RoomType` FOREIGN KEY (`RoomTypeID`) REFERENCES `roomtype` (`RoomTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data
/*
INSERT INTO RoomTypeAmenities (RoomID, RoomTypeID, RoomAmenID)
VALUES (1, 3, 1),
(1, 3, 2),
(1, 3, 3),
(1, 3, 4),
(1, 3, 5),
(2, 3, 1),
(3, 3, 5);*/

CREATE TABLE IF NOT EXISTS `roomrates` (
  `RoomRateID` int(11) NOT NULL,
  `StartDate` datetime NOT NULL,
  `EndDate` datetime NOT NULL,
  PRIMARY KEY (`RoomRateID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data
/*
INSERT INTO RoomRates (RoomRateID, StartDate, EndDate)
VALUES (1, '2018/01/01', '2018/01/30'),
(2, '2018/01/30', '2018/7/15');*/

CREATE TABLE `customeraddons` (
  `CustomerID` int(11) NOT NULL,
  `AddOnsID` int(11) NOT NULL,
  PRIMARY KEY (`CustomerID`,`AddOnsID`),
  UNIQUE KEY `Customer_CustomerID_UNIQUE` (`CustomerID`),
  UNIQUE KEY `AddOns_AddOnsID_UNIQUE` (`AddOnsID`),
  KEY `fk_CustomerAddons_AddOns1_idx` (`AddOnsID`),
  CONSTRAINT `fk_CustomerAddons_AddOns1` FOREIGN KEY (`AddOnsID`) REFERENCES `addons` (`AddOnsID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_CustomerAddons_Customer1` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `customerrooms` (   `CustomerID` int(11) NOT NULL,   `RoomID` int(11) NOT NULL,   `ReservationID` int(11) NOT NULL,   PRIMARY KEY (`CustomerID`,`RoomID`),   KEY `fk_HotelReservation_CustomerHotelRoom` (`RoomID`),   KEY `fk_HotelReservation_CustReservation` (`ReservationID`),   CONSTRAINT `fk_HotelReservation_CustReservation` FOREIGN KEY (`ReservationID`) REFERENCES `reservation` (`ReservationID`),   CONSTRAINT `fk_HotelReservation_Customer` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`),   CONSTRAINT `fk_HotelReservation_CustomerHotelRoom` FOREIGN KEY (`RoomID`) REFERENCES `hotelroom` (`RoomID`) ) ENGINE=InnoDB DEFAULT CHARSET=latin1
