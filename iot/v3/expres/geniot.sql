-- MySQL dump 10.13  Distrib 5.7.27, for Linux (x86_64)
--
-- Host: sitebuilt.net    Database: geniot
-- ------------------------------------------------------
-- Server version	5.7.27-0ubuntu0.16.04.1

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
-- Table structure for table `app_loc`
--

DROP TABLE IF EXISTS `app_loc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_loc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `appid` varchar(20) NOT NULL,
  `locid` varchar(20) NOT NULL,
  `devs` varchar(600) DEFAULT NULL,
  `zones` varchar(600) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `main` (`appid`,`locid`),
  KEY `locid` (`locid`),
  KEY `appid` (`appid`)
) ENGINE=InnoDB AUTO_INCREMENT=413 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_loc`
--

LOCK TABLES `app_loc` WRITE;
/*!40000 ALTER TABLE `app_loc` DISABLE KEYS */;
INSERT INTO `app_loc` VALUES (405,'hvac','12ParleyVale','{\n  \"CYURD030\": [\n    {\n      \"sr\": 0,\n      \"label\": \"kid\"\n    },\n    {\n      \"sr\": 1,\n      \"label\": \"lr\"\n    },\n    {\n      \"sr\": 2,\n      \"label\": \"music\"\n    },\n    {\n      \"sr\": 3,\n      \"label\": \"peri\"\n    },\n    {\n      \"sr\": 4,\n      \"label\": \"timer\"\n    }\n  ],\n  \"CYURD006\": [\n    {\n      \"sr\": 0,\n      \"label\": \"temp_out\"\n    }\n  ]\n}','[\n  {\n    \"id\": \"kid\",\n    \"name\": \"Kid\'s Suite\",\n    \"img\": \"kid.jpg\"\n  },\n  {\n    \"id\": \"lr\",\n    \"name\": \"Living Room\",\n    \"img\": \"lr.jpg\"\n  },\n  {\n    \"id\": \"music\",\n    \"name\": \"Music Room\",\n    \"img\": \"music.jpg\"\n  },\n  {\n    \"id\": \"peri\",\n    \"name\": \"Peri\'s Study\",\n    \"img\": \"peri.jpg\"\n  },\n  {\n    \"id\": \"temp_out\",\n    \"name\": \"Outside Temperature\",\n    \"img\": \"temp_out.jpg\"\n  },\n  {\n    \"id\": \"timer\",\n    \"name\": \"Timer\",\n    \"img\": \"timer.jpg\"\n  }\n]'),(406,'hvac','255ChestnutAve','{\"CYURD013\": [{\"sr\":0,\"label\":\"kid\"}, {\"sr\":1,\"label\":\"lr\"}], \"CYURD016\": [{\"sr\":0,\"label\":\"music\"}, {\"sr\":1,\"label\":\"peri\"}]}','[{\"id\":\"kid\", \"name\":\"Kid\'s Suite\",\"img\":\"kid.jpg\"}, {\"id\":\"lr\",\"name\":\"Living Room\",\"img\":\"lr.jpg\"},{\"id\":\"music\",\"name\":\"Music Room\",\"img\":\"music.jpg\"},{\"id\":\"peri\",\"name\":\"Peri\'s Study\",\"img\":\"peri.jpg\"}]'),(407,'greenhouse','12ParleyVale','{\"CYURD004\": [{\"sr\":0,\"label\":\"temp_gh\"}, {\"sr\":1,\"label\":\"hum_gh\"}, {\"sr\":2,\"label\":\"light_gh\"}], \"CYURD006\": [{\"sr\":0,\"label\":\"temp_out\"}]}','[{\"id\":\"temp_gh\", \"name\":\"Greenhouse Temperature\",\"img\":\"temp_gh.jpg\"}, {\"id\":\"hum_gh\",\"name\":\"Greenhouse Humidity\",\"img\":\"hum_gh.jpg\"}, {\"id\": \"light_gh\", \"name\":\"Greenhouse Lights\",\"img\":\"light_gh.jpg\"},{\"id\":\"temp_out\",\"name\":\"Outside Temperature\",\"img\":\"temp_out.jpg\"}]'),(409,'timr','255ChestnutAve','{\"CYURD013\": [{\"sr\":0,\"label\":\"temp-gh\"}, {\"sr\":1,\"label\":\"hum-gh\"}, {\"sr\":2,\"label\":\"light-gh\"}], \"CYURD016\": [{\"sr\":0,\"label\":\"temp-out\"}]}','[{\"id\":\"temp-gh\", \"name\":\"Greenhouse Temperature\",\"img\":\"temp-gh.jpg\"}, {\"id\":\"hum-gh\",\"name\":\"Greenhouse Humidity\",\"img\":\"hum-gh.jpg\"},{\"id\":\"temp-out\",\"name\":\"Outside Temperature\",\"img\":\"temp-out.jpg\"}]'),(410,'lightsoff','12ParleyVale','{\"CYURD004\": [{\"sr\":0,\"label\":\"temp-gh\"}, {\"sr\":1,\"label\":\"hum-gh\"}, {\"sr\":2,\"label\":\"light-gh\"}], \"CYURD006\": [{\"sr\":0,\"label\":\"temp-out\"}]}','[{\"id\":\"temp-gh\", \"name\":\"Greenhouse Temperature\",\"img\":\"temp-gh.jpg\"}, {\"id\":\"hum-gh\",\"name\":\"Greenhouse Humidity\",\"img\":\"hum-gh.jpg\"}, {\"id\": \"light-gh\", \"name\":\"Greenhouse Lights\",\"img\":\"light-gh.jpg\"},{\"id\":\"temp-out\",\"name\":\"Outside Temperature\",\"img\":\"temp-out.jpg\"}]'),(411,'cascada','10-12ParleyVale','{\n  \"CYURD002\": [\n    {\n      \"sr\": 4,\n      \"label\": \"pond\"\n    },\n    {\n      \"sr\": 3,\n      \"label\": \"bridge\"\n    },\n    {\n      \"sr\": 2,\n      \"label\": \"center\"\n    }\n  ]\n}','[\r\n  {\r\n    \"id\": \"pond\",\r\n    \"name\": \"pond\",\r\n    \"img\": \"pond.jpg\"\r\n  },\r\n  {\r\n    \"id\": \"bridge\",\r\n    \"name\": \"bridge\",\r\n    \"img\": \"bridge.jpg\"\r\n  },\r\n  {\r\n    \"id\": \"center\",\r\n    \"name\": \"center\",\r\n    \"img\": \"center.jpg\"\r\n  }\r\n]'),(412,'greenhouse','10-12ParleyVale','{\"CYURD004\": [{\"sr\":0,\"label\":\"temp_gh\"}, {\"sr\":1,\"label\":\"hum_gh\"}, {\"sr\":3,\"label\":\"light_gh\"}], \"CYURD006\": [{\"sr\":0,\"label\":\"temp_out\"}]}','[{\"id\":\"temp_gh\", \"name\":\"Greenhouse Temperature\",\"img\":\"temp_gh.jpg\"}, {\"id\":\"hum_gh\",\"name\":\"Greenhouse Humidity\",\"img\":\"hum_gh.jpg\"}, {\"id\": \"light_gh\", \"name\":\"Greenhouse Lights\",\"img\":\"light_gh.jpg\"},{\"id\":\"temp_out\",\"name\":\"Outside Temperature\",\"img\":\"temp_out.jpg\"}]');
/*!40000 ALTER TABLE `app_loc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_loc_user`
--

DROP TABLE IF EXISTS `app_loc_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_loc_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `appid` varchar(20) DEFAULT NULL,
  `locid` varchar(60) DEFAULT NULL,
  `userid` varchar(60) NOT NULL,
  `role` varchar(20) DEFAULT NULL,
  `auth` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `main` (`userid`,`appid`,`locid`,`role`) USING BTREE,
  KEY `userid` (`userid`) USING BTREE,
  KEY `appid` (`appid`) USING BTREE,
  KEY `role` (`role`) USING BTREE,
  KEY `auth` (`auth`),
  KEY `locid` (`locid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_loc_user`
--

LOCK TABLES `app_loc_user` WRITE;
/*!40000 ALTER TABLE `app_loc_user` DISABLE KEYS */;
INSERT INTO `app_loc_user` VALUES (1,'base','4505NHaightAve','tim@sitebuilt.net','admin',0),(2,'builder','12ParleyVale','tim@sitebuilt.net','admin',1),(3,'builder','4505NHaightAve','tim@sitebuilt.net','admin',1),(4,'builder','794048thAveS','tim@sitebuilt.net','admin',1),(5,'builder','12ParleyVale','mckenna.tim@gmail.com','user',1),(6,'builder','4505NHaightAve','tim@sitebuilt.net','user',1),(7,'cascada','10-12ParleyVale','clipperjohn@gmail.com','admin',1),(8,'cascada','10-12ParleyVale','clippingersue@gmail.com','admin',1),(9,'cascada','10-12ParleyVale','tim@sitebuilt.net','admin',1),(10,'cascada','4505NHaightAve','tim@sitebuilt.net','admin',0),(11,'cascada','794048thAveS','tim@sitebuilt.net','admin',0),(12,'cascada','4505NHaightAve','mckenna.tim@gmail.com','user',NULL),(13,'demo','anywhere','mckenna.tim@gmail.com','admin',1),(14,'demo','anywhere','anybody','obs',1),(15,'greenhouse','794048thAveS','mckenna.tim@gmail.com','admin',1),(16,'greenhouse','12ParleyVale','mckenna.tim@gmail.com','user',1),(17,'greenhouse','255ChestnutAve','mckenna.tim@gmail.com','user',1),(18,'greenhouse','4505NHaightAve','mckenna.tim@gmail.com','user',1),(19,'hvac','12ParleyVale','tim@sitebuilt.net','admin',1),(20,'hvac','794048thAveS','tim@sitebuilt.net','admin',1),(21,'hvac','4505NHaightAve','tim@sitebuilt.net','obs',1),(22,'hvac','12ParleyVale','mckenna.tim@gmail.com','user',1),(23,'hvac','255ChestnutAve','mckenna.tim@gmail.com','user',1),(24,'hvac','255ChestnutAve','tim@sitebuilt.net','user',1),(25,'installer','12ParleyVale','mckenna.tim@gmail.com','admin',1),(26,'installer','12ParleyVale','tim@sitebuilt.net','admin',0),(27,'lightsoff','255ChestnutAve','tim@sitebuilt.net','admin',1),(28,'lightsoff','794048thAveS','tim@sitebuilt.net','admin',1),(29,'lightsoff','12ParleyVale','tim@sitebuilt.net','user',1),(30,'pahoRawSB','255ChestnutAve','mckenna.tim@gmail.com','admin',1),(31,'pahoRawSB','12ParleyVale','mckenna.tim@gmail.com','user',1),(32,'shrooms','255ChestnutAve','tim@sitebuilt.net','admin',0),(33,'shrooms','12ParleyVale','tim@sitebuilt.net','user',0),(34,'timr','12ParleyVale','tim@sitebuilt.net','user',1),(35,'timr','255ChestnutAve','tim@sitebuilt.net','user',1),(36,'timr','4505NHaightAve','tim@sitebuilt.net','user',1),(37,'timr','794048thAveS','tim@sitebuilt.net','user',1),(40,'greenhouse','12ParleyVale','mckenna.tim@gmail.com','builder',1),(41,'greenhouse','12ParleyVale','mckenna.tim@gmail.com','installer',1),(42,'lightsoff','12ParleyVale','tim@sitebuilt.net','installer',1),(43,'lightsoff','12ParleyVale','mckenna.tim@gmail.com','installer',1),(44,'lightsoff','12ParleyVale','mckenna.tim@gmail.com','admin',1),(45,'lightsoff','12ParleyVale','tim@sitebuilt.net','admin',1),(46,'greenhouse','12ParleyVale','tim@sitebuilt.net','user',1),(47,'greenhouse','12ParleyVale','tim@sitebuilt.net','installer',1),(48,'cascada','10-12ParleyVale','mckenna.tim@gmail.com','admin',1),(49,'greenhouse','10-12ParleyVale','tim@sitebuilt.net','user',1);
/*!40000 ALTER TABLE `app_loc_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `apps`
--

DROP TABLE IF EXISTS `apps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `apps` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `appid` varchar(20) NOT NULL,
  `appurl` varchar(30) DEFAULT NULL,
  `apiurl` varchar(30) DEFAULT NULL,
  `desc` varchar(200) DEFAULT NULL,
  `developer` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `appid` (`appid`),
  KEY `appurl` (`appurl`),
  KEY `apiurl` (`apiurl`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `apps`
--

LOCK TABLES `apps` WRITE;
/*!40000 ALTER TABLE `apps` DISABLE KEYS */;
INSERT INTO `apps` VALUES (1,'admind',NULL,NULL,NULL,NULL),(2,'shroom',NULL,NULL,NULL,NULL),(3,'pahoRawSB',NULL,NULL,NULL,NULL),(4,'cascada',NULL,NULL,NULL,NULL),(5,'hvac',NULL,NULL,NULL,NULL),(6,'lightsoff',NULL,NULL,NULL,NULL),(7,'timr',NULL,NULL,NULL,NULL),(8,'builder',NULL,NULL,NULL,'mckenna.tim@gmail.com'),(9,'developer',NULL,NULL,NULL,'mckenna.tim@gmail.com'),(10,'installer',NULL,NULL,NULL,'mckenna.tim@gmail.com');
/*!40000 ALTER TABLE `apps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `biz`
--

DROP TABLE IF EXISTS `biz`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `biz` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bizid` varchar(20) NOT NULL,
  `bizname` varchar(120) DEFAULT NULL,
  `emid` varchar(40) DEFAULT NULL,
  `job` varchar(40) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `location` varchar(200) DEFAULT NULL,
  `prefix` varchar(8) NOT NULL DEFAULT 'CYURD',
  PRIMARY KEY (`id`),
  KEY `bizid` (`bizid`),
  KEY `bizname` (`bizname`),
  KEY `owner` (`emid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biz`
--

LOCK TABLES `biz` WRITE;
/*!40000 ALTER TABLE `biz` DISABLE KEYS */;
INSERT INTO `biz` VALUES (1,'sbs','Sitebuilt Systems','mckenna.tim@gmail.com','builder','crazy shit','JP','CYURD'),(2,'sbs','Sitebuilt Systems','mckenna.tim@gmail.com','installer','crazy shit','JP','CYURD');
/*!40000 ALTER TABLE `biz` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bizapp`
--

DROP TABLE IF EXISTS `bizapp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bizapp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bizid` varchar(20) DEFAULT NULL,
  `appid` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `main` (`bizid`,`appid`),
  KEY `bizid` (`bizid`),
  KEY `appid` (`appid`)
) ENGINE=InnoDB AUTO_INCREMENT=452 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bizapp`
--

LOCK TABLES `bizapp` WRITE;
/*!40000 ALTER TABLE `bizapp` DISABLE KEYS */;
INSERT INTO `bizapp` VALUES (300,'sbs','admin'),(392,'sbs','base'),(332,'sbs','cascada'),(331,'sbs','cascada_hs'),(377,'sbs','hvac'),(314,'sbs','lightsoff'),(353,'sbs','pahoRawSB'),(360,'sbs','shroom'),(451,'sbs','shrooms'),(301,'sbs','user');
/*!40000 ALTER TABLE `bizapp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `devs`
--

DROP TABLE IF EXISTS `devs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `devs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `devid` varchar(30) NOT NULL,
  `devpwd` varchar(24) DEFAULT NULL,
  `description` varchar(220) DEFAULT NULL,
  `bizid` varchar(20) DEFAULT NULL,
  `locid` varchar(20) DEFAULT NULL,
  `server` varchar(120) DEFAULT NULL,
  `specs` varchar(2048) DEFAULT NULL,
  `owner` varchar(60) DEFAULT NULL,
  `apps` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `devid` (`devid`),
  KEY `bizid` (`bizid`),
  KEY `locid` (`locid`),
  KEY `owner` (`owner`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devs`
--

LOCK TABLES `devs` WRITE;
/*!40000 ALTER TABLE `devs` DISABLE KEYS */;
INSERT INTO `devs` VALUES (1,'CYURD001','geniot','2 temps, 3 timers 1 relay demo board','sbs','12ParleyVale','{\"url\":\"10.0.1.105\",\"mqtt\":1883,\"express\":3332}','{\"HAStIMER\":28,\"notTimerTags\":[\"temp\",\"onoff\",\"hilimit\",\"lolimit\"],\"hysteresis\":2,\"sr\":[null]}','tim@sitebuilt.net','[\"hvac\"]'),(2,'CYURD007','geniot','2 temps, 3 timers 1 relay demo board2','sbs','12ParleyVale','{\"mqtt_server\":\"sitebuilt.net\",\"mqtt_port\":\"1884\",\"sensor_type\":\"\"}','{\"HAStIMER\":28,\"notTimerTags\":[\"temp\",\"onoff\",\"hilimit\",\"lolimit\"]}','tim@sitebuilt.net','[\"admin\", \"user\"]'),(3,'CYURBAD','nopwd',NULL,'sbs','12ParleyVale',NULL,NULL,NULL,NULL),(4,'CYURD008','geniot','2 temps, 3 timers 1 relay demo board','sbs','12ParleyVale','{\"url\":\"sitebuilt.net\",\"mqtt\":1884,\"express\":4332}','{\"HAStIMER\":28,\"notTimerTags\":[\"temp\",\"onoff\",\"hilimit\",\"lolimit\"]}','tim@sitebuilt.net',NULL),(5,'CYURD003','geniot','DHT 3 timers 1 temp 1 humidity greenhouse control','sbs','12ParleyVale','{\"mqtt_server\":\"sitebuilt.net\",\"mqtt_port\":\"1884\",\"sensor_type\":\"dht\"}','{ \"software_version\": \"2.0\", \"hardware_version\": \"wemos\", \"sr\": [ { \"srid\":0, \"hayrelay\":0, \"haysensor\":{ \"senses\":\"temp\", \"model\":\"DHT22\" } }, { \"srid\":1, \"hayrelay\":0, \"haysensor\":{ \"senses\":\"humid\", \"model\":\"DHT22\" } }, { \"srid\":2, \"hayrelay\":{ \"controlled\":0, \"defsched\":[[0,0,1]] }, \"haysensor\":0 } ] }','tim@sitebuilt.net','[\"admin\", \"base\", \"shrooms\", \"hvac\", \"lightsoff\"]'),(6,'CYURD006','geniot','just tem sensor','sbs','12ParleyVale','{\"mqtt_server\":\"sitebuilt.net\",\"mqtt_port\":\"1884\",\"sensor_type\":\"\"}','{\"HAStIMER\":28,\"notTimerTags\":[\"temp\",\"onoff\",\"hilimit\",\"lolimit\"],\"sr\":[{\"id\":0,\"hayrelay\":0,\"sensor\":{\"senses\":\"temp\",\"model\":\"DSP18b20\"}}]}','tim@sitebuilt.net','[\"admin\", \"base\", \"shrooms\", \"hvac\", \"lightsoff\", \"timr\"]'),(7,'CYURD004','geniot','DHT temp, humidity 1 relay greenhouse lights4','sbs','12ParleyVale','{\"mqtt_server\":\"sitebuilt.net\",\"mqtt_port\":\"1884\",\"sensor_type\":\"DHT\"}','{\"HAStIMER\":28,\"notTimerTags\":[\"temp\",\"onoff\",\"hilimit\",\"lolimit\"],\"sr\":[{\"id\":0,\"hayrelay\":0,\"sensor\":{\"senses\":\"temp\",\"model\":\"DHT22\"}},{\"id\":1,\"hayrelay\":0,\"sensor\":{\"senses\":\"humid\",\"model\":\"DHT22\"}},{\"id\":2,\"hayrelay\":1,\"sensor\":{}}]}','tim@sitebuilt.net','[\"lightsoff\",\"timr\"]'),(8,'CYURD002','geniot','cascada 3 timers 3 relays','sbs','12ParleyVale','{\"url\":\"sitebuilt.net\",\"mqtt\":1884,\"express\":3333}','{\"HAStIMER\":28,\"notTimerTags\":[\"temp\",\"onoff\",\"hilimit\",\"lolimit\"]}','tim@sitebuilt.net',NULL),(27,'CYURD027','geniot','2 temps, 3 timers 1 relay demo board','sbs','794048thAveS','{\"mqtt_server\":\"sitebuilt.net\",\"mqtt_port\":\"1884\",\"sensor_type\":\"\"}','{\"HAStIMER\":28,\"notTimerTags\":[\"temp\",\"onoff\",\"hilimit\",\"lolimit\"]}','tim@sitebuilt.net','[\"admin\", \"user\", \"hvac\", \"base\"]'),(29,'CYURD013','geniot','2 temps, 3 timers 1 relay demo board','sbs','255ChestnutAve','{\"mqtt_server\":\"sitebuilt.net\",\"mqtt_port\":\"1884\",\"sensor_type\":\"\"}','{\"HAStIMER\":28,\"notTimerTags\":[\"temp\",\"onoff\",\"hilimit\",\"lolimit\"]}','tim@sitebuilt.net','[\"admin\", \"user\", \"hvac\", \"base\"]'),(30,'CYURD029','geniot','2 temps, 3 timers 1 relay demo board','sbs','4505NHaightAve','{\"mqtt_server\":\"sitebuilt.net\",\"mqtt_port\":\"1884\",\"sensor_type\":\"\"}','{\"HAStIMER\":28,\"notTimerTags\":[\"temp\",\"onoff\",\"hilimit\",\"lolimit\"]}','tim@sitebuilt.net','[\"admin\", \"user\", \"hvac\", \"base\"]'),(38,'CYURD016','geniot','2 temps, 3 timers 1 relay demo board','sbs','255ChestnutAve','{\"mqtt_server\":\"sitebuilt.net\",\"mqtt_port\":\"1884\",\"sensor_type\":\"\"}','{\"HAStIMER\":28,\"notTimerTags\":[\"temp\",\"onoff\",\"hilimit\",\"lolimit\"]}','tim@sitebuilt.net','[\"admin\", \"user\", \"hvac\", \"base\"]'),(40,'CYURD','nopwd',NULL,'sbs','12ParleyVale',NULL,NULL,'mckenna.tim@gmail.com','[\"builder\", \"developer\"]'),(48,'CYURD030','geniot','description','sbs','12ParleyVale','{\n  \"url\": \"sitebuilt.net\",\n  \"mqtt\": 1884,\n  \"express\": 3333\n}','{\n  \"HAStIMER\": 16,\n  \"notTimerTags\": [\n    \"temp\",\n    \"onoff\",\n    \"hilimit\",\n    \"lolimit\"\n  ],\n  \"hysteresis\": 2,\n  \"reportEvery\": 5,\n  \"software_version\": \"espboth/hvac\",\n  \"hardware_version\": \"d1_wemos\",\n  \"sr\": [\n    {\n      \"srid\": 0,\n      \"haysensor\": {\n        \"senses\": \"temp\",\n        \"model\": \"DS18B20\"\n      },\n      \"hayrelay\": {\n        \"controlled\": 1,\n        \"defsched\": [\n          0,\n          0,\n          55,\n          52\n        ]\n      }\n    },\n    {\n      \"srid\": 1,\n      \"haysensor\": {\n        \"senses\": \"temp\",\n        \"model\": \"DS18B20\"\n      },\n      \"hayrelay\": {\n        \"controlled\": 1,\n        \"defsched\": [\n          0,\n          0,\n          66,\n          62\n        ]\n      }\n    },\n    {\n      \"srid\": 2,\n      \"haysensor\": {\n        \"senses\": \"temp\",\n        \"model\": \"DS18B20\"\n      },\n      \"hayrelay\": {\n        \"controlled\": 1,\n        \"defsched\": [\n          0,\n          0,\n          66,\n          62\n        ]\n      }\n    },\n    {\n      \"srid\": 3,\n      \"haysensor\": {\n        \"senses\": \"temp\",\n        \"model\": \"DS18B20\"\n      },\n      \"hayrelay\": {\n        \"controlled\": 1,\n        \"defsched\": [\n          0,\n          0,\n          66,\n          62\n        ]\n      }\n    },\n    {\n      \"srid\": 4,\n      \"hayrelay\": {\n        \"controlled\": 0,\n        \"defsched\": [\n          [\n            0,\n            0,\n            1\n          ]\n        ]\n      },\n      \"haysensor\": 0\n    }\n  ]\n}','tim@sitebuilt.net',NULL),(53,'CYURD031',NULL,'description dist2',NULL,NULL,NULL,'{\"software_version\":\"2.0\",\"hardware_version\":\"wemos\",\"sr\":[{\"srid\":0,\"haysensor\":{\"senses\":\"humid/temp\",\"model\":\"DHT22/DS18B20\"},\"hayrelay\":{\"controlled\":1,\"defsched\":[0,0,55,52]}},{\"srid\":1,\"haysensor\":0,\"hayrelay\":0}]}','mckenna.tim@gmail.com',NULL),(54,'CYURD041','geniot','blank wemos d1_mini esp8266','sbs','12ParleyVale','{\"mqtt_server\":\"sitebuilt.net\",\"mqtt_port\":\"1884\",\"sensor_type\":\"\"}','{\"HAStIMER\":28,\"notTimerTags\":[\"temp\",\"onoff\",\"hilimit\",\"lolimit\"],\"sr\":[{\"id\":0,\"hayrelay\":0,\"sensor\":{\"senses\":\"temp\",\"model\":\"DSP18b20\"}}]}','tim@sitebuilt.net','[\"admin\", \"base\", \"shrooms\", \"hvac\", \"lightsoff\", \"timr\"]'),(55,'CYURD042','geniot','blank lolin32 rover esp32 board','sbs','12ParleyVale','{\"mqtt_server\":\"sitebuilt.net\",\"mqtt_port\":\"1884\",\"sensor_type\":\"\"}','{\"HAStIMER\":28,\"notTimerTags\":[\"temp\",\"onoff\",\"hilimit\",\"lolimit\"],\"sr\":[{\"id\":0,\"hayrelay\":0,\"sensor\":{\"senses\":\"temp\",\"model\":\"DSP18b20\"}}]}','tim@sitebuilt.net','[\"admin\", \"base\", \"shrooms\", \"hvac\", \"lightsoff\", \"timr\"]'),(57,'CYURD043','geniot','blank nodemcu-32s esp32 board','sbs','12ParleyVale','{\"mqtt_server\":\"sitebuilt.net\",\"mqtt_port\":\"1884\",\"sensor_type\":\"\"}','{\"HAStIMER\":28,\"notTimerTags\":[\"temp\",\"onoff\",\"hilimit\",\"lolimit\"],\"sr\":[{\"id\":0,\"hayrelay\":0,\"sensor\":{\"senses\":\"temp\",\"model\":\"DSP18b20\"}}]}','tim@sitebuilt.net','[\"admin\", \"base\", \"shrooms\", \"hvac\", \"lightsoff\", \"timr\"]'),(58,'CYURD044','geniot','blank esp32doit-devkit-v1 esp32 board','sbs','12ParleyVale','{\"mqtt_server\":\"sitebuilt.net\",\"mqtt_port\":\"1884\",\"sensor_type\":\"\"}','{\"HAStIMER\":28,\"notTimerTags\":[\"temp\",\"onoff\",\"hilimit\",\"lolimit\"],\"sr\":[{\"id\":0,\"hayrelay\":0,\"sensor\":{\"senses\":\"temp\",\"model\":\"DSP18b20\"}}],\"software_version\":\"pio-ardui_espBoth\",\"hardware_version\":\"esp32doit-devkit-v1\"}','tim@sitebuilt.net','[\"admin\", \"base\", \"shrooms\", \"hvac\", \"lightsoff\", \"timr\"]'),(65,'CYURD060','geniot','description','sbs','4505NHaightAve','{\r\n  \"url\": \"sitebuilt.net\",\r\n  \"mqtt\": 1884,\r\n  \"express\": 3333\r\n}','{\r\n  \"HAStIMER\": 16,\r\n  \"notTimerTags\": [\r\n    \"temp\",\r\n    \"onoff\",\r\n    \"hilimit\",\r\n    \"lolimit\"\r\n  ],\r\n  \"hysteresis\": 2,\r\n  \"reportEvery\": 5,\r\n  \"software_version\": \"espboth/hvac\",\r\n  \"hardware_version\": \"d1_wemos\",\r\n  \"sr\": [\r\n    {\r\n      \"srid\": 0,\r\n      \"haysensor\": {\r\n        \"senses\": \"temp\",\r\n        \"model\": \"DS18B20\"\r\n      },\r\n      \"hayrelay\": {\r\n        \"controlled\": 1,\r\n        \"defsched\": [\r\n          0,\r\n          0,\r\n          55,\r\n          52\r\n        ]\r\n      }\r\n    },\r\n    {\r\n      \"srid\": 1,\r\n      \"haysensor\": {\r\n        \"senses\": \"temp\",\r\n        \"model\": \"DS18B20\"\r\n      },\r\n      \"hayrelay\": {\r\n        \"controlled\": 1,\r\n        \"defsched\": [\r\n          0,\r\n          0,\r\n          66,\r\n          62\r\n        ]\r\n      }\r\n    },\r\n    {\r\n      \"srid\": 2,\r\n      \"haysensor\": {\r\n        \"senses\": \"temp\",\r\n        \"model\": \"DS18B20\"\r\n      },\r\n      \"hayrelay\": {\r\n        \"controlled\": 1,\r\n        \"defsched\": [\r\n          0,\r\n          0,\r\n          66,\r\n          62\r\n        ]\r\n      }\r\n    },\r\n    {\r\n      \"srid\": 3,\r\n      \"haysensor\": {\r\n        \"senses\": \"temp\",\r\n        \"model\": \"DS18B20\"\r\n      },\r\n      \"hayrelay\": {\r\n        \"controlled\": 1,\r\n        \"defsched\": [\r\n          0,\r\n          0,\r\n          66,\r\n          62\r\n        ]\r\n      }\r\n    },\r\n    {\r\n      \"srid\": 4,\r\n      \"hayrelay\": {\r\n        \"controlled\": 0,\r\n        \"defsched\": [\r\n          [\r\n            0,\r\n            0,\r\n            1\r\n          ]\r\n        ]\r\n      },\r\n      \"haysensor\": 0\r\n    }\r\n  ]\r\n}','tobinmckenna@gmail.com',NULL);
/*!40000 ALTER TABLE `devs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `heirlooms`
--

DROP TABLE IF EXISTS `heirlooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `heirlooms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `variety` varchar(28) NOT NULL,
  `dot` varchar(20) NOT NULL,
  `num` int(2) DEFAULT NULL,
  `amt` int(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `name` (`variety`),
  KEY `color` (`dot`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `heirlooms`
--

LOCK TABLES `heirlooms` WRITE;
/*!40000 ALTER TABLE `heirlooms` DISABLE KEYS */;
INSERT INTO `heirlooms` VALUES (2,'Brandywine','red',12,18),(4,'Purple Cherokee','purple',13,21),(8,'Moskovich','green',6,13),(9,'Valencia','orange',11,17),(10,'Striped German','pink',11,16),(12,'Glacier','yellow',3,7),(13,'Supersweet 100','blue',12,18);
/*!40000 ALTER TABLE `heirlooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hepeop`
--

DROP TABLE IF EXISTS `hepeop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hepeop` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(70) NOT NULL,
  `selected` varchar(600) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=148 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hepeop`
--

LOCK TABLES `hepeop` WRITE;
/*!40000 ALTER TABLE `hepeop` DISABLE KEYS */;
INSERT INTO `hepeop` VALUES (1,'mckenna.tim@gmail.com','[{\"variety\":\"Brandywine\",\"dot\":\"red\",\"num\":\"5\"},{\"variety\":\"Purple Cherokee\",\"dot\":\"purple\",\"num\":\"7\"},{\"variety\":\"Moskovich\",\"dot\":\"green\",\"num\":\"6\"},{\"variety\":\"Valencia\",\"dot\":\"orange\",\"num\":\"5\"},{\"variety\":\"Striped German\",\"dot\":\"pink\",\"num\":\"5\"},{\"variety\":\"Glacier\",\"dot\":\"yellow\",\"num\":\"4\"},{\"variety\":\"Supersweet 100\",\"dot\":\"blue\",\"num\":\"4\"}]'),(101,'lucyarth@gmail.com','[{\"variety\":\"Brandywine\",\"dot\":\"red\",\"num\":\"1\"},{\"variety\":\"Purple Cherokee\",\"dot\":\"purple\",\"num\":\"1\"},{\"variety\":\"Moskovich\",\"dot\":\"green\",\"num\":\"1\"},{\"variety\":\"Valencia\",\"dot\":\"orange\",\"num\":\"1\"}]'),(146,'clips','[{\"variety\":\"Supersweet 100\",\"dot\":\"blue\",\"num\":\"2\"}]'),(147,'t','[]');
/*!40000 ALTER TABLE `hepeop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `locid` varchar(20) NOT NULL,
  `address` varchar(120) NOT NULL,
  `latlng` varchar(100) DEFAULT NULL,
  `timezone` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `locid` (`locid`) USING BTREE,
  KEY `timezone` (`timezone`)
) ENGINE=InnoDB AUTO_INCREMENT=1005 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
INSERT INTO `locations` VALUES (1000,'12ParleyVale','12 Parley Vale, Jamaica Plain, MA 02130','{\"lat\":42.315,\"lng\":-71.111}','America/New_York'),(1001,'255ChestnutAve','255 Chestnut Ave, Jamaica Plain, MA 02130, USA','{\"lat\":42.31381409999999,\"lng\":-71.10874749999999}','America/New_York'),(1002,'794048thAveS','7940 48th Ave S, Seattle, WA 98118, USA','{\"lat\":47.5303635,\"lng\":-122.2724899}','America/Los_Angeles'),(1003,'4505NHaightAve','4505 N Haight Ave, Portland, OR 97217, USA','{\"lat\":45.5555363,\"lng\":-122.6703647}','America/Los_Angeles'),(1004,'10-12ParleyVale','12 Parley Vale, Jamaica Plain, MA 02130','{\"lat\":42.315,\"lng\":-71.111}','America/New_York');
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheds`
--

DROP TABLE IF EXISTS `scheds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scheds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `devid` varchar(30) NOT NULL,
  `senrel` int(2) NOT NULL,
  `dow` int(2) NOT NULL,
  `sched` varchar(200) DEFAULT NULL,
  `until` varchar(16) NOT NULL DEFAULT '0000-00-00 00:00',
  `season` varchar(40) NOT NULL DEFAULT 'current',
  PRIMARY KEY (`id`),
  UNIQUE KEY `main` (`devid`,`senrel`,`dow`) USING BTREE,
  KEY `devid` (`devid`),
  KEY `dow` (`dow`),
  KEY `senrel` (`senrel`),
  KEY `until` (`until`),
  KEY `season` (`season`)
) ENGINE=InnoDB AUTO_INCREMENT=1045 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheds`
--

LOCK TABLES `scheds` WRITE;
/*!40000 ALTER TABLE `scheds` DISABLE KEYS */;
INSERT INTO `scheds` VALUES (1000,'CYURD001',1,4,'[[0,0,55,53],[17,12,78,76],[20,50,55,53],[22,50,64,61]]','0000-00-00 00:00','current'),(1001,'CYURD001',0,4,'[[12,20,77,73]]','0000-00-00 00:00','current'),(1003,'CYURD002',4,0,'[[0,0,0],[9,10,1],[9,40,0],[17,0,1],[17,50,0]]','0000-00-00 00:00','current'),(1004,'CYURD002',4,2,'[[0,0,0],[9,12,1],[9,44,0],[17,5,1],[17,56,0]]','0000-00-00 00:00','current'),(1005,'CYURD002',2,0,'[[0,0,1]]','0000-00-00 00:00','current'),(1007,'CYURD002',3,0,'[[0,0,1]]','0000-00-00 00:00','current'),(1008,'CYURD001',1,5,'[[0,0,77,75]]','0000-00-00 00:00','current'),(1009,'CYURD003',0,0,'[[0,0,55,53],[20,12,78,76],[22,50,56,52],[23,50,64,61]]','0000-00-00 00:00','current'),(1010,'CYURD003',1,0,'[[0,0,55,53],[20,12,78,76],[22,50,56,52],[23,50,64,61]]','0000-00-00 00:00','current'),(1011,'CYURD001',1,0,'[[0,0,55,53],[20,12,78,76],[22,50,55,53],[23,50,64,61]]','0000-00-00 00:00','current'),(1012,'CYURD001',0,0,'[[0,0,65,63],[20,12,78,76],[22,50,55,53],[23,50,64,61]]','0000-00-00 00:00','current'),(1015,'CYURD001',1,2,'[[0,0,57,55],[12,20,77,75]]','0000-00-00 00:00','current'),(1016,'CYURD001',0,8,'[[0,0,52,49]]','2018-03-12 10:15','current'),(1019,'CYURD001',0,5,'[[0,0,55,53],[19,12,78,76],[20,50,55,53],[22,50,64,61]]','0000-00-00 00:00','current'),(1021,'CYURD003',0,8,'[[0,0,51,49]]','2018-03-28 12:09','current'),(1029,'CYURD004',2,0,'[[0,0,1],[7,45,0],[19,0,1]]','0000-00-00 00:00','current'),(1032,'CYURD001',0,1,'[[0,0,55,53],[19,12,78,76],[20,50,55,53],[22,50,64,61]]','0000-00-00 00:00','current'),(1033,'CYURD001',0,3,'[[0,0,55,53],[19,12,78,76],[20,50,55,53],[22,50,64,61]]','0000-00-00 00:00','current'),(1037,'CYURD004',0,0,'[[0,0,81,78]]','0000-00-00 00:00','current'),(1038,'CYURD004',1,0,'[[0,0,54,30]]','0000-00-00 00:00','current'),(1039,'CYURD006',0,0,'[[0,0,72,68]]','0000-00-00 00:00','current'),(1044,'CYURD001',0,2,'[[0,0,55,53],[17,45,79,77],[20,50,55,53],[22,50,64,61]]','0000-00-00 00:00','current');
/*!40000 ALTER TABLE `scheds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_app_loc`
--

DROP TABLE IF EXISTS `user_app_loc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_app_loc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` varchar(60) NOT NULL,
  `appid` varchar(20) DEFAULT NULL,
  `role` varchar(20) DEFAULT NULL,
  `devid` varchar(40) DEFAULT NULL,
  `auth` tinyint(4) DEFAULT NULL,
  `builder` tinyint(1) NOT NULL DEFAULT '1',
  `developer` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `main` (`userid`,`appid`,`devid`,`role`) USING BTREE,
  KEY `devid` (`devid`),
  KEY `userid` (`userid`) USING BTREE,
  KEY `appid` (`appid`) USING BTREE,
  KEY `role` (`role`) USING BTREE,
  KEY `auth` (`auth`)
) ENGINE=InnoDB AUTO_INCREMENT=200 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_app_loc`
--

LOCK TABLES `user_app_loc` WRITE;
/*!40000 ALTER TABLE `user_app_loc` DISABLE KEYS */;
INSERT INTO `user_app_loc` VALUES (27,'mckenna.tim@gmail.com','hvac','user','CYURD003',1,1,1),(55,'tim@sitebuilt.net','hvac','user','CYURD006',1,1,1),(57,'tim@sitebuilt.net','hvac','user','CYURD003',1,1,1),(59,'mckenna.tim@gmail.com','hvac','user','CYURD006',1,1,1),(63,'tim@sitebuilt.net','hvac','admin','CYURD006',1,1,1),(66,'tim@sitebuilt.net','admin','admin','CYURD007',1,1,1),(71,'tim@sitebuilt.net','user','admin','CYURD007',0,1,1),(78,'tim@sitebuilt.net','admin','admin','CYURD027',1,1,1),(79,'tim@sitebuilt.net','user','admin','CYURD027',0,1,1),(80,'tim@sitebuilt.net','hvac','admin','CYURD027',1,1,1),(81,'tim@sitebuilt.net','base','admin','CYURD027',0,1,1),(86,'tim@sitebuilt.net','admin','admin','CYURD028',1,1,1),(87,'tim@sitebuilt.net','user','admin','CYURD028',0,1,1),(88,'tim@sitebuilt.net','hvac','admin','CYURD028',1,1,1),(89,'tim@sitebuilt.net','base','admin','CYURD028',0,1,1),(90,'tim@sitebuilt.net','admin','admin','CYURD029',1,1,1),(91,'tim@sitebuilt.net','user','admin','CYURD029',0,1,1),(92,'tim@sitebuilt.net','hvac','admin','CYURD029',1,1,1),(93,'tim@sitebuilt.net','base','admin','CYURD029',0,1,1),(94,'tim@sitebuilt.net','admin','admin','CYURD003',1,1,1),(95,'tim@sitebuilt.net','base','admin','CYURD003',0,1,1),(96,'tim@sitebuilt.net','shrooms','admin','CYURD003',0,1,1),(98,'tim@sitebuilt.net','lightsoff','admin','CYURD003',1,1,1),(104,'tim@sitebuilt.net','admin','admin','CYURD006',1,1,1),(105,'tim@sitebuilt.net','base','admin','CYURD006',0,1,1),(106,'tim@sitebuilt.net','shrooms','admin','CYURD006',0,1,1),(108,'tim@sitebuilt.net','lightsoff','admin','CYURD006',1,1,1),(115,'tim3@sitebuilt.net','hvac','user','CYURD14I',0,1,1),(116,'tim4@sitebuilt.net','base','user','CYURD003',0,1,1),(118,'tim@sitebuilt.net','lightsoff','admin','CYURD004',1,1,1),(122,'mckenna.tim@gmail.com','admin','super','CYURD14I',1,1,1),(123,'mckenna.tim@gmail.com','admin','admin','CYURD14I',1,1,1),(142,'tim@sitebuilt.net','hvac','admin','CYURD001',1,1,1),(143,'mckenna.tim@gmail.com','pahoRawSB','super','CYURD14I',1,1,1),(144,'mckenna.tim@gmail.com','pahoRawSB','admin','CYURD14I',1,1,1),(145,'mckenna.tim@gmail.com','hvac','super','CYURD14I',1,1,1),(146,'mckenna.tim@gmail.com','hvac','admin','CYURD14I',1,1,1),(155,'mckenna.tim@gmail.com','base','super','CYURD14I',1,1,1),(156,'mckenna.tim@gmail.com','base','admin','CYURD14I',1,1,1),(161,'mckenna.tim@gmail.com','cascada','super','CYURD14I',1,1,1),(162,'mckenna.tim@gmail.com','cascada','admin','CYURD14I',1,1,1),(165,'tim@sitebuilt.net','timr','user','CYURD004',1,1,1),(166,'tim@sitebuilt.net','timr','user','CYURD006',1,1,1),(167,'tim@sitebuilt.net','timr','user','CYURD013',1,1,1),(168,'tim@sitebuilt.net','timr','user','CYURD016',1,1,1),(170,'mckenna.tim@gmail.com','developer','sbs','CYURD',1,1,1),(171,'mckenna.tim@gmail.com','timr','super','CYURD14I',1,1,1),(172,'mckenna.tim@gmail.com','timr','admin','CYURD14I',1,1,1),(194,'mckenna.tim@gmail.com','builder','sbs','CYURD',1,1,1),(195,'mckenna.tim@gmail.com','installer','sbs','CYURD',NULL,1,1),(196,'tim@sitebuilt.net','builder','sbs','CYURD',1,1,1),(197,'tim2@sitebuilt.net','cascada','admin','CYURD14I',1,1,1),(198,'clipperjohn@gmail.com','cascada','admin','CYURD14I',1,1,1),(199,'clippingersue@gmail.com','cascada','admin','CYURD14I',1,1,1);
/*!40000 ALTER TABLE `user_app_loc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` varchar(80) NOT NULL,
  `name` varchar(60) DEFAULT NULL,
  `address` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-10-11 12:41:48
