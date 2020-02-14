/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: bids
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `bids` (
  `id` int(11) NOT NULL DEFAULT '0',
  `coid` varchar(20) DEFAULT 'reroo',
  `job` varchar(65) DEFAULT '',
  `material` varchar(10) DEFAULT '',
  `labor` varchar(10) DEFAULT '',
  `subs` varchar(10) DEFAULT '',
  `equip` varchar(10) DEFAULT '',
  `overhead` varchar(10) DEFAULT '',
  `contingency` varchar(10) DEFAULT '',
  `profit` varchar(10) DEFAULT ''
) ENGINE = InnoDB DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: co
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `co` (
  `id` int(11) NOT NULL DEFAULT '0',
  `goodtil` datetime DEFAULT '2017-12-31 00:00:00',
  `coid` varchar(20) DEFAULT '',
  `name` varchar(40) DEFAULT '',
  `street` varchar(100) DEFAULT '',
  `city` varchar(50) DEFAULT '',
  `st` varchar(2) DEFAULT 'MA',
  `zip` varchar(10) DEFAULT '',
  `fedein` varchar(20) NOT NULL DEFAULT '',
  `stein` varchar(20) NOT NULL DEFAULT ''
) ENGINE = InnoDB DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: cosr
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `cosr` (
  `id` int(11) NOT NULL DEFAULT '0',
  `coid` varchar(20) DEFAULT '',
  `wcrate` decimal(4, 4) DEFAULT '0.0620',
  `wcrateadmin` decimal(4, 4) NOT NULL DEFAULT '0.0250',
  `stuirate` decimal(4, 4) DEFAULT '0.0520',
  `firstday` int(2) DEFAULT '1',
  `otrate` decimal(3, 2) NOT NULL DEFAULT '1.50',
  `sarate` decimal(3, 2) NOT NULL DEFAULT '1.00',
  `surate` decimal(3, 2) NOT NULL DEFAULT '1.00',
  `ot` varchar(120) DEFAULT '{over40:1.5, sa:1, su:1}',
  `effective` date DEFAULT '2018-01-01',
  `healthFICAded` varchar(1) NOT NULL DEFAULT '1',
  `retireFICAded` varchar(1) NOT NULL DEFAULT '0'
) ENGINE = InnoDB DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: gl
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `gl` (
  `id` int(11) NOT NULL DEFAULT '0',
  `coid` varchar(20) DEFAULT '',
  `account` varchar(20) DEFAULT '',
  `wdprt` varchar(12) DEFAULT '',
  `job` varchar(60) DEFAULT '',
  `cat` varchar(40) DEFAULT '',
  `date` date DEFAULT NULL,
  `someid` varchar(60) DEFAULT '',
  `somenum` decimal(6, 2) DEFAULT '0.00',
  `debit` decimal(9, 2) DEFAULT '0.00',
  `credit` decimal(9, 2) DEFAULT '0.00'
) ENGINE = InnoDB DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: jobcatact
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `jobcatact` (
  `id` int(11) NOT NULL DEFAULT '0',
  `job` varchar(60) CHARACTER SET utf8 DEFAULT NULL,
  `category` varchar(60) CHARACTER SET utf8 DEFAULT '',
  `active` int(1) DEFAULT NULL,
  `week` int(2) NOT NULL DEFAULT '0',
  `idx` int(11) DEFAULT NULL,
  `coid` varchar(20) CHARACTER SET utf8 DEFAULT NULL
) ENGINE = InnoDB DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: persons
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `persons` (
  `id` int(11) NOT NULL DEFAULT '0',
  `coid` varchar(20) DEFAULT '',
  `effective` date DEFAULT '2017-12-31',
  `emailid` varchar(60) DEFAULT '',
  `firstmid` varchar(60) DEFAULT '',
  `lastname` varchar(40) DEFAULT '',
  `street` varchar(100) DEFAULT '',
  `city` varchar(50) DEFAULT '',
  `st` varchar(2) DEFAULT 'MA',
  `zip` varchar(10) DEFAULT '',
  `locality` varchar(100) NOT NULL DEFAULT '',
  `phone` varchar(13) NOT NULL DEFAULT '',
  `emerperson` varchar(60) NOT NULL DEFAULT '',
  `emerphone` varchar(13) NOT NULL DEFAULT '',
  `ssn` varchar(11) DEFAULT '',
  `wtype` varchar(20) NOT NULL DEFAULT '1099',
  `weeklybase` decimal(6, 2) DEFAULT '0.00',
  `haystatewh` tinyint(1) NOT NULL DEFAULT '1',
  `haylocalwh` tinyint(1) NOT NULL DEFAULT '0',
  `marital` varchar(20) NOT NULL DEFAULT 'marASsingl',
  `w4allow` int(2) DEFAULT '3',
  `w4add` int(3) DEFAULT '0',
  `w4exempt` tinyint(4) NOT NULL DEFAULT '0',
  `stallow` int(2) DEFAULT '1',
  `stadd` int(3) DEFAULT '0',
  `student` tinyint(4) NOT NULL DEFAULT '0',
  `sthoh` int(1) DEFAULT '0',
  `stblind` int(1) DEFAULT '0',
  `localallow` tinyint(4) NOT NULL DEFAULT '0',
  `rate` decimal(8, 2) DEFAULT '15.00',
  `vacation` varchar(2) NOT NULL DEFAULT '0',
  `holiday` varchar(2) NOT NULL DEFAULT '0',
  `personal` varchar(2) NOT NULL DEFAULT '0',
  `pto` varchar(2) NOT NULL DEFAULT '0',
  `healthemp` varchar(7) NOT NULL DEFAULT '0.00',
  `healthco` varchar(7) NOT NULL DEFAULT '0.00',
  `k401emp` varchar(7) NOT NULL DEFAULT '0.00',
  `k401co` varchar(7) NOT NULL DEFAULT '0.00'
) ENGINE = InnoDB DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rolewho
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `rolewho` (
  `id` int(11) NOT NULL DEFAULT '0',
  `role` varchar(20) DEFAULT NULL,
  `emailid` varchar(60) DEFAULT NULL,
  `coid` varchar(20) DEFAULT NULL,
  `active` int(1) NOT NULL DEFAULT '1'
) ENGINE = InnoDB DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: bids
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: co
# ------------------------------------------------------------

INSERT INTO
  `co` (
    `id`,
    `goodtil`,
    `coid`,
    `name`,
    `street`,
    `city`,
    `st`,
    `zip`,
    `fedein`,
    `stein`
  )
VALUES
  (
    34,
    '2018-12-31 00:00:00',
    'tim4co',
    '',
    '',
    '',
    'MA',
    '',
    '',
    ''
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: cosr
# ------------------------------------------------------------

INSERT INTO
  `cosr` (
    `id`,
    `coid`,
    `wcrate`,
    `wcrateadmin`,
    `stuirate`,
    `firstday`,
    `otrate`,
    `sarate`,
    `surate`,
    `ot`,
    `effective`,
    `healthFICAded`,
    `retireFICAded`
  )
VALUES
  (
    75,
    'tim4co',
    0.0620,
    0.0250,
    0.0520,
    1,
    1.50,
    1.00,
    1.00,
    '{over40:1.5, sa:1, su:1}',
    '2018-10-30',
    '1',
    '0'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: gl
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: jobcatact
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: persons
# ------------------------------------------------------------

INSERT INTO
  `persons` (
    `id`,
    `coid`,
    `effective`,
    `emailid`,
    `firstmid`,
    `lastname`,
    `street`,
    `city`,
    `st`,
    `zip`,
    `locality`,
    `phone`,
    `emerperson`,
    `emerphone`,
    `ssn`,
    `wtype`,
    `weeklybase`,
    `haystatewh`,
    `haylocalwh`,
    `marital`,
    `w4allow`,
    `w4add`,
    `w4exempt`,
    `stallow`,
    `stadd`,
    `student`,
    `sthoh`,
    `stblind`,
    `localallow`,
    `rate`,
    `vacation`,
    `holiday`,
    `personal`,
    `pto`,
    `healthemp`,
    `healthco`,
    `k401emp`,
    `k401co`
  )
VALUES
  (
    154,
    'tim4co',
    '2018-10-30',
    'tim4@sitebuilt.net',
    'S.',
    'MCKENNA',
    '12 Parley Vale',
    'Jamaica Plain',
    'MA',
    '02130',
    '',
    '',
    '',
    '',
    '',
    'hourly',
    0.00,
    1,
    0,
    'marASsingl',
    3,
    0,
    0,
    1,
    0,
    0,
    0,
    0,
    0,
    15.00,
    '10',
    '10',
    '2',
    '0',
    '23.00',
    '33.00',
    '33.00',
    '22.00'
  );
INSERT INTO
  `persons` (
    `id`,
    `coid`,
    `effective`,
    `emailid`,
    `firstmid`,
    `lastname`,
    `street`,
    `city`,
    `st`,
    `zip`,
    `locality`,
    `phone`,
    `emerperson`,
    `emerphone`,
    `ssn`,
    `wtype`,
    `weeklybase`,
    `haystatewh`,
    `haylocalwh`,
    `marital`,
    `w4allow`,
    `w4add`,
    `w4exempt`,
    `stallow`,
    `stadd`,
    `student`,
    `sthoh`,
    `stblind`,
    `localallow`,
    `rate`,
    `vacation`,
    `holiday`,
    `personal`,
    `pto`,
    `healthemp`,
    `healthco`,
    `k401emp`,
    `k401co`
  )
VALUES
  (
    156,
    'tim4co',
    '2018-10-30',
    'tim5@sitebuilt.net',
    '',
    'tim5',
    '',
    '',
    'MA',
    '',
    '',
    '',
    '',
    '',
    '',
    'hourly',
    0.00,
    1,
    0,
    '',
    1,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    15.00,
    '0',
    '0',
    '0',
    '0',
    '0.00',
    '0.00',
    '0.00',
    '0.00'
  );
INSERT INTO
  `persons` (
    `id`,
    `coid`,
    `effective`,
    `emailid`,
    `firstmid`,
    `lastname`,
    `street`,
    `city`,
    `st`,
    `zip`,
    `locality`,
    `phone`,
    `emerperson`,
    `emerphone`,
    `ssn`,
    `wtype`,
    `weeklybase`,
    `haystatewh`,
    `haylocalwh`,
    `marital`,
    `w4allow`,
    `w4add`,
    `w4exempt`,
    `stallow`,
    `stadd`,
    `student`,
    `sthoh`,
    `stblind`,
    `localallow`,
    `rate`,
    `vacation`,
    `holiday`,
    `personal`,
    `pto`,
    `healthemp`,
    `healthco`,
    `k401emp`,
    `k401co`
  )
VALUES
  (
    161,
    'tim4co',
    '2018-09-11',
    'tim5@sitebuilt.net',
    '',
    'tim5',
    '',
    '',
    'MA',
    '',
    '',
    '',
    '',
    '',
    '',
    'hourly',
    0.00,
    1,
    0,
    '',
    1,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    15.00,
    '0',
    '0',
    '0',
    '0',
    '0.00',
    '0.00',
    '0.00',
    '0.00'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rolewho
# ------------------------------------------------------------

INSERT INTO
  `rolewho` (`id`, `role`, `emailid`, `coid`, `active`)
VALUES
  (153, 'partner', 'tim4@sitebuilt.net', 'tim4co', 1);
INSERT INTO
  `rolewho` (`id`, `role`, `emailid`, `coid`, `active`)
VALUES
  (154, 'hr', 'tim5@sitebuilt.net', 'tim4co', 1);

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
