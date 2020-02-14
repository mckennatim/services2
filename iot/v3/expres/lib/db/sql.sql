other sql files...
/tmstack/hsc/sql/sql.sql

------------------- IOTbroker2.0 queries---------------
SELECT * FROM scheds a INNER JOIN (SELECT MAX(dow)as mdow, senrel FROM scheds WHERE devid='CYURD001' AND (dow=4 OR dow=0) GROUP BY senrel)b ON a.dow=b.mdow AND a.senrel=b.senrel 

SELECT * FROM scheds a INNER JOIN (SELECT MAX(dow)as mdow, senrel FROM scheds WHERE devid='CYURD001' AND senrel=0 AND (dow=5 OR dow=0) GROUP BY senrel)b ON a.dow=b.mdow AND a.senrel=b.senrel

-------

SELECT * FROM scheds 
WHERE devid= 'CYURD001' 
AND senrel=0 
AND (dow=0 OR dow=4) 
ORDER BY dow

SELECT * FROM scheds 
WHERE devid= 'CYURD001' 
AND senrel=0 
ORDER BY sched

SELECT id, devid, dow, senrel, sched, until FROM scheds
ORDER BY devid, dow, senrel

SELECT id, devid, dow, senrel, sched, until FROM scheds
ORDER BY devid, senrel, dow

-----------------now used in my.getTodaysSchedule called by sched/findSched------
SELECT * FROM scheds 
WHERE (devid,senrel,dow) 
IN ( 
  SELECT devid, senrel, MAX(dow) 
  FROM scheds 
  WHERE (dow=0 OR dow=1 OR dow=8) 
  AND (until = '0000-00-00 00:00' OR '2018-03-12' <= until) 
  GROUP BY devid, senrel 
  ) 
AND devid = 'CYURD001'


SELECT * FROM scheds WHERE (devid,senrel,dow) IN ( SELECT devid, senrel, MAX(dow) FROM scheds WHERE (dow=0 OR dow=? OR dow=8) AND (until = '0000-00-00 00:00' OR ? <=until) GROUP BY devid, senrel ) AND devid = ?

----------------------my.getSenRelSched ---called by sched/modSchedIfHoldEndsToday--
SELECT * FROM scheds 
WHERE devid= 'CYURD001' 
AND senrel=0 AND (dow=0 OR dow=1) 
ORDER BY dow DESC LIMIT 0,1

---------------------------------------------------------------

DROP TABLE IF EXISTS `holds`;
CREATE TABLE IF NOT EXISTS `holds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `devid` varchar(30) NOT NULL,
  `senrel` int(2) NOT NULL,
  `until` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sched` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `main` (`devid`,`senrel`,`until`) USING BTREE,
  KEY `devid` (`devid`),
  KEY `senrel` (`senrel`),
  KEY `until` (`until`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `holds`(`devid`, `senrel`, `until`, `sched`) 
VALUES ('CYURD001',0,'2018-02-15 00:00','[[0,0,72,74]]')
-------------------new IOTexress2.0 tables---------------
/*
locations, devs, user-app-loc
*/

DROP TABLE IF EXISTS `app_loc`;
CREATE TABLE `app_loc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `appid` varchar(20) NOT NULL,
  `locid` varchar(20) NOT NULL,
  `devs` varchar(300) DEFAULT NULL,
  `zones` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locid` (`locid`),
  KEY `appid` (`appid`),
  UNIQUE KEY `main` (`appid`, `locid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=400 ;
INSERT INTO app_loc (appid, locid, devs, zones)
  VALUES (

    'hvac',
    '12ParleyVale',
    '{"CYURD003": [{"sr":0,"label":"kid"}, {"sr":1,"label":"lr"}], "CYURD006": [{"sr":0,"label":"music"}, {"sr":1,"label":"peri"}]}',
    '[{"id":"kid", "name":"Kid\'s Suite","img":"kid.jpg"}, {"id":"lr","name":"Living Room","img":"lr.jpg"},{"id":"music","name":"Music Room","img":"music.jpg"},{"id":"peri","name":"Peri\'s Study","img":"peri.jpg"}]'
  )

INSERT INTO app_loc (appid, locid, devs, zones)
  VALUES (
    'hvac',
    '255ChestnutAve',
    '{"CYURD013": [{"sr":0,"label":"kid"}, {"sr":1,"label":"lr"}], "CYURD016": [{"sr":0,"label":"music"}, {"sr":1,"label":"peri"}]}',
    '[{"id":"kid", "name":"Kid\'s Suite","img":"kid.jpg"}, {"id":"lr","name":"Living Room","img":"lr.jpg"},{"id":"music","name":"Music Room","img":"music.jpg"},{"id":"peri","name":"Peri\'s Study","img":"peri.jpg"}]'
  )

DROP TABLE IF EXISTS `locations`;
CREATE TABLE `locations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `locid` varchar(20) NOT NULL,
  `address` varchar(120) NOT NULL,
  `latlng` varchar(100) DEFAULT NULL,
  `timezone` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `locid` (`locid`),
  KEY `timezone` (`timezone`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1000 ;

INSERT INTO locations (locid, address, latlng, timezone)
  VALUES (
    '12ParleyVale',
    '12 Parley Vale, Boston, MA 02130, USA',
    '{"lat":42.3150229,"lng":-71.111138}',
    'America/New_York'
  )
  INSERT INTO locations (locid, address, latlng, timezone)
    VALUES (
      '255Chestnut',
      '255 Chestnut Ave, Jamaica Plain, MA 02130, USA',
      '{"lat":42.31381409999999,"lng":-71.10874749999999}',
      'America/New_York'
    )
    INSERT INTO locations (locid, address, latlng, timezone)
      VALUES (
        '794048thS',
        '7940 48th Ave S, Seattle, WA 98118, USA',
        '{"lat":47.5303635,"lng":-122.2724899}',
        'America/Los_Angeles'
      )
      INSERT INTO locations (locid, address, latlng, timezone)
        VALUES (
          '4505NHaight',
          '4505 N Haight Ave, Portland, OR 97217, USA',
          '{"lat":45.5555363,"lng":-122.6703647}',
          'America/Los_Angeles'
        )

DROP TABLE IF EXISTS `devs`;
CREATE TABLE IF NOT EXISTS `devs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `devid` varchar(30) NOT NULL,
  `devpwd` varchar(24) DEFAULT NULL,
  `description` varchar(220) DEFAULT NULL,
  `bizid` varchar(20) DEFAULT NULL,
  `locid` varchar(20) DEFAULT NULL,
  `server` varchar(120) DEFAULT NULL,
  `specs` varchar(120) DEFAULT NULL,
  `owner` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `devid` (`devid`),
  KEY `bizid` (`bizid`),
  KEY `locid` (`locid`),
  KEY `owner` (`owner`),
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=100 ;

INSERT INTO `devs` (`devid`, devpwd, description, bizid, server,specs,owner)
SELECT `devid`,
       devpwd,
       description,
       bizid,
       server,
       specs,
       owner
FROM `devices`;

TRUNCATE TABLE devs;

UPDATE devs SET locid='12ParleyVale'

ALTER TABLE `scheds` ADD `season` VARCHAR(40) NOT NULL AFTER `until`, ADD INDEX `season` (`season`);

UPDATE scheds SEt season='current'



SELECT * FROM scheds
WHERE season='current'
AND devid = 'CYURD001'
AND senrel = 0
ORDER BY dow

DROP TABLE IF EXISTS `user_app_loc_dev`;
DROP TABLE IF EXISTS `user_app_dev`;
CREATE TABLE IF NOT EXISTS `user_app_dev` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` varchar(60) NOT NULL,
  `appid` varchar(20) DEFAULT NULL,
  `devid` varchar(30) NOT NULL,
  `role` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `appid` (`appid`),
  KEY `devid` (`devid`),
  KEY `role` (`role`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=100 ;

select locids for user and app
select devices for locid and user and app

CREATE TABLE user_app_loc AS
SELECT DISTINCT userid,
                appid,
                ROLE
FROM user_app_dev;


ALTER TABLE user_app_loc ADD id int(11) NOT NULL AUTO_INCREMENT, ADD PRIMARY KEY (id);

ALTER TABLE `user_app_loc` CHANGE `id` `id` INT(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE user_app_loc ADD locid varchar(40), ADD KEY (locid);
ALTER TABLE user_app_loc ADD devid varchar(40), ADD KEY (devid);

ALTER TABLE user_app_loc CHANGE `rolle` `role` VARCHAR(20);

UPDATE user_app_loc SET locid =
 ELT(1 + FLOOR(RAND()*4), '12ParleyVale', '255Chestnut', '4505NHaight', '794048thAvS');

 SELECT userid,
        appid,
        locid
 FROM user_app_loc
 WHERE userid = 'tim@sitebuilt.net'
   AND appid= 'hvac';

SELECT *
FROM user_app_loc
WHERE userid = 'tim@sitebuilt.net'
 AND appid= 'hvac';


SELECT u.userid, u.appid, u.locid, d.devid
FROM user_app_loc u
LEFT JOIN devs d ON d.locid= u.locid
WHERE u.userid = 'tim@sitebuilt.net'
  AND u.appid= 'hvac';

   INSERT INTO `user_app_loc` ( `userid`, `appid`, `role`, `locid`) VALUES ('tim@sitebuilt.net', 'hvac', 'user', '12ParleyVale')

   INSERT INTO `user_app_loc` ( `userid`, `appid`, `role`, `locid`) VALUES ('tim@sitebuilt.net', 'hvac', 'user', '12ParleyVale')

   INSERT INTO `user_app_loc` ( `userid`, `appid`, `role`, `locid`) VALUES ('tim@sitebuilt.net', 'hvac', 'user', '255Chestnut')
   INSERT INTO `user_app_loc` ( `userid`, `appid`, `role`, `locid`, `devid`) VALUES ('tim@sitebuilt.net', 'hvac', 'user', '255Chestnut', 'CYURD050')

UPDATE user_app_loc
SET locid = '4505NHaight'
WHERE locid = '4505N Haight'


UPDATE user_app_loc
SET devid = 'CYURD003'
WHERE appid = 'hvac'
AND locid = '12ParleyVale'
AND userid = 'tim@sitebuilt.net'

UPDATE user_app_loc
SET locid = '12ParleyVale'
WHERE locid = '12parleyVale'

INSERT into user_app_loc (userid, appid, role, locid, devid)
VALUES ('tim@sitebuilt.net', 'hvac', 'user', '12parleyVale', 'CYURD003')
---------------end of IOTexpress2.0 table creation------------
---------------- exploratory queries--------
SELECT *
FROM user_app_loc
WHERE userid ='mckenna.tim@gmail.com'

SELECT *
FROM user_app_loc
WHERE userid ='tim@sitebuilt.net'
AND devid IS NOT null

SELECT *
FROM user_app_loc
WHERE userid ='mckenna.tim@gmail.com'
AND devid IS NOT null
AND (role="admin" OR role="super") 

INSERT INTO `user_app_loc` 
(`id`, `userid`, `appid`, `role`, `locid`, `devid`) 
VALUES 
(NULL, 'mckenna.tim@gmail.com', 'admind', 'super', '1NearwaterAve', 'CYURD14I');

ALTER TABLE `geniot`.`devuserapp` 
DROP INDEX `main`, 
ADD UNIQUE `main` (`devid`, `userid`, `bizid`, `appid`) 
USING BTREE;

ALTER TABLE `geniot`.`devuserapp` 
DROP INDEX `main`, 
ADD UNIQUE `main` (`devid`, `userid`, `bizid`, `appid`) 
USING BTREE;

ALTER TABLE `geniot`.`devuserapp` 
DROP INDEX `main`, 
ADD UNIQUE `main` (`devid`, `userid`, `bizid`, `appid`) 
USING BTREE;

ALTER TABLE `geniot`.`user_app_loc` 
DROP INDEX `locid`, 
ADD INDEX `locid` (`locid`) 
USING BTREE;

ALTER TABLE `geniot`.`user_app_loc` 
ADD INDEX `userid` (`userid`) 
USING BTREE;

ALTER TABLE `geniot`.`user_app_loc` 
ADD INDEX `appid` (`appid`) 
USING BTREE;

ALTER TABLE `geniot`.`user_app_loc` 
ADD INDEX `role` (`role`) 
USING BTREE;

ALTER TABLE `geniot`.`user_app_loc` 
ADD UNIQUE `main` (`userid`, `appid`, `devid`, `role`, `locid`) 
USING BTREE;

SELECT * FROM `user_app_loc` 
ORDER BY `userid`, `appid`, `role`, `locid`, `devid`  
ASC 

ALTER TABLE `geniot`.`user_app_loc`
DROP INDEX `locid`,
           ADD INDEX `locid` (`locid`) USING BTREE;

ALTER TABLE `geniot`.`user_app_loc`
DROP INDEX `locid`,
           ADD INDEX `locid` (`locid`) USING BTREE;

SELECT DISTINCT u.devid
FROM user_app_loc u, devs d
WHERE d.devid=u.devid
    AND u.userid='tim@sitebuilt.net'
    AND u.appid='hvac'
    AND d.locid='12ParleyVale'

SELECT a.appid, a.locid, a.devs, a.zones 
FROM app_loc a
WHERE appid='hvac' 
AND locid='12ParleyVale' 

SELECT a.appid, a.locid, a.devs, a.zones, l.timezone 
FROM app_loc a
LEFT JOIN locations l ON a.locid=l.locid
WHERE a.appid='hvac' 
AND a.locid='12ParleyVale'   

SELECT *
FROM app_loc a
LEFT JOIN devs d ON d.locid= u.locid
WHERE u.userid = 'tim@sitebuilt.net'
  AND u.appid= 'hvac';  

  ----------------queries in the api2.0---------------------

SELECT d.devid,
       d.devpwd,
       d.description,
       d.bizid,
       d.locid,
       l.address,
       l.latlng,
       l.timezone,
       d.server,
       d.specs,
       d.owner,
       d.apps
FROM devs d, locations l
WHERE d.locid=l.locid
ORDER BY d.devid

SELECT devs.devid,
       devs.devpwd,
       devs.description,
       devs.bizid,
       devs.locid,
       locations.address,
       locations.latlng,
       locations.timezone,
       devs.server,
       devs.specs,
       devs.owner,
       devs.apps
FROM devs, locations       
WHERE devs.locid = locations.locid
ORDER BY devs.devid

SELECT * FROM  app_loc 
WHERE appid="hvac" 
AND locid="12ParleyVale"


SELECT DISTINCT d.locid
FROM user_app_loc u , devs d
WHERE u.devid=d.devid
    AND u.userid='tim@sitebuilt.net'
    AND u.appid='hvac'
ORDER BY d.locid ASC

INSERT INTO user_app_loc
SET `devid` = 'CYURD14I',
    `userid` = 'tim3@sitebuilt.net',
    `appid` = 'hvac',
    `role` = 'user' 
ON DUPLICATE KEY
UPDATE `devid` = 'CYURD14I',
       `userid` = 'tim2@sitebuilt.net',
       `appid` = 'hvac',
       `role` = 'user'


INSERT INTO devuserapp
SET `devid` = 'CYURD14I',
    `userid` = 'tim2@sitebuilt.net',
    `appid` = 'hvac',
    `role` = 'user' ON DUPLICATE KEY
UPDATE `devid` = 'CYURD14I',
       `userid` = 'tim2@sitebuilt.net',
       `appid` = 'hvac',
       `role` = 'user'

----------------equeries in the api -----------------

--ex2.0/strategy/ln30
SELECT userid, devid 
FROM user_app_loc 
WHERE userid= 'mckenna.tim@gmail.com' 
AND devid IS NOT null

---dedata.get/apps index.js:21 

---admind2.0/super/devinfo 
SELECT * FROM user_app_loc 
WHERE userid ='mckenna.tim@gmail.com' 
AND devid IS NOT null 
AND (role="admin" OR role="super")

---dedata/index:184.post/dev 
INSERT INTO scheds
SET 
`devid` = 'CYURD003',
`senrel` = 0,
`dow` = 0,
`sched` = '[[0,0,55,53],[20,12,78,76],[22,50,56,52],[23,50,64,61]]'
ON DUPLICATE KEY
UPDATE 
`devid` = 'CYURD003',
`senrel` = 0,
`dow` = 0,
`sched` = '[[0,0,55,53],[20,12,78,76],[22,50,56,52],[23,50,64,61]]'

INSERT INTO scheds
SET 
`devid` = 'CYURD003',
`senrel` = 1,
`dow` = 0,
`sched` = '[[0,0,55,53],[20,12,78,76],[22,50,56,52],[23,50,64,61]]'
ON DUPLICATE KEY
UPDATE 
`devid` = 'CYURD003',
`senrel` = 1,
`dow` = 0,
`sched` = '[[0,0,55,53],[20,12,78,76],[22,50,56,52],[23,50,64,61]]'

INSERT INTO user_app_loc
SET `userid` = 'tim@sitebuilt.net',
`role` = 'admin',
`locid` = '12ParleyVale',
`devid` = 'CYURD007',
`appid` = 'admin' ON DUPLICATE KEY
UPDATE `userid` = 'tim@sitebuilt.net',
`role` = 'admin',
`locid` = '12ParleyVale',
`devid` = 'CYURD007',
`appid` = 'admin'

---dedata/index.js:204.post/dev  /super/CYURD14I
INSERT INTO locations
SET `locid` = '12ParleyVale',
`address` = '12 Parley Vale, Jamaica Plain, MA 02130',
`latlng` = '{\"lat\":42.315,\"lng\":-71.111}',
`timezone` = 'America/New_York' ON DUPLICATE KEY
UPDATE `locid` = '12ParleyVale',
`address` = '12 Parley Vale, Jamaica Plain, MA 02130',
`latlng` = '{\"lat\":42.315,\"lng\":-71.111}',
`timezone` = 'America/New_York'

INSERT INTO scheds
SET 
`devid` = 'CYURD001',
`senrel` = 1,
`dow` = 0,
`sched` = '[[0,0,55,53],[20,12,78,76],[22,50,56,52],[23,50,64,61]]'
ON DUPLICATE KEY
UPDATE 
`devid` = 'CYURD001',
`senrel` = 1,
`dow` = 0,
`sched` = '[[0,0,55,53],[20,12,78,76],[22,50,56,52],[23,50,64,61]]'

INSERT INTO scheds
SET 
`devid` = 'CYURD001',
`senrel` = 0,
`dow` = 1,
`sched` = '[[0,0,55,53],[20,12,78,76],[22,50,56,52],[23,50,64,61]]'
ON DUPLICATE KEY
UPDATE 
`devid` = 'CYURD001',
`senrel` = 0,
`dow` = 1,
`sched` = '[[0,0,55,53],[20,12,78,76],[22,50,56,52],[23,50,64,61]]'

INSERT INTO scheds
SET 
`devid` = 'CYURD001',
`senrel` = 0,
`dow` = 5,
`sched` = '[[0,0,55,53],[17,12,78,76],[20,50,56,52],[22,50,64,61]]'
ON DUPLICATE KEY
UPDATE 
`devid` = 'CYURD001',
`senrel` = 0,
`dow` = 5,
`sched` = '[[0,0,55,53],[17,12,78,76],[20,50,56,52],[22,50,64,61]]'

INSERT INTO scheds
SET 
`devid` = 'CYURD001',
`senrel` = 0,
`dow` = 8,
`sched` = '[[0,0,55,53]]',
`until` = '2018-03-12 10:15'
ON DUPLICATE KEY
UPDATE 
`devid` = 'CYURD001',
`senrel` = 0,
`dow` = 8,
`sched` = '[[0,0,55,53]]',
`until` = '2018-03-12 10:15'

INSERT INTO scheds
SET 
`devid` = 'CYURD001',
`senrel` = 1,
`dow` = 8,
`sched` = '[[0,0,55,53]]',
`until` = '2018-03-12 10:15'
ON DUPLICATE KEY
UPDATE 
`devid` = 'CYURD001',
`senrel` = 1,
`dow` = 8,
`sched` = '[[0,0,55,53]]',
`until` = '2018-03-12 10:15'

INSERT INTO scheds
SET 
`devid` = 'CYURD001',
`senrel` = 1,
`dow` = 4,
`sched` = '[[0,0,55,53],[17,12,78,76],[20,50,56,52],[22,50,64,61]]'
ON DUPLICATE KEY
UPDATE 
`devid` = 'CYURD001',
`senrel` = 1,
`dow` = 4,
`sched` = '[[0,0,55,53],[17,12,78,76],[20,50,56,52],[22,50,64,61]]'
---dedata/index.js:213.post/dev  /super/CYURD14I 
INSERT INTO devs
SET `devid` = 'CYURD007',
`bizid` = 'sbs',
`description` = '2 temps, 3 timers 1 relay demo board',
`locid` = '12ParleyVale',
`server` = '{\"mqtt_server\":\"sitebuilt.net\",\"mqtt_port\":\"1884\",\"sensor_type\":\"\"}',
`specs` = '{\"HAStIMER\":28,\"notTimerTags\":[\"temp\",\"onoff\",\"hilimit\",\"lolimit\"]}',
`owner` = 'tim@sitebuilt.net',
`apps` = '[\"admin\", \"user\"]' ON DUPLICATE KEY
UPDATE `devid` = 'CYURD007',
`bizid` = 'sbs',
`description` = '2 temps, 3 timers 1 relay demo board',
`locid` = '12ParleyVale',
`server` = '{\"mqtt_server\":\"sitebuilt.net\",\"mqtt_port\":\"1884\",\"sensor_type\":\"\"}',
`specs` = '{\"HAStIMER\":28,\"notTimerTags\":[\"temp\",\"onoff\",\"hilimit\",\"lolimit\"]}',
`owner` = 'tim@sitebuilt.net',
`apps` = '[\"admin\", \"user\"]'

------dedata/index.js:108.get/dev  /super/CYURD14I 
SELECT d.devid,
       d.devpwd,
       d.description,
       d.bizid,
       d.locid,
       l.address,
       l.latlng,
       l.timezone,
       d.server,
       d.specs,
       d.owner,
       d.apps
FROM devs d, locations l
WHERE d.locid=l.locid
ORDER BY d.devid

SELECT l.timezone
FROM locations l,
     devs d
WHERE l.locid=d.locid
    AND d.devid='CYURD003'
------dedata/index.js:84.get/users/:devid  /admin/CYURD14I 


SELECT * 
FROM user_app_loc 
WHERE devid='CYURD003'

SELECT DISTINCT locid
FROM `user_app_loc`
WHERE userid='tim@sitebuilt.net'
  AND appid='hvac'
ORDER BY `locid` ASC

SELECT devid
FROM `user_app_loc`
WHERE userid='tim@sitebuilt.net'
  AND appid='hvac'
  AND locid='12ParleyVale'
ORDER BY `locid` ASC

----------------end of queries in the api -----------------

DROP TABLE IF EXISTS `apps`;
CREATE TABLE `apps` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `appid` varchar(20) NOT NULL,
  `appurl` varchar(30) DEFAULT NULL,
  `apiurl` varchar(30) DEFAULT NULL,
  `desc` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `appid` (`appid`),
  KEY `appurl` (`appurl`),
  KEY `apiurl` (`apiurl`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=400 ;


INSERT INTO apps (appid) VALUES ('admind')
INSERT INTO apps (appid) VALUES ('shroom')
INSERT INTO apps (appid) VALUES ('pahoRawSB')
INSERT INTO apps (appid) VALUES ('cascada')
INSERT INTO apps (appid) VALUES ('hvac')
INSERT INTO apps (appid) VALUES ('lightsoff')

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` varchar(80) NOT NULL,
  `name` varchar(60) DEFAULT NULL,
  `address` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=400 ;


--------------original Tables------------------------
DROP TABLE IF EXISTS `scheds`;
CREATE TABLE `scheds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `devid` varchar(30) NOT NULL,
  `dow` int(2) NOT NULL,
  `senrel` int(2) NOT NULL,
  `sched` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `devid` (`devid`),
  KEY `dow` (`dow`),
  KEY `senrel` (`senrel`),
  UNIQUE KEY `main` (`devid`, `dow`, `senrel`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1000 ;

CREATE TABLE IF NOT EXISTS `bizapp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bizid` varchar(20) DEFAULT NULL,
  `appid` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bizid` (`bizid`),
  KEY `appid` (`appid`),
  UNIQUE KEY `main` (`bizid`, `appid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=300 ;

CREATE TABLE IF NOT EXISTS `devuserapp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `devid` varchar(30) DEFAULT NULL,
  `userid` varchar(24) NOT NULL,
  `bizid` varchar(20) DEFAULT NULL,
  `appid` varchar(20) DEFAULT NULL,
  `role` varchar(20) DEFAULT NULL,
  `auth` boolean DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `devid` (`devid`),
  KEY `userid` (`userid`),
  KEY `appid` (`appid`),
  KEY `role` (`role`),
  KEY `auth` (`auth`),
  UNIQUE KEY `main` (`devid`, `userid`, `bizid`, `appid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=200 ;

DROP TABLE IF EXISTS `devices`;
CREATE TABLE IF NOT EXISTS `devices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `devid` varchar(30) NOT NULL,
  `devpwd` varchar(24) DEFAULT NULL,
  `description` varchar(220) DEFAULT NULL,
  `bizid` varchar(20) DEFAULT NULL,
  `address` varchar(120) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `timezone` varchar(40) DEFAULT NULL,
  `server` varchar(120) DEFAULT NULL,
  `specs` varchar(120) DEFAULT NULL,
  `owner` varchar(60) DEFAULT NULL,
  `apps` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `devid` (`devid`),
  KEY `bizid` (`bizid`),
  KEY `specs` (`specs`),
  KEY `owner` (`owner`),
  KEY `location` (`location`),
  KEY `timezone` (`timezone`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=100 ;

SELECT DISTINCT `userid` FROM `devuserapp` ;
SELECT DISTINCT devuserapp.userid FROM devuserapp
SELECT DISTINCT devuserapp.userid, devs.devid FROM devuserapp, devs ;
CREATE TABLE temp AS SELECT DISTINCT devuserapp.userid, devs.devid FROM devuserapp, devs ;
CREATE TABLE temp2 AS SELECT DISTINCT temp.userid, temp.devid, apps.appid FROM temp, apps ;

INSERT INTO `user_app_dev` (userid, appid, devid,role)
SELECT userid, appid, devid, "user"
FROM `temp2`;

CREATE TABLE IF NOT EXISTS `biz` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bizid` varchar(20) NOT NULL,
  `bizname` varchar(120) DEFAULT NULL,
  `owner` varchar(40) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `location` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bizid` (`bizid`),
  KEY `bizname` (`bizname`),
  KEY `owner` (`owner`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=500 ;

-- a slow build
SELECT * FROM `devuserapp` d
LEFT JOIN `devices`e
ON d.devid=e.devid

SELECT * FROM `devuserapp` d
LEFT JOIN `devices` e
ON d.devid=e.devid
LEFT JOIN `apps` a
ON d.appid=a.appid


SELECT d.userid, d.devid, d.appid, e.description, a.desc
FROM `devuserapp` d
LEFT JOIN `devices` e
ON d.devid=e.devid
LEFT JOIN `apps` a
ON d.appid=a.appid

SELECT d.userid, d.devid, d.appid, e.description, a.desc
FROM `devuserapp` d
LEFT JOIN `devices` e
ON d.devid=e.devid
LEFT JOIN `apps` a
ON d.appid=a.appid
WHERE d.userid="mckenna.tim@gmail.com"

SELECT d.userid, d.devid, e.description as devdesc, d.appid,  a.desc as appdesc, d.role, d.auth
FROM `devuserapp` d
LEFT JOIN `devices` e
ON d.devid=e.devid
LEFT JOIN `apps` a
ON d.appid=a.appid
WHERE d.userid="mckenna.tim@gmail.com"


SELECT
  d.userid,
  d.devid,
  e.description AS devdesc,
  d.bizid,
  d.appid,
  d.role,
  d.auth
FROM
  devuserapp d
LEFT JOIN
  devices e ON d.devid = e.devid
WHERE
  d.userid = 'mckenna.tim@gmail.com'

SELECT
  devid,
  description,
  owner
FROM
  `devices`
WHERE
  owner ='tim@sitebuilt.net'
ORDER BY
  devid;
-- last is it
SELECT
  d.userid,
  d.devid,
  e.description AS devdesc,
  d.bizid,
  d.appid,
  d.role,
  d.auth
FROM
  `devuserapp` d
LEFT JOIN
  `devices` e ON d.devid = e.devid
WHERE
  d.userid = 'tim@sitebuilt.net'
AND
(d.appid='admin' OR d.appid='super')

SELECT
  d.userid,
  d.devid,
  e.description AS devdesc,
  d.bizid,
  d.appid,
  d.role,
  d.auth
FROM
  `devuserapp` d
LEFT JOIN
  `devices` e ON d.devid = e.devid
WHERE
  d.userid = 'mckenna.tim@gmail.com'
AND
(d.appid='admin' OR d.appid='super')

-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 09, 2018 at 03:53 PM
-- Server version: 5.7.16-0ubuntu0.16.04.1
-- PHP Version: 7.0.22-0ubuntu0.16.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `geniot`
--

-- --------------------------------------------------------

--
-- Table structure for table `scheds`
--

CREATE TABLE `scheds` (
  `id` int(11) NOT NULL,
  `devid` varchar(30) NOT NULL,
  `senrel` int(2) NOT NULL,
  `dow` int(2) NOT NULL,
  `sched` varchar(200) DEFAULT NULL,
  `until` varchar(16) NOT NULL DEFAULT '0000-00-00 00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `scheds`
--

INSERT INTO `scheds` (`id`, `devid`, `senrel`, `dow`, `sched`, `until`) VALUES
(1000, 'CYURD001', 1, 4, '[[0,0,55,53],[17,12,78,76],[20,50,56,52],[22,50,64,61]]', '0000-00-00 00:00'),
(1001, 'CYURD001', 0, 4, '[[0,0,55,53],[17,12,78,76],[20,50,56,52],[22,50,64,61]]', '0000-00-00 00:00'),
(1002, 'CYURD002', 3, 2, '[[0,0,0],[9,15,1],[9,45,0],[17,0,1],[17,56,0]]', '0000-00-00 00:00'),
(1003, 'CYURD002', 4, 0, '[[0,0,0],[9,10,1],[9,40,0],[17,0,1],[17,50,0]]', '0000-00-00 00:00'),
(1004, 'CYURD002', 4, 2, '[[0,0,0],[9,12,1],[9,44,0],[17,5,1],[17,56,0]]', '0000-00-00 00:00'),
(1005, 'CYURD002', 2, 0, '[[0,0,1]]', '0000-00-00 00:00'),
(1007, 'CYURD002', 3, 0, '[[0,0,1]]', '0000-00-00 00:00'),
(1008, 'CYURD001', 1, 5, '[[0,0,77,75]]', '0000-00-00 00:00'),
(1009, 'CYURD003', 0, 0, '[[0,0,55,53],[20,12,78,76],[22,50,56,52],[23,50,64,61]]', '0000-00-00 00:00'),
(1010, 'CYURD003', 1, 0, '[[0,0,55,53],[20,12,78,76],[22,50,56,52],[23,50,64,61]]', '0000-00-00 00:00'),
(1011, 'CYURD001', 1, 0, '[[0,0,55,53],[20,12,78,76],[22,50,56,52],[23,50,64,61]]', '0000-00-00 00:00'),
(1012, 'CYURD001', 0, 0, '[[0,0,55,53],[20,12,78,76],[22,50,56,52],[23,50,64,61]]', '0000-00-00 00:00'),
(1015, 'CYURD001', 1, 2, '[[0,0,58,54],[12,20,77,75]]', '0000-00-00 00:00'),
(1016, 'CYURD001', 0, 8, '[[0,0,55,53]]', '2018-06-02 10:15');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `scheds`
--
ALTER TABLE `scheds`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `main` (`devid`,`senrel`,`dow`) USING BTREE,
  ADD KEY `devid` (`devid`),
  ADD KEY `dow` (`dow`),
  ADD KEY `senrel` (`senrel`),
  ADD KEY `until` (`until`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `scheds`
--
ALTER TABLE `scheds`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1019;

SELECT * FROM `scheds` ORDER BY devid, senrel, dow 

DROP TABLE IF EXISTS `heirlooms`;
CREATE TABLE `heirlooms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `color` varchar(20) NOT NULL,
  `amt` int(2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `color` (`color`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1  ;

INSERT INTO `heirlooms` (name, color, amt) VALUES
("Black Prince", "black",6),
("Brandywine", "red",6),
("Yellow Brandywine ", "yellow",6),
("Cherokee Purple","purple",6),
("Cherokee Green","green",6),
("Rose","blue",6),
("Great White","white",6),
("Moskvich","brown",6),
("Valencia","orange",6),
("Striped German", "pink",6),
("Subartic Plenty","grey",6)


DROP TABLE IF EXISTS `hepeop`;
CREATE TABLE `hepeop` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `selected` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1  ;


UPDATE heirlooms Set amt=4


Select name, color from heirlooms Where id in [2,4]

INSERT INTO hepeop
SET `name` = 'mckenna.tim@gmail.com',
    `selected` = '[0,0,0,1,1,0,0,0,0,1,0]'
ON DUPLICATE KEY
UPDATE 
    `name` = 'mckenna.tim@gmail.com',
    `selected` = '[1,1,0,1,1,0,0,0,0,1,0]'

INSERT INTO scheds
SET 
`devid` = 'CYURD001',
`senrel` = 1,
`dow` = 4,
`sched` = '[[0,0,55,53],[17,12,78,76],[20,50,56,52],[22,50,64,61]]'
ON DUPLICATE KEY
UPDATE 
`devid` = 'CYURD001',
`senrel` = 1,
`dow` = 4,
`sched` = '[[0,0,55,53],[17,12,78,76],[20,50,56,52],[22,50,64,61]]'    

SELECT devid
FROM devs
WHERE devid LIKE 'CYURD%'
ORDER BY devid DESC LIMIT 1

ALTER TABLE `roleapp` CHANGE `appid` `task` VARCHAR(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL;

INSERT INTO `scheds` (`devid`, `senrel`, `dow`, `sched`, `until`) VALUES
('CYURD030', 0, 0, '[[0,0,55,53],[17,12,78,76],[20,50,56,52],[22,50,64,61]]', '0000-00-00 00:00');


SELECT * FROM devs WHERE devid = 'CYURD030' OR devid = 'CYURD006';

SELECT devid, `description`, `server`, specs, `owner` FROM devs WHERE devid IN ('CYURD030','CYURD006');

SELECT 24 & 12;

INSERT INTO `scheds` (`devid`, `senrel`, `dow`, `sched`, `until`, `season`) VALUES
('CYURD333', 0, 0, '[[0,0,55,53],[17,12,78,76],[20,50,56,52],[22,50,64,61]]', '0000-00-00 00:00', 'current'),
('CYURD333', 0, 96, '[[0,0,55,53],[20,50,56,52],[22,50,64,61]]', '0000-00-00 00:00', 'current'),
('CYURD333', 0, 31, '[[0,0,55,53],[4,12,78,76],[20,50,56,52],[22,50,64,61]]', '0000-00-00 00:00', 'current'),
('CYURD333', 0, 21, '[[0,0,55,53],[5,12,78,76],[20,50,56,52],[22,50,64,61]]', '0000-00-00 00:00', 'current'),
('CYURD333', 0, 12, '[[0,0,55,53],[6,12,78,76],[20,50,56,52],[22,50,64,61]]', '0000-00-00 00:00', 'current'),
('CYURD333', 0, 128, '[[0,0,55,53],[7,12,78,76],[20,50,56,52],[22,50,64,61]]', '0000-00-00 00:00', 'current'),
('CYURD333', 0, 2, '[[0,0,55,53],[8,12,78,76],[20,50,56,52],[22,50,64,61]]', '0000-00-00 00:00', 'current'),
('CYURD333', 0, 4, '[[0,0,55,53],[9,12,78,76],[20,50,56,52],[22,50,64,61]]', '0000-00-00 00:00', 'current'),
('CYURD333', 0, 8, '[[0,0,55,53],[10,12,78,76],[20,50,56,52],[22,50,64,61]]', '0000-00-00 00:00', 'current'),
('CYURD333', 0, 16, '[[0,0,55,53],[11,12,78,76],[20,50,56,52],[22,50,64,61]]', '0000-00-00 00:00', 'current'),
('CYURD333', 0, 32, '[[0,0,55,53],[12,12,78,76],[20,50,56,52],[22,50,64,61]]', '0000-00-00 00:00', 'current'),
('CYURD333', 0, 64, '[[0,0,55,53],[13,12,78,76],[20,50,56,52],[22,50,64,61]]', '0000-00-00 00:00', 'current');

DELETE from `scheds` WHERE devid='CYURD333';

SELECT * FROM scheds 
WHERE (devid,senrel,dow) 
IN ( 
  SELECT devid, senrel, MAX(dow) 
  FROM scheds 
  WHERE (dow=0 OR dow & POW(2,3) OR dow>=128) 
  AND (until = '0000-00-00 00:00' OR '2018-03-12' <= until) 
  GROUP BY devid, senrel 
  ) 
AND devid = 'CYURD333';

SELECT * FROM scheds WHERE (devid,senrel,dow) IN ( SELECT devid, senrel, MAX(dow) FROM scheds WHERE (dow=0 OR dow & POW(2,3) OR dow>=128) AND (until = '0000-00-00 00:00' OR '2018-03-12' <= until) GROUP BY devid, senrel ) AND devid = 'CYURD333'

SELECT * FROM scheds WHERE (devid,senrel,dow) IN ( SELECT devid, senrel, MAX(dow) FROM scheds WHERE (dow=0 OR dow & POW(2,?) OR dow>=128) AND (until = '0000-00-00 00:00' OR '2018-03-12' <= until) GROUP BY devid, senrel ) AND devid = ?

INSERT INTO `scheds` (`devid`, `senrel`, `dow`, `sched`, `until`, `season`) VALUES
('CYURD030', 1, 96, '[[0,0,55,53],[20,50,56,52],[22,50,64,61]]', '0000-00-00 00:00', 'current'),
('CYURD030', 1, 31, '[[0,0,55,53],[4,12,78,76],[20,50,56,52],[22,50,64,61]]', '0000-00-00 00:00', 'current');

SELECT * FROM scheds WHERE devid='CYURD030' AND senrel=1;
SELECT * FROM scheds WHERE devid=? AND senrel=?;


DROP TABLE IF EXISTS `bigdata`;
CREATE TABLE `bigdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dev` varchar(30) NOT NULL,
  `sr` int(2) NOT NULL,
  `temp` int(3) DEFAULT NULL,
  `setpt` int(3) DEFAULT NULL,
  `calling` boolean NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `devsr` (`dev`, `sr`),
  KEY `timestamp` (`timestamp`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1000 ;

INSERT INTO `bigdata` (`dev`, `sr`, temp, setpt, calling) VALUES
('CYURD030', 0, 67, 70, false),
('CYURD030', 4, null, null,0);

INSERT INTO `bigdata` (`dev`, `sr`, temp, setpt, calling) VALUES
('CYURD030', 0, 67, 70, 1),
('CYURD030', 4, null, '',1);

SELECT * FROM scheds WHERE (devid,senrel,dow) IN ( SELECT devid, senrel, MAX(dow) FROM scheds WHERE (dow=0 OR dow & POW(2,?-1)  GROUP BY devid, senrel, dow ) AND devid = ?


SELECT devid, senrel, MAX(dow) FROM scheds WHERE (dow=0 OR dow & POW(2,4-1)) 
GROUP BY devid, senrel

SELECT sched FROM scheds WHERE (devid,senrel,dow) IN (
SELECT devid, senrel, MAX(dow) FROM scheds 
WHERE (dow=0 OR dow & POW(2,4-1)) 
GROUP BY devid, senrel) 
AND devid ='CYURD030'
AND senrel = 1


SELECT dev,sr,temp,setpt, calling,`timestamp` FROM `bigdata` ORDER BY id desc LIMIT 20

SELECT dev,sr,temp,setpt, calling,`timestamp` FROM `bigdata` WHERE (timestamp BETWEEN '2019-11-07T23:14' AND '2019-11-08T13:01') AND dev IN ("CYURD030", "CYURD006")

SELECT dev,sr,temp,setpt, calling,`timestamp` FROM `bigdata` WHERE (timestamp BETWEEN ? AND ?) AND dev IN (?)

SELECT dev,sr,temp,setpt, calling,`timestamp` FROM `bigdata` WHERE (timestamp BETWEEN '2019-11-12T18:29:39' AND '2019-11-14T20:29:39') AND dev IN ('CYURD030', 'CYURD006')

SELECT dev,sr,temp,setpt, calling,`timestamp` FROM `bigdata` WHERE (timestamp BETWEEN '2019-11-12T18:29:39' AND '2019-11-14T20:29:39') AND dev IN ('CYURD030', 'CYURD006');


INSERT INTO `devs` (`id`, `devid`, `devpwd`, `description`, `bizid`, `locid`, `server`, `specs`, `owner`, `apps`) VALUES (NULL, 'CYURD071', 'geniot', 'thermostat relay/sensors 1, timer 1.', 'sbs', '12ParleyVale', '{ "url": "sitebuilt.net", "mqtt": 1884, "express": 3333 }', '{ "HAStIMER": 16, "notTimerTags": [ "temp", "onoff", "hilimit", "lolimit" ], "hysteresis": 2, "reportEvery": 5, "software_version": "espboth/hvac", "hardware_version": "d1_wemos", "sr": [ { "srid": 0, "haysensor": { "senses": "temp", "model": "DS18B20" }, "hayrelay": { "controlled": 1, "defsched": [ 0, 0, 55, 52 ] } }, { "srid": 4, "hayrelay": { "controlled": 0, "defsched": [ [ 0, 0, 1 ] ] }, "haysensor": 0 } ] }', 'tim@sitebuilt.net', NULL)


DROP TABLE IF EXISTS `ssaRA`;
CREATE TABLE IF NOT EXISTS `ssaRA` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rwhat` char(2) ,
  `ein` char(9) NOT NULL,
  `agein` char(9) NOT NULL,
  `sched` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `main` (`devid`,`senrel`,`until`) USING BTREE,
  KEY `devid` (`devid`),
  KEY `senrel` (`senrel`),
  KEY `until` (`until`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `holds`(`devid`, `senrel`, `until`, `sched`) 
VALUES ('CYURD001',0,'2018-02-15 00:00','[[0,0,72,74]]')

DROP TABLE IF EXISTS `ssaRE`;
CREATE TABLE IF NOT EXISTS `ssaRE` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rwhat` char(2) DEFAULT 'RE',
  `taxyear` char(4) NOT NULL, 
  `agic` char(1) NOT NULL DEFAULT ' ',
  `ein` char(9)  NOT NULL,
  `agein` char(9)  NOT NULL DEFAULT '         ' ,
  `tbi` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `ssaRE`(`taxyear`, `ein`) 
VALUES ('2019','222333445');

select * from ssaRE;