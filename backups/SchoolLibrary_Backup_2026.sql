-- MySQL dump 10.13  Distrib 9.7.1, for macos15.7 (arm64)
--
-- Host: localhost    Database: SchoolLibrary
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Audit_Log`
--

DROP TABLE IF EXISTS `Audit_Log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Audit_Log` (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `action_type` varchar(20) DEFAULT NULL,
  `table_name` varchar(30) DEFAULT NULL,
  `record_id` int DEFAULT NULL,
  `action_timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `performed_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Audit_Log`
--

LOCK TABLES `Audit_Log` WRITE;
/*!40000 ALTER TABLE `Audit_Log` DISABLE KEYS */;
INSERT INTO `Audit_Log` VALUES (1,'RETURN','Issued_Books',503,'2026-11-17 09:23:12','root@localhost');
/*!40000 ALTER TABLE `Audit_Log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Books`
--

DROP TABLE IF EXISTS `Books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Books` (
  `book_id` int NOT NULL,
  `title` varchar(100) NOT NULL,
  `author` varchar(50) DEFAULT NULL,
  `copies_available` int DEFAULT NULL,
  PRIMARY KEY (`book_id`),
  KEY `idx_books_title_author` (`title`,`author`),
  CONSTRAINT `books_chk_1` CHECK ((`copies_available` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Books`
--

LOCK TABLES `Books` WRITE;
/*!40000 ALTER TABLE `Books` DISABLE KEYS */;
INSERT INTO `Books` VALUES (1,'Harry Potter and the Sorcerer\'s Stone','J.K. Rowling',3),(2,'A Brief History of Time','Stephen Hawking',2),(3,'Wings of Fire','A.P.J. Abdul Kalam',4),(4,'The Alchemist','Paulo Coelho',6),(5,'Malgudi Days','R.K. Narayan',4),(6,'The Hobbit','J.R.R. Tolkien',3),(7,'To Kill a Mockingbird','Harper Lee',2),(8,'1984','George Orwell',4),(9,'The Diary of a Young Girl','Anne Frank',6),(10,'Percy Jackson: The Lightning Thief','Rick Riordan',5),(11,'Matilda','Roald Dahl',4),(12,'Charlie and the Chocolate Factory','Roald Dahl',3),(13,'The Jungle Book','Rudyard Kipling',5),(14,'Treasure Island','Robert Louis Stevenson',2),(15,'Sherlock Holmes: Complete Stories','Arthur Conan Doyle',3),(16,'The Guide','R.K. Narayan',4),(17,'Ignited Minds','A.P.J. Abdul Kalam',6),(18,'The Theory of Everything','Stephen Hawking',2),(19,'Cosmos','Carl Sagan',3),(20,'Sapiens: A Brief History of Humankind','Yuval Noah Harari',2),(21,'Atomic Habits','James Clear',4),(22,'The Little Prince','Antoine de Saint-Exupery',5),(23,'Charlotte\'s Web','E.B. White',4),(24,'The Chronicles of Narnia','C.S. Lewis',3),(25,'Alice\'s Adventures in Wonderland','Lewis Carroll',5),(26,'Gulliver\'s Travels','Jonathan Swift',3),(27,'Robinson Crusoe','Daniel Defoe',2),(28,'Around the World in Eighty Days','Jules Verne',4),(29,'Twenty Thousand Leagues Under the Sea','Jules Verne',3),(30,'The Time Machine','H.G. Wells',2),(31,'The Invisible Man','H.G. Wells',3),(32,'Pride and Prejudice','Jane Austen',4),(33,'Oliver Twist','Charles Dickens',3),(34,'A Tale of Two Cities','Charles Dickens',2),(35,'The Adventures of Tom Sawyer','Mark Twain',5),(36,'The Adventures of Huckleberry Finn','Mark Twain',4),(37,'Fahrenheit 451','Ray Bradbury',3),(38,'Animal Farm','George Orwell',5),(39,'The Giver','Lois Lowry',4),(40,'Wonder','R.J. Palacio',6),(41,'The Fault in Our Stars','John Green',3),(42,'Life of Pi','Yann Martel',4),(43,'The Book Thief','Markus Zusak',2),(44,'A Wrinkle in Time','Madeleine L\'Engle',3),(45,'The Secret Garden','Frances Hodgson Burnett',4);
/*!40000 ALTER TABLE `Books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Issued_Books`
--

DROP TABLE IF EXISTS `Issued_Books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Issued_Books` (
  `issue_id` int NOT NULL,
  `student_id` int DEFAULT NULL,
  `book_id` int DEFAULT NULL,
  `issue_date` date DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `return_date` date DEFAULT NULL,
  `status` enum('Issued','Returned','Overdue') DEFAULT 'Issued',
  `fine_amount` decimal(6,2) DEFAULT '0.00',
  PRIMARY KEY (`issue_id`),
  KEY `student_id` (`student_id`),
  KEY `book_id` (`book_id`),
  KEY `idx_issued_status_due` (`status`,`due_date`),
  CONSTRAINT `issued_books_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `Students` (`student_id`),
  CONSTRAINT `issued_books_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `Books` (`book_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Issued_Books`
--

LOCK TABLES `Issued_Books` WRITE;
/*!40000 ALTER TABLE `Issued_Books` DISABLE KEYS */;
INSERT INTO `Issued_Books` VALUES (501,101,1,'2026-11-17','2026-12-01',NULL,'Issued',0.00),(502,102,3,'2026-11-17','2026-12-01',NULL,'Issued',0.00),(503,104,4,'2026-10-01','2026-10-15','2026-10-20','Returned',25.00),(504,105,5,'2026-10-02','2026-10-16',NULL,'Issued',0.00),(505,106,6,'2026-10-03','2026-10-17',NULL,'Issued',0.00),(506,107,7,'2026-10-04','2026-10-18',NULL,'Issued',0.00),(507,108,8,'2026-10-05','2026-10-19',NULL,'Issued',0.00),(508,109,9,'2026-10-06','2026-10-20',NULL,'Issued',0.00),(509,110,10,'2026-10-07','2026-10-21',NULL,'Issued',0.00),(510,111,11,'2026-10-08','2026-10-22',NULL,'Issued',0.00),(511,112,12,'2026-10-09','2026-10-23',NULL,'Issued',0.00),(512,113,13,'2026-10-10','2026-10-24',NULL,'Issued',0.00),(513,114,14,'2026-10-11','2026-10-25',NULL,'Issued',0.00),(514,115,15,'2026-10-12','2026-10-26',NULL,'Issued',0.00),(515,116,16,'2026-10-13','2026-10-27',NULL,'Issued',0.00),(516,117,17,'2026-10-14','2026-10-28',NULL,'Issued',0.00),(517,118,18,'2026-10-15','2026-10-29',NULL,'Issued',0.00),(518,119,19,'2026-10-16','2026-10-30',NULL,'Issued',0.00),(519,120,20,'2026-10-17','2026-10-31',NULL,'Issued',0.00),(520,121,21,'2026-10-18','2026-11-01',NULL,'Issued',0.00),(521,122,22,'2026-10-19','2026-11-02',NULL,'Issued',0.00),(522,123,23,'2026-10-20','2026-11-03',NULL,'Issued',0.00),(523,124,24,'2026-10-21','2026-11-04',NULL,'Issued',0.00),(524,125,25,'2026-10-22','2026-11-05',NULL,'Issued',0.00),(525,126,26,'2026-10-23','2026-11-06',NULL,'Issued',0.00),(526,127,27,'2026-10-24','2026-11-07',NULL,'Issued',0.00),(527,128,28,'2026-10-25','2026-11-08',NULL,'Issued',0.00),(528,129,29,'2026-10-26','2026-11-09',NULL,'Issued',0.00),(529,130,30,'2026-10-27','2026-11-10',NULL,'Issued',0.00),(530,131,31,'2026-10-28','2026-11-11',NULL,'Issued',0.00),(531,132,32,'2026-10-29','2026-11-12',NULL,'Issued',0.00),(532,133,33,'2026-10-30','2026-11-13',NULL,'Issued',0.00),(533,134,34,'2026-11-01','2026-11-15',NULL,'Issued',0.00),(534,135,35,'2026-11-02','2026-11-16',NULL,'Issued',0.00),(535,136,36,'2026-11-03','2026-11-17',NULL,'Issued',0.00),(536,137,37,'2026-11-04','2026-11-18',NULL,'Issued',0.00),(537,138,38,'2026-11-05','2026-11-19',NULL,'Issued',0.00),(538,139,39,'2026-11-06','2026-11-20',NULL,'Issued',0.00),(539,140,40,'2026-11-07','2026-11-21',NULL,'Issued',0.00),(540,141,41,'2026-11-08','2026-11-22',NULL,'Issued',0.00),(541,142,42,'2026-11-09','2026-11-23',NULL,'Issued',0.00),(542,143,43,'2026-11-10','2026-11-24',NULL,'Issued',0.00),(543,144,44,'2026-11-11','2026-11-25',NULL,'Issued',0.00),(544,145,45,'2026-11-12','2026-11-26',NULL,'Issued',0.00),(545,146,4,'2026-11-13','2026-11-27',NULL,'Issued',0.00),(546,147,10,'2026-11-14','2026-11-28',NULL,'Issued',0.00),(547,148,17,'2026-11-15','2026-11-29',NULL,'Issued',0.00);
/*!40000 ALTER TABLE `Issued_Books` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_book_issue` AFTER INSERT ON `issued_books` FOR EACH ROW BEGIN
    UPDATE Books 
    SET copies_available = copies_available - 1 
    WHERE book_id = NEW.book_id;

    INSERT INTO Audit_Log (action_type, table_name, record_id, performed_by)
    VALUES ('ISSUE', 'Issued_Books', NEW.issue_id, USER());
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_book_return` AFTER UPDATE ON `issued_books` FOR EACH ROW BEGIN
    IF OLD.status <> 'Returned' AND NEW.status = 'Returned' THEN
        UPDATE Books 
        SET copies_available = copies_available + 1 
        WHERE book_id = NEW.book_id;

        INSERT INTO Audit_Log (action_type, table_name, record_id, performed_by)
        VALUES ('RETURN', 'Issued_Books', NEW.issue_id, USER());
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `overdue_books_report`
--

DROP TABLE IF EXISTS `overdue_books_report`;
/*!50001 DROP VIEW IF EXISTS `overdue_books_report`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `overdue_books_report` AS SELECT 
 1 AS `issue_id`,
 1 AS `student_name`,
 1 AS `grade`,
 1 AS `title`,
 1 AS `issue_date`,
 1 AS `due_date`,
 1 AS `days_overdue`,
 1 AS `estimated_fine`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Students`
--

DROP TABLE IF EXISTS `Students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Students` (
  `student_id` int NOT NULL,
  `student_name` varchar(50) NOT NULL,
  `grade` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Students`
--

LOCK TABLES `Students` WRITE;
/*!40000 ALTER TABLE `Students` DISABLE KEYS */;
INSERT INTO `Students` VALUES (101,'Aarav Sharma','10th'),(102,'Diya Patel','9th'),(103,'Rohan Verma','10th'),(104,'Ananya Reddy','10th'),(105,'Vikram Nair','9th'),(106,'Kavya Menon','8th'),(107,'Aditya Kulkarni','10th'),(108,'Sneha Iyer','9th'),(109,'Karthik Rao','8th'),(110,'Meera Joshi','10th'),(111,'Siddharth Verma','7th'),(112,'Pooja Deshmukh','9th'),(113,'Arjun Kapoor','8th'),(114,'Nandini Pillai','10th'),(115,'Rahul Choudhary','7th'),(116,'Divya Krishnan','9th'),(117,'Manish Tiwari','8th'),(118,'Shreya Sen','10th'),(119,'Nikhil Agarwal','9th'),(120,'Tanvi Shetty','7th'),(121,'Pranav Hegde','8th'),(122,'Riya Malhotra','10th'),(123,'Varun Bhatia','9th'),(124,'Ishita Ghosh','8th'),(125,'Harsha Vardhan','10th'),(126,'Keerthi Suresh','7th'),(127,'Sai Charan','9th'),(128,'Lakshmi Narayanan','8th'),(129,'Abhinav Mishra','10th'),(130,'Swathi Reddy','9th'),(131,'Tarun Kumar','7th'),(132,'Bhavana Gowda','8th'),(133,'Gautam Menon','10th'),(134,'Neha Saxena','9th'),(135,'Tejaswini Rao','8th'),(136,'Yashwanth Naidu','10th'),(137,'Pallavi Kulkarni','7th'),(138,'Surya Prakash','9th'),(139,'Anjali Bansal','8th'),(140,'Kiran Babu','10th'),(141,'Deepika Padukone','9th'),(142,'Rakesh Roshan','7th'),(143,'Madhavi Latha','8th'),(144,'Chaitanya Krishna','10th'),(145,'Sravani Devi','9th'),(146,'Vamsi Krishna','8th'),(147,'Harika Reddy','7th'),(148,'Pavan Parthiv','10th');
/*!40000 ALTER TABLE `Students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'SchoolLibrary'
--
--
-- WARNING: can't read the INFORMATION_SCHEMA.libraries table. It's most probably an old server 8.0.46.
--
--
-- WARNING: can't read the INFORMATION_SCHEMA.libraries table. It's most probably an old server 8.0.46.
--
/*!50003 DROP PROCEDURE IF EXISTS `ReturnBook` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ReturnBook`(IN p_issue_id INT, IN p_return_date DATE)
BEGIN
    DECLARE v_due_date DATE;
    DECLARE v_late_days INT;
    DECLARE v_fine DECIMAL(6,2) DEFAULT 0.00;

    SELECT due_date INTO v_due_date FROM Issued_Books WHERE issue_id = p_issue_id;
    SET v_late_days = DATEDIFF(p_return_date, v_due_date);

    IF v_late_days > 0 THEN
        SET v_fine = v_late_days * 5.00;
    END IF;

    UPDATE Issued_Books
    SET return_date = p_return_date,
        status = 'Returned',
        fine_amount = v_fine
    WHERE issue_id = p_issue_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `overdue_books_report`
--

/*!50001 DROP VIEW IF EXISTS `overdue_books_report`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `overdue_books_report` AS select `i`.`issue_id` AS `issue_id`,`s`.`student_name` AS `student_name`,`s`.`grade` AS `grade`,`b`.`title` AS `title`,`i`.`issue_date` AS `issue_date`,`i`.`due_date` AS `due_date`,(to_days('2026-11-17') - to_days(`i`.`due_date`)) AS `days_overdue`,((to_days('2026-11-17') - to_days(`i`.`due_date`)) * 5) AS `estimated_fine` from ((`issued_books` `i` join `students` `s` on((`i`.`student_id` = `s`.`student_id`))) join `books` `b` on((`i`.`book_id` = `b`.`book_id`))) where ((`i`.`status` = 'Issued') and (`i`.`due_date` < '2026-11-17')) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-17 15:05:20
