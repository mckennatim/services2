other sql files...
/tmstack/hsc/sql/sql.sql


CREATE TABLE IF NOT EXISTS `bizapp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bizid` varchar(20) DEFAULT NULL,
  `appid` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bizid` (`bizid`),
  KEY `appid` (`appid`),
  UNIQUE KEY `main` (`bizid`, `appid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=145 ;

CREATE TABLE IF NOT EXISTS `devuserapp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `devid` varchar(30) DEFAULT NULL,
  `userid` varchar(24) NOT NULL,
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=145 ;

CREATE TABLE IF NOT EXISTS `devices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `devid` varchar(30) NOT NULL,
  `devpwd` varchar(24) DEFAULT NULL,
  `bizid` varchar(20) DEFAULT NULL,
  `description` varchar(220) DEFAULT NULL,
  `server` varchar(120) DEFAULT NULL,
  `sensortype` varchar(20) DEFAULT NULL,
  `owner` varchar(30) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `zipcode` varchar(12) DEFAULT NULL,
  `timezone` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `devid` (`devid`),
  KEY `bizid` (`bizid`),
  KEY `sensortype` (`sensortype`),
  KEY `owner` (`owner`),
  KEY `zipcode` (`zipcode`),
  KEY `timezone` (`timezone`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=145 ;

CREATE TABLE IF NOT EXISTS `apps` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `appid` varchar(20) NOT NULL,
  `appurl` varchar(30) DEFAULT NULL,
  `apiurl` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `appid` (`appid`),
  KEY `appurl` (`appurl`),
  KEY `apiurl` (`apiurl`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=145 ;

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=145 ;

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
-- last is it
