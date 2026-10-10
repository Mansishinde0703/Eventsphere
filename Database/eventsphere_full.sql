CREATE DATABASE  IF NOT EXISTS `event_sphere` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `event_sphere`;
-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: event_sphere
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
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
INSERT INTO `event` VALUES (1,'Tech Fest','2026-09-20','10:00:00','Annual technology festival',1,1,200,200,300.00),(2,'Music Night','2026-09-22','18:00:00','Live music and entertainment',2,2,500,498,200.00),(3,'Coding Hackathon','2026-09-25','09:00:00','Competitive coding event',1,1,100,98,150.00),(4,'Dance Fiesta','2026-09-28','17:00:00','Dance competition',2,2,300,300,100.00),(5,'AI Workshop','2026-10-01','11:00:00','Hands-on artificial intelligence workshop',1,1,80,80,250.00),(6,'Drama Night','2026-10-03','19:00:00','Theatre and drama performance',2,2,150,150,120.00),(7,'Robotics Expo','2026-10-05','10:00:00','Robotics showcase',1,1,120,120,200.00),(8,'Photography Walk','2026-10-07','07:00:00','City photography walk',2,2,50,50,80.00),(9,'techno','2026-10-10','08:00:00','make your own ai agent ',1,4,180,180,200.00),(10,'techhack','2026-10-25','10:00:00','hackathon for for tennagers who want to learn, innovate and build ',1,5,180,180,500.00);
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `organizer`
--

LOCK TABLES `organizer` WRITE;
/*!40000 ALTER TABLE `organizer` DISABLE KEYS */;
INSERT INTO `organizer` VALUES (1,'John','john@mail.com','9999999991','TechClub'),(2,'Priya','priya@mail.com','9999999992','CulturalCell');
/*!40000 ALTER TABLE `organizer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `participant`
--

LOCK TABLES `participant` WRITE;
/*!40000 ALTER TABLE `participant` DISABLE KEYS */;
INSERT INTO `participant` VALUES (1,'Riya','riya@mail.com','8888888881','student'),(2,'Aman','aman@mail.com','8888888882','regular'),(3,'Sneha','sneha@mail.com','8888888883','student'),(4,'Vikram','vikram@mail.com','8888888884','regular'),(5,'Neha','neha@mail.com','8888888885','student'),(6,'Rahul','rahul@mail.com','8888888886','regular'),(7,'Kavya','kavya@mail.com','8888888887','student'),(8,'Arjun','arjun@mail.com','8888888888','regular'),(9,'mansi','mansi.shinde@vpt.edu.in','347683964','student'),(10,'Mansi Shinde','mansi06shinde@gmail.com','8850197296','student'),(11,'Mansi Shinde','mansi06shinde@gmail.com','8850197296','student');
/*!40000 ALTER TABLE `participant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `registration`
--

LOCK TABLES `registration` WRITE;
/*!40000 ALTER TABLE `registration` DISABLE KEYS */;
INSERT INTO `registration` VALUES (1,1,1,'2026-09-10',150.00,'absent'),(2,2,2,'2026-09-11',200.00,'absent'),(3,3,3,'2026-09-12',75.00,'absent'),(4,4,4,'2026-09-13',100.00,'absent'),(5,5,5,'2026-09-14',125.00,'absent'),(6,6,6,'2026-09-15',120.00,'absent'),(7,7,7,'2026-09-16',100.00,'absent'),(8,8,8,'2026-09-17',80.00,'absent'),(9,NULL,9,'2026-10-03',150.00,'absent'),(10,2,10,'2026-10-08',180.00,'absent'),(11,3,11,'2026-10-08',135.00,'absent');
/*!40000 ALTER TABLE `registration` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `AfterRegistrationInsert` AFTER INSERT ON `registration` FOR EACH ROW BEGIN
  UPDATE event SET AvailableSeats = AvailableSeats - 1 WHERE EventID = NEW.EventID;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping data for table `venue`
--

LOCK TABLES `venue` WRITE;
/*!40000 ALTER TABLE `venue` DISABLE KEYS */;
INSERT INTO `venue` VALUES (1,'Main Hall','123 MG Road','Pune',200),(2,'Open Ground','45 Park St','Mumbai',500),(3,'Test Hall','123 St','Pune',100),(4,'lab','wadala east','mumbai',180),(5,'lab','wadala east','mumbai',180);
/*!40000 ALTER TABLE `venue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'event_sphere'
--
/*!50003 DROP FUNCTION IF EXISTS `CalculateFee` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `CalculateFee`(p_type VARCHAR(20),p_base DECIMAL(10,2)) RETURNS decimal(10,2)
    DETERMINISTIC
BEGIN
IF LOWER(p_type)='student' THEN
RETURN p_base*0.9;
ELSE
RETURN p_base;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RegisterParticipant` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RegisterParticipant`(IN p_EventID INT, IN p_ParticipantID INT, IN p_Fee DECIMAL(10,2))
BEGIN
  DECLARE seats INT;
  SELECT AvailableSeats INTO seats FROM event WHERE EventID = p_EventID;
  IF seats > 0 THEN
    INSERT INTO registration (EventID, ParticipantID, RegistrationDate, FeePaid, AttendanceStatus)
    VALUES (p_EventID, p_ParticipantID, CURDATE(), p_Fee, 'absent');
  ELSE
    SELECT 'No seats available' AS Message;
  END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-10 18:59:15
