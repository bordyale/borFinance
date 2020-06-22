-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jun 22, 2020 at 02:56 PM
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
-- Table structure for table `BFIN_PRODUCT`
--

CREATE TABLE `BFIN_PRODUCT` (
  `PROD_ID` varchar(20) NOT NULL,
  `PROD_SYM` varchar(255) DEFAULT NULL,
  `PROD_NAME` varchar(255) DEFAULT NULL,
  `PRODUCT_TYPE` varchar(255) DEFAULT NULL,
  `LAST_UPDATED_STAMP` datetime(3) DEFAULT NULL,
  `LAST_UPDATED_TX_STAMP` datetime(3) DEFAULT NULL,
  `CREATED_STAMP` datetime(3) DEFAULT NULL,
  `CREATED_TX_STAMP` datetime(3) DEFAULT NULL,
  `DIV_FREQ_ID` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `BFIN_PRODUCT`
--

INSERT INTO `BFIN_PRODUCT` (`PROD_ID`, `PROD_SYM`, `PROD_NAME`, `PRODUCT_TYPE`, `LAST_UPDATED_STAMP`, `LAST_UPDATED_TX_STAMP`, `CREATED_STAMP`, `CREATED_TX_STAMP`, `DIV_FREQ_ID`) VALUES
('10041', 'KO', 'COCA COLA', 'STOCK', '2020-06-22 12:54:01.000', '2020-06-22 12:54:01.000', '2020-06-15 12:12:14.000', '2020-06-15 12:12:14.000', 'QUAR'),
('10050', 'BAC', 'BANK OF AMERICA CORPORATION', 'STOCK', '2020-06-22 12:54:17.000', '2020-06-22 12:54:17.000', '2020-06-16 14:13:41.000', '2020-06-16 14:13:41.000', 'QUAR'),
('10060', 'WFC', 'WELLS FARGO & C', 'STOCK', '2020-06-22 12:54:39.000', '2020-06-22 12:54:39.000', '2020-06-17 14:31:59.000', '2020-06-17 14:31:59.000', 'QUAR'),
('10061', 'AFL', 'AFLAC', 'STOCK', '2020-06-22 12:54:49.000', '2020-06-22 12:54:49.000', '2020-06-17 14:32:09.000', '2020-06-17 14:32:09.000', 'QUAR'),
('10062', 'JPM', 'JP MORGAN CHASE', 'STOCK', '2020-06-22 12:54:58.000', '2020-06-22 12:54:57.000', '2020-06-17 14:32:21.000', '2020-06-17 14:32:21.000', 'QUAR'),
('10063', 'TROW', 'T.ROWE PRICE GROUP, INC', 'STOCK', '2020-06-22 12:55:34.000', '2020-06-22 12:55:34.000', '2020-06-17 14:32:38.000', '2020-06-17 14:32:38.000', 'QUAR'),
('10064', 'MAIN', 'MAIN STREET CAPITAL', 'STOCK', '2020-06-22 12:55:49.000', '2020-06-22 12:55:49.000', '2020-06-17 14:32:51.000', '2020-06-17 14:32:51.000', 'MON'),
('10065', 'TD', 'TORONTO DOMINION BANK', 'STOCK', '2020-06-22 12:56:03.000', '2020-06-22 12:56:03.000', '2020-06-17 14:33:00.000', '2020-06-17 14:33:00.000', 'QUAR'),
('10066', 'RY', 'ROYAL BANK OF CANADA', 'STOCK', '2020-06-22 12:56:12.000', '2020-06-22 12:56:12.000', '2020-06-17 14:33:13.000', '2020-06-17 14:33:13.000', 'QUAR'),
('10067', 'LNC', 'LINCOLN NATIONAL CORPORATION', 'STOCK', '2020-06-22 12:56:24.000', '2020-06-22 12:56:24.000', '2020-06-17 14:33:26.000', '2020-06-17 14:33:26.000', 'QUAR'),
('10068', 'USB', 'U.S. BANKCORP', 'STOCK', '2020-06-22 12:56:39.000', '2020-06-22 12:56:39.000', '2020-06-17 14:33:39.000', '2020-06-17 14:33:39.000', 'QUAR'),
('10069', 'TRV', 'THE TRAVELERS COMPANIES', 'STOCK', '2020-06-22 12:56:51.000', '2020-06-22 12:56:51.000', '2020-06-17 14:33:50.000', '2020-06-17 14:33:50.000', 'QUAR'),
('10070', 'BMO', 'BANK OF MONTREAL', 'STOCK', '2020-06-22 12:57:05.000', '2020-06-22 12:57:05.000', '2020-06-17 14:33:59.000', '2020-06-17 14:33:59.000', 'QUAR'),
('10071', 'BK', 'THE BANK OF NEW YORK MELLON CORPORATION', 'STOCK', '2020-06-22 12:57:14.000', '2020-06-22 12:57:14.000', '2020-06-17 14:34:15.000', '2020-06-17 14:34:15.000', 'QUAR'),
('10072', 'UNM', 'UNUM GROUP', 'STOCK', '2020-06-22 12:57:24.000', '2020-06-22 12:57:24.000', '2020-06-17 14:34:27.000', '2020-06-17 14:34:27.000', 'QUAR'),
('10073', 'ISP.MIL', 'INTESA SAN PAOLO', 'STOCK', '2020-06-22 12:57:47.000', '2020-06-22 12:57:47.000', '2020-06-17 14:34:38.000', '2020-06-17 14:34:38.000', 'ANN'),
('10074', 'UCG.MIL', 'UNICREDIT SPA', 'STOCK', '2020-06-22 12:57:54.000', '2020-06-22 12:57:54.000', '2020-06-17 14:38:32.000', '2020-06-17 14:38:32.000', 'ANN'),
('10075', 'G.MIL', 'ASSICURAZIONI GENERALI SPA', 'STOCK', '2020-06-22 12:58:00.000', '2020-06-22 12:58:00.000', '2020-06-17 14:39:20.000', '2020-06-17 14:39:20.000', 'ANN'),
('10076', 'US.MIL', 'UNIPOLSAI ASSICURAZIONI SPA', 'STOCK', '2020-06-22 12:58:06.000', '2020-06-22 12:58:06.000', '2020-06-17 14:39:53.000', '2020-06-17 14:39:53.000', 'ANN'),
('10080', 'IMA.MIL', 'I.M.A. SPA', 'STOCK', '2020-06-22 14:45:23.000', '2020-06-22 14:45:23.000', '2020-06-22 14:45:23.000', '2020-06-22 14:45:23.000', 'ANN'),
('10081', 'WM', 'WASTE MANAGEMENT', 'STOCK', '2020-06-22 14:45:51.000', '2020-06-22 14:45:51.000', '2020-06-22 14:45:51.000', '2020-06-22 14:45:51.000', 'QUAR'),
('10082', 'UNP', 'UNION PACIFIC CORPORATION', 'STOCK', '2020-06-22 14:46:10.000', '2020-06-22 14:46:10.000', '2020-06-22 14:46:10.000', '2020-06-22 14:46:10.000', 'QUAR'),
('10083', 'MMM', '3M', 'STOCK', '2020-06-22 14:46:27.000', '2020-06-22 14:46:27.000', '2020-06-22 14:46:27.000', '2020-06-22 14:46:27.000', 'QUAR'),
('10084', 'LEG', 'LEGGETT & PLATT', 'STOCK', '2020-06-22 14:46:46.000', '2020-06-22 14:46:46.000', '2020-06-22 14:46:46.000', '2020-06-22 14:46:46.000', 'QUAR'),
('10085', 'CAT', 'CATERPILLAR', 'STOCK', '2020-06-22 14:47:06.000', '2020-06-22 14:47:06.000', '2020-06-22 14:47:06.000', '2020-06-22 14:47:06.000', 'QUAR'),
('10086', 'BG', 'BUNGE LIMITED', 'STOCK', '2020-06-22 14:47:27.000', '2020-06-22 14:47:27.000', '2020-06-22 14:47:27.000', '2020-06-22 14:47:27.000', 'QUAR'),
('10087', 'EMR', 'EMERSON ELECTRIC CO', 'STOCK', '2020-06-22 14:47:49.000', '2020-06-22 14:47:48.000', '2020-06-22 14:47:49.000', '2020-06-22 14:47:48.000', 'QUAR'),
('10088', 'ZV.MIL', 'ZIGNAGO VETRO SPA', 'STOCK', '2020-06-22 14:51:06.000', '2020-06-22 14:51:06.000', '2020-06-22 14:51:06.000', '2020-06-22 14:51:06.000', 'ANN'),
('10089', 'LMT', 'LOCKHEED MARTIN CORPORATION', 'STOCK', '2020-06-22 14:51:41.000', '2020-06-22 14:51:41.000', '2020-06-22 14:51:41.000', '2020-06-22 14:51:41.000', 'QUAR'),
('10090', 'HNI', 'HNI CORPORATION', 'STOCK', '2020-06-22 14:51:58.000', '2020-06-22 14:51:58.000', '2020-06-22 14:51:58.000', '2020-06-22 14:51:58.000', 'QUAR'),
('10091', 'TXN', 'TEXAS INSTRUMENTS INCORPORATED', 'STOCK', '2020-06-22 14:52:22.000', '2020-06-22 14:52:22.000', '2020-06-22 14:52:22.000', '2020-06-22 14:52:22.000', 'QUAR'),
('10092', 'APD', 'AIR PRODUCTS AND CHEMICALS INC', 'STOCK', '2020-06-22 14:52:46.000', '2020-06-22 14:52:46.000', '2020-06-22 14:52:46.000', '2020-06-22 14:52:46.000', 'QUAR');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `BFIN_PRODUCT`
--
ALTER TABLE `BFIN_PRODUCT`
  ADD PRIMARY KEY (`PROD_ID`),
  ADD KEY `BFN_PRDCT_TXSTMP` (`LAST_UPDATED_TX_STAMP`),
  ADD KEY `BFN_PRDCT_TXCRTS` (`CREATED_TX_STAMP`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
