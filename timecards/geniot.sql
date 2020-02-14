-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jan 16, 2018 at 03:19 PM
-- Server version: 5.7.16-0ubuntu0.16.04.1
-- PHP Version: 7.0.22-0ubuntu0.16.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `geniot`
--

-- --------------------------------------------------------

--
-- Table structure for table `apps`
--

CREATE TABLE `apps` (
  `id` int(11) NOT NULL,
  `appid` varchar(20) NOT NULL,
  `appurl` varchar(30) DEFAULT NULL,
  `apiurl` varchar(30) DEFAULT NULL,
  `desc` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `apps`
--

INSERT INTO `apps` (`id`, `appid`, `appurl`, `apiurl`, `desc`) VALUES
(1, 'admind', NULL, NULL, NULL),
(2, 'shroom', NULL, NULL, NULL),
(3, 'pahoRawSB', NULL, NULL, NULL),
(4, 'cascada', NULL, NULL, NULL),
(5, 'hvac', NULL, NULL, NULL),
(6, 'lightsoff', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `biz`
--

CREATE TABLE `biz` (
  `id` int(11) NOT NULL,
  `bizid` varchar(20) NOT NULL,
  `bizname` varchar(120) DEFAULT NULL,
  `owner` varchar(40) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `location` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `bizapp`
--

CREATE TABLE `bizapp` (
  `id` int(11) NOT NULL,
  `bizid` varchar(20) DEFAULT NULL,
  `appid` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bizapp`
--

INSERT INTO `bizapp` (`id`, `bizid`, `appid`) VALUES
(300, 'sbs', 'admin'),
(332, 'sbs', 'cascada'),
(331, 'sbs', 'cascada_hs'),
(377, 'sbs', 'hvac'),
(314, 'sbs', 'lightsoff'),
(353, 'sbs', 'pahoRawSB'),
(360, 'sbs', 'shroom'),
(301, 'sbs', 'user');

-- --------------------------------------------------------

--
-- Table structure for table `devices`
--

CREATE TABLE `devices` (
  `id` int(11) NOT NULL,
  `devid` varchar(30) NOT NULL,
  `devpwd` varchar(24) DEFAULT NULL,
  `description` varchar(220) DEFAULT NULL,
  `bizid` varchar(20) DEFAULT NULL,
  `address` varchar(120) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `timezone` varchar(40) DEFAULT NULL,
  `server` varchar(300) DEFAULT NULL,
  `specs` varchar(120) DEFAULT NULL,
  `owner` varchar(60) DEFAULT NULL,
  `apps` varchar(300) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `devices`
--

INSERT INTO `devices` (`id`, `devid`, `devpwd`, `description`, `bizid`, `address`, `location`, `timezone`, `server`, `specs`, `owner`, `apps`) VALUES
(100, 'CYURD001', 'geniot', '2 temps, 3 timers 1 relay demo board', 'sbs', '12 Parley Vale, Boston, MA 02130, USA', '{"lat":42.3150229,"lng":-71.111138}', 'America/New_York', '{"url":"10.0.1.105","mqtt":1883,"express":3332}', '{"HAStIMER":28,"notTimerTags":["temp","onoff","hilimit","lolimit"]}', 'tim@sitebuilt.net', '["admin", "user", "pahoRawSB"]'),
(101, 'CYURD007', 'geniot', '2 temps, 3 timers 1 relay demo board', 'sbs', '255 Chestnut Ave, Jamaica Plain, MA 02130, USA', '{"lat":42.31381409999999,"lng":-71.10874749999999}', 'America/New_York', '{"mqtt_server":"sitebuilt.net","mqtt_port":"1884","sensor_type":""}', '{"HAStIMER":28,"notTimerTags":["temp","onoff","hilimit","lolimit"]}', 'tim@sitebuilt.net', '["admin", "user"]'),
(102, 'CYURBAD', 'nopwd', NULL, 'sbs', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(103, 'CYURD008', 'geniot', '2 temps, 3 timers 1 relay demo board', 'sbs', '12 Parley Vale, Boston, MA 02130, USA', '{"lat":42.3150229,"lng":-71.111138}', 'America/New_York', '{"url":"sitebuilt.net","mqtt":1884,"express":4332}', '{"HAStIMER":28,"notTimerTags":["temp","onoff","hilimit","lolimit"]}', 'tim@sitebuilt.net', '["admin", "user"]'),
(104, 'CYURD003', 'geniot', 'DHT 3 timers 1 temp 1 humidity greenhouse control', 'sbs', '12 Parley Vale, Boston, MA 02130, USA', '{"lat":42.3150229,"lng":-71.111138}', 'America/New_York', '{"mqtt_server":"sitebuilt.net","mqtt_port":"1884","sensor_type":"dht"}', '{"HAStIMER":28,"notTimerTags":["temp","onoff","hilimit","lolimit"]}', 'tim@sitebuilt.net', '["admin", "user", "shroom", "hvac"]'),
(107, 'CYURD006', 'geniot', 'just tem sensor', 'sbs', '12 Parley Vale, Boston, MA 02130, USA', '{"lat":42.3150229,"lng":-71.111138}', 'America/New_York', '{"mqtt_server":"sitebuilt.net","mqtt_port":"1884","sensor_type":""}', '{"HAStIMER":28,"notTimerTags":["temp","onoff","hilimit","lolimit"]}', 'tim@sitebuilt.net', '["admin", "user", "lightsoff", "shroom"]'),
(108, 'CYURD004', 'geniot', 'DHT temp, humidity 1 relay greenhouse lights', 'sbs', '12 Parley Vale, Boston, MA 02130, USA', '{"lat":42.3150229,"lng":-71.111138}', 'America/New_York', '{"mqtt_server":"sitebuilt.net","mqtt_port":"1884","sensor_type":"DHT"}', '{"HAStIMER":28,"notTimerTags":["temp","onoff","hilimit","lolimit"]}', 'tim@sitebuilt.net', '["admin", "user", "lightsoff"]'),
(109, 'CYURD002', 'geniot', 'cascada 3 timers 3 relays', 'sbs', '12 Parley Vale, Boston, MA 02130, USA', '{"lat":42.3150229,"lng":-71.111138}', 'America/New_York', '{"url":"sitebuilt.net","mqtt":1884,"express":3333}', '{"HAStIMER":28,"notTimerTags":["temp","onoff","hilimit","lolimit"]}', 'tim@sitebuilt.net', '["admin", "user", "pahoRawSB", "cascada"]'),
(123, 'CYURD017', 'geniot', '2 temps, 3 timers 1 relay demo board', 'sbs', '7940 48th Ave S, Seattle, WA 98118, USA', '{"lat":47.5303635,"lng":-122.2724899}', 'America/Los_Angeles', '{"mqtt_server":"sitebuilt.net","mqtt_port":"1884","sensor_type":""}', '{"HAStIMER":28,"notTimerTags":["temp","onoff","hilimit","lolimit"]}', 'tim@sitebuilt.net', '["admin", "hvac"]'),
(124, 'CYURD018', 'geniot', '2 temps, 3 timers 1 relay demo board', 'sbs', '4505 N Haight Ave, Portland, OR 97217, USA', '{"lat":45.5555363,"lng":-122.6703647}', 'America/Los_Angeles', '{"mqtt_server":"sitebuilt.net","mqtt_port":"1884","sensor_type":""}', '{"HAStIMER":28,"notTimerTags":["temp","onoff","hilimit","lolimit"]}', 'tim@sitebuilt.net', '["admin", "hvac"]');

-- --------------------------------------------------------

--
-- Table structure for table `devs`
--

CREATE TABLE `devs` (
  `id` int(11) NOT NULL,
  `devid` varchar(30) NOT NULL,
  `devpwd` varchar(24) DEFAULT NULL,
  `description` varchar(220) DEFAULT NULL,
  `bizid` varchar(20) DEFAULT NULL,
  `locid` varchar(20) DEFAULT NULL,
  `server` varchar(120) DEFAULT NULL,
  `specs` varchar(120) DEFAULT NULL,
  `owner` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `devs`
--

INSERT INTO `devs` (`id`, `devid`, `devpwd`, `description`, `bizid`, `locid`, `server`, `specs`, `owner`) VALUES
(1, 'CYURD001', 'geniot', '2 temps, 3 timers 1 relay demo board', 'sbs', '12ParleyVale', '{"url":"10.0.1.105","mqtt":1883,"express":3332}', '{"HAStIMER":28,"notTimerTags":["temp","onoff","hilimit","lolimit"]}', 'tim@sitebuilt.net'),
(2, 'CYURD007', 'geniot', '2 temps, 3 timers 1 relay demo board', 'sbs', '12ParleyVale', '{"mqtt_server":"sitebuilt.net","mqtt_port":"1884","sensor_type":""}', '{"HAStIMER":28,"notTimerTags":["temp","onoff","hilimit","lolimit"]}', 'tim@sitebuilt.net'),
(3, 'CYURBAD', 'nopwd', NULL, 'sbs', '12ParleyVale', NULL, NULL, NULL),
(4, 'CYURD008', 'geniot', '2 temps, 3 timers 1 relay demo board', 'sbs', '12ParleyVale', '{"url":"sitebuilt.net","mqtt":1884,"express":4332}', '{"HAStIMER":28,"notTimerTags":["temp","onoff","hilimit","lolimit"]}', 'tim@sitebuilt.net'),
(5, 'CYURD003', 'geniot', 'DHT 3 timers 1 temp 1 humidity greenhouse control', 'sbs', '12ParleyVale', '{"mqtt_server":"sitebuilt.net","mqtt_port":"1884","sensor_type":"dht"}', '{"HAStIMER":28,"notTimerTags":["temp","onoff","hilimit","lolimit"]}', 'tim@sitebuilt.net'),
(6, 'CYURD006', 'geniot', 'just tem sensor', 'sbs', '12ParleyVale', '{"mqtt_server":"sitebuilt.net","mqtt_port":"1884","sensor_type":""}', '{"HAStIMER":28,"notTimerTags":["temp","onoff","hilimit","lolimit"]}', 'tim@sitebuilt.net'),
(7, 'CYURD004', 'geniot', 'DHT temp, humidity 1 relay greenhouse lights', 'sbs', '12ParleyVale', '{"mqtt_server":"sitebuilt.net","mqtt_port":"1884","sensor_type":"DHT"}', '{"HAStIMER":28,"notTimerTags":["temp","onoff","hilimit","lolimit"]}', 'tim@sitebuilt.net'),
(8, 'CYURD002', 'geniot', 'cascada 3 timers 3 relays', 'sbs', '12ParleyVale', '{"url":"sitebuilt.net","mqtt":1884,"express":3333}', '{"HAStIMER":28,"notTimerTags":["temp","onoff","hilimit","lolimit"]}', 'tim@sitebuilt.net');

-- --------------------------------------------------------

--
-- Table structure for table `devuserapp`
--

CREATE TABLE `devuserapp` (
  `id` int(11) NOT NULL,
  `devid` varchar(30) DEFAULT NULL,
  `userid` varchar(24) NOT NULL,
  `bizid` varchar(20) DEFAULT NULL,
  `appid` varchar(20) DEFAULT NULL,
  `role` varchar(20) DEFAULT NULL,
  `auth` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `devuserapp`
--

INSERT INTO `devuserapp` (`id`, `devid`, `userid`, `bizid`, `appid`, `role`, `auth`) VALUES
(200, 'CYURD14I', 'mckenna.tim@gmail.com', 'sbs', 'super', 'super', 1),
(201, 'CYURD14I', 'mckenna.tim@gmail.com', 'sbs', 'admin', 'admin', 1),
(202, 'CYURD14I', 'mckenna.tim@gmail.com', 'sbs', 'tauth_lo', 'admin', 1),
(203, 'CYURD001', 'tim@sitebuilt.net', 'sbs', 'admin', 'admin', 1),
(204, 'CYURD001', 'tim@sitebuilt.net', 'sbs', 'user', 'admin', NULL),
(209, 'CYURD007', 'tim@sitebuilt.net', 'sbs', 'admin', 'admin', 1),
(210, 'CYURD007', 'tim@sitebuilt.net', 'sbs', 'user', 'admin', NULL),
(213, 'CYURD14I', 'mckenna.tim@gmail.com', 'sbs', 'pahoRawSB', 'admin', 1),
(216, 'CYURD14I', 'mckenna.tim@gmail.com', 'sbs', 'tauth', 'admin', 1),
(217, 'CYURD008', 'tim@sitebuilt.net', 'sbs', 'admin', 'admin', 1),
(218, 'CYURD008', 'tim@sitebuilt.net', 'sbs', 'user', 'admin', NULL),
(222, 'CYURD003', 'tim@sitebuilt.net', 'sbs', 'admin', 'admin', 1),
(223, 'CYURD003', 'tim@sitebuilt.net', 'sbs', 'user', 'admin', NULL),
(226, 'CYURD14I', 'mckenna.tim@gmail.com', 'sbs', 'tauth_hs', 'admin', 1),
(231, 'CYURD004', 'tim@sitebuilt.net', 'sbs', 'admin', 'admin', 1),
(232, 'CYURD004', 'tim@sitebuilt.net', 'sbs', 'user', 'admin', NULL),
(252, 'CYURD14I', 'mckenna.tim@gmail.com', 'sbs', 'lightsoff', 'admin', 1),
(258, 'CYURD004', 'tim@sitebuilt.net', 'sbs', 'lightsoff', 'admin', 1),
(259, 'CYURD006', 'tim@sitebuilt.net', 'sbs', 'admin', 'admin', 1),
(260, 'CYURD006', 'tim@sitebuilt.net', 'sbs', 'user', 'admin', NULL),
(261, 'CYURD006', 'tim@sitebuilt.net', 'sbs', 'lightsoff', 'admin', 1),
(276, 'CYURD002', 'tim@sitebuilt.net', 'sbs', 'admin', 'admin', 1),
(277, 'CYURD002', 'tim@sitebuilt.net', 'sbs', 'user', 'admin', NULL),
(278, 'CYURD002', 'tim@sitebuilt.net', 'sbs', 'cascada_hs', 'admin', 1),
(279, 'CYURD002', 'tim@sitebuilt.net', 'sbs', 'cascada', 'admin', 1),
(294, 'CYURD14I', 'mckenna.tim@gmail.com', 'sbs', 'cascada_hs', 'admin', 1),
(364, 'CYURD004', 'fred@sitebuilt.net', 'sbs', 'lightsoff', 'user', 1),
(366, 'CYURD004', 'tim2@sitebuilt.net', 'sbs', 'lightsoff', 'user', NULL),
(367, 'CYURD004', 'tim3@sitebuilt.net', 'sbs', 'lightsoff', 'obs', 1),
(369, 'CYURD006', 'tim3@sitebuilt.net', 'sbs', 'lightsoff', 'obs', 1),
(390, 'CYURD001', 'tim@sitebuilt.net', 'sbs', 'pahoRawSB', 'admin', 1),
(393, 'CYURD002', 'tim@sitebuilt.net', 'sbs', 'pahoRawSB', 'admin', 1),
(395, 'CYURD002', 'tim2@sitebuilt.net', 'sbs', 'pahoRawSB', 'obs', 1),
(396, 'CYURD002', 'tim2@sitebuilt.net', 'sbs', 'cascada', 'obs', 1),
(397, 'CYURD002', 'anybody', 'sbs', 'cascada', 'obs', 1),
(403, 'CYURD14I', 'mckenna.tim@gmail.com', 'sbs', 'cascada', 'admin', 1),
(410, 'CYURD002', 'perimckenna@gmail.com', 'sbs', 'cascada', 'user', 1),
(411, 'CYURD002', 'clipperjohn@gmail.com ', 'sbs', 'cascada', 'user', 1),
(412, 'CYURD002', 'clippingersue@gmail.com', 'sbs', 'cascada', 'user', NULL),
(461, 'CYURD002', 'tim3@sitebuilt.net', 'sbs', 'cascada', 'user', 1),
(500, 'CYURD003', 'tim@sitebuilt.net', 'sbs', 'shroom', 'admin', 1),
(507, 'CYURD006', 'tim@sitebuilt.net', 'sbs', 'shroom', 'admin', 1),
(514, 'CYURD14I', 'mckenna.tim@gmail.com', 'sbs', 'shroom', 'admin', 1),
(544, 'CYURD003', 'tim@sitebuilt.net', 'sbs', 'hvac', 'admin', NULL),
(572, 'CYURD017', 'tim@sitebuilt.net', 'sbs', 'admin', 'admin', NULL),
(573, 'CYURD017', 'tim@sitebuilt.net', 'sbs', 'hvac', 'admin', NULL),
(574, 'CYURD018', 'tim@sitebuilt.net', 'sbs', 'admin', 'admin', NULL),
(575, 'CYURD018', 'tim@sitebuilt.net', 'sbs', 'hvac', 'admin', NULL),
(587, 'CYURD14I', 'mckenna.tim@gmail.com', 'sbs', 'hvac', 'admin', 1);

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE `locations` (
  `id` int(11) NOT NULL,
  `locid` varchar(20) NOT NULL,
  `address` varchar(120) NOT NULL,
  `latlng` varchar(100) DEFAULT NULL,
  `timezone` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `locations`
--

INSERT INTO `locations` (`id`, `locid`, `address`, `latlng`, `timezone`) VALUES
(1000, '12ParleyVale', '12 Parley Vale, Boston, MA 02130, USA', '{"lat":42.3150229,"lng":-71.111138}', 'America/New_York'),
(1001, '255Chestnut', '255 Chestnut Ave, Jamaica Plain, MA 02130, USA', '{"lat":42.31381409999999,"lng":-71.10874749999999}', 'America/New_York'),
(1002, '794048thS', '7940 48th Ave S, Seattle, WA 98118, USA', '{"lat":47.5303635,"lng":-122.2724899}', 'America/Los_Angeles'),
(1003, '4505NHaight', '4505 N Haight Ave, Portland, OR 97217, USA', '{"lat":45.5555363,"lng":-122.6703647}', 'America/Los_Angeles');

-- --------------------------------------------------------

--
-- Table structure for table `scheds`
--

CREATE TABLE `scheds` (
  `id` int(11) NOT NULL,
  `devid` varchar(30) NOT NULL,
  `senrel` int(2) NOT NULL,
  `dow` int(2) NOT NULL,
  `sched` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `scheds`
--

INSERT INTO `scheds` (`id`, `devid`, `senrel`, `dow`, `sched`) VALUES
(1000, 'CYURD001', 1, 4, '[[12,20,77,75]]'),
(1001, 'CYURD001', 0, 4, '[[12,40,77,73]]'),
(1002, 'CYURD002', 3, 2, '[[0,0,0],[9,15,1],[9,45,0],[17,0,1],[17,56,0]]'),
(1003, 'CYURD002', 4, 0, '[[0,0,0],[9,10,1],[9,40,0],[17,0,1],[17,50,0]]'),
(1004, 'CYURD002', 4, 2, '[[0,0,0],[9,12,1],[9,44,0],[17,5,1],[17,56,0]]'),
(1005, 'CYURD002', 2, 0, '[[0,0,1]]'),
(1007, 'CYURD002', 3, 0, '[[0,0,1]]');

-- --------------------------------------------------------

--
-- Table structure for table `temp`
--

CREATE TABLE `temp` (
  `userid` varchar(24) NOT NULL,
  `devid` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `temp`
--

INSERT INTO `temp` (`userid`, `devid`) VALUES
('anybody', 'CYURBAD'),
('anybody', 'CYURD001'),
('anybody', 'CYURD002'),
('anybody', 'CYURD003'),
('anybody', 'CYURD004'),
('anybody', 'CYURD006'),
('anybody', 'CYURD007'),
('anybody', 'CYURD008'),
('clipperjohn@gmail.com ', 'CYURBAD'),
('clipperjohn@gmail.com ', 'CYURD001'),
('clipperjohn@gmail.com ', 'CYURD002'),
('clipperjohn@gmail.com ', 'CYURD003'),
('clipperjohn@gmail.com ', 'CYURD004'),
('clipperjohn@gmail.com ', 'CYURD006'),
('clipperjohn@gmail.com ', 'CYURD007'),
('clipperjohn@gmail.com ', 'CYURD008'),
('clippingersue@gmail.com', 'CYURBAD'),
('clippingersue@gmail.com', 'CYURD001'),
('clippingersue@gmail.com', 'CYURD002'),
('clippingersue@gmail.com', 'CYURD003'),
('clippingersue@gmail.com', 'CYURD004'),
('clippingersue@gmail.com', 'CYURD006'),
('clippingersue@gmail.com', 'CYURD007'),
('clippingersue@gmail.com', 'CYURD008'),
('fred@sitebuilt.net', 'CYURBAD'),
('fred@sitebuilt.net', 'CYURD001'),
('fred@sitebuilt.net', 'CYURD002'),
('fred@sitebuilt.net', 'CYURD003'),
('fred@sitebuilt.net', 'CYURD004'),
('fred@sitebuilt.net', 'CYURD006'),
('fred@sitebuilt.net', 'CYURD007'),
('fred@sitebuilt.net', 'CYURD008'),
('mckenna.tim@gmail.com', 'CYURBAD'),
('mckenna.tim@gmail.com', 'CYURD001'),
('mckenna.tim@gmail.com', 'CYURD002'),
('mckenna.tim@gmail.com', 'CYURD003'),
('mckenna.tim@gmail.com', 'CYURD004'),
('mckenna.tim@gmail.com', 'CYURD006'),
('mckenna.tim@gmail.com', 'CYURD007'),
('mckenna.tim@gmail.com', 'CYURD008'),
('perimckenna@gmail.com', 'CYURBAD'),
('perimckenna@gmail.com', 'CYURD001'),
('perimckenna@gmail.com', 'CYURD002'),
('perimckenna@gmail.com', 'CYURD003'),
('perimckenna@gmail.com', 'CYURD004'),
('perimckenna@gmail.com', 'CYURD006'),
('perimckenna@gmail.com', 'CYURD007'),
('perimckenna@gmail.com', 'CYURD008'),
('tim2@sitebuilt.net', 'CYURBAD'),
('tim2@sitebuilt.net', 'CYURD001'),
('tim2@sitebuilt.net', 'CYURD002'),
('tim2@sitebuilt.net', 'CYURD003'),
('tim2@sitebuilt.net', 'CYURD004'),
('tim2@sitebuilt.net', 'CYURD006'),
('tim2@sitebuilt.net', 'CYURD007'),
('tim2@sitebuilt.net', 'CYURD008'),
('tim3@sitebuilt.net', 'CYURBAD'),
('tim3@sitebuilt.net', 'CYURD001'),
('tim3@sitebuilt.net', 'CYURD002'),
('tim3@sitebuilt.net', 'CYURD003'),
('tim3@sitebuilt.net', 'CYURD004'),
('tim3@sitebuilt.net', 'CYURD006'),
('tim3@sitebuilt.net', 'CYURD007'),
('tim3@sitebuilt.net', 'CYURD008'),
('tim@sitebuilt.net', 'CYURBAD'),
('tim@sitebuilt.net', 'CYURD001'),
('tim@sitebuilt.net', 'CYURD002'),
('tim@sitebuilt.net', 'CYURD003'),
('tim@sitebuilt.net', 'CYURD004'),
('tim@sitebuilt.net', 'CYURD006'),
('tim@sitebuilt.net', 'CYURD007'),
('tim@sitebuilt.net', 'CYURD008');

-- --------------------------------------------------------

--
-- Table structure for table `temp2`
--

CREATE TABLE `temp2` (
  `userid` varchar(24) NOT NULL,
  `devid` varchar(30) NOT NULL,
  `appid` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `temp2`
--

INSERT INTO `temp2` (`userid`, `devid`, `appid`) VALUES
('anybody', 'CYURBAD', 'admind'),
('anybody', 'CYURBAD', 'cascada'),
('anybody', 'CYURBAD', 'hvac'),
('anybody', 'CYURBAD', 'lightsoff'),
('anybody', 'CYURBAD', 'pahoRawSB'),
('anybody', 'CYURBAD', 'shroom'),
('anybody', 'CYURD001', 'admind'),
('anybody', 'CYURD001', 'cascada'),
('anybody', 'CYURD001', 'hvac'),
('anybody', 'CYURD001', 'lightsoff'),
('anybody', 'CYURD001', 'pahoRawSB'),
('anybody', 'CYURD001', 'shroom'),
('anybody', 'CYURD002', 'admind'),
('anybody', 'CYURD002', 'cascada'),
('anybody', 'CYURD002', 'hvac'),
('anybody', 'CYURD002', 'lightsoff'),
('anybody', 'CYURD002', 'pahoRawSB'),
('anybody', 'CYURD002', 'shroom'),
('anybody', 'CYURD003', 'admind'),
('anybody', 'CYURD003', 'cascada'),
('anybody', 'CYURD003', 'hvac'),
('anybody', 'CYURD003', 'lightsoff'),
('anybody', 'CYURD003', 'pahoRawSB'),
('anybody', 'CYURD003', 'shroom'),
('anybody', 'CYURD004', 'admind'),
('anybody', 'CYURD004', 'cascada'),
('anybody', 'CYURD004', 'hvac'),
('anybody', 'CYURD004', 'lightsoff'),
('anybody', 'CYURD004', 'pahoRawSB'),
('anybody', 'CYURD004', 'shroom'),
('anybody', 'CYURD006', 'admind'),
('anybody', 'CYURD006', 'cascada'),
('anybody', 'CYURD006', 'hvac'),
('anybody', 'CYURD006', 'lightsoff'),
('anybody', 'CYURD006', 'pahoRawSB'),
('anybody', 'CYURD006', 'shroom'),
('anybody', 'CYURD007', 'admind'),
('anybody', 'CYURD007', 'cascada'),
('anybody', 'CYURD007', 'hvac'),
('anybody', 'CYURD007', 'lightsoff'),
('anybody', 'CYURD007', 'pahoRawSB'),
('anybody', 'CYURD007', 'shroom'),
('anybody', 'CYURD008', 'admind'),
('anybody', 'CYURD008', 'cascada'),
('anybody', 'CYURD008', 'hvac'),
('anybody', 'CYURD008', 'lightsoff'),
('anybody', 'CYURD008', 'pahoRawSB'),
('anybody', 'CYURD008', 'shroom'),
('clipperjohn@gmail.com ', 'CYURBAD', 'admind'),
('clipperjohn@gmail.com ', 'CYURBAD', 'cascada'),
('clipperjohn@gmail.com ', 'CYURBAD', 'hvac'),
('clipperjohn@gmail.com ', 'CYURBAD', 'lightsoff'),
('clipperjohn@gmail.com ', 'CYURBAD', 'pahoRawSB'),
('clipperjohn@gmail.com ', 'CYURBAD', 'shroom'),
('clipperjohn@gmail.com ', 'CYURD001', 'admind'),
('clipperjohn@gmail.com ', 'CYURD001', 'cascada'),
('clipperjohn@gmail.com ', 'CYURD001', 'hvac'),
('clipperjohn@gmail.com ', 'CYURD001', 'lightsoff'),
('clipperjohn@gmail.com ', 'CYURD001', 'pahoRawSB'),
('clipperjohn@gmail.com ', 'CYURD001', 'shroom'),
('clipperjohn@gmail.com ', 'CYURD002', 'admind'),
('clipperjohn@gmail.com ', 'CYURD002', 'cascada'),
('clipperjohn@gmail.com ', 'CYURD002', 'hvac'),
('clipperjohn@gmail.com ', 'CYURD002', 'lightsoff'),
('clipperjohn@gmail.com ', 'CYURD002', 'pahoRawSB'),
('clipperjohn@gmail.com ', 'CYURD002', 'shroom'),
('clipperjohn@gmail.com ', 'CYURD003', 'admind'),
('clipperjohn@gmail.com ', 'CYURD003', 'cascada'),
('clipperjohn@gmail.com ', 'CYURD003', 'hvac'),
('clipperjohn@gmail.com ', 'CYURD003', 'lightsoff'),
('clipperjohn@gmail.com ', 'CYURD003', 'pahoRawSB'),
('clipperjohn@gmail.com ', 'CYURD003', 'shroom'),
('clipperjohn@gmail.com ', 'CYURD004', 'admind'),
('clipperjohn@gmail.com ', 'CYURD004', 'cascada'),
('clipperjohn@gmail.com ', 'CYURD004', 'hvac'),
('clipperjohn@gmail.com ', 'CYURD004', 'lightsoff'),
('clipperjohn@gmail.com ', 'CYURD004', 'pahoRawSB'),
('clipperjohn@gmail.com ', 'CYURD004', 'shroom'),
('clipperjohn@gmail.com ', 'CYURD006', 'admind'),
('clipperjohn@gmail.com ', 'CYURD006', 'cascada'),
('clipperjohn@gmail.com ', 'CYURD006', 'hvac'),
('clipperjohn@gmail.com ', 'CYURD006', 'lightsoff'),
('clipperjohn@gmail.com ', 'CYURD006', 'pahoRawSB'),
('clipperjohn@gmail.com ', 'CYURD006', 'shroom'),
('clipperjohn@gmail.com ', 'CYURD007', 'admind'),
('clipperjohn@gmail.com ', 'CYURD007', 'cascada'),
('clipperjohn@gmail.com ', 'CYURD007', 'hvac'),
('clipperjohn@gmail.com ', 'CYURD007', 'lightsoff'),
('clipperjohn@gmail.com ', 'CYURD007', 'pahoRawSB'),
('clipperjohn@gmail.com ', 'CYURD007', 'shroom'),
('clipperjohn@gmail.com ', 'CYURD008', 'admind'),
('clipperjohn@gmail.com ', 'CYURD008', 'cascada'),
('clipperjohn@gmail.com ', 'CYURD008', 'hvac'),
('clipperjohn@gmail.com ', 'CYURD008', 'lightsoff'),
('clipperjohn@gmail.com ', 'CYURD008', 'pahoRawSB'),
('clipperjohn@gmail.com ', 'CYURD008', 'shroom'),
('clippingersue@gmail.com', 'CYURBAD', 'admind'),
('clippingersue@gmail.com', 'CYURBAD', 'cascada'),
('clippingersue@gmail.com', 'CYURBAD', 'hvac'),
('clippingersue@gmail.com', 'CYURBAD', 'lightsoff'),
('clippingersue@gmail.com', 'CYURBAD', 'pahoRawSB'),
('clippingersue@gmail.com', 'CYURBAD', 'shroom'),
('clippingersue@gmail.com', 'CYURD001', 'admind'),
('clippingersue@gmail.com', 'CYURD001', 'cascada'),
('clippingersue@gmail.com', 'CYURD001', 'hvac'),
('clippingersue@gmail.com', 'CYURD001', 'lightsoff'),
('clippingersue@gmail.com', 'CYURD001', 'pahoRawSB'),
('clippingersue@gmail.com', 'CYURD001', 'shroom'),
('clippingersue@gmail.com', 'CYURD002', 'admind'),
('clippingersue@gmail.com', 'CYURD002', 'cascada'),
('clippingersue@gmail.com', 'CYURD002', 'hvac'),
('clippingersue@gmail.com', 'CYURD002', 'lightsoff'),
('clippingersue@gmail.com', 'CYURD002', 'pahoRawSB'),
('clippingersue@gmail.com', 'CYURD002', 'shroom'),
('clippingersue@gmail.com', 'CYURD003', 'admind'),
('clippingersue@gmail.com', 'CYURD003', 'cascada'),
('clippingersue@gmail.com', 'CYURD003', 'hvac'),
('clippingersue@gmail.com', 'CYURD003', 'lightsoff'),
('clippingersue@gmail.com', 'CYURD003', 'pahoRawSB'),
('clippingersue@gmail.com', 'CYURD003', 'shroom'),
('clippingersue@gmail.com', 'CYURD004', 'admind'),
('clippingersue@gmail.com', 'CYURD004', 'cascada'),
('clippingersue@gmail.com', 'CYURD004', 'hvac'),
('clippingersue@gmail.com', 'CYURD004', 'lightsoff'),
('clippingersue@gmail.com', 'CYURD004', 'pahoRawSB'),
('clippingersue@gmail.com', 'CYURD004', 'shroom'),
('clippingersue@gmail.com', 'CYURD006', 'admind'),
('clippingersue@gmail.com', 'CYURD006', 'cascada'),
('clippingersue@gmail.com', 'CYURD006', 'hvac'),
('clippingersue@gmail.com', 'CYURD006', 'lightsoff'),
('clippingersue@gmail.com', 'CYURD006', 'pahoRawSB'),
('clippingersue@gmail.com', 'CYURD006', 'shroom'),
('clippingersue@gmail.com', 'CYURD007', 'admind'),
('clippingersue@gmail.com', 'CYURD007', 'cascada'),
('clippingersue@gmail.com', 'CYURD007', 'hvac'),
('clippingersue@gmail.com', 'CYURD007', 'lightsoff'),
('clippingersue@gmail.com', 'CYURD007', 'pahoRawSB'),
('clippingersue@gmail.com', 'CYURD007', 'shroom'),
('clippingersue@gmail.com', 'CYURD008', 'admind'),
('clippingersue@gmail.com', 'CYURD008', 'cascada'),
('clippingersue@gmail.com', 'CYURD008', 'hvac'),
('clippingersue@gmail.com', 'CYURD008', 'lightsoff'),
('clippingersue@gmail.com', 'CYURD008', 'pahoRawSB'),
('clippingersue@gmail.com', 'CYURD008', 'shroom'),
('fred@sitebuilt.net', 'CYURBAD', 'admind'),
('fred@sitebuilt.net', 'CYURBAD', 'cascada'),
('fred@sitebuilt.net', 'CYURBAD', 'hvac'),
('fred@sitebuilt.net', 'CYURBAD', 'lightsoff'),
('fred@sitebuilt.net', 'CYURBAD', 'pahoRawSB'),
('fred@sitebuilt.net', 'CYURBAD', 'shroom'),
('fred@sitebuilt.net', 'CYURD001', 'admind'),
('fred@sitebuilt.net', 'CYURD001', 'cascada'),
('fred@sitebuilt.net', 'CYURD001', 'hvac'),
('fred@sitebuilt.net', 'CYURD001', 'lightsoff'),
('fred@sitebuilt.net', 'CYURD001', 'pahoRawSB'),
('fred@sitebuilt.net', 'CYURD001', 'shroom'),
('fred@sitebuilt.net', 'CYURD002', 'admind'),
('fred@sitebuilt.net', 'CYURD002', 'cascada'),
('fred@sitebuilt.net', 'CYURD002', 'hvac'),
('fred@sitebuilt.net', 'CYURD002', 'lightsoff'),
('fred@sitebuilt.net', 'CYURD002', 'pahoRawSB'),
('fred@sitebuilt.net', 'CYURD002', 'shroom'),
('fred@sitebuilt.net', 'CYURD003', 'admind'),
('fred@sitebuilt.net', 'CYURD003', 'cascada'),
('fred@sitebuilt.net', 'CYURD003', 'hvac'),
('fred@sitebuilt.net', 'CYURD003', 'lightsoff'),
('fred@sitebuilt.net', 'CYURD003', 'pahoRawSB'),
('fred@sitebuilt.net', 'CYURD003', 'shroom'),
('fred@sitebuilt.net', 'CYURD004', 'admind'),
('fred@sitebuilt.net', 'CYURD004', 'cascada'),
('fred@sitebuilt.net', 'CYURD004', 'hvac'),
('fred@sitebuilt.net', 'CYURD004', 'lightsoff'),
('fred@sitebuilt.net', 'CYURD004', 'pahoRawSB'),
('fred@sitebuilt.net', 'CYURD004', 'shroom'),
('fred@sitebuilt.net', 'CYURD006', 'admind'),
('fred@sitebuilt.net', 'CYURD006', 'cascada'),
('fred@sitebuilt.net', 'CYURD006', 'hvac'),
('fred@sitebuilt.net', 'CYURD006', 'lightsoff'),
('fred@sitebuilt.net', 'CYURD006', 'pahoRawSB'),
('fred@sitebuilt.net', 'CYURD006', 'shroom'),
('fred@sitebuilt.net', 'CYURD007', 'admind'),
('fred@sitebuilt.net', 'CYURD007', 'cascada'),
('fred@sitebuilt.net', 'CYURD007', 'hvac'),
('fred@sitebuilt.net', 'CYURD007', 'lightsoff'),
('fred@sitebuilt.net', 'CYURD007', 'pahoRawSB'),
('fred@sitebuilt.net', 'CYURD007', 'shroom'),
('fred@sitebuilt.net', 'CYURD008', 'admind'),
('fred@sitebuilt.net', 'CYURD008', 'cascada'),
('fred@sitebuilt.net', 'CYURD008', 'hvac'),
('fred@sitebuilt.net', 'CYURD008', 'lightsoff'),
('fred@sitebuilt.net', 'CYURD008', 'pahoRawSB'),
('fred@sitebuilt.net', 'CYURD008', 'shroom'),
('mckenna.tim@gmail.com', 'CYURBAD', 'admind'),
('mckenna.tim@gmail.com', 'CYURBAD', 'cascada'),
('mckenna.tim@gmail.com', 'CYURBAD', 'hvac'),
('mckenna.tim@gmail.com', 'CYURBAD', 'lightsoff'),
('mckenna.tim@gmail.com', 'CYURBAD', 'pahoRawSB'),
('mckenna.tim@gmail.com', 'CYURBAD', 'shroom'),
('mckenna.tim@gmail.com', 'CYURD001', 'admind'),
('mckenna.tim@gmail.com', 'CYURD001', 'cascada'),
('mckenna.tim@gmail.com', 'CYURD001', 'hvac'),
('mckenna.tim@gmail.com', 'CYURD001', 'lightsoff'),
('mckenna.tim@gmail.com', 'CYURD001', 'pahoRawSB'),
('mckenna.tim@gmail.com', 'CYURD001', 'shroom'),
('mckenna.tim@gmail.com', 'CYURD002', 'admind'),
('mckenna.tim@gmail.com', 'CYURD002', 'cascada'),
('mckenna.tim@gmail.com', 'CYURD002', 'hvac'),
('mckenna.tim@gmail.com', 'CYURD002', 'lightsoff'),
('mckenna.tim@gmail.com', 'CYURD002', 'pahoRawSB'),
('mckenna.tim@gmail.com', 'CYURD002', 'shroom'),
('mckenna.tim@gmail.com', 'CYURD003', 'admind'),
('mckenna.tim@gmail.com', 'CYURD003', 'cascada'),
('mckenna.tim@gmail.com', 'CYURD003', 'hvac'),
('mckenna.tim@gmail.com', 'CYURD003', 'lightsoff'),
('mckenna.tim@gmail.com', 'CYURD003', 'pahoRawSB'),
('mckenna.tim@gmail.com', 'CYURD003', 'shroom'),
('mckenna.tim@gmail.com', 'CYURD004', 'admind'),
('mckenna.tim@gmail.com', 'CYURD004', 'cascada'),
('mckenna.tim@gmail.com', 'CYURD004', 'hvac'),
('mckenna.tim@gmail.com', 'CYURD004', 'lightsoff'),
('mckenna.tim@gmail.com', 'CYURD004', 'pahoRawSB'),
('mckenna.tim@gmail.com', 'CYURD004', 'shroom'),
('mckenna.tim@gmail.com', 'CYURD006', 'admind'),
('mckenna.tim@gmail.com', 'CYURD006', 'cascada'),
('mckenna.tim@gmail.com', 'CYURD006', 'hvac'),
('mckenna.tim@gmail.com', 'CYURD006', 'lightsoff'),
('mckenna.tim@gmail.com', 'CYURD006', 'pahoRawSB'),
('mckenna.tim@gmail.com', 'CYURD006', 'shroom'),
('mckenna.tim@gmail.com', 'CYURD007', 'admind'),
('mckenna.tim@gmail.com', 'CYURD007', 'cascada'),
('mckenna.tim@gmail.com', 'CYURD007', 'hvac'),
('mckenna.tim@gmail.com', 'CYURD007', 'lightsoff'),
('mckenna.tim@gmail.com', 'CYURD007', 'pahoRawSB'),
('mckenna.tim@gmail.com', 'CYURD007', 'shroom'),
('mckenna.tim@gmail.com', 'CYURD008', 'admind'),
('mckenna.tim@gmail.com', 'CYURD008', 'cascada'),
('mckenna.tim@gmail.com', 'CYURD008', 'hvac'),
('mckenna.tim@gmail.com', 'CYURD008', 'lightsoff'),
('mckenna.tim@gmail.com', 'CYURD008', 'pahoRawSB'),
('mckenna.tim@gmail.com', 'CYURD008', 'shroom'),
('perimckenna@gmail.com', 'CYURBAD', 'admind'),
('perimckenna@gmail.com', 'CYURBAD', 'cascada'),
('perimckenna@gmail.com', 'CYURBAD', 'hvac'),
('perimckenna@gmail.com', 'CYURBAD', 'lightsoff'),
('perimckenna@gmail.com', 'CYURBAD', 'pahoRawSB'),
('perimckenna@gmail.com', 'CYURBAD', 'shroom'),
('perimckenna@gmail.com', 'CYURD001', 'admind'),
('perimckenna@gmail.com', 'CYURD001', 'cascada'),
('perimckenna@gmail.com', 'CYURD001', 'hvac'),
('perimckenna@gmail.com', 'CYURD001', 'lightsoff'),
('perimckenna@gmail.com', 'CYURD001', 'pahoRawSB'),
('perimckenna@gmail.com', 'CYURD001', 'shroom'),
('perimckenna@gmail.com', 'CYURD002', 'admind'),
('perimckenna@gmail.com', 'CYURD002', 'cascada'),
('perimckenna@gmail.com', 'CYURD002', 'hvac'),
('perimckenna@gmail.com', 'CYURD002', 'lightsoff'),
('perimckenna@gmail.com', 'CYURD002', 'pahoRawSB'),
('perimckenna@gmail.com', 'CYURD002', 'shroom'),
('perimckenna@gmail.com', 'CYURD003', 'admind'),
('perimckenna@gmail.com', 'CYURD003', 'cascada'),
('perimckenna@gmail.com', 'CYURD003', 'hvac'),
('perimckenna@gmail.com', 'CYURD003', 'lightsoff'),
('perimckenna@gmail.com', 'CYURD003', 'pahoRawSB'),
('perimckenna@gmail.com', 'CYURD003', 'shroom'),
('perimckenna@gmail.com', 'CYURD004', 'admind'),
('perimckenna@gmail.com', 'CYURD004', 'cascada'),
('perimckenna@gmail.com', 'CYURD004', 'hvac'),
('perimckenna@gmail.com', 'CYURD004', 'lightsoff'),
('perimckenna@gmail.com', 'CYURD004', 'pahoRawSB'),
('perimckenna@gmail.com', 'CYURD004', 'shroom'),
('perimckenna@gmail.com', 'CYURD006', 'admind'),
('perimckenna@gmail.com', 'CYURD006', 'cascada'),
('perimckenna@gmail.com', 'CYURD006', 'hvac'),
('perimckenna@gmail.com', 'CYURD006', 'lightsoff'),
('perimckenna@gmail.com', 'CYURD006', 'pahoRawSB'),
('perimckenna@gmail.com', 'CYURD006', 'shroom'),
('perimckenna@gmail.com', 'CYURD007', 'admind'),
('perimckenna@gmail.com', 'CYURD007', 'cascada'),
('perimckenna@gmail.com', 'CYURD007', 'hvac'),
('perimckenna@gmail.com', 'CYURD007', 'lightsoff'),
('perimckenna@gmail.com', 'CYURD007', 'pahoRawSB'),
('perimckenna@gmail.com', 'CYURD007', 'shroom'),
('perimckenna@gmail.com', 'CYURD008', 'admind'),
('perimckenna@gmail.com', 'CYURD008', 'cascada'),
('perimckenna@gmail.com', 'CYURD008', 'hvac'),
('perimckenna@gmail.com', 'CYURD008', 'lightsoff'),
('perimckenna@gmail.com', 'CYURD008', 'pahoRawSB'),
('perimckenna@gmail.com', 'CYURD008', 'shroom'),
('tim2@sitebuilt.net', 'CYURBAD', 'admind'),
('tim2@sitebuilt.net', 'CYURBAD', 'cascada'),
('tim2@sitebuilt.net', 'CYURBAD', 'hvac'),
('tim2@sitebuilt.net', 'CYURBAD', 'lightsoff'),
('tim2@sitebuilt.net', 'CYURBAD', 'pahoRawSB'),
('tim2@sitebuilt.net', 'CYURBAD', 'shroom'),
('tim2@sitebuilt.net', 'CYURD001', 'admind'),
('tim2@sitebuilt.net', 'CYURD001', 'cascada'),
('tim2@sitebuilt.net', 'CYURD001', 'hvac'),
('tim2@sitebuilt.net', 'CYURD001', 'lightsoff'),
('tim2@sitebuilt.net', 'CYURD001', 'pahoRawSB'),
('tim2@sitebuilt.net', 'CYURD001', 'shroom'),
('tim2@sitebuilt.net', 'CYURD002', 'admind'),
('tim2@sitebuilt.net', 'CYURD002', 'cascada'),
('tim2@sitebuilt.net', 'CYURD002', 'hvac'),
('tim2@sitebuilt.net', 'CYURD002', 'lightsoff'),
('tim2@sitebuilt.net', 'CYURD002', 'pahoRawSB'),
('tim2@sitebuilt.net', 'CYURD002', 'shroom'),
('tim2@sitebuilt.net', 'CYURD003', 'admind'),
('tim2@sitebuilt.net', 'CYURD003', 'cascada'),
('tim2@sitebuilt.net', 'CYURD003', 'hvac'),
('tim2@sitebuilt.net', 'CYURD003', 'lightsoff'),
('tim2@sitebuilt.net', 'CYURD003', 'pahoRawSB'),
('tim2@sitebuilt.net', 'CYURD003', 'shroom'),
('tim2@sitebuilt.net', 'CYURD004', 'admind'),
('tim2@sitebuilt.net', 'CYURD004', 'cascada'),
('tim2@sitebuilt.net', 'CYURD004', 'hvac'),
('tim2@sitebuilt.net', 'CYURD004', 'lightsoff'),
('tim2@sitebuilt.net', 'CYURD004', 'pahoRawSB'),
('tim2@sitebuilt.net', 'CYURD004', 'shroom'),
('tim2@sitebuilt.net', 'CYURD006', 'admind'),
('tim2@sitebuilt.net', 'CYURD006', 'cascada'),
('tim2@sitebuilt.net', 'CYURD006', 'hvac'),
('tim2@sitebuilt.net', 'CYURD006', 'lightsoff'),
('tim2@sitebuilt.net', 'CYURD006', 'pahoRawSB'),
('tim2@sitebuilt.net', 'CYURD006', 'shroom'),
('tim2@sitebuilt.net', 'CYURD007', 'admind'),
('tim2@sitebuilt.net', 'CYURD007', 'cascada'),
('tim2@sitebuilt.net', 'CYURD007', 'hvac'),
('tim2@sitebuilt.net', 'CYURD007', 'lightsoff'),
('tim2@sitebuilt.net', 'CYURD007', 'pahoRawSB'),
('tim2@sitebuilt.net', 'CYURD007', 'shroom'),
('tim2@sitebuilt.net', 'CYURD008', 'admind'),
('tim2@sitebuilt.net', 'CYURD008', 'cascada'),
('tim2@sitebuilt.net', 'CYURD008', 'hvac'),
('tim2@sitebuilt.net', 'CYURD008', 'lightsoff'),
('tim2@sitebuilt.net', 'CYURD008', 'pahoRawSB'),
('tim2@sitebuilt.net', 'CYURD008', 'shroom'),
('tim3@sitebuilt.net', 'CYURBAD', 'admind'),
('tim3@sitebuilt.net', 'CYURBAD', 'cascada'),
('tim3@sitebuilt.net', 'CYURBAD', 'hvac'),
('tim3@sitebuilt.net', 'CYURBAD', 'lightsoff'),
('tim3@sitebuilt.net', 'CYURBAD', 'pahoRawSB'),
('tim3@sitebuilt.net', 'CYURBAD', 'shroom'),
('tim3@sitebuilt.net', 'CYURD001', 'admind'),
('tim3@sitebuilt.net', 'CYURD001', 'cascada'),
('tim3@sitebuilt.net', 'CYURD001', 'hvac'),
('tim3@sitebuilt.net', 'CYURD001', 'lightsoff'),
('tim3@sitebuilt.net', 'CYURD001', 'pahoRawSB'),
('tim3@sitebuilt.net', 'CYURD001', 'shroom'),
('tim3@sitebuilt.net', 'CYURD002', 'admind'),
('tim3@sitebuilt.net', 'CYURD002', 'cascada'),
('tim3@sitebuilt.net', 'CYURD002', 'hvac'),
('tim3@sitebuilt.net', 'CYURD002', 'lightsoff'),
('tim3@sitebuilt.net', 'CYURD002', 'pahoRawSB'),
('tim3@sitebuilt.net', 'CYURD002', 'shroom'),
('tim3@sitebuilt.net', 'CYURD003', 'admind'),
('tim3@sitebuilt.net', 'CYURD003', 'cascada'),
('tim3@sitebuilt.net', 'CYURD003', 'hvac'),
('tim3@sitebuilt.net', 'CYURD003', 'lightsoff'),
('tim3@sitebuilt.net', 'CYURD003', 'pahoRawSB'),
('tim3@sitebuilt.net', 'CYURD003', 'shroom'),
('tim3@sitebuilt.net', 'CYURD004', 'admind'),
('tim3@sitebuilt.net', 'CYURD004', 'cascada'),
('tim3@sitebuilt.net', 'CYURD004', 'hvac'),
('tim3@sitebuilt.net', 'CYURD004', 'lightsoff'),
('tim3@sitebuilt.net', 'CYURD004', 'pahoRawSB'),
('tim3@sitebuilt.net', 'CYURD004', 'shroom'),
('tim3@sitebuilt.net', 'CYURD006', 'admind'),
('tim3@sitebuilt.net', 'CYURD006', 'cascada'),
('tim3@sitebuilt.net', 'CYURD006', 'hvac'),
('tim3@sitebuilt.net', 'CYURD006', 'lightsoff'),
('tim3@sitebuilt.net', 'CYURD006', 'pahoRawSB'),
('tim3@sitebuilt.net', 'CYURD006', 'shroom'),
('tim3@sitebuilt.net', 'CYURD007', 'admind'),
('tim3@sitebuilt.net', 'CYURD007', 'cascada'),
('tim3@sitebuilt.net', 'CYURD007', 'hvac'),
('tim3@sitebuilt.net', 'CYURD007', 'lightsoff'),
('tim3@sitebuilt.net', 'CYURD007', 'pahoRawSB'),
('tim3@sitebuilt.net', 'CYURD007', 'shroom'),
('tim3@sitebuilt.net', 'CYURD008', 'admind'),
('tim3@sitebuilt.net', 'CYURD008', 'cascada'),
('tim3@sitebuilt.net', 'CYURD008', 'hvac'),
('tim3@sitebuilt.net', 'CYURD008', 'lightsoff'),
('tim3@sitebuilt.net', 'CYURD008', 'pahoRawSB'),
('tim3@sitebuilt.net', 'CYURD008', 'shroom'),
('tim@sitebuilt.net', 'CYURBAD', 'admind'),
('tim@sitebuilt.net', 'CYURBAD', 'cascada'),
('tim@sitebuilt.net', 'CYURBAD', 'hvac'),
('tim@sitebuilt.net', 'CYURBAD', 'lightsoff'),
('tim@sitebuilt.net', 'CYURBAD', 'pahoRawSB'),
('tim@sitebuilt.net', 'CYURBAD', 'shroom'),
('tim@sitebuilt.net', 'CYURD001', 'admind'),
('tim@sitebuilt.net', 'CYURD001', 'cascada'),
('tim@sitebuilt.net', 'CYURD001', 'hvac'),
('tim@sitebuilt.net', 'CYURD001', 'lightsoff'),
('tim@sitebuilt.net', 'CYURD001', 'pahoRawSB'),
('tim@sitebuilt.net', 'CYURD001', 'shroom'),
('tim@sitebuilt.net', 'CYURD002', 'admind'),
('tim@sitebuilt.net', 'CYURD002', 'cascada'),
('tim@sitebuilt.net', 'CYURD002', 'hvac'),
('tim@sitebuilt.net', 'CYURD002', 'lightsoff'),
('tim@sitebuilt.net', 'CYURD002', 'pahoRawSB'),
('tim@sitebuilt.net', 'CYURD002', 'shroom'),
('tim@sitebuilt.net', 'CYURD003', 'admind'),
('tim@sitebuilt.net', 'CYURD003', 'cascada'),
('tim@sitebuilt.net', 'CYURD003', 'hvac'),
('tim@sitebuilt.net', 'CYURD003', 'lightsoff'),
('tim@sitebuilt.net', 'CYURD003', 'pahoRawSB'),
('tim@sitebuilt.net', 'CYURD003', 'shroom'),
('tim@sitebuilt.net', 'CYURD004', 'admind'),
('tim@sitebuilt.net', 'CYURD004', 'cascada'),
('tim@sitebuilt.net', 'CYURD004', 'hvac'),
('tim@sitebuilt.net', 'CYURD004', 'lightsoff'),
('tim@sitebuilt.net', 'CYURD004', 'pahoRawSB'),
('tim@sitebuilt.net', 'CYURD004', 'shroom'),
('tim@sitebuilt.net', 'CYURD006', 'admind'),
('tim@sitebuilt.net', 'CYURD006', 'cascada'),
('tim@sitebuilt.net', 'CYURD006', 'hvac'),
('tim@sitebuilt.net', 'CYURD006', 'lightsoff'),
('tim@sitebuilt.net', 'CYURD006', 'pahoRawSB'),
('tim@sitebuilt.net', 'CYURD006', 'shroom'),
('tim@sitebuilt.net', 'CYURD007', 'admind'),
('tim@sitebuilt.net', 'CYURD007', 'cascada'),
('tim@sitebuilt.net', 'CYURD007', 'hvac'),
('tim@sitebuilt.net', 'CYURD007', 'lightsoff'),
('tim@sitebuilt.net', 'CYURD007', 'pahoRawSB'),
('tim@sitebuilt.net', 'CYURD007', 'shroom'),
('tim@sitebuilt.net', 'CYURD008', 'admind'),
('tim@sitebuilt.net', 'CYURD008', 'cascada'),
('tim@sitebuilt.net', 'CYURD008', 'hvac'),
('tim@sitebuilt.net', 'CYURD008', 'lightsoff'),
('tim@sitebuilt.net', 'CYURD008', 'pahoRawSB'),
('tim@sitebuilt.net', 'CYURD008', 'shroom');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `userid` varchar(80) NOT NULL,
  `name` varchar(60) DEFAULT NULL,
  `address` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user_app_dev`
--

CREATE TABLE `user_app_dev` (
  `id` int(11) NOT NULL,
  `userid` varchar(60) NOT NULL,
  `appid` varchar(20) DEFAULT NULL,
  `devid` varchar(30) NOT NULL,
  `role` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_app_dev`
--

INSERT INTO `user_app_dev` (`id`, `userid`, `appid`, `devid`, `role`) VALUES
(100, 'anybody', 'admind', 'CYURBAD', 'user'),
(108, 'anybody', 'hvac', 'CYURD001', 'user'),
(109, 'anybody', 'lightsoff', 'CYURD001', 'user'),
(110, 'anybody', 'pahoRawSB', 'CYURD001', 'user'),
(111, 'anybody', 'shroom', 'CYURD001', 'user'),
(112, 'anybody', 'admind', 'CYURD002', 'user'),
(113, 'anybody', 'cascada', 'CYURD002', 'user'),
(114, 'anybody', 'hvac', 'CYURD002', 'user'),
(115, 'anybody', 'lightsoff', 'CYURD002', 'user'),
(116, 'anybody', 'pahoRawSB', 'CYURD002', 'user'),
(117, 'anybody', 'shroom', 'CYURD002', 'user'),
(118, 'anybody', 'admind', 'CYURD003', 'user'),
(119, 'anybody', 'cascada', 'CYURD003', 'user'),
(120, 'anybody', 'hvac', 'CYURD003', 'user'),
(121, 'anybody', 'lightsoff', 'CYURD003', 'user'),
(122, 'anybody', 'pahoRawSB', 'CYURD003', 'user'),
(123, 'anybody', 'shroom', 'CYURD003', 'user'),
(124, 'anybody', 'admind', 'CYURD004', 'user'),
(125, 'anybody', 'cascada', 'CYURD004', 'user'),
(126, 'anybody', 'hvac', 'CYURD004', 'user'),
(127, 'anybody', 'lightsoff', 'CYURD004', 'user'),
(128, 'anybody', 'pahoRawSB', 'CYURD004', 'user'),
(129, 'anybody', 'shroom', 'CYURD004', 'user'),
(130, 'anybody', 'admind', 'CYURD006', 'user'),
(131, 'anybody', 'cascada', 'CYURD006', 'user'),
(132, 'anybody', 'hvac', 'CYURD006', 'user'),
(133, 'anybody', 'lightsoff', 'CYURD006', 'user'),
(134, 'anybody', 'pahoRawSB', 'CYURD006', 'user'),
(135, 'anybody', 'shroom', 'CYURD006', 'user'),
(136, 'anybody', 'admind', 'CYURD007', 'user'),
(137, 'anybody', 'cascada', 'CYURD007', 'user'),
(138, 'anybody', 'hvac', 'CYURD007', 'user'),
(139, 'anybody', 'lightsoff', 'CYURD007', 'user'),
(140, 'anybody', 'pahoRawSB', 'CYURD007', 'user'),
(141, 'anybody', 'shroom', 'CYURD007', 'user'),
(142, 'anybody', 'admind', 'CYURD008', 'user'),
(143, 'anybody', 'cascada', 'CYURD008', 'user'),
(144, 'anybody', 'hvac', 'CYURD008', 'user'),
(145, 'anybody', 'lightsoff', 'CYURD008', 'user'),
(146, 'anybody', 'pahoRawSB', 'CYURD008', 'user'),
(147, 'anybody', 'shroom', 'CYURD008', 'user'),
(148, 'clipperjohn@gmail.com ', 'admind', 'CYURBAD', 'user'),
(149, 'clipperjohn@gmail.com ', 'cascada', 'CYURBAD', 'user'),
(150, 'clipperjohn@gmail.com ', 'hvac', 'CYURBAD', 'user'),
(151, 'clipperjohn@gmail.com ', 'lightsoff', 'CYURBAD', 'user'),
(152, 'clipperjohn@gmail.com ', 'pahoRawSB', 'CYURBAD', 'user'),
(153, 'clipperjohn@gmail.com ', 'shroom', 'CYURBAD', 'user'),
(154, 'clipperjohn@gmail.com ', 'admind', 'CYURD001', 'user'),
(155, 'clipperjohn@gmail.com ', 'cascada', 'CYURD001', 'user'),
(156, 'clipperjohn@gmail.com ', 'hvac', 'CYURD001', 'user'),
(157, 'clipperjohn@gmail.com ', 'lightsoff', 'CYURD001', 'user'),
(158, 'clipperjohn@gmail.com ', 'pahoRawSB', 'CYURD001', 'user'),
(159, 'clipperjohn@gmail.com ', 'shroom', 'CYURD001', 'user'),
(160, 'clipperjohn@gmail.com ', 'admind', 'CYURD002', 'user'),
(161, 'clipperjohn@gmail.com ', 'cascada', 'CYURD002', 'user'),
(162, 'clipperjohn@gmail.com ', 'hvac', 'CYURD002', 'user'),
(163, 'clipperjohn@gmail.com ', 'lightsoff', 'CYURD002', 'user'),
(164, 'clipperjohn@gmail.com ', 'pahoRawSB', 'CYURD002', 'user'),
(165, 'clipperjohn@gmail.com ', 'shroom', 'CYURD002', 'user'),
(166, 'clipperjohn@gmail.com ', 'admind', 'CYURD003', 'user'),
(167, 'clipperjohn@gmail.com ', 'cascada', 'CYURD003', 'user'),
(168, 'clipperjohn@gmail.com ', 'hvac', 'CYURD003', 'user'),
(169, 'clipperjohn@gmail.com ', 'lightsoff', 'CYURD003', 'user'),
(170, 'clipperjohn@gmail.com ', 'pahoRawSB', 'CYURD003', 'user'),
(171, 'clipperjohn@gmail.com ', 'shroom', 'CYURD003', 'user'),
(172, 'clipperjohn@gmail.com ', 'admind', 'CYURD004', 'user'),
(173, 'clipperjohn@gmail.com ', 'cascada', 'CYURD004', 'user'),
(174, 'clipperjohn@gmail.com ', 'hvac', 'CYURD004', 'user'),
(175, 'clipperjohn@gmail.com ', 'lightsoff', 'CYURD004', 'user'),
(176, 'clipperjohn@gmail.com ', 'pahoRawSB', 'CYURD004', 'user'),
(177, 'clipperjohn@gmail.com ', 'shroom', 'CYURD004', 'user'),
(178, 'clipperjohn@gmail.com ', 'admind', 'CYURD006', 'user'),
(179, 'clipperjohn@gmail.com ', 'cascada', 'CYURD006', 'user'),
(180, 'clipperjohn@gmail.com ', 'hvac', 'CYURD006', 'user'),
(181, 'clipperjohn@gmail.com ', 'lightsoff', 'CYURD006', 'user'),
(182, 'clipperjohn@gmail.com ', 'pahoRawSB', 'CYURD006', 'user'),
(183, 'clipperjohn@gmail.com ', 'shroom', 'CYURD006', 'user'),
(184, 'clipperjohn@gmail.com ', 'admind', 'CYURD007', 'user'),
(185, 'clipperjohn@gmail.com ', 'cascada', 'CYURD007', 'user'),
(186, 'clipperjohn@gmail.com ', 'hvac', 'CYURD007', 'user'),
(187, 'clipperjohn@gmail.com ', 'lightsoff', 'CYURD007', 'user'),
(188, 'clipperjohn@gmail.com ', 'pahoRawSB', 'CYURD007', 'user'),
(189, 'clipperjohn@gmail.com ', 'shroom', 'CYURD007', 'user'),
(190, 'clipperjohn@gmail.com ', 'admind', 'CYURD008', 'user'),
(191, 'clipperjohn@gmail.com ', 'cascada', 'CYURD008', 'user'),
(192, 'clipperjohn@gmail.com ', 'hvac', 'CYURD008', 'user'),
(193, 'clipperjohn@gmail.com ', 'lightsoff', 'CYURD008', 'user'),
(194, 'clipperjohn@gmail.com ', 'pahoRawSB', 'CYURD008', 'user'),
(195, 'clipperjohn@gmail.com ', 'shroom', 'CYURD008', 'user'),
(196, 'clippingersue@gmail.com', 'admind', 'CYURBAD', 'user'),
(197, 'clippingersue@gmail.com', 'cascada', 'CYURBAD', 'user'),
(198, 'clippingersue@gmail.com', 'hvac', 'CYURBAD', 'user'),
(199, 'clippingersue@gmail.com', 'lightsoff', 'CYURBAD', 'user'),
(200, 'clippingersue@gmail.com', 'pahoRawSB', 'CYURBAD', 'user'),
(201, 'clippingersue@gmail.com', 'shroom', 'CYURBAD', 'user'),
(202, 'clippingersue@gmail.com', 'admind', 'CYURD001', 'user'),
(203, 'clippingersue@gmail.com', 'cascada', 'CYURD001', 'user'),
(204, 'clippingersue@gmail.com', 'hvac', 'CYURD001', 'user'),
(205, 'clippingersue@gmail.com', 'lightsoff', 'CYURD001', 'user'),
(206, 'clippingersue@gmail.com', 'pahoRawSB', 'CYURD001', 'user'),
(207, 'clippingersue@gmail.com', 'shroom', 'CYURD001', 'user'),
(208, 'clippingersue@gmail.com', 'admind', 'CYURD002', 'user'),
(209, 'clippingersue@gmail.com', 'cascada', 'CYURD002', 'user'),
(210, 'clippingersue@gmail.com', 'hvac', 'CYURD002', 'user'),
(211, 'clippingersue@gmail.com', 'lightsoff', 'CYURD002', 'user'),
(212, 'clippingersue@gmail.com', 'pahoRawSB', 'CYURD002', 'user'),
(213, 'clippingersue@gmail.com', 'shroom', 'CYURD002', 'user'),
(214, 'clippingersue@gmail.com', 'admind', 'CYURD003', 'user'),
(215, 'clippingersue@gmail.com', 'cascada', 'CYURD003', 'user'),
(216, 'clippingersue@gmail.com', 'hvac', 'CYURD003', 'user'),
(217, 'clippingersue@gmail.com', 'lightsoff', 'CYURD003', 'user'),
(218, 'clippingersue@gmail.com', 'pahoRawSB', 'CYURD003', 'user'),
(219, 'clippingersue@gmail.com', 'shroom', 'CYURD003', 'user'),
(220, 'clippingersue@gmail.com', 'admind', 'CYURD004', 'user'),
(221, 'clippingersue@gmail.com', 'cascada', 'CYURD004', 'user'),
(222, 'clippingersue@gmail.com', 'hvac', 'CYURD004', 'user'),
(223, 'clippingersue@gmail.com', 'lightsoff', 'CYURD004', 'user'),
(224, 'clippingersue@gmail.com', 'pahoRawSB', 'CYURD004', 'user'),
(225, 'clippingersue@gmail.com', 'shroom', 'CYURD004', 'user'),
(226, 'clippingersue@gmail.com', 'admind', 'CYURD006', 'user'),
(227, 'clippingersue@gmail.com', 'cascada', 'CYURD006', 'user'),
(228, 'clippingersue@gmail.com', 'hvac', 'CYURD006', 'user'),
(229, 'clippingersue@gmail.com', 'lightsoff', 'CYURD006', 'user'),
(230, 'clippingersue@gmail.com', 'pahoRawSB', 'CYURD006', 'user'),
(231, 'clippingersue@gmail.com', 'shroom', 'CYURD006', 'user'),
(232, 'clippingersue@gmail.com', 'admind', 'CYURD007', 'user'),
(233, 'clippingersue@gmail.com', 'cascada', 'CYURD007', 'user'),
(234, 'clippingersue@gmail.com', 'hvac', 'CYURD007', 'user'),
(235, 'clippingersue@gmail.com', 'lightsoff', 'CYURD007', 'user'),
(236, 'clippingersue@gmail.com', 'pahoRawSB', 'CYURD007', 'user'),
(237, 'clippingersue@gmail.com', 'shroom', 'CYURD007', 'user'),
(238, 'clippingersue@gmail.com', 'admind', 'CYURD008', 'user'),
(239, 'clippingersue@gmail.com', 'cascada', 'CYURD008', 'user'),
(240, 'clippingersue@gmail.com', 'hvac', 'CYURD008', 'user'),
(241, 'clippingersue@gmail.com', 'lightsoff', 'CYURD008', 'user'),
(242, 'clippingersue@gmail.com', 'pahoRawSB', 'CYURD008', 'user'),
(243, 'clippingersue@gmail.com', 'shroom', 'CYURD008', 'user'),
(244, 'fred@sitebuilt.net', 'admind', 'CYURBAD', 'user'),
(245, 'fred@sitebuilt.net', 'cascada', 'CYURBAD', 'user'),
(246, 'fred@sitebuilt.net', 'hvac', 'CYURBAD', 'user'),
(247, 'fred@sitebuilt.net', 'lightsoff', 'CYURBAD', 'user'),
(248, 'fred@sitebuilt.net', 'pahoRawSB', 'CYURBAD', 'user'),
(249, 'fred@sitebuilt.net', 'shroom', 'CYURBAD', 'user'),
(250, 'fred@sitebuilt.net', 'admind', 'CYURD001', 'user'),
(251, 'fred@sitebuilt.net', 'cascada', 'CYURD001', 'user'),
(252, 'fred@sitebuilt.net', 'hvac', 'CYURD001', 'user'),
(253, 'fred@sitebuilt.net', 'lightsoff', 'CYURD001', 'user'),
(254, 'fred@sitebuilt.net', 'pahoRawSB', 'CYURD001', 'user'),
(255, 'fred@sitebuilt.net', 'shroom', 'CYURD001', 'user'),
(256, 'fred@sitebuilt.net', 'admind', 'CYURD002', 'user'),
(257, 'fred@sitebuilt.net', 'cascada', 'CYURD002', 'user'),
(258, 'fred@sitebuilt.net', 'hvac', 'CYURD002', 'user'),
(259, 'fred@sitebuilt.net', 'lightsoff', 'CYURD002', 'user'),
(260, 'fred@sitebuilt.net', 'pahoRawSB', 'CYURD002', 'user'),
(261, 'fred@sitebuilt.net', 'shroom', 'CYURD002', 'user'),
(262, 'fred@sitebuilt.net', 'admind', 'CYURD003', 'user'),
(263, 'fred@sitebuilt.net', 'cascada', 'CYURD003', 'user'),
(264, 'fred@sitebuilt.net', 'hvac', 'CYURD003', 'user'),
(265, 'fred@sitebuilt.net', 'lightsoff', 'CYURD003', 'user'),
(266, 'fred@sitebuilt.net', 'pahoRawSB', 'CYURD003', 'user'),
(267, 'fred@sitebuilt.net', 'shroom', 'CYURD003', 'user'),
(268, 'fred@sitebuilt.net', 'admind', 'CYURD004', 'user'),
(269, 'fred@sitebuilt.net', 'cascada', 'CYURD004', 'user'),
(270, 'fred@sitebuilt.net', 'hvac', 'CYURD004', 'user'),
(271, 'fred@sitebuilt.net', 'lightsoff', 'CYURD004', 'user'),
(272, 'fred@sitebuilt.net', 'pahoRawSB', 'CYURD004', 'user'),
(273, 'fred@sitebuilt.net', 'shroom', 'CYURD004', 'user'),
(274, 'fred@sitebuilt.net', 'admind', 'CYURD006', 'user'),
(275, 'fred@sitebuilt.net', 'cascada', 'CYURD006', 'user'),
(276, 'fred@sitebuilt.net', 'hvac', 'CYURD006', 'user'),
(277, 'fred@sitebuilt.net', 'lightsoff', 'CYURD006', 'user'),
(278, 'fred@sitebuilt.net', 'pahoRawSB', 'CYURD006', 'user'),
(279, 'fred@sitebuilt.net', 'shroom', 'CYURD006', 'user'),
(280, 'fred@sitebuilt.net', 'admind', 'CYURD007', 'user'),
(281, 'fred@sitebuilt.net', 'cascada', 'CYURD007', 'user'),
(282, 'fred@sitebuilt.net', 'hvac', 'CYURD007', 'user'),
(283, 'fred@sitebuilt.net', 'lightsoff', 'CYURD007', 'user'),
(284, 'fred@sitebuilt.net', 'pahoRawSB', 'CYURD007', 'user'),
(285, 'fred@sitebuilt.net', 'shroom', 'CYURD007', 'user'),
(286, 'fred@sitebuilt.net', 'admind', 'CYURD008', 'user'),
(287, 'fred@sitebuilt.net', 'cascada', 'CYURD008', 'user'),
(288, 'fred@sitebuilt.net', 'hvac', 'CYURD008', 'user'),
(289, 'fred@sitebuilt.net', 'lightsoff', 'CYURD008', 'user'),
(290, 'fred@sitebuilt.net', 'pahoRawSB', 'CYURD008', 'user'),
(291, 'fred@sitebuilt.net', 'shroom', 'CYURD008', 'user'),
(292, 'mckenna.tim@gmail.com', 'admind', 'CYURBAD', 'user'),
(293, 'mckenna.tim@gmail.com', 'cascada', 'CYURBAD', 'user'),
(294, 'mckenna.tim@gmail.com', 'hvac', 'CYURBAD', 'user'),
(295, 'mckenna.tim@gmail.com', 'lightsoff', 'CYURBAD', 'user'),
(296, 'mckenna.tim@gmail.com', 'pahoRawSB', 'CYURBAD', 'user'),
(297, 'mckenna.tim@gmail.com', 'shroom', 'CYURBAD', 'user'),
(298, 'mckenna.tim@gmail.com', 'admind', 'CYURD001', 'user'),
(299, 'mckenna.tim@gmail.com', 'cascada', 'CYURD001', 'user'),
(300, 'mckenna.tim@gmail.com', 'hvac', 'CYURD001', 'user'),
(301, 'mckenna.tim@gmail.com', 'lightsoff', 'CYURD001', 'user'),
(302, 'mckenna.tim@gmail.com', 'pahoRawSB', 'CYURD001', 'user'),
(303, 'mckenna.tim@gmail.com', 'shroom', 'CYURD001', 'user'),
(304, 'mckenna.tim@gmail.com', 'admind', 'CYURD002', 'user'),
(305, 'mckenna.tim@gmail.com', 'cascada', 'CYURD002', 'user'),
(306, 'mckenna.tim@gmail.com', 'hvac', 'CYURD002', 'user'),
(307, 'mckenna.tim@gmail.com', 'lightsoff', 'CYURD002', 'user'),
(308, 'mckenna.tim@gmail.com', 'pahoRawSB', 'CYURD002', 'user'),
(309, 'mckenna.tim@gmail.com', 'shroom', 'CYURD002', 'user'),
(310, 'mckenna.tim@gmail.com', 'admind', 'CYURD003', 'user'),
(311, 'mckenna.tim@gmail.com', 'cascada', 'CYURD003', 'user'),
(312, 'mckenna.tim@gmail.com', 'hvac', 'CYURD003', 'user'),
(313, 'mckenna.tim@gmail.com', 'lightsoff', 'CYURD003', 'user'),
(314, 'mckenna.tim@gmail.com', 'pahoRawSB', 'CYURD003', 'user'),
(315, 'mckenna.tim@gmail.com', 'shroom', 'CYURD003', 'user'),
(316, 'mckenna.tim@gmail.com', 'admind', 'CYURD004', 'user'),
(317, 'mckenna.tim@gmail.com', 'cascada', 'CYURD004', 'user'),
(318, 'mckenna.tim@gmail.com', 'hvac', 'CYURD004', 'user'),
(319, 'mckenna.tim@gmail.com', 'lightsoff', 'CYURD004', 'user'),
(320, 'mckenna.tim@gmail.com', 'pahoRawSB', 'CYURD004', 'user'),
(321, 'mckenna.tim@gmail.com', 'shroom', 'CYURD004', 'user'),
(322, 'mckenna.tim@gmail.com', 'admind', 'CYURD006', 'user'),
(323, 'mckenna.tim@gmail.com', 'cascada', 'CYURD006', 'user'),
(324, 'mckenna.tim@gmail.com', 'hvac', 'CYURD006', 'user'),
(325, 'mckenna.tim@gmail.com', 'lightsoff', 'CYURD006', 'user'),
(326, 'mckenna.tim@gmail.com', 'pahoRawSB', 'CYURD006', 'user'),
(327, 'mckenna.tim@gmail.com', 'shroom', 'CYURD006', 'user'),
(328, 'mckenna.tim@gmail.com', 'admind', 'CYURD007', 'user'),
(329, 'mckenna.tim@gmail.com', 'cascada', 'CYURD007', 'user'),
(330, 'mckenna.tim@gmail.com', 'hvac', 'CYURD007', 'user'),
(331, 'mckenna.tim@gmail.com', 'lightsoff', 'CYURD007', 'user'),
(332, 'mckenna.tim@gmail.com', 'pahoRawSB', 'CYURD007', 'user'),
(333, 'mckenna.tim@gmail.com', 'shroom', 'CYURD007', 'user'),
(334, 'mckenna.tim@gmail.com', 'admind', 'CYURD008', 'user'),
(335, 'mckenna.tim@gmail.com', 'cascada', 'CYURD008', 'user'),
(336, 'mckenna.tim@gmail.com', 'hvac', 'CYURD008', 'user'),
(337, 'mckenna.tim@gmail.com', 'lightsoff', 'CYURD008', 'user'),
(338, 'mckenna.tim@gmail.com', 'pahoRawSB', 'CYURD008', 'user'),
(339, 'mckenna.tim@gmail.com', 'shroom', 'CYURD008', 'user'),
(340, 'perimckenna@gmail.com', 'admind', 'CYURBAD', 'user'),
(341, 'perimckenna@gmail.com', 'cascada', 'CYURBAD', 'user'),
(342, 'perimckenna@gmail.com', 'hvac', 'CYURBAD', 'user'),
(343, 'perimckenna@gmail.com', 'lightsoff', 'CYURBAD', 'user'),
(344, 'perimckenna@gmail.com', 'pahoRawSB', 'CYURBAD', 'user'),
(345, 'perimckenna@gmail.com', 'shroom', 'CYURBAD', 'user'),
(346, 'perimckenna@gmail.com', 'admind', 'CYURD001', 'user'),
(347, 'perimckenna@gmail.com', 'cascada', 'CYURD001', 'user'),
(348, 'perimckenna@gmail.com', 'hvac', 'CYURD001', 'user'),
(349, 'perimckenna@gmail.com', 'lightsoff', 'CYURD001', 'user'),
(350, 'perimckenna@gmail.com', 'pahoRawSB', 'CYURD001', 'user'),
(351, 'perimckenna@gmail.com', 'shroom', 'CYURD001', 'user'),
(352, 'perimckenna@gmail.com', 'admind', 'CYURD002', 'user'),
(353, 'perimckenna@gmail.com', 'cascada', 'CYURD002', 'user'),
(354, 'perimckenna@gmail.com', 'hvac', 'CYURD002', 'user'),
(355, 'perimckenna@gmail.com', 'lightsoff', 'CYURD002', 'user'),
(356, 'perimckenna@gmail.com', 'pahoRawSB', 'CYURD002', 'user'),
(357, 'perimckenna@gmail.com', 'shroom', 'CYURD002', 'user'),
(358, 'perimckenna@gmail.com', 'admind', 'CYURD003', 'user'),
(359, 'perimckenna@gmail.com', 'cascada', 'CYURD003', 'user'),
(360, 'perimckenna@gmail.com', 'hvac', 'CYURD003', 'user'),
(361, 'perimckenna@gmail.com', 'lightsoff', 'CYURD003', 'user'),
(362, 'perimckenna@gmail.com', 'pahoRawSB', 'CYURD003', 'user'),
(363, 'perimckenna@gmail.com', 'shroom', 'CYURD003', 'user'),
(364, 'perimckenna@gmail.com', 'admind', 'CYURD004', 'user'),
(365, 'perimckenna@gmail.com', 'cascada', 'CYURD004', 'user'),
(366, 'perimckenna@gmail.com', 'hvac', 'CYURD004', 'user'),
(367, 'perimckenna@gmail.com', 'lightsoff', 'CYURD004', 'user'),
(368, 'perimckenna@gmail.com', 'pahoRawSB', 'CYURD004', 'user'),
(369, 'perimckenna@gmail.com', 'shroom', 'CYURD004', 'user'),
(370, 'perimckenna@gmail.com', 'admind', 'CYURD006', 'user'),
(371, 'perimckenna@gmail.com', 'cascada', 'CYURD006', 'user'),
(372, 'perimckenna@gmail.com', 'hvac', 'CYURD006', 'user'),
(373, 'perimckenna@gmail.com', 'lightsoff', 'CYURD006', 'user'),
(374, 'perimckenna@gmail.com', 'pahoRawSB', 'CYURD006', 'user'),
(375, 'perimckenna@gmail.com', 'shroom', 'CYURD006', 'user'),
(376, 'perimckenna@gmail.com', 'admind', 'CYURD007', 'user'),
(377, 'perimckenna@gmail.com', 'cascada', 'CYURD007', 'user'),
(378, 'perimckenna@gmail.com', 'hvac', 'CYURD007', 'user'),
(379, 'perimckenna@gmail.com', 'lightsoff', 'CYURD007', 'user'),
(380, 'perimckenna@gmail.com', 'pahoRawSB', 'CYURD007', 'user'),
(381, 'perimckenna@gmail.com', 'shroom', 'CYURD007', 'user'),
(382, 'perimckenna@gmail.com', 'admind', 'CYURD008', 'user'),
(383, 'perimckenna@gmail.com', 'cascada', 'CYURD008', 'user'),
(384, 'perimckenna@gmail.com', 'hvac', 'CYURD008', 'user'),
(385, 'perimckenna@gmail.com', 'lightsoff', 'CYURD008', 'user'),
(386, 'perimckenna@gmail.com', 'pahoRawSB', 'CYURD008', 'user'),
(387, 'perimckenna@gmail.com', 'shroom', 'CYURD008', 'user'),
(388, 'tim2@sitebuilt.net', 'admind', 'CYURBAD', 'user'),
(389, 'tim2@sitebuilt.net', 'cascada', 'CYURBAD', 'user'),
(390, 'tim2@sitebuilt.net', 'hvac', 'CYURBAD', 'user'),
(391, 'tim2@sitebuilt.net', 'lightsoff', 'CYURBAD', 'user'),
(392, 'tim2@sitebuilt.net', 'pahoRawSB', 'CYURBAD', 'user'),
(393, 'tim2@sitebuilt.net', 'shroom', 'CYURBAD', 'user'),
(394, 'tim2@sitebuilt.net', 'admind', 'CYURD001', 'user'),
(395, 'tim2@sitebuilt.net', 'cascada', 'CYURD001', 'user'),
(396, 'tim2@sitebuilt.net', 'hvac', 'CYURD001', 'user'),
(397, 'tim2@sitebuilt.net', 'lightsoff', 'CYURD001', 'user'),
(398, 'tim2@sitebuilt.net', 'pahoRawSB', 'CYURD001', 'user'),
(399, 'tim2@sitebuilt.net', 'shroom', 'CYURD001', 'user'),
(400, 'tim2@sitebuilt.net', 'admind', 'CYURD002', 'user'),
(401, 'tim2@sitebuilt.net', 'cascada', 'CYURD002', 'user'),
(402, 'tim2@sitebuilt.net', 'hvac', 'CYURD002', 'user'),
(403, 'tim2@sitebuilt.net', 'lightsoff', 'CYURD002', 'user'),
(404, 'tim2@sitebuilt.net', 'pahoRawSB', 'CYURD002', 'user'),
(405, 'tim2@sitebuilt.net', 'shroom', 'CYURD002', 'user'),
(406, 'tim2@sitebuilt.net', 'admind', 'CYURD003', 'user'),
(407, 'tim2@sitebuilt.net', 'cascada', 'CYURD003', 'user'),
(408, 'tim2@sitebuilt.net', 'hvac', 'CYURD003', 'user'),
(409, 'tim2@sitebuilt.net', 'lightsoff', 'CYURD003', 'user'),
(410, 'tim2@sitebuilt.net', 'pahoRawSB', 'CYURD003', 'user'),
(411, 'tim2@sitebuilt.net', 'shroom', 'CYURD003', 'user'),
(412, 'tim2@sitebuilt.net', 'admind', 'CYURD004', 'user'),
(413, 'tim2@sitebuilt.net', 'cascada', 'CYURD004', 'user'),
(414, 'tim2@sitebuilt.net', 'hvac', 'CYURD004', 'user'),
(415, 'tim2@sitebuilt.net', 'lightsoff', 'CYURD004', 'user'),
(416, 'tim2@sitebuilt.net', 'pahoRawSB', 'CYURD004', 'user'),
(417, 'tim2@sitebuilt.net', 'shroom', 'CYURD004', 'user'),
(418, 'tim2@sitebuilt.net', 'admind', 'CYURD006', 'user'),
(419, 'tim2@sitebuilt.net', 'cascada', 'CYURD006', 'user'),
(420, 'tim2@sitebuilt.net', 'hvac', 'CYURD006', 'user'),
(421, 'tim2@sitebuilt.net', 'lightsoff', 'CYURD006', 'user'),
(422, 'tim2@sitebuilt.net', 'pahoRawSB', 'CYURD006', 'user'),
(423, 'tim2@sitebuilt.net', 'shroom', 'CYURD006', 'user'),
(424, 'tim2@sitebuilt.net', 'admind', 'CYURD007', 'user'),
(425, 'tim2@sitebuilt.net', 'cascada', 'CYURD007', 'user'),
(426, 'tim2@sitebuilt.net', 'hvac', 'CYURD007', 'user'),
(427, 'tim2@sitebuilt.net', 'lightsoff', 'CYURD007', 'user'),
(428, 'tim2@sitebuilt.net', 'pahoRawSB', 'CYURD007', 'user'),
(429, 'tim2@sitebuilt.net', 'shroom', 'CYURD007', 'user'),
(430, 'tim2@sitebuilt.net', 'admind', 'CYURD008', 'user'),
(431, 'tim2@sitebuilt.net', 'cascada', 'CYURD008', 'user'),
(432, 'tim2@sitebuilt.net', 'hvac', 'CYURD008', 'user'),
(433, 'tim2@sitebuilt.net', 'lightsoff', 'CYURD008', 'user'),
(434, 'tim2@sitebuilt.net', 'pahoRawSB', 'CYURD008', 'user'),
(435, 'tim2@sitebuilt.net', 'shroom', 'CYURD008', 'user'),
(436, 'tim3@sitebuilt.net', 'admind', 'CYURBAD', 'user'),
(437, 'tim3@sitebuilt.net', 'cascada', 'CYURBAD', 'user'),
(438, 'tim3@sitebuilt.net', 'hvac', 'CYURBAD', 'user'),
(439, 'tim3@sitebuilt.net', 'lightsoff', 'CYURBAD', 'user'),
(440, 'tim3@sitebuilt.net', 'pahoRawSB', 'CYURBAD', 'user'),
(441, 'tim3@sitebuilt.net', 'shroom', 'CYURBAD', 'user'),
(442, 'tim3@sitebuilt.net', 'admind', 'CYURD001', 'user'),
(443, 'tim3@sitebuilt.net', 'cascada', 'CYURD001', 'user'),
(444, 'tim3@sitebuilt.net', 'hvac', 'CYURD001', 'user'),
(445, 'tim3@sitebuilt.net', 'lightsoff', 'CYURD001', 'user'),
(446, 'tim3@sitebuilt.net', 'pahoRawSB', 'CYURD001', 'user'),
(447, 'tim3@sitebuilt.net', 'shroom', 'CYURD001', 'user'),
(448, 'tim3@sitebuilt.net', 'admind', 'CYURD002', 'user'),
(449, 'tim3@sitebuilt.net', 'cascada', 'CYURD002', 'user'),
(450, 'tim3@sitebuilt.net', 'hvac', 'CYURD002', 'user'),
(451, 'tim3@sitebuilt.net', 'lightsoff', 'CYURD002', 'user'),
(452, 'tim3@sitebuilt.net', 'pahoRawSB', 'CYURD002', 'user'),
(453, 'tim3@sitebuilt.net', 'shroom', 'CYURD002', 'user'),
(454, 'tim3@sitebuilt.net', 'admind', 'CYURD003', 'user'),
(455, 'tim3@sitebuilt.net', 'cascada', 'CYURD003', 'user'),
(456, 'tim3@sitebuilt.net', 'hvac', 'CYURD003', 'user'),
(457, 'tim3@sitebuilt.net', 'lightsoff', 'CYURD003', 'user'),
(458, 'tim3@sitebuilt.net', 'pahoRawSB', 'CYURD003', 'user'),
(459, 'tim3@sitebuilt.net', 'shroom', 'CYURD003', 'user'),
(460, 'tim3@sitebuilt.net', 'admind', 'CYURD004', 'user'),
(461, 'tim3@sitebuilt.net', 'cascada', 'CYURD004', 'user'),
(462, 'tim3@sitebuilt.net', 'hvac', 'CYURD004', 'user'),
(463, 'tim3@sitebuilt.net', 'lightsoff', 'CYURD004', 'user'),
(464, 'tim3@sitebuilt.net', 'pahoRawSB', 'CYURD004', 'user'),
(465, 'tim3@sitebuilt.net', 'shroom', 'CYURD004', 'user'),
(466, 'tim3@sitebuilt.net', 'admind', 'CYURD006', 'user'),
(467, 'tim3@sitebuilt.net', 'cascada', 'CYURD006', 'user'),
(468, 'tim3@sitebuilt.net', 'hvac', 'CYURD006', 'user'),
(469, 'tim3@sitebuilt.net', 'lightsoff', 'CYURD006', 'user'),
(470, 'tim3@sitebuilt.net', 'pahoRawSB', 'CYURD006', 'user'),
(471, 'tim3@sitebuilt.net', 'shroom', 'CYURD006', 'user'),
(472, 'tim3@sitebuilt.net', 'admind', 'CYURD007', 'user'),
(473, 'tim3@sitebuilt.net', 'cascada', 'CYURD007', 'user'),
(474, 'tim3@sitebuilt.net', 'hvac', 'CYURD007', 'user'),
(475, 'tim3@sitebuilt.net', 'lightsoff', 'CYURD007', 'user'),
(476, 'tim3@sitebuilt.net', 'pahoRawSB', 'CYURD007', 'user'),
(477, 'tim3@sitebuilt.net', 'shroom', 'CYURD007', 'user'),
(478, 'tim3@sitebuilt.net', 'admind', 'CYURD008', 'user'),
(479, 'tim3@sitebuilt.net', 'cascada', 'CYURD008', 'user'),
(480, 'tim3@sitebuilt.net', 'hvac', 'CYURD008', 'user'),
(481, 'tim3@sitebuilt.net', 'lightsoff', 'CYURD008', 'user'),
(482, 'tim3@sitebuilt.net', 'pahoRawSB', 'CYURD008', 'user'),
(483, 'tim3@sitebuilt.net', 'shroom', 'CYURD008', 'user'),
(484, 'tim@sitebuilt.net', 'admind', 'CYURBAD', 'user'),
(485, 'tim@sitebuilt.net', 'cascada', 'CYURBAD', 'user'),
(486, 'tim@sitebuilt.net', 'hvac', 'CYURBAD', 'user'),
(487, 'tim@sitebuilt.net', 'lightsoff', 'CYURBAD', 'user'),
(488, 'tim@sitebuilt.net', 'pahoRawSB', 'CYURBAD', 'user'),
(489, 'tim@sitebuilt.net', 'shroom', 'CYURBAD', 'user'),
(490, 'tim@sitebuilt.net', 'admind', 'CYURD001', 'user'),
(491, 'tim@sitebuilt.net', 'cascada', 'CYURD001', 'user'),
(492, 'tim@sitebuilt.net', 'hvac', 'CYURD001', 'user'),
(493, 'tim@sitebuilt.net', 'lightsoff', 'CYURD001', 'user'),
(494, 'tim@sitebuilt.net', 'pahoRawSB', 'CYURD001', 'user'),
(495, 'tim@sitebuilt.net', 'shroom', 'CYURD001', 'user'),
(496, 'tim@sitebuilt.net', 'admind', 'CYURD002', 'user'),
(497, 'tim@sitebuilt.net', 'cascada', 'CYURD002', 'user'),
(498, 'tim@sitebuilt.net', 'hvac', 'CYURD002', 'user'),
(499, 'tim@sitebuilt.net', 'lightsoff', 'CYURD002', 'user'),
(500, 'tim@sitebuilt.net', 'pahoRawSB', 'CYURD002', 'user'),
(501, 'tim@sitebuilt.net', 'shroom', 'CYURD002', 'user'),
(502, 'tim@sitebuilt.net', 'admind', 'CYURD003', 'user'),
(503, 'tim@sitebuilt.net', 'cascada', 'CYURD003', 'user'),
(504, 'tim@sitebuilt.net', 'hvac', 'CYURD003', 'user'),
(505, 'tim@sitebuilt.net', 'lightsoff', 'CYURD003', 'user'),
(506, 'tim@sitebuilt.net', 'pahoRawSB', 'CYURD003', 'user'),
(507, 'tim@sitebuilt.net', 'shroom', 'CYURD003', 'user'),
(508, 'tim@sitebuilt.net', 'admind', 'CYURD004', 'user'),
(509, 'tim@sitebuilt.net', 'cascada', 'CYURD004', 'user'),
(510, 'tim@sitebuilt.net', 'hvac', 'CYURD004', 'user'),
(511, 'tim@sitebuilt.net', 'lightsoff', 'CYURD004', 'user'),
(512, 'tim@sitebuilt.net', 'pahoRawSB', 'CYURD004', 'user'),
(513, 'tim@sitebuilt.net', 'shroom', 'CYURD004', 'user'),
(514, 'tim@sitebuilt.net', 'admind', 'CYURD006', 'user'),
(515, 'tim@sitebuilt.net', 'cascada', 'CYURD006', 'user'),
(516, 'tim@sitebuilt.net', 'hvac', 'CYURD006', 'user'),
(517, 'tim@sitebuilt.net', 'lightsoff', 'CYURD006', 'user'),
(518, 'tim@sitebuilt.net', 'pahoRawSB', 'CYURD006', 'user'),
(519, 'tim@sitebuilt.net', 'shroom', 'CYURD006', 'user'),
(520, 'tim@sitebuilt.net', 'admind', 'CYURD007', 'user'),
(521, 'tim@sitebuilt.net', 'cascada', 'CYURD007', 'user'),
(522, 'tim@sitebuilt.net', 'hvac', 'CYURD007', 'user'),
(523, 'tim@sitebuilt.net', 'lightsoff', 'CYURD007', 'user'),
(524, 'tim@sitebuilt.net', 'pahoRawSB', 'CYURD007', 'user'),
(525, 'tim@sitebuilt.net', 'shroom', 'CYURD007', 'user'),
(526, 'tim@sitebuilt.net', 'admind', 'CYURD008', 'user'),
(527, 'tim@sitebuilt.net', 'cascada', 'CYURD008', 'user'),
(528, 'tim@sitebuilt.net', 'hvac', 'CYURD008', 'user'),
(529, 'tim@sitebuilt.net', 'lightsoff', 'CYURD008', 'user'),
(530, 'tim@sitebuilt.net', 'pahoRawSB', 'CYURD008', 'user'),
(531, 'tim@sitebuilt.net', 'shroom', 'CYURD008', 'user');

-- --------------------------------------------------------

--
-- Table structure for table `user_app_loc`
--

CREATE TABLE `user_app_loc` (
  `id` int(11) NOT NULL,
  `userid` varchar(60) NOT NULL,
  `appid` varchar(20) DEFAULT NULL,
  `role` varchar(20) DEFAULT NULL,
  `locid` varchar(40) DEFAULT NULL,
  `devid` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_app_loc`
--

INSERT INTO `user_app_loc` (`id`, `userid`, `appid`, `role`, `locid`, `devid`) VALUES
(1, 'anybody', 'admind', 'user', '12ParleyVale', NULL),
(2, 'anybody', 'hvac', 'user', '794048thAvS', NULL),
(3, 'anybody', 'lightsoff', 'user', '12ParleyVale', NULL),
(4, 'anybody', 'pahoRawSB', 'user', '12ParleyVale', NULL),
(5, 'anybody', 'shroom', 'user', '255Chestnut', NULL),
(6, 'anybody', 'cascada', 'user', '12ParleyVale', NULL),
(7, 'clipperjohn@gmail.com ', 'admind', 'user', '4505NHaight', NULL),
(8, 'clipperjohn@gmail.com ', 'cascada', 'user', '12ParleyVale', NULL),
(9, 'clipperjohn@gmail.com ', 'hvac', 'user', '794048thAvS', NULL),
(10, 'clipperjohn@gmail.com ', 'lightsoff', 'user', '794048thAvS', NULL),
(11, 'clipperjohn@gmail.com ', 'pahoRawSB', 'user', '255Chestnut', NULL),
(12, 'clipperjohn@gmail.com ', 'shroom', 'user', '255Chestnut', NULL),
(13, 'clippingersue@gmail.com', 'admind', 'user', '255Chestnut', NULL),
(14, 'clippingersue@gmail.com', 'cascada', 'user', '794048thAvS', NULL),
(15, 'clippingersue@gmail.com', 'hvac', 'user', '4505NHaight', NULL),
(16, 'clippingersue@gmail.com', 'lightsoff', 'user', '4505NHaight', NULL),
(17, 'clippingersue@gmail.com', 'pahoRawSB', 'user', '12ParleyVale', NULL),
(18, 'clippingersue@gmail.com', 'shroom', 'user', '794048thAvS', NULL),
(19, 'fred@sitebuilt.net', 'admind', 'user', '4505NHaight', NULL),
(20, 'fred@sitebuilt.net', 'cascada', 'user', '794048thAvS', NULL),
(21, 'fred@sitebuilt.net', 'hvac', 'user', '4505NHaight', NULL),
(22, 'fred@sitebuilt.net', 'lightsoff', 'user', '794048thAvS', NULL),
(23, 'fred@sitebuilt.net', 'pahoRawSB', 'user', '794048thAvS', NULL),
(24, 'fred@sitebuilt.net', 'shroom', 'user', '255Chestnut', NULL),
(25, 'mckenna.tim@gmail.com', 'admind', 'user', '794048thAvS', NULL),
(26, 'mckenna.tim@gmail.com', 'cascada', 'user', '12ParleyVale', NULL),
(27, 'mckenna.tim@gmail.com', 'hvac', 'user', '12ParleyVale', NULL),
(28, 'mckenna.tim@gmail.com', 'lightsoff', 'user', '4505NHaight', NULL),
(29, 'mckenna.tim@gmail.com', 'pahoRawSB', 'user', '255Chestnut', NULL),
(30, 'mckenna.tim@gmail.com', 'shroom', 'user', '12ParleyVale', NULL),
(31, 'perimckenna@gmail.com', 'admind', 'user', '12ParleyVale', NULL),
(32, 'perimckenna@gmail.com', 'cascada', 'user', '794048thAvS', NULL),
(33, 'perimckenna@gmail.com', 'hvac', 'user', '255Chestnut', NULL),
(34, 'perimckenna@gmail.com', 'lightsoff', 'user', '794048thAvS', NULL),
(35, 'perimckenna@gmail.com', 'pahoRawSB', 'user', '12ParleyVale', NULL),
(36, 'perimckenna@gmail.com', 'shroom', 'user', '255Chestnut', NULL),
(37, 'tim2@sitebuilt.net', 'admind', 'user', '4505NHaight', NULL),
(38, 'tim2@sitebuilt.net', 'cascada', 'user', '255Chestnut', NULL),
(39, 'tim2@sitebuilt.net', 'hvac', 'user', '794048thAvS', NULL),
(40, 'tim2@sitebuilt.net', 'lightsoff', 'user', '12ParleyVale', NULL),
(41, 'tim2@sitebuilt.net', 'pahoRawSB', 'user', '12ParleyVale', NULL),
(42, 'tim2@sitebuilt.net', 'shroom', 'user', '12ParleyVale', NULL),
(43, 'tim3@sitebuilt.net', 'admind', 'user', '12ParleyVale', NULL),
(44, 'tim3@sitebuilt.net', 'cascada', 'user', '794048thAvS', NULL),
(45, 'tim3@sitebuilt.net', 'hvac', 'user', '4505NHaight', NULL),
(46, 'tim3@sitebuilt.net', 'lightsoff', 'user', '4505NHaight', NULL),
(47, 'tim3@sitebuilt.net', 'pahoRawSB', 'user', '794048thAvS', NULL),
(48, 'tim3@sitebuilt.net', 'shroom', 'user', '794048thAvS', NULL),
(49, 'tim@sitebuilt.net', 'admind', 'user', '794048thAvS', NULL),
(50, 'tim@sitebuilt.net', 'cascada', 'user', '255Chestnut', NULL),
(51, 'tim@sitebuilt.net', 'hvac', 'user', '4505NHaight', NULL),
(52, 'tim@sitebuilt.net', 'lightsoff', 'user', '4505NHaight', NULL),
(53, 'tim@sitebuilt.net', 'pahoRawSB', 'user', '12ParleyVale', NULL),
(54, 'tim@sitebuilt.net', 'shroom', 'user', '12ParleyVale', NULL),
(55, 'tim@sitebuilt.net', 'hvac', 'user', '12ParleyVale', 'CYURD006'),
(56, 'tim@sitebuilt.net', 'hvac', 'user', '255Chestnut', 'CYURD051'),
(57, 'tim@sitebuilt.net', 'hvac', 'user', '12ParleyVale', 'CYURD003'),
(58, 'tim@sitebuilt.net', 'hvac', 'user', '255Chestnut', 'CYURD050');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `apps`
--
ALTER TABLE `apps`
  ADD PRIMARY KEY (`id`),
  ADD KEY `appid` (`appid`),
  ADD KEY `appurl` (`appurl`),
  ADD KEY `apiurl` (`apiurl`);

--
-- Indexes for table `biz`
--
ALTER TABLE `biz`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bizid` (`bizid`),
  ADD KEY `bizname` (`bizname`),
  ADD KEY `owner` (`owner`);

--
-- Indexes for table `bizapp`
--
ALTER TABLE `bizapp`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `main` (`bizid`,`appid`),
  ADD KEY `bizid` (`bizid`),
  ADD KEY `appid` (`appid`);

--
-- Indexes for table `devices`
--
ALTER TABLE `devices`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `devid` (`devid`),
  ADD KEY `bizid` (`bizid`),
  ADD KEY `specs` (`specs`),
  ADD KEY `owner` (`owner`),
  ADD KEY `location` (`location`),
  ADD KEY `timezone` (`timezone`);

--
-- Indexes for table `devs`
--
ALTER TABLE `devs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `devid` (`devid`),
  ADD KEY `bizid` (`bizid`),
  ADD KEY `locid` (`locid`),
  ADD KEY `owner` (`owner`);

--
-- Indexes for table `devuserapp`
--
ALTER TABLE `devuserapp`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `main` (`devid`,`userid`,`bizid`,`appid`),
  ADD KEY `devid` (`devid`),
  ADD KEY `userid` (`userid`),
  ADD KEY `appid` (`appid`),
  ADD KEY `role` (`role`),
  ADD KEY `auth` (`auth`);

--
-- Indexes for table `locations`
--
ALTER TABLE `locations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `locid` (`locid`),
  ADD KEY `timezone` (`timezone`);

--
-- Indexes for table `scheds`
--
ALTER TABLE `scheds`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `main` (`devid`,`senrel`,`dow`) USING BTREE,
  ADD KEY `devid` (`devid`),
  ADD KEY `dow` (`dow`),
  ADD KEY `senrel` (`senrel`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userid` (`userid`);

--
-- Indexes for table `user_app_dev`
--
ALTER TABLE `user_app_dev`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userid` (`userid`),
  ADD KEY `appid` (`appid`),
  ADD KEY `devid` (`devid`),
  ADD KEY `role` (`role`);

--
-- Indexes for table `user_app_loc`
--
ALTER TABLE `user_app_loc`
  ADD PRIMARY KEY (`id`),
  ADD KEY `locid` (`locid`),
  ADD KEY `devid` (`devid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `apps`
--
ALTER TABLE `apps`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `biz`
--
ALTER TABLE `biz`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `bizapp`
--
ALTER TABLE `bizapp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=388;
--
-- AUTO_INCREMENT for table `devices`
--
ALTER TABLE `devices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=125;
--
-- AUTO_INCREMENT for table `devs`
--
ALTER TABLE `devs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT for table `devuserapp`
--
ALTER TABLE `devuserapp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=738;
--
-- AUTO_INCREMENT for table `locations`
--
ALTER TABLE `locations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1004;
--
-- AUTO_INCREMENT for table `scheds`
--
ALTER TABLE `scheds`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1008;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=400;
--
-- AUTO_INCREMENT for table `user_app_dev`
--
ALTER TABLE `user_app_dev`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=611;
--
-- AUTO_INCREMENT for table `user_app_loc`
--
ALTER TABLE `user_app_loc`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
