-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: event_sphere
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event` (
  `EventID` int NOT NULL AUTO_INCREMENT,
  `EventName` varchar(100) NOT NULL,
  `EventDate` date DEFAULT NULL,
  `EventTime` time DEFAULT NULL,
  `Description` varchar(500) DEFAULT NULL,
  `OrganizerID` int DEFAULT NULL,
  `VenueID` int DEFAULT NULL,
  `TotalSeats` int DEFAULT NULL,
  `AvailableSeats` int DEFAULT NULL,
  `Fee` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`EventID`),
  KEY `OrganizerID` (`OrganizerID`),
  KEY `VenueID` (`VenueID`),
  CONSTRAINT `event_ibfk_1` FOREIGN KEY (`OrganizerID`) REFERENCES `organizer` (`OrganizerID`),
  CONSTRAINT `event_ibfk_2` FOREIGN KEY (`VenueID`) REFERENCES `venue` (`VenueID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
INSERT INTO `event` VALUES (1,'Tech Fest','2026-09-20','10:00:00','Annual technology festival',1,1,200,200,300.00),(2,'Music Night','2026-09-22','18:00:00','Live music and entertainment',2,2,500,500,200.00),(3,'Coding Hackathon','2026-09-25','09:00:00','Competitive coding event',1,1,100,100,150.00),(4,'Dance Fiesta','2026-09-28','17:00:00','Dance competition',2,2,300,300,100.00),(5,'AI Workshop','2026-10-01','11:00:00','Hands-on artificial intelligence workshop',1,1,80,80,250.00),(6,'Drama Night','2026-10-03','19:00:00','Theatre and drama performance',2,2,150,150,120.00),(7,'Robotics Expo','2026-10-05','10:00:00','Robotics showcase',1,1,120,120,200.00),(8,'Photography Walk','2026-10-07','07:00:00','City photography walk',2,2,50,50,80.00);
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organizer`
--

DROP TABLE IF EXISTS `organizer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organizer` (
  `OrganizerID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Phone` varchar(15) DEFAULT NULL,
  `Organization` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`OrganizerID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organizer`
--

LOCK TABLES `organizer` WRITE;
/*!40000 ALTER TABLE `organizer` DISABLE KEYS */;
INSERT INTO `organizer` VALUES (1,'John','john@mail.com','9999999991','TechClub'),(2,'Priya','priya@mail.com','9999999992','CulturalCell');
/*!40000 ALTER TABLE `organizer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `participant`
--

DROP TABLE IF EXISTS `participant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `participant` (
  `ParticipantID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Phone` varchar(15) DEFAULT NULL,
  `ParticipantType` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ParticipantID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `participant`
--

LOCK TABLES `participant` WRITE;
/*!40000 ALTER TABLE `participant` DISABLE KEYS */;
INSERT INTO `participant` VALUES (1,'Riya','riya@mail.com','8888888881','student'),(2,'Aman','aman@mail.com','8888888882','regular'),(3,'Sneha','sneha@mail.com','8888888883','student'),(4,'Vikram','vikram@mail.com','8888888884','regular'),(5,'Neha','neha@mail.com','8888888885','student'),(6,'Rahul','rahul@mail.com','8888888886','regular'),(7,'Kavya','kavya@mail.com','8888888887','student'),(8,'Arjun','arjun@mail.com','8888888888','regular');
/*!40000 ALTER TABLE `participant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registration`
--

DROP TABLE IF EXISTS `registration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registration` (
  `RegistrationID` int NOT NULL AUTO_INCREMENT,
  `EventID` int DEFAULT NULL,
  `ParticipantID` int DEFAULT NULL,
  `RegistrationDate` date DEFAULT NULL,
  `FeePaid` decimal(10,2) DEFAULT NULL,
  `AttendanceStatus` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`RegistrationID`),
  KEY `EventID` (`EventID`),
  KEY `ParticipantID` (`ParticipantID`),
  CONSTRAINT `registration_ibfk_1` FOREIGN KEY (`EventID`) REFERENCES `event` (`EventID`),
  CONSTRAINT `registration_ibfk_2` FOREIGN KEY (`ParticipantID`) REFERENCES `participant` (`ParticipantID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration`
--

LOCK TABLES `registration` WRITE;
/*!40000 ALTER TABLE `registration` DISABLE KEYS */;
INSERT INTO `registration` VALUES (1,1,1,'2026-09-10',150.00,'absent'),(2,2,2,'2026-09-11',200.00,'absent'),(3,3,3,'2026-09-12',75.00,'absent'),(4,4,4,'2026-09-13',100.00,'absent'),(5,5,5,'2026-09-14',125.00,'absent'),(6,6,6,'2026-09-15',120.00,'absent'),(7,7,7,'2026-09-16',100.00,'absent'),(8,8,8,'2026-09-17',80.00,'absent');
/*!40000 ALTER TABLE `registration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `venue`
--

DROP TABLE IF EXISTS `venue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `venue` (
  `VenueID` int NOT NULL AUTO_INCREMENT,
  `VenueName` varchar(100) NOT NULL,
  `Address` varchar(200) DEFAULT NULL,
  `City` varchar(50) DEFAULT NULL,
  `Capacity` int DEFAULT NULL,
  PRIMARY KEY (`VenueID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `venue`
--

LOCK TABLES `venue` WRITE;
/*!40000 ALTER TABLE `venue` DISABLE KEYS */;
INSERT INTO `venue` VALUES (1,'Main Hall','123 MG Road','Pune',200),(2,'Open Ground','45 Park St','Mumbai',500);
/*!40000 ALTER TABLE `venue` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-09-17 19:53:04
