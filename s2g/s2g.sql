-- MySQL dump 10.13  Distrib 5.7.27, for Linux (x86_64)
--
-- Host: sitebuilt.net    Database: s2g
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
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lid` varchar(20) NOT NULL,
  `product` varchar(200) NOT NULL,
  `done` int(1) DEFAULT '0',
  `jsod` varchar(400) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `lidprod` (`lid`,`product`),
  KEY `lid` (`lid`),
  KEY `done` (`done`),
  KEY `liddone` (`lid`,`done`)
) ENGINE=InnoDB AUTO_INCREMENT=754 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES (100,'Minohu','Steel wool',1,'{}'),(101,'Minohu','smoke detector Worry Free 10-Year Sealed',1,'{\"tags\":[\"1001632542 08 003\"]}'),(102,'Minohu','Mouse traps',1,'{}'),(103,'Minohu','Light bulbs',1,'{}'),(104,'Minohu','Light screw',1,'{}'),(105,'Minohu','strike',1,'{\"tags\":[\"09 20 1000054053\"]}'),(106,'Minohu','FireX Hardwire Smoke and Carbon Monoxide',1,'{\"tags\":[\"1001824517 08 003\"]}'),(107,'Minohu','Black Plasti Dip',1,'{\"tags\":[\"Aisle 07\",\"Bay 018\"]}'),(108,'Minohu','1/4 in. x 1-3/4 in. White Ultrashield Hex-Washer-Head Concrete Anchors (8-Pack)',1,'{\"tags\":[\"aisle 13 bay015\"]}'),(109,'Minohu','5/16 in. x 1-7/8 in. Steel Magnetic Nut Driver',1,'{\"tags\":[\"bay 12 aisle 5\"]}'),(110,'Minohu','3/16 in. x 7 in. SDS Carbide Drill Bit',1,'{}'),(111,'Minohu','5/16 in. x 2-1/4 in. Hex-Washer-Head Large Diameter Concrete Anchors (4-Pack)',1,'{}'),(112,'Minohu','(18) Steel Rebar (Common: 0.375-in; Actual: 0.375-in)',1,'{\"amt\":{\"qty\":\"\",\"unit\":\"2ft\"},\"tags\":[\"# 17199 lowes LW 17\"]}'),(113,'Minohu','Quikrete 8.6 oz. High Strength Anchoring Epoxy',1,'{\"amt\":{\"qty\":\"\",\"unit\":\"\"},\"tags\":[\"201253 hd 16 002\"]}'),(114,'Minohu','ANVIL Wire Twister',1,'{\"tags\":[\"#1002277329 hd 16  001\"]}'),(115,'Minohu','(3) 2x4',1,'{\"amt\":{\"qty\":\"\",\"unit\":\"8\"},\"tags\":[\"lowes aisle 18 bay 9\"]}'),(116,'Minohu','(4)Sakrete 5000 Plus 80-lb High Strength Concrete Mix',1,'{\"amt\":{\"qty\":\"\",\"unit\":\"\"},\"tags\":[\"lowes aisle 19 bay 8\"]}'),(117,'Minohu','LYSOL 4-Pack Nylon Straw Brushes',1,'{\"tags\":[\"# 751578  Lowes Aisle 4\",\"Bay 13\"]}'),(118,'Minohu','67/100 ft. 16-Gauge Rebar Tie Wire (100-Piece/Bag)',1,'{\"tags\":[\"hd 16 011\"]}'),(119,'Minohu','glue sticks',1,'{}'),(120,'Minohu','groved cutter',1,'{\"tags\":[\"Aisle 10\",\"Bay 018 150916\"]}'),(121,'Minohu','Nylon spacers',1,'{}'),(122,'Minohu','cedar 1x 3',1,'{\"tags\":[\"Aisle 22\",\"Bay 008 411729\"]}'),(123,'Minohu','5/16 in.-18 x 4 in. Stainless Hanger Bolt',1,'{\"tags\":[\"Aisle 15\",\"Bay 020\"]}'),(124,'Minohu','Flush 1/4',1,'{}'),(125,'Minohu','Burr tool countersink',1,'{}'),(126,'Minohu','corrugated plastic sheet',1,'{\"tags\":[\"1000118572 Aisle 45\",\"Bay 016\"]}'),(127,'Minohu','Smoke detectors',1,'{\"tags\":[\"aisle8bay3hd\"]}'),(128,'Minohu','Keeney Brass 3/8-in Compression Quarter Turn Straight Valve',1,'{\"tags\":[\"Aisle 15 bay 8\"]}'),(129,'Minohu','1/2\" self drilling screws',1,'{\"tags\":[\"156417 Aisle 13\",\"Bay 015\"]}'),(130,'Minohu','3/4\" self drilling screw',1,'{}'),(131,'Minohu','Dw 339284801',1,'{}'),(132,'Minohu','Fans',1,'{}'),(133,'Minohu','Bath fixture',1,'{}'),(134,'Minohu','3/8 copper',1,'{}'),(135,'Minohu','Bonding latex',1,'{\"tags\":[\"aisle 16 bay 2 hd\"]}'),(136,'Minohu','Stair ladder',1,'{}'),(137,'Minohu','oak flooring',1,'{}'),(138,'Minohu','Base',1,'{\"tags\":[\"Aisle 22\",\"Bay 009\"]}'),(139,'Minohu','threshold',1,'{\"tags\":[\"Aisle 46\",\"Bay 010\"]}'),(140,'Minohu','2x6',1,'{}'),(141,'Minohu','unikal',1,'{\"tags\":[\"Aisle 17\",\"Bay 013\"]}'),(142,'Minohu','durabond 90',1,'{\"tags\":[\"Aisle 17\",\"Bay 011\"]}'),(143,'Minohu','drain cleaner',1,'{}'),(144,'Minohu','Recycle bins small',1,'{}'),(145,'Minohu','Flashlight bulb',1,'{}'),(146,'Minohu','Black mesh fabric',1,'{\"tags\":[\"Outside Garden\",\"Bay 018\"]}'),(147,'Minohu','Deck screws',1,'{\"tags\":[\"Aisle 13\",\"Bay 008\"]}'),(148,'Minohu','Bleach',1,'{}'),(149,'Minohu','Tile bleach cleaner',1,'{}'),(150,'Minohu','Rubber matts',1,'{}'),(151,'Minohu','Wellworth Trip Lever in Polished Chrome',1,'{\"tags\":[\"411052 Aisle 38\",\"Bay 001\"]}'),(152,'Minohu','sandpaper',1,'{}'),(153,'Minohu','Silicone caulk',1,'{}'),(154,'Minohu','Grout tools',1,'{\"tags\":[\"Aisle 23\",\"Bay 019\"]}'),(155,'Minohu','Silicone sealer',1,'{}'),(156,'Minohu','6x2 white',1,'{}'),(157,'Minohu','Sponge',1,'{}'),(158,'Minohu','Scrapers',1,'{}'),(159,'Minohu','Block plane',1,'{}'),(160,'Minohu','Backer rod',1,'{}'),(161,'Minohu','Green pad',1,'{}'),(162,'Minohu','1 1/2 tail w y',1,'{}'),(163,'Minohu','1/2 male adapter',1,'{}'),(164,'Minohu','26 balance 22 balance',1,'{}'),(165,'Minohu','3 way dimmers',1,'{}'),(166,'Minohu','3/4 close nipple',1,'{}'),(167,'Minohu','3/4 plastic ma',1,'{}'),(168,'Minohu','3/8 supply dw adapter',1,'{}'),(169,'Minohu','38tand shutoff',1,'{}'),(170,'Minohu','4-1/2 5 x1',1,'{}'),(171,'Minohu','aerator',1,'{}'),(172,'Minohu','Brass faucet cap',1,'{}'),(173,'Minohu','brass screw',1,'{}'),(174,'Minohu','Breaker',1,'{}'),(175,'Minohu','Cat 5',1,'{}'),(176,'Minohu','Countertop 120 in. Marbella in Breccia Nouvelle',1,'{\"tags\":[\"Store SKU # 634678\"]}'),(177,'Minohu','Countertop 72 in. Marbella in Breccia Nouvelle',1,'{\"amt\":{\"qty\":\"\",\"unit\":\"in\"},\"tags\":[\"22&35 Hampton Bay Model # 494852M6 Internet # 203243111 Store SKU # 634355\"]}'),(178,'Minohu','countertop endcaps',1,'{\"amt\":{\"qty\":\"\",\"unit\":\"\"},\"tags\":[\"HD Breccia Nouvelle Model # 494852MECK Internet # 203243125 Store SKU # 631456\"]}'),(179,'Minohu','Degreaset',1,'{}'),(180,'Minohu','door knob',1,'{}'),(181,'Minohu','drain pvc for kitchen, lav and basement',1,'{}'),(182,'Minohu','drawer pull',1,'{}'),(183,'Minohu','Dw tail piece',1,'{}'),(184,'Minohu','electrical plates',1,'{\"tags\":[\"1dd\",\"1sd\",\"3ds\",\"19o\"]}'),(185,'Minohu','exterior led light',1,'{}'),(186,'Minohu','faucet restrict',1,'{}'),(187,'Minohu','finish screws',1,'{}'),(188,'Minohu','fix path light bases',1,'{}'),(189,'Minohu','glass 27x26',1,'{}'),(190,'Minohu','glass for light 3-3/16',1,'{}'),(191,'Minohu','grout sealer',1,'{}'),(192,'Minohu','handle puller',1,'{}'),(193,'Minohu','ice machine cap',1,'{}'),(194,'Minohu','ice maker',1,'{}'),(195,'Minohu','light fixture parts',1,'{}'),(196,'Minohu','Lock',1,'{}'),(198,'Minohu','roof stairs 25x53.5x8\'4.5',1,'{}'),(199,'Minohu','scotch bonnet',1,'{}'),(200,'Minohu','screen door',1,'{}'),(201,'Minohu','shelf 34_5/8 33_3/4',1,'{}'),(202,'Minohu','shelf liner',1,'{\"tags\":[\"Loews Duck Covers 10-ft x 24-in Black Shelf Liner Item #: 47550 |  Model #: 1297467\"]}'),(203,'Minohu','shower head',1,'{}'),(205,'Minohu','shower rods',1,'{\"amt\":{\"qty\":\"\",\"unit\":\"\"}}'),(206,'Minohu','sibk xlips',1,'{}'),(207,'Minohu','sink supports',1,'{}'),(208,'Minohu','smoke/co detector',1,'{\"tags\":[\"$48@homedeopot FireX Model # KN COSM IBA Internet # 205465828 Store SKU # 1000535870\"]}'),(209,'Minohu','Style Selections Euro Vanity White Belly Bowl Single Sink Bathroom Vanity with Vitreous China Top (Common: 24-in x 17-in',1,'{\"tags\":[\"Lowes Item #: 297598 |  Model #: 41660\"]}'),(210,'Minohu','supplies kitchen bath toilet',1,'{}'),(211,'Minohu','symmons parts',1,'{}'),(212,'Minohu','Tail piece',1,'{}'),(213,'Minohu','tan grout',1,'{}'),(214,'Minohu','tile',1,'{}'),(215,'Minohu','toilet float',1,'{\"tags\":[\"507484 Aisle 38\",\"Bay 001\"]}'),(216,'Minohu','toilet KOHLER Wellworth White',1,'{\"tags\":[\"16\\\"L5o $149 item #: 331676 |  Model #: 11464-0\"]}'),(217,'Minohu','toilet seat',1,'{}'),(218,'Minohu','Toilet valve',1,'{}'),(219,'Minohu','Trap',1,'{}'),(220,'Minohu','triangle scraper',1,'{}'),(221,'Minohu','vinyl coated steel cable',1,'{}'),(222,'Minohu','Wire connectors',1,'{}'),(223,'Minohu','Clamp lights and bulbs',1,'{}'),(224,'Minohu','Faucet outside',1,'{}'),(225,'Minohu','Washers for kitchen sink',1,'{}'),(226,'Minohu','Sink basket strainer>5/8',1,'{}'),(227,'Minohu','Solder',1,'{}'),(228,'Minohu','Flux',1,'{}'),(229,'Minohu','Ball valves',1,'{}'),(230,'Minohu','24\" 1/2x3/8 2',1,'{}'),(231,'Minohu','3/8fcx1/4 m',1,'{}'),(232,'Minohu','16 flex',1,'{}'),(233,'Minohu','2x6pt 10\'',1,'{}'),(234,'Minohu','1x8 2/10',1,'{}'),(235,'Minohu','Primer',1,'{}'),(236,'Minohu','Blue paint',1,'{}'),(237,'Minohu','Tub drain2',1,'{}'),(238,'Minohu','Blank playe',1,'{}'),(239,'Minohu','Knob screwa',1,'{}'),(240,'Minohu','Caulking gun',1,'{}'),(241,'Minohu','Kitchen basket strainer 2 slooted',1,'{}'),(242,'Minohu','Kitchen sprayer',1,'{}'),(243,'Kiyidu','circuit tester',0,'{}'),(244,'Kiyidu','Drill',1,'{}'),(245,'Kiyidu','check dw length',1,'{}'),(246,'Kiyidu','check dw electric',1,'{}'),(247,'Kiyidu','air hose',1,'{}'),(248,'Kiyidu','What type breaker',1,'{}'),(249,'Kiyidu','How much 14/2',1,'{}'),(250,'Kiyidu','Iron',1,'{}'),(251,'Kiyidu','Wax',1,'{}'),(252,'Kiyidu','1/2Fx1/2F flex gas connector 36\"',1,'{}'),(253,'Kiyidu','3/8x1/2 B I reducer couoling',1,'{}'),(254,'Kiyidu','1/2 close nipple BI',1,'{}'),(255,'Kiyidu','3\"aluminum tape',1,'{}'),(256,'Kiyidu','framing nailer',1,'{}'),(257,'Kiyidu','finish nailer',1,'{}'),(258,'Kiyidu','battery tools',1,'{}'),(259,'Kiyidu','yellow pine',1,'{}'),(260,'Kiyidu','tape measure',1,'{}'),(261,'Kiyidu','sanding supplies',1,'{}'),(262,'Kiyidu','bath paint',1,'{}'),(263,'Kiyidu','sharp tools',1,'{}'),(264,'Kiyidu','roof stuff',1,'{}'),(265,'Kiyidu','rags',1,'{}'),(266,'Kiyidu','pine',1,'{}'),(267,'Kiyidu','hand truck',1,'{}'),(268,'Kiyidu','formica',1,'{}'),(269,'Kiyidu','dremel',1,'{}'),(270,'Kiyidu','clamp',1,'{}'),(271,'Kiyidu','apt 5 key',1,'{}'),(272,'Kiyidu','1/2 I T',1,'{}'),(273,'Kiyidu','1/2 plug',1,'{}'),(274,'Gabuge','Z flashing',0,'{}'),(275,'Gabuge','1x8 16',0,'{}'),(276,'Gabuge','1x6 10',0,'{}'),(277,'Gabuge','1x4 10',0,'{}'),(278,'Gabuge','5/4x4 6',0,'{}'),(279,'Gabuge','Clapboard 6',0,'{}'),(280,'Gabuge','8d box galv',0,'{}'),(281,'Gabuge','flat bar',0,'{}'),(282,'Gabuge','glue',0,'{}'),(283,'Gabuge','skill saw',0,'{}'),(284,'Gabuge','extension rollers',0,'{}'),(285,'Gabuge','1/2sheetrock',1,'{}'),(286,'Gabuge','1x8',1,'{\"amt\":{\"qty\":\"\",\"unit\":\"12\"}}'),(287,'Gabuge','corner bead',1,'{}'),(288,'Gabuge','mesh tape',1,'{}'),(289,'Gabuge','nail set',1,'{}'),(290,'Gabuge','spindle',1,'{}'),(291,'Gabuge','door frame',1,'{}'),(292,'Gabuge','door knob',1,'{}'),(293,'Gabuge','1/4 acx',1,'{}'),(294,'Gabuge','1x4 1/12,8',1,'{}'),(295,'Gabuge','2x4',1,'{\"amt\":{\"qty\":\"\",\"unit\":\"8\"}}'),(296,'Gabuge','3/4 acx',1,'{}'),(297,'Gabuge','door trim',1,'{}'),(298,'Gabuge','plaster 45 minute',1,'{}'),(299,'Gabuge','hinges',1,'{}'),(300,'Gabuge','1/4 \"bit',1,'{}'),(301,'Bozoxi','Ed angle under the wall',1,'{}'),(302,'Bozoxi','Drill holes in base',1,'{}'),(303,'Bozoxi','Mill lower horizontal',1,'{}'),(304,'Bozoxi','Mill and attached upper horizontal',1,'{}'),(305,'Bozoxi','Mill and attached clapboard vertical',1,'{}'),(306,'Bozoxi','Glue on foam',0,'{}'),(307,'Bozoxi','Make permanent leg',1,'{}'),(308,'Bozoxi','Make temporary leg',1,'{}'),(309,'Bozoxi','Drill for light hangers',0,'{}'),(310,'Bozoxi','Drill through whole right side base',1,'{}'),(311,'Bozoxi','modify light',1,'{}'),(312,'Bozoxi','hoisin sauce',1,'{}'),(313,'Bozoxi','baking soda',1,'{}'),(314,'Bozoxi','Corn starch',1,'{}'),(315,'Bozoxi','chicken breast',1,'{}'),(316,'Bozoxi','dw detergent',1,'{}'),(317,'Bozoxi','cheese',1,'{}'),(318,'Bozoxi','bread',1,'{}'),(319,'Bozoxi','knife sharpener',1,'{}'),(320,'Bozoxi','squash',1,'{}'),(321,'Bozoxi','cream cheese',1,'{}'),(322,'Bozoxi','salad dressing',1,'{}'),(323,'Bozoxi','fix porch upper lower',1,'{}'),(324,'Bozoxi','investigate windows',1,'{}'),(325,'Bozoxi','fix rear porch',1,'{}'),(326,'Bozoxi','remove greenhouse',1,'{}'),(327,'Bozoxi','fix upper porch',1,'{}'),(328,'Bozoxi','duplicate pi',1,'{}'),(329,'Bozoxi','go scothb lowesdepot',1,'{}'),(330,'Bozoxi','build structures',1,'{}'),(331,'Bozoxi','fix lights',1,'{}'),(332,'Bozoxi','setup porch wiring',1,'{}'),(333,'Bozoxi','repoint chimney',1,'{}'),(334,'Bozoxi','clean gutters',1,'{}'),(335,'Bozoxi','add mesh to gutters',1,'{}'),(336,'Qoqida','9v batteries',0,'{}'),(337,'Qoqida','Round screws',1,'{}'),(338,'Qoqida','Chair bottoms',1,'{}'),(339,'Qoqida','Po hat',1,'{}'),(340,'Qoqida','corkscrew',1,'{}'),(341,'Qoqida','Durabond90',1,'{}'),(342,'Qoqida','Plaster buttons',1,'{}'),(343,'Qoqida','Plastic bags',1,'{}'),(344,'Qoqida','Kilz',1,'{}'),(345,'Qoqida','Wire',1,'{}'),(346,'Qoqida','Connectors',1,'{}'),(347,'Qoqida','Yellow wire nuts',1,'{}'),(348,'Qoqida','Flex gas 3/4 x 1/2',1,'{}'),(349,'Qoqida','Cherry stain',1,'{}'),(350,'Qoqida','Oak filler',1,'{}'),(351,'Qoqida','Grout',1,'{}'),(352,'Qoqida','Tile',1,'{}'),(353,'Qoqida','Adhesove',1,'{}'),(354,'Qoqida','Gray owl paint',1,'{}'),(355,'Qoqida','3.5 hinges',1,'{}'),(356,'Qoqida','Closet pole',1,'{}'),(357,'Qoqida','Stain',1,'{}'),(358,'Qoqida','Shellac',1,'{}'),(359,'Qoqida','1 gal bucket',1,'{}'),(360,'Qoqida','Double coax plate',1,'{}'),(361,'Qoqida','Rubber cement',1,'{}'),(362,'Qoqida','2in aluminum',1,'{}'),(363,'Qoqida','One and a half inch bolts',1,'{}'),(364,'Qoqida','4 in hanger bolts',1,'{}'),(365,'Qoqida','Three-quarter inch angle',1,'{\"loc\":\"cereal\",\"amt\":{\"qty\":\"\",\"unit\":\"Ft\"}}'),(366,'Qoqida','A file',1,'{}'),(367,'Qoqida','Zucchini seeds',1,'{}'),(368,'Qoqida','Plug',0,'{}'),(369,'Qoqida','Double pulley',0,'{}'),(370,'Qoqida','Blue cover',1,'{}'),(371,'Qoqida','Bolt',0,'{}'),(372,'Jutebi','Cream cheese, whipped nonorganic what milk',1,'{}'),(373,'Jutebi','DF cream cheese',1,'{}'),(374,'Jutebi','Stock',1,'{}'),(375,'Jutebi','peper flakes',1,'{}'),(376,'Jutebi','anchovies',1,'{}'),(377,'Jutebi','Chives',1,'{}'),(378,'Jutebi','sweet potatoes',1,'{}'),(379,'Jutebi','oat crackers',1,'{}'),(380,'Jutebi','Fresh ginger',1,'{\"loc\":\"produce\",\"amt\":{\"qty\":\"\",\"unit\":\"pc\"}}'),(381,'Jutebi','Rice noodles',1,'{}'),(382,'Jutebi','cottage cheese 4%',1,'{\"loc\":\"dairy\"}'),(383,'Jutebi','Apples',1,'{}'),(384,'Jutebi','white flour',1,'{\"loc\":\"bake-cook\",\"amt\":{\"qty\":\"\",\"unit\":\"lb\"},\"tags\":[\"King Arthur\"]}'),(385,'Jutebi','Eggs',1,'{}'),(386,'Jutebi','Oregano',1,'{}'),(387,'Jutebi','Parsley',1,'{}'),(388,'Jutebi','Red pepper',1,'{}'),(389,'Jutebi','Oregano big',1,'{}'),(390,'Jutebi','Ginger. Pickled',1,'{\"amt\":{\"qty\":\"\",\"unit\":\"\"}}'),(391,'Jutebi','Mung bean sprouts',1,'{}'),(392,'Jutebi','Wasabi',1,'{}'),(393,'Jutebi','Trail mix',1,'{}'),(394,'Jutebi','Bread',1,'{}'),(395,'Jutebi','Rice',1,'{}'),(396,'Jutebi','oj',1,'{}'),(397,'Jutebi','Butter',1,'{}'),(398,'Jutebi','Toilet paper',1,'{\"loc\":\"paper/plastic\"}'),(399,'Jutebi','Brocolli',1,'{}'),(400,'Jutebi','Cheerios',1,'{}'),(401,'Jutebi','DFYogurt',1,'{}'),(402,'Jutebi','Organic carrots',1,'{}'),(403,'Jutebi','Peanut buttet',1,'{}'),(404,'Jutebi','Sponges',1,'{}'),(405,'Jutebi','DF kefir',1,'{}'),(406,'Jutebi','Orange marmalade',1,'{}'),(407,'Jutebi','Humus',1,'{}'),(408,'Jutebi','bananas',1,'{}'),(409,'Jutebi','Pretzels',1,'{}'),(410,'Jutebi','FAGE yogurt',1,'{}'),(411,'Jutebi','Thin Stackers quinoa',1,'{}'),(412,'Jutebi','Soy sauce',1,'{}'),(413,'Jutebi','Lemons',1,'{\"loc\":\"produce\"}'),(414,'Jutebi','onions',1,'{}'),(415,'Jutebi','baking soda',1,'{\"loc\":\"bake-cook\"}'),(416,'Jutebi','capers',1,'{}'),(417,'Jutebi','ground beef',1,'{}'),(418,'Jutebi','Ivory dish soap',1,'{\"loc\":\"cleaning\"}'),(419,'Jutebi','Limes',1,'{\"amt\":{\"qty\":\"\",\"unit\":\"\"}}'),(420,'Jutebi','Paper towels',1,'{}'),(421,'Jutebi','sour cream (not lofat) big',1,'{}'),(422,'Jutebi','oranges',1,'{}'),(423,'Jutebi','pears',1,'{}'),(424,'Jutebi','Cream of wheat',1,'{}'),(425,'Jutebi','cream cheese',1,'{}'),(426,'Jutebi','Coffee',1,'{\"tags\":[\"(big bags)\"]}'),(427,'Jutebi','Olive oil',1,'{}'),(428,'Jutebi','Red wine vinegar',1,'{}'),(429,'Jutebi','Crackers',1,'{}'),(430,'Jutebi','Shallots',1,'{}'),(431,'Jutebi','Kitty litter',1,'{}'),(432,'Jutebi','Peanuts',1,'{}'),(434,'Jutebi','Potatoes',1,'{}'),(435,'Jutebi','Almond milk, unsweetened',1,'{}'),(436,'Jutebi','Mussels and french bread or supper??',1,'{}'),(437,'Jutebi','Flowers',1,'{}'),(438,'Jutebi','Almonds',1,'{}'),(439,'Jutebi','Goat cheese',1,'{}'),(440,'Jutebi','Jarlsburg Swiss cheese',1,'{}'),(441,'Jutebi','Carrots',1,'{}'),(442,'Jutebi','Cherry tomatoes',1,'{}'),(443,'Jutebi','Pecans',1,'{}'),(444,'Jutebi','Kale',1,'{\"loc\":\"produce\"}'),(445,'Jutebi','Milk another qt',1,'{}'),(446,'Jutebi','Tomato heirloom',1,'{\"loc\":\"produce\",\"tags\":[\"for me bagels\"]}'),(447,'Jutebi','WM Brown cow yogurt',1,'{}'),(448,'Jutebi','Avacado',1,'{\"loc\":\"produce\"}'),(449,'Jutebi','Blueberries',1,'{}'),(450,'Jutebi','Salsa',1,'{}'),(451,'Jutebi','vitamin c powder packages',1,'{}'),(452,'Jutebi','Celery',1,'{\"loc\":\"produce\"}'),(453,'Jutebi','Soap',1,'{}'),(454,'Jutebi','Wax paper',1,'{}'),(455,'Jutebi','Bon Ami cleanser',1,'{}'),(456,'Jutebi','Pepper corns',1,'{}'),(457,'Jutebi','Bagette',1,'{}'),(458,'Jutebi','Raisins',1,'{}'),(459,'Jutebi','3 evaporated milk',1,'{}'),(460,'Jutebi','4 onion',1,'{}'),(461,'Jutebi','Adobo',1,'{}'),(462,'Jutebi','Almond butter',1,'{}'),(464,'Jutebi','Almond paste',1,'{}'),(465,'Jutebi','almonds raw',1,'{}'),(466,'Jutebi','Apple cider',1,'{}'),(467,'Jutebi','Apple cider vinegar',1,'{\"loc\":\"bake-cook\",\"tags\":[\"mad from dogs\"]}'),(468,'Jutebi','apple sauce',1,'{}'),(470,'Jutebi','Applesauce',1,'{}'),(471,'Jutebi','Arrowroot',1,'{}'),(472,'Jutebi','Baby detergent',1,'{}'),(473,'Jutebi','Bacon',1,'{\"loc\":\"meats\"}'),(474,'Jutebi','Bags',1,'{}'),(475,'Jutebi','baguette',1,'{\"loc\":\"bread\"}'),(476,'Jutebi','baked beans',1,'{\"loc\":\"canned\"}'),(477,'Jutebi','Balsamic vinegar',1,'{}'),(479,'Jutebi','barbecue sauce',1,'{\"loc\":\"flavoring\"}'),(480,'Jutebi','Basil',1,'{}'),(481,'Jutebi','Beautiful curls conditioner',1,'{}'),(482,'Jutebi','beer',1,'{}'),(483,'Jutebi','Berrys',1,'{}'),(484,'Jutebi','black beans',1,'{\"loc\":\"canned\"}'),(485,'Jutebi','Black Tea',1,'{}'),(486,'Jutebi','Bleach',1,'{}'),(488,'Jutebi','Boillon',1,'{}'),(489,'Jutebi','Bok choi',1,'{}'),(490,'Jutebi','Bonito',1,'{}'),(491,'Jutebi','Brewers Yeast',1,'{}'),(492,'Jutebi','Brisket',1,'{}'),(493,'Jutebi','Brown cowPLAIN  Yogurt whole milk cream on top',1,'{}'),(494,'Jutebi','Brown rice',1,'{}'),(495,'Jutebi','Brown rice flour',1,'{}'),(496,'Jutebi','Brown sugar',1,'{}'),(497,'Jutebi','brussels sprouts',1,'{\"loc\":\"produce\"}'),(498,'Jutebi','Buckwheat  noodles',1,'{}'),(499,'Jutebi','Buckwheat flour',1,'{}'),(500,'Jutebi','Buckwheat groats',1,'{}'),(502,'Jutebi','butternut squash',1,'{\"loc\":\"produce\"}'),(503,'Jutebi','Candied ginger',1,'{}'),(504,'Jutebi','Canned tomatoes',1,'{}'),(505,'Jutebi','canned whole tomatoes',1,'{\"loc\":\"canned\"}'),(506,'Jutebi','Canola oil',1,'{\"loc\":\"bake-cook\"}'),(507,'Jutebi','Cashews',1,'{}'),(508,'Jutebi','Cayenne powder',1,'{}'),(510,'Jutebi','Cheddar',1,'{}'),(511,'Jutebi','Cheese sticks',1,'{}'),(512,'Jutebi','Chia seeds, 1/2 cup',1,'{}'),(513,'Jutebi','Chicken',1,'{\"loc\":\"meats\"}'),(514,'Jutebi','Chicken broth',1,'{}'),(515,'Jutebi','Chicken thighs',1,'{}'),(516,'Jutebi','Chiles DE arbol',1,'{}'),(517,'Jutebi','Chipotle caned chiles',1,'{}'),(519,'Jutebi','Chocalte',1,'{}'),(520,'Jutebi','chocolate, dark 070% bits',1,'{}'),(521,'Jutebi','Choriso',1,'{}'),(522,'Jutebi','cider',1,'{\"loc\":\"produce\"}'),(523,'Jutebi','cilantro',1,'{\"loc\":\"produce\"}'),(524,'Jutebi','clementines',1,'{\"loc\":\"produce\"}'),(525,'Jutebi','Coconut',1,'{}'),(526,'Jutebi','Coconut milk',1,'{}'),(527,'Jutebi','Cold cuts',1,'{}'),(528,'Jutebi','condensed milk',1,'{\"loc\":\"canned\"}'),(529,'Jutebi','Confectioner\'s sugar',1,'{}'),(530,'Jutebi','Corn meal',1,'{}'),(531,'Jutebi','Cornstarch',1,'{}'),(532,'Jutebi','Corona',1,'{}'),(533,'Jutebi','Cranberries',1,'{}'),(534,'Jutebi','cream',1,'{\"loc\":\"dairy\"}'),(536,'Jutebi','Cucumber',1,'{}'),(537,'Jutebi','daikon',1,'{}'),(538,'Jutebi','DF butter',1,'{}'),(539,'Jutebi','DF sour cream',1,'{}'),(540,'Jutebi','Dill',1,'{}'),(541,'Jutebi','Dishwasher detergent',1,'{}'),(542,'Jutebi','Dog rawhide',1,'{}'),(543,'Jutebi','Dried fruit',1,'{}'),(544,'Jutebi','Earth balance, soy free',1,'{}'),(545,'Jutebi','Earth Science Clarifying Wash',1,'{}'),(546,'Jutebi','Earth science toner',1,'{}'),(547,'Jutebi','Eccinachea and golden seal',1,'{}'),(548,'Jutebi','Elbow macaroni',1,'{}'),(549,'Jutebi','english muffins',1,'{\"amt\":{\"qty\":\"\",\"unit\":\"\"}}'),(550,'Jutebi','Farmers chees',1,'{}'),(551,'Jutebi','Feta',1,'{}'),(552,'Jutebi','Fish sauce',1,'{}'),(553,'Jutebi','Fish, 4lb',1,'{}'),(554,'Jutebi','frogs',1,'{}'),(555,'Jutebi','frozen fruit',1,'{}'),(556,'Jutebi','Frozen peas',1,'{}'),(557,'Jutebi','fruit',1,'{}'),(558,'Jutebi','Fruit jam, unsweetened',1,'{}'),(559,'Jutebi','Fun food',1,'{\"tags\":[\"Whatever strikes ur fancy\"]}'),(560,'Jutebi','Galangal',1,'{}'),(561,'Jutebi','Gallon of vinegar',1,'{}'),(562,'Jutebi','Garbanzo bean flour',1,'{}'),(563,'Jutebi','Gelatin',1,'{}'),(564,'Jutebi','Genmaicha (Brown Rice Green Tea)',1,'{}'),(565,'Jutebi','GF bagels',1,'{}'),(566,'Jutebi','GF bread Canyon Ranch white or rye',1,'{}'),(567,'Jutebi','GF granola',1,'{}'),(568,'Jutebi','GF pasta',1,'{}'),(569,'Jutebi','GF Pretzels',1,'{}'),(570,'Jutebi','ginger',1,'{\"loc\":\"produce\"}'),(571,'Jutebi','Ginger ale',1,'{}'),(572,'Jutebi','Gochujang',1,'{}'),(574,'Jutebi','Granola',1,'{}'),(575,'Jutebi','Grapefruit',1,'{\"loc\":\"produce\"}'),(576,'Jutebi','Grapes',1,'{}'),(577,'Jutebi','Ground cardMon',1,'{}'),(578,'Jutebi','ham',1,'{}'),(579,'Jutebi','ham (thick)',1,'{\"loc\":\"deli\",\"amt\":{\"qty\":\"\",\"unit\":\"lb\"},\"tags\":[\"thick(for eggs bennadict)\"]}'),(580,'Jutebi','Heavy cream',1,'{\"loc\":\"dairy\",\"amt\":{\"qty\":\"\",\"unit\":\"Pints\"}}'),(581,'Jutebi','Hellmans',1,'{}'),(582,'Jutebi','Honey',1,'{}'),(583,'Jutebi','Huggins Lil Movers sz3',1,'{}'),(584,'Jutebi','Ice',1,'{}'),(585,'Jutebi','Ice cream',1,'{}'),(586,'Jutebi','italian bread',1,'{}'),(587,'Jutebi','italian/french bread',1,'{}'),(588,'Jutebi','Kalamata pitted olives',1,'{\"loc\":\"deli\",\"amt\":{\"qty\":\"\",\"unit\":\"pints\"},\"tags\":[]}'),(589,'Jutebi','Kasha',1,'{}'),(590,'Jutebi','Kelp',1,'{}'),(591,'Jutebi','Ketchup',1,'{}'),(592,'Jutebi','Kim chee',1,'{}'),(593,'Jutebi','Kitchen bouquet',1,'{}'),(594,'Jutebi','Kitchen garbage bags',1,'{}'),(595,'Jutebi','Lamb chops',1,'{}'),(596,'Jutebi','Lamb shank',1,'{}'),(597,'Jutebi','Laundry derergent',1,'{}'),(598,'Jutebi','Lentils',1,'{}'),(599,'Jutebi','Lettuce',1,'{}'),(600,'Jutebi','LF yogurt',1,'{}'),(601,'Jutebi','Lime zest',1,'{}'),(602,'Jutebi','mango',1,'{\"loc\":\"produce\"}'),(603,'Jutebi','Marjoram',1,'{}'),(604,'Jutebi','Mayonaise',1,'{}'),(605,'Jutebi','Melatonin',1,'{}'),(606,'Jutebi','Milk',1,'{}'),(607,'Jutebi','Millet flour',1,'{}'),(608,'Jutebi','mint',1,'{\"loc\":\"produce\"}'),(609,'Jutebi','Mint sauce',1,'{}'),(610,'Jutebi','Miso',1,'{}'),(611,'Jutebi','molasses',1,'{\"loc\":\"bake-cook\"}'),(612,'Jutebi','Mozzerella',1,'{}'),(613,'Jutebi','Multigrain bread',1,'{}'),(614,'Jutebi','mussels',1,'{}'),(615,'Jutebi','mustard',1,'{\"loc\":\"flavoring\"}'),(616,'Jutebi','Mustard,powdered',1,'{}'),(617,'Jutebi','Nattokinase',1,'{}'),(618,'Jutebi','Nature\'s balance, soy free',1,'{}'),(619,'Jutebi','Nori',1,'{}'),(621,'Jutebi','Olives',1,'{}'),(622,'Jutebi','olives and pimentos pitted',1,'{\"loc\":\"canned\",\"tags\":[\"goya\"]}'),(623,'Jutebi','Onion',1,'{\"loc\":\"produce\"}'),(624,'Jutebi','Orange zest',1,'{}'),(625,'Jutebi','Oranges, organic',1,'{}'),(626,'Jutebi','Oyster sauce',1,'{}'),(627,'Jutebi','palmolive eco dishawasher detergnet',1,'{\"tags\":[\"not that green shit\"]}'),(628,'Jutebi','Paper plates',1,'{}'),(629,'Jutebi','Parmesan',1,'{}'),(630,'Jutebi','Parsnip',1,'{}'),(631,'Jutebi','Peanut oil',1,'{\"loc\":\"bake-cook\"}'),(632,'Jutebi','Peas',1,'{}'),(633,'Jutebi','Peppercorns',1,'{}'),(634,'Jutebi','Pine nuts',1,'{}'),(635,'Jutebi','pitted olives/pimentos',1,'{\"loc\":\"canned\"}'),(636,'Jutebi','pizza',1,'{}'),(637,'Jutebi','Plastic. Containers',1,'{}'),(638,'Jutebi','polenta',1,'{}'),(639,'Jutebi','Potato starch',1,'{}'),(640,'Jutebi','Proscuto',1,'{}'),(641,'Jutebi','pumpkin',1,'{\"loc\":\"produce\"}'),(642,'Jutebi','Pumpkin seeds',1,'{}'),(643,'Jutebi','Purple olives',1,'{\"loc\":\"canned\"}'),(644,'Jutebi','Quinoa',1,'{}'),(645,'Jutebi','Red onion',1,'{}'),(646,'Jutebi','red onions',1,'{\"loc\":\"produce\",\"amt\":{\"qty\":\"\",\"unit\":\"\"}}'),(647,'Jutebi','Red potatoes',1,'{}'),(648,'Jutebi','Ribs',1,'{}'),(649,'Jutebi','Rice cakes',1,'{}'),(650,'Jutebi','Rice vermicelli',1,'{}'),(651,'Jutebi','Rice vinegar',1,'{}'),(652,'Jutebi','Ritz crackers',1,'{}'),(653,'Jutebi','Rosemary',1,'{}'),(654,'Jutebi','Saffron threads',1,'{}'),(655,'Jutebi','Salmon',1,'{}'),(657,'Jutebi','Salt',1,'{}'),(658,'Jutebi','salt big chrystals for salt grinder',1,'{}'),(659,'Jutebi','salt kosher coarse',1,'{}'),(660,'Jutebi','Scallions',1,'{}'),(661,'Jutebi','Sea salt crystals',1,'{}'),(662,'Jutebi','Seaweed snacks',1,'{}'),(663,'Jutebi','Seltzer',1,'{}'),(664,'Jutebi','Sesame oil',1,'{}'),(665,'Jutebi','sesame seeds',1,'{}'),(667,'Jutebi','sherry, dry',1,'{}'),(668,'Jutebi','Shitake',1,'{}'),(669,'Jutebi','Shredded coconut, unsweetened',1,'{}'),(670,'Jutebi','Shrimp',1,'{}'),(671,'Jutebi','small onions',1,'{\"loc\":\"produce\"}'),(672,'Jutebi','smoked almonds',1,'{}'),(674,'Jutebi','smoked bluefish',1,'{\"loc\":\"seafood\"}'),(675,'Jutebi','smoked turkey butt',1,'{}'),(676,'Jutebi','Smoked turkey butt, neck..',1,'{}'),(677,'Jutebi','Soft scrub',1,'{}'),(678,'Jutebi','Sound sleep',1,'{}'),(679,'Jutebi','Sour cream LF',1,'{}'),(680,'Jutebi','Sourdough bread',1,'{}'),(681,'Jutebi','Spanish BBQ base for jerk sauce',1,'{}'),(682,'Jutebi','sparkling lemonade',1,'{}'),(683,'Jutebi','Spelt pretzels',1,'{}'),(684,'Jutebi','Spinach',1,'{}'),(685,'Jutebi','Split peas',1,'{}'),(686,'Jutebi','spring mix lettuce',1,'{\"loc\":\"produce\"}'),(687,'Jutebi','Sprouts',1,'{}'),(688,'Jutebi','Sriracha',1,'{}'),(689,'Jutebi','steak tips',1,'{\"loc\":\"meats\",\"tags\":[\"on sale\",\"could be quick dinner\"]}'),(690,'Jutebi','Steamers',1,'{}'),(691,'Jutebi','Steel cut oats',1,'{}'),(692,'Jutebi','Strawberries',1,'{\"loc\":\"produce\"}'),(693,'Jutebi','sugar',1,'{\"loc\":\"bake-cook\"}'),(694,'Jutebi','Sushi rice',1,'{}'),(695,'Jutebi','Sweet rice flour',1,'{\"loc\":\"natural-bulk\"}'),(696,'Jutebi','Tapioca',1,'{}'),(697,'Jutebi','Tapioca flour',1,'{}'),(698,'Jutebi','Throat coat',1,'{}'),(699,'Jutebi','Thyme',1,'{}'),(700,'Jutebi','thyme, fresh',1,'{}'),(701,'Jutebi','Tofu',1,'{}'),(702,'Jutebi','Toilet bowl cleaner',1,'{}'),(703,'Jutebi','tomato paste',1,'{\"loc\":\"canned\"}'),(704,'Jutebi','Tomato soup',1,'{}'),(705,'Jutebi','Tonic  water',1,'{}'),(706,'Jutebi','Trefoil',1,'{}'),(707,'Jutebi','Turkey',1,'{}'),(708,'Jutebi','Turkey bags',1,'{}'),(709,'Jutebi','Turkey to smoke?',1,'{}'),(710,'Jutebi','Turmeric',1,'{}'),(711,'Jutebi','Umboshi Plum paste',1,'{}'),(712,'Jutebi','Unsulphured molasses',1,'{}'),(713,'Jutebi','Vanilla extract',1,'{\"loc\":\"bake-cook\"}'),(714,'Jutebi','Vanilla ice cream on sale',1,'{}'),(715,'Jutebi','vinegar, sherry',1,'{}'),(716,'Jutebi','Vit D',1,'{}'),(717,'Jutebi','Vitamin C',1,'{}'),(718,'Jutebi','Walnut oil',1,'{}'),(719,'Jutebi','Walnuts',1,'{}'),(720,'Jutebi','wasabe',1,'{}'),(721,'Jutebi','White beans garbanzo connola',1,'{}'),(722,'Jutebi','white wine for cooking',1,'{\"loc\":\"canned\"}'),(723,'Jutebi','Whole Black peppers',1,'{}'),(724,'Jutebi','Wine vinegar',1,'{}'),(725,'Jutebi','Wocheshire sauce',1,'{}'),(726,'Jutebi','Xanthum gum',1,'{}'),(727,'Jutebi','Yellow pepper',1,'{}'),(728,'Jutebi','Yogurt',1,'{}'),(729,'Jutebi','zanthum gum',1,'{\"loc\":\"bake-cook\"}'),(731,'Jutebi','Popcorn',1,'{}'),(732,'Camala','pipe dope',1,'{}'),(733,'Camala','(3)1\" close hangers',1,'{}'),(734,'Camala','(4) 10\' 1\" BI',1,'{}'),(735,'Camala','(2) 3/4 elbows',1,'{}'),(736,'Camala','nipple rise',1,'{}'),(737,'Camala','8\' connector kit from 1/8\"x1/4 compression for fridge',1,'{}'),(738,'Camala','aerator',1,'{}'),(739,'Camala','3/4x1 reducer elbow BI',1,'{}'),(740,'Camala','3/4 union',1,'{}'),(741,'Camala','1\" union',1,'{}'),(742,'Camala','3/4x1x1 Tee BI',1,'{}'),(743,'Camala','(3) 1\" coupling',1,'{}'),(744,'Camala','(3) 1\"elbows',1,'{}'),(745,'Camala','1x3/4x1 Tee BI',1,'{}'),(746,'Camala','TA10-3HL min flow spindle',1,'{}'),(747,'Camala','1x3/4 reducer coupling bi',1,'{}'),(748,'Paposu','hp es6 token auth 2 pi',1,'{}'),(749,'Paposu','pi es6 token auth',1,'{}'),(750,'Paposu','001fix chair',0,'{}'),(751,'Paposu','02 TV    Mount Shelf',0,'{}'),(752,'Paposu','Greenhouse',0,'{}'),(753,'Paposu','Oatmeal',0,'{}');
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lists`
--

DROP TABLE IF EXISTS `lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lists` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lid` varchar(20) NOT NULL,
  `type` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `lid` (`lid`),
  KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=408 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lists`
--

LOCK TABLES `lists` WRITE;
/*!40000 ALTER TABLE `lists` DISABLE KEYS */;
INSERT INTO `lists` VALUES (400,'Minohu','lowes depot'),(401,'Kiyidu','2Chestnut'),(402,'Gabuge','dbs'),(403,'Bozoxi','todo'),(404,'Qoqida','down centre'),(405,'Jutebi','groceries'),(406,'Camala','economy'),(407,'Paposu','code');
/*!40000 ALTER TABLE `lists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(60) NOT NULL,
  `email` varchar(100) NOT NULL,
  `lids` varchar(260) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `user` (`user`)
) ENGINE=InnoDB AUTO_INCREMENT=405 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (400,'tim','mckenna.tim@gmail.com','[\"Minohu\",\"Kiyidu\",\"Gabuge\",\"Bozoxi\",\"Qoqida\",\"Jutebi\",\"Camala\",\"Paposu\"]'),(401,'tim','tim@sitebuilt.net','[\"Minohu\",\"Kiyidu\",\"Gabuge\",\"Bozoxi\",\"Qoqida\",\"Jutebi\",\"Camala\",\"Paposu\"]'),(402,'peri','perimckenna@gmail.com','[\"Minohu\",\"Kiyidu\",\"Gabuge\",\"Bozoxi\",\"Qoqida\",\"Jutebi\",\"Camala\",\"Paposu\"]'),(403,'peri','perimckenna@yahoo.com','[\"Minohu\",\"Kiyidu\",\"Gabuge\",\"Bozoxi\",\"Qoqida\",\"Jutebi\",\"Camala\",\"Paposu\"]'),(404,'noah','noahmckenna@gmail.com','[\"Minohu\",\"Kiyidu\",\"Gabuge\",\"Bozoxi\",\"Qoqida\",\"Jutebi\",\"Camala\",\"Paposu\"]');
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

-- Dump completed on 2020-01-24 14:43:45

delete from `users` where email='ckenn.tim@gmail.com';
delete from `users` where id=412;

ALTER TABLE `users` CHANGE `lids` `lids` VARCHAR(260) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '[]';

select users.lids, lists.type from users 
join lists on lists.lid = users.lid ;


select * from users;

select * from items;

SELECT product FROM items WHERE lid='Jutebi' AND product like("%ba%");

SELECT * FROM `items`ORDER BY lid,product

SELECT lid, product, COUNT(product) FROM items
group by lid,product
HAVING COUNT(product) > 1;

update items set done=IF(RAND()<.03,0,1) where lid = 'Jutebi';

update items set done=IF(RAND()<.03,0,1) where lid = 'Minohu';

select * from items where lid='Jutebi' and done=0;

USE s2g;
INSERT INTO items
SET `name` = 'mckenna.tim@gmail.com',
    `selected` = '[0,0,0,1,1,0,0,0,0,1,0]'
ON DUPLICATE KEY
UPDATE 
    `name` = 'mckenna.tim@gmail.com',
    `selected` = '[1,1,0,1,1,0,0,0,0,1,0]'


Select * from items where id = 372;

update items set done=0 where LENGTH(jsod)>3 AND lid='Jutebi' ;

DROP TABLE IF EXISTS `stores` ;

CREATE TABLE `stores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lid` varchar(20) NOT NULL,
  `store`varchar(40) NOT NULL,
  `loc` varchar(200) NOT NULL,
  `idx` int(3) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `lidstlo` (`lid`,`store`,`loc`),
  KEY `lid` (`lid`),
  KEY `store` (`store`),
  KEY `loc` (`loc`),
  KEY `idx` (`idx`)
) ENGINE=InnoDB AUTO_INCREMENT=754 DEFAULT CHARSET=utf8;

DELETE FROM stores WHERE lid='Jutebi';

INSERT INTO stores (lid,store,loc,idx) VALUES
  ('Jutebi','WholeFoodJP', 'produce',0),
  ('Jutebi','WholeFoodJP', 'bulk',1),
  ('Jutebi','WholeFoodJP', 'meat',2),
  ('Jutebi','WholeFoodJP', 'seafood',3),
  ('Jutebi','WholeFoodJP', 'pharma',4),
  ('Jutebi','WholeFoodJP', 'paper/clean',5),
  ('Jutebi','WholeFoodJP', 'intl',6),
  ('Jutebi','WholeFoodJP', 'coffee/tea',7),
  ('Jutebi','WholeFoodJP', 'can/jar',8),
  ('Jutebi','WholeFoodJP', 'dairy',9),
  ('Jutebi','WholeFoodJP', 'cook/bake',10),
  ('Jutebi','WholeFoodJP', 'pkg',11),
  ('Jutebi','WholeFoodJP', 'frozen',12),
  ('Jutebi','WholeFoodJP', 'deli',13),
  ('Jutebi','WholeFoodJP', 'bakery',14),
  ('Jutebi','Stop&ShopJP', 'produce',1),
  ('Jutebi','Stop&ShopJP', 'deli',2),
  ('Jutebi','Stop&ShopJP', 'seafood',3),
  ('Jutebi','Stop&ShopJP', 'coffee/tea',3),
  ('Jutebi','Stop&ShopJP', 'pkg',4),
  ('Jutebi','Stop&ShopJP', 'can/jar',5),
  ('Jutebi','Stop&ShopJP', 'meat',6),
  ('Jutebi','Stop&ShopJP', 'bulk',7),
  ('Jutebi','Stop&ShopJP', 'intl',8),
  ('Jutebi','Stop&ShopJP', 'cook/bake',9),
  ('Jutebi','Stop&ShopJP', 'pharma',10),
  ('Jutebi','Stop&ShopJP', 'paper/clean',11),
  ('Jutebi','Stop&ShopJP', 'dairy',12),
  ('Jutebi','Stop&ShopJP', 'frozen',13),
  ('Jutebi','Stop&ShopJP', 'bakery',14);

SELECT DISTINCT loc FROM stores WHERE lid='Jutebi' ORDER BY loc;

SELECT * FROM stores WHERE lid = 'Jutebi' AND store ='WholeFoods' ORDER BY idx

UPDATE items  SET done = 0 WHERE  lid='Jutebi' AND done = 1
UPDATE items  SET done = 0 WHERE  lid='Jutebi' AND loc IS NULL

UPDATE items  SET jsod = '' WHERE  jsod= '{}'


UPDATE items  SET loc = 'fish' WHERE  lid='Jutebi' AND loc = 'seafood';

UPDATE items  SET loc = 'can/jar' WHERE  lid='Jutebi' AND loc = 'packaged';

select * from items where loc='fish'

update items set done=IF(RAND()<.03,0,1) where lid = 'Jutebi';