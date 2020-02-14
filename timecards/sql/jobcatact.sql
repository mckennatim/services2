-- MySQL dump 10.13  Distrib 5.7.22, for Linux (x86_64)
--
-- Host: localhost    Database: reroo
-- ------------------------------------------------------
-- Server version	5.7.22-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `jobcatact`
--

DROP TABLE IF EXISTS `jobcatact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jobcatact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job` varchar(60) DEFAULT NULL,
  `category` varchar(10) DEFAULT NULL,
  `active` int(1) DEFAULT NULL,
  `week` int(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `jobcat` (`job`,`category`) USING BTREE,
  KEY `category` (`category`),
  KEY `job` (`job`),
  KEY `active` (`active`),
  KEY `week` (`week`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobcatact`
--

LOCK TABLES `jobcatact` WRITE;
/*!40000 ALTER TABLE `jobcatact` DISABLE KEYS */;
INSERT INTO `jobcatact` VALUES (49,'Marketting',NULL,1,0),(50,'Nursery',NULL,0,0),(51,'Truck and tools',NULL,0,0),(52,'HYCC',NULL,0,0),(53,'Ken Wing - Rockview',NULL,0,0),(54,'Eastie Farm',NULL,0,0),(55,'15 Atherton',NULL,1,0),(56,'2054 Dot Ave',NULL,1,0),(57,'105 Green St',NULL,1,0),(58,'Egelston Library',NULL,0,0),(59,'19 cornelius way',NULL,0,0),(60,'20 Alveston',NULL,1,0),(61,'16 roanoke',NULL,0,0),(62,'Roz Walter - 20 Dell',NULL,1,0),(63,'Boston Microgreens',NULL,1,0),(64,'Gibran and Samantha',NULL,1,0),(65,'195 chestnut',NULL,0,0),(66,'40 chestnut ave - alex marburger',NULL,0,0),(67,'38 Jamaica',NULL,0,0),(68,'18 Holbrook - Everett and Molly',NULL,1,0),(69,'Karen and Duncan - 254 Hawthorne',NULL,0,0),(70,'Terese Hammerle - ',NULL,1,0),(71,'Arbour Hospital',NULL,1,0),(72,'Diana McClure ',NULL,0,0),(73,'Cam Kerry - 21 Adelaide',NULL,1,0),(74,'Nancy Lipamn - Kitteridge Court',NULL,0,0),(75,'68 Cypress',NULL,0,0),(76,'Rick Hammond - Liszt St Rosi',NULL,0,0),(77,'Jeanette - Clayborne garden green roof',NULL,0,0),(78,'76 South St, Lucy Orloski',NULL,1,0),(79,'349 VFW Parkway - Bunny Hickey',NULL,0,0),(80,'68 Rockview - terri martell',NULL,1,0),(81,'Jennileen Joseph 218 Neponset Ave',NULL,0,0),(82,'Nathan Lord - 158 Hampshire',NULL,1,0),(83,'South Boston Library - Kathleen Mar',NULL,0,0),(84,'Jodie Wahldesbuhl - 22 Thayer st brookline',NULL,0,0),(85,'Michael Bellefeille - 40 Gartland',NULL,1,0),(86,'Daphnah and Jay - 1435 Centre',NULL,1,0),(87,'241-5 Chestnut Ave',NULL,1,0),(88,'17 Park Lane',NULL,1,0),(89,'JPNDC brewery',NULL,1,0),(90,'John Stainton - 37 Pondview',NULL,0,0),(91,'37 ogden',NULL,0,0),(92,'14 chestnut',NULL,1,0),(93,'Dae Kim - 16 Zamora',NULL,0,0),(94,'63-65 Chestnut',NULL,1,0),(95,'233 Chestnut - Greg Gulickssen',NULL,0,0),(96,'126 Thornton - Lucy Lomas',NULL,0,0),(97,'Dee and Maya - Rockview',NULL,0,0),(98,'Michael Hecht - 9 Park Lane',NULL,1,0),(99,'241-5 Chestnut Ave',NULL,0,0),(100,'Chestnut Rockview Backwoods',NULL,1,0),(101,'11 danforth',NULL,1,0),(102,'connolly library',NULL,1,0),(103,'Marushka Glissen - Lamartine?',NULL,1,0),(104,'Donna Woonteiler - 8 Chetnut Place',NULL,0,0),(105,'J&M Brown',NULL,1,0);
/*!40000 ALTER TABLE `jobcatact` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-07-26 13:04:55
