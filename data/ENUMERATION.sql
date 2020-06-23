-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jun 23, 2020 at 07:37 AM
-- Server version: 10.4.13-MariaDB-1:10.4.13+maria~buster
-- PHP Version: 7.3.14-1~deb10u1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ofbiz`
--

-- --------------------------------------------------------

--
-- Table structure for table `ENUMERATION`
--

CREATE TABLE `ENUMERATION` (
  `ENUM_ID` varchar(20) NOT NULL,
  `ENUM_TYPE_ID` varchar(20) DEFAULT NULL,
  `ENUM_CODE` varchar(60) DEFAULT NULL,
  `SEQUENCE_ID` varchar(20) DEFAULT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `LAST_UPDATED_STAMP` datetime(3) DEFAULT NULL,
  `LAST_UPDATED_TX_STAMP` datetime(3) DEFAULT NULL,
  `CREATED_STAMP` datetime(3) DEFAULT NULL,
  `CREATED_TX_STAMP` datetime(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ENUMERATION`
--

INSERT INTO `ENUMERATION` (`ENUM_ID`, `ENUM_TYPE_ID`, `ENUM_CODE`, `SEQUENCE_ID`, `DESCRIPTION`, `LAST_UPDATED_STAMP`, `LAST_UPDATED_TX_STAMP`, `CREATED_STAMP`, `CREATED_TX_STAMP`) VALUES
('ANN', 'BFIN_DIVFREQ', 'ANN', '03', 'ANNUALLY', '2019-07-31 13:27:29.084', '2019-07-31 13:27:29.065', '2019-07-31 13:27:29.084', '2019-07-31 13:27:29.065'),
('BO', 'BFIN_SECTOR', 'BO', '02', 'BONDS', '2019-07-31 13:27:29.084', '2019-07-31 13:27:29.065', '2019-07-31 13:27:29.084', '2019-07-31 13:27:29.065'),
('CAP', 'BFIN_BROKER', 'CAP', '04', 'CAPTRADER', '2019-07-31 13:27:29.084', '2019-07-31 13:27:29.065', '2019-07-31 13:27:29.084', '2019-07-31 13:27:29.065'),
('CO', 'BFIN_SECTOR', 'CO', '06', 'CONSUMER', '2019-07-31 13:27:29.084', '2019-07-31 13:27:29.065', '2019-07-31 13:27:29.084', '2019-07-31 13:27:29.065'),
('DEG', 'BFIN_BROKER', 'DEG', '02', 'DEGIRO', '2019-07-31 13:27:29.084', '2019-07-31 13:27:29.065', '2019-07-31 13:27:29.084', '2019-07-31 13:27:29.065'),
('EN', 'BFIN_SECTOR', 'EN', '10', 'ENERGY', '2019-07-31 13:27:29.084', '2019-07-31 13:27:29.065', '2019-07-31 13:27:29.084', '2019-07-31 13:27:29.065'),
('ETF', 'BFIN_PRODUCT_TYPE', 'ETF', '02', 'ETF', '2019-07-31 13:27:29.084', '2019-07-31 13:27:29.065', '2019-07-31 13:27:29.084', '2019-07-31 13:27:29.065'),
('FI', 'BFIN_SECTOR', 'FI', '01', 'FINANCE', '2019-07-31 13:27:29.084', '2019-07-31 13:27:29.065', '2019-07-31 13:27:29.084', '2019-07-31 13:27:29.065'),
('HC', 'BFIN_SECTOR', 'HC', '05', 'HEALTCARE', '2019-07-31 13:27:29.084', '2019-07-31 13:27:29.065', '2019-07-31 13:27:29.084', '2019-07-31 13:27:29.065'),
('IB', 'BFIN_BROKER', 'IB', '01', 'Interactive Brokers', '2019-07-31 13:27:29.084', '2019-07-31 13:27:29.065', '2019-07-31 13:27:29.084', '2019-07-31 13:27:29.065'),
('IND', 'BFIN_SECTOR', 'IND', '08', 'INDUSTRIAL', '2019-07-31 13:27:29.084', '2019-07-31 13:27:29.065', '2019-07-31 13:27:29.084', '2019-07-31 13:27:29.065'),
('KBC', 'BFIN_BROKER', 'KBC', '03', 'KBC', '2019-07-31 13:27:29.084', '2019-07-31 13:27:29.065', '2019-07-31 13:27:29.084', '2019-07-31 13:27:29.065'),
('MON', 'BFIN_DIVFREQ', 'MON', '02', 'MONTHLY', '2019-07-31 13:27:29.084', '2019-07-31 13:27:29.065', '2019-07-31 13:27:29.084', '2019-07-31 13:27:29.065'),
('NYSE', 'BFIN_EXCHANGE', 'NYSE', '01', 'New York Stock Exchange', '2019-07-31 13:27:29.084', '2019-07-31 13:27:29.065', '2019-07-31 13:27:29.084', '2019-07-31 13:27:29.065'),
('QUAR', 'BFIN_DIVFREQ', 'QUAR', '01', 'QUARTERLY', '2019-07-31 13:27:29.084', '2019-07-31 13:27:29.065', '2019-07-31 13:27:29.084', '2019-07-31 13:27:29.065'),
('RE', 'BFIN_SECTOR', 'RE', '03', 'REAL ESTATE', '2019-07-31 13:27:29.084', '2019-07-31 13:27:29.065', '2019-07-31 13:27:29.084', '2019-07-31 13:27:29.065'),
('STOCK', 'BFIN_PRODUCT_TYPE', 'STOCK', '01', 'STOCK', '2019-07-31 13:27:29.084', '2019-07-31 13:27:29.065', '2019-07-31 13:27:29.084', '2019-07-31 13:27:29.065'),
('TE', 'BFIN_SECTOR', 'TE', '09', 'TECH', '2019-07-31 13:27:29.084', '2019-07-31 13:27:29.065', '2019-07-31 13:27:29.084', '2019-07-31 13:27:29.065'),
('TEL', 'BFIN_SECTOR', 'TEL', '07', 'TELECOM', '2019-07-31 13:27:29.084', '2019-07-31 13:27:29.065', '2019-07-31 13:27:29.084', '2019-07-31 13:27:29.065'),
('UT', 'BFIN_SECTOR', 'UT', '04', 'UTILITIES', '2019-07-31 13:27:29.084', '2019-07-31 13:27:29.065', '2019-07-31 13:27:29.084', '2019-07-31 13:27:29.065');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ENUMERATION`
--
ALTER TABLE `ENUMERATION`
  ADD PRIMARY KEY (`ENUM_ID`),
  ADD KEY `ENUM_TO_TYPE` (`ENUM_TYPE_ID`),
  ADD KEY `ENUMERATION_TXSTMP` (`LAST_UPDATED_TX_STAMP`),
  ADD KEY `ENUMERATION_TXCRTS` (`CREATED_TX_STAMP`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `ENUMERATION`
--
ALTER TABLE `ENUMERATION`
  ADD CONSTRAINT `ENUM_TO_TYPE` FOREIGN KEY (`ENUM_TYPE_ID`) REFERENCES `ENUMERATION_TYPE` (`ENUM_TYPE_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;