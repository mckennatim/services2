DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lid` varchar(20) NOT NULL, 
  `product` varchar(200) NOT NULL,
  `done` int(1) DEFAULT 0,
  `jdata` varchar(260) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `lidprod` (`lid`, `product`),
  KEY (`lid`),
  KEY (`done`),
  KEY `liddone` (`lid`, `done`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;




DROP TABLE IF EXISTS `lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lists` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lid` varchar(20) NOT NULL, 
  `type` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  KEY (`lid`),
  KEY (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=400 DEFAULT CHARSET=utf8;

INSERT INTO `lists`(lid, shops) VALUES ('Minohu', 'lowes depot'), ('Kiyidu', '2Chestnut'), ('Gabuge', 'dbs'), ('Bozoxi', 'todo'), ('Qoqida', 'down centre'), ('Jutebi', 'groceries'), ('Camala', 'economy'), ('Paposu', 'code');


SELECT COUNT from lists;

SELECT COUNT(*) FROM items;

SELECT * from items;

SELECT * from users;

INSERT INTO `items` SET `lid` = 'Minohu', `product` = 'smoke detector Worry Free 10-Year Sealed', `done` = true, `jsod` = '{\"tags\":[\"1001632542 08 003\"]}'

INSERT INTO `items` SET `lid` = 'Paposu', `product` = 'Oatmeal', `done` = false, `jsod` = '{}' ON DUPLICATE KEY UPDATE `lid` = 'Paposu', `product` = 'Oatmeal', `done` = false, `jsod` = '{}';

INSERT INTO `items` SET (`lid` = 'Minohu', `product` = '5/16 in. x 1-7/8 in. Steel Magnetic Nut Driver', `done` = true, `jsod` = '{\"tags\":[\"bay 12 aisle 5\"]}') ON DUPLICATE KEY UPDATE (`lid` = 'Minohu', `product` = '5/16 in. x 1-7/8 in. Steel Magnetic Nut Driver', `done` = true, `jsod` = '{\"tags\":[\"bay 12 aisle 5\"]}');

INSERT INTO `items` SET `lid` = 'Minohu', `product` = '(18) Steel Rebar (Common: 0.375-in; Actual: 0.375-in)', `done` = true, `jsod` = 
'{\"amt\":{\"qty\":\"\",\"unit\":\"2ft\"},\"tags\":[\"# 17199 lowes LW 17\"]}' ON DUPLICATE KEY UPDATE `lid` = 'Minohu', `product` = '(18) Steel Rebar (Common: 0.375-in; Actual: 0.375-in)', `done` = true, `jsod` = '{\"amt\":{\"qty\":\"\",\"unit\":\"2ft\"},\"tags\":[\"# 17199 lowes LW 17\"]}';

show tables from `s2g`;

    INSERT INTO `items` SET `lid` = 'Minohu', `product` = 'Steel wool', `done` = true, `jsod` = '{}' ON DUPLICATE KEY UPDATE `lid` = 'Minohu', `product` = 'Steel wool', `done` = true, `jsod` = '{}';
    INSERT INTO `items` SET `lid` = 'Minohu', `product` = 'smoke detector Worry Free 10-Year Sealed', `done` = true, `jsod` = '{\"tags\":[\"1001632542 08 003\"]}' ON DUPLICATE KEY UPDATE `lid` = 'Minohu', `product` = 'smoke detector Worry Free 10-Year Sealed', `done` = true, `jsod` = '{\"tags\":[\"1001632542 08 003\"]}';
    INSERT INTO `items` SET `lid` = 'Minohu', `product` = 'Mouse traps', `done` = true, `jsod` = '{}' ON DUPLICATE KEY UPDATE `lid` = 'Minohu', `product` = 'Mouse traps', `done` = true, `jsod` = '{}';
    INSERT INTO `items` SET `lid` = 'Minohu', `product` = 'Light bulbs', `done` = true, `jsod` = '{}' ON DUPLICATE KEY UPDATE `lid` = 'Minohu', `product` = 'Light bulbs', `done` = true, `jsod` = '{}';
    INSERT INTO `items` SET `lid` = 'Minohu', `product` = 'Light screw', `done` = true, `jsod` = '{}' ON DUPLICATE KEY UPDATE `lid` = 'Minohu', `product` = 'Light screw', `done` = true, `jsod` = '{}';
    INSERT INTO `items` SET `lid` = 'Minohu', `product` = 'strike', `done` = true, `jsod` = '{\"tags\":[\"09 20 1000054053\"]}' ON DUPLICATE KEY UPDATE `lid` = 'Minohu', `product` = 'strike', `done` = true, `jsod` = '{\"tags\":[\"09 20 1000054053\"]}';
    INSERT INTO `items` SET `lid` = 'Minohu', `product` = 'FireX Hardwire Smoke and Carbon Monoxide', `done` = true, `jsod` = '{\"tags\":[\"1001824517 08 003\"]}' ON DUPLICATE KEY UPDATE `lid` = 'Minohu', `product` = 'FireX Hardwire Smoke and Carbon Monoxide', `done` = true, `jsod` = '{\"tags\":[\"1001824517 08 003\"]}';
    INSERT INTO `items` SET `lid` = 'Minohu', `product` = 'Black Plasti Dip', `done` = true, `jsod` = '{\"tags\":[\"Aisle 07\",\"Bay 018\"]}' ON DUPLICATE KEY UPDATE `lid` = 'Minohu', `product` = 'Black Plasti Dip', `done` = true, `jsod` = '{\"tags\":[\"Aisle 07\",\"Bay 018\"]}';
    INSERT INTO `items` SET `lid` = 'Minohu', `product` = '1/4 in. x 1-3/4 in. White Ultrashield Hex-Washer-Head Concrete Anchors (8-Pack)', `done` = 
true, `jsod` = '{\"tags\":[\"aisle 13 bay015\"]}' ON DUPLICATE KEY UPDATE `lid` = 'Minohu', `product` = '1/4 in. x 1-3/4 in. White Ultrashield Hex-Washer-Head Concrete Anchors (8-Pack)', `done` = true, `jsod` = '{\"tags\":[\"aisle 13 bay015\"]}';
    INSERT INTO `items` SET `lid` = 'Minohu', `product` = '5/16 in. x 1-7/8 in. Steel Magnetic Nut Driver', `done` = true, `jsod` = '{\"tags\":[\"bay 
12 aisle 5\"]}' ON DUPLICATE KEY UPDATE `lid` = 'Minohu', `product` = '5/16 in. x 1-7/8 in. Steel Magnetic Nut Driver', `done` = true, `jsod` = '{\"tags\":[\"bay 12 aisle 5\"]}';
    INSERT INTO `items` SET `lid` = 'Minohu', `product` = '3/16 in. x 7 in. SDS Carbide Drill Bit', `done` = true, `jsod` = '{}' ON DUPLICATE KEY UPDATE `lid` = 'Minohu', `product` = '3/16 in. x 7 in. SDS Carbide Drill Bit', `done` = true, `jsod` = '{}';
    INSERT INTO `items` SET `lid` = 'Minohu', `product` = '5/16 in. x 2-1/4 in. Hex-Washer-Head Large Diameter Concrete Anchors (4-Pack)', `done` = true, `jsod` = '{}' ON DUPLICATE KEY UPDATE `lid` = 'Minohu', `product` = '5/16 in. x 2-1/4 in. Hex-Washer-Head Large Diameter Concrete Anchors (4-Pack)', `done` = true, `jsod` = '{}';
    INSERT INTO `items` SET `lid` = 'Minohu', `product` = '(18) Steel Rebar (Common: 0.375-in; Actual: 0.375-in)', `done` = true, `jsod` = '{\"amt\":{\"qty\":\"\",\"unit\":\"2ft\"},\"tags\":[\"# 17199 lowes LW 17\"]}' ON DUPLICATE KEY UPDATE `lid` = 'Minohu', `product` = '(18) Steel Rebar (Common: 0.375-in; Actual: 0.375-in)', `done` = true, `jsod` = '{\"amt\":{\"qty\":\"\",\"unit\":\"2ft\"},\"tags\":[\"# 17199 lowes LW 17\"]}';
    INSERT INTO `items` SET `lid` = 'Minohu', `product` = 'Quikrete 8.6 oz. High Strength Anchoring Epoxy', `done` = true, `jsod` = '{\"amt\":{\"qty\":\"\",\"unit\":\"\"},\"tags\":[\"201253 hd 16 002\"]}' ON DUPLICATE KEY UPDATE `lid` = 'Minohu', `product` = 'Quikrete 8.6 oz. High Strength Anchoring Epoxy', `done` = true, `jsod` = '{\"amt\":{\"qty\":\"\",\"unit\":\"\"},\"tags\":[\"201253 hd 16 002\"]}';
    INSERT INTO `items` SET `lid` = 'Minohu', `product` = 'ANVIL Wire Twister', `done` = true, `jsod` = '{\"tags\":[\"#1002277329 hd 16  001\"]}' ON DUPLICATE KEY UPDATE `lid` = 'Minohu', `product` = 'ANVIL Wire Twister', `done` = true, `jsod` = '{\"tags\":[\"#1002277329 hd 16  001\"]}';
    INSERT INTO `items` SET `lid` = 'Minohu', `product` = '(3) 2x4', `done` = true, `jsod` = '{\"amt\":{\"qty\":\"\",\"unit\":\"8\"},\"tags\":[\"lowes aisle 18 bay 9\"]}' ON DUPLICATE KEY UPDATE `lid` = 'Minohu', `product` = '(3) 2x4', `done` = true, `jsod` = '{\"amt\":{\"qty\":\"\",\"unit\":\"8\"},\"tags\":[\"lowes aisle 18 bay 9\"]}';
    INSERT INTO `items` SET `lid` = 'Minohu', `product` = '(4)Sakrete 5000 Plus 80-lb High Strength Concrete Mix', `done` = true, `jsod` = '{\"amt\":{\"qty\":\"\",\"unit\":\"\"},\"tags\":[\"lowes aisle 19 bay 8\"]}' ON DUPLICATE KEY UPDATE `lid` = 'Minohu', `product` = '(4)Sakrete 5000 Plus 80-lb High Strength Concrete Mix', `done` = true, `jsod` = '{\"amt\":{\"qty\":\"\",\"unit\":\"\"},\"tags\":[\"lowes aisle 19 bay 8\"]}';
    INSERT INTO `items` SET `lid` = 'Minohu', `product` = 'LYSOL 4-Pack Nylon Straw Brushes', `done` = true, `jsod` = '{\"tags\":[\"# 751578  Lowes Aisle 4\",\"Bay 13\"]}' ON DUPLICATE KEY UPDATE `lid` = 'Minohu', `product` = 'LYSOL 4-Pack Nylon Straw Brushes', `done` = true, `jsod` = '{\"tags\":[\"# 751578  Lowes Aisle 4\",\"Bay 13\"]}';
    INSERT INTO `items` SET `lid` = 'Minohu', `product` = '67/100 ft. 16-Gauge Rebar Tie Wire (100-Piece/Bag)', `done` = true, `jsod` = '{\"tags\":[\"hd 16 011\"]}' ON DUPLICATE KEY UPDATE `lid` = 'Minohu', `product` = '67/100 ft. 16-Gauge Rebar Tie Wire (100-Piece/Bag)', `done` = true, `jsod` = '{\"tags\":[\"hd 16 011\"]}';
    INSERT INTO `items` SET `lid` = 'Minohu', `product` = 'glue sticks', `done` = true, `jsod` = '{}' ON DUPLICATE KEY UPDATE `lid` = 'Minohu', `product` = 'glue sticks', `done` = true, `jsod` = '{}';


    SELECT * FROM users;   

    SELECT lids FROM users WHERE email='mckenna.tim@gmail.com';

DELETE FROM users WHERE id=405;
