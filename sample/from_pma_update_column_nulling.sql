-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 13, 2023 at 08:52 PM
-- Server version: 10.6.12-MariaDB-0ubuntu0.22.04.1
-- PHP Version: 8.1.2-1ubuntu2.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `test_db`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `p_test` ()   BEGIN
SELECT aa.mahasiswaUsername FROM d_access_proposal aa;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `f_test` () RETURNS INT(11)  BEGIN
RETURN 1;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `d_access_proposal`
--

CREATE TABLE `d_access_proposal` (
  `mahasiswaUsername` varchar(64) NOT NULL,
  `labCode` varchar(64) NOT NULL,
  `itemCode` varchar(64) DEFAULT NULL,
  `proposedDate` date NOT NULL,
  `proposedTime` time DEFAULT NULL,
  `statusCode` text NULL DEFAULT NULL,
  `confirmedBy` varchar(64) DEFAULT NULL,
  `createdDate` timestamp NOT NULL DEFAULT current_timestamp(),
  `deletedDate` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `d_access_proposal`
--

INSERT INTO `d_access_proposal` (`mahasiswaUsername`, `labCode`, `itemCode`, `proposedDate`, `proposedTime`, `statusCode`, `confirmedBy`, `createdDate`, `deletedDate`) VALUES
('are@gmail.com', 'SKJ', 'itemB', '2022-08-14', '09:46:52', 'ACCEPT', NULL, '2022-08-12 15:47:22', NULL),
('are@gmail.com', 'SKJ', 'itemA', '2022-08-19', '12:00:00', 'REJECT', NULL, '2022-08-13 01:07:03', NULL),
('eieieie@gmail.com', 'SKJ', 'itemC', '2022-08-13', '09:46:52', 'REJECT', NULL, '2022-08-12 15:47:22', NULL),
('esesese@gmail.com', 'SKJ', 'itemD', '2022-08-10', '13:00:00', 'REJECT', NULL, '2022-08-13 01:20:20', NULL),
('muham@mail.ugm.ac.id', 'SKJ', 'itemE', '2022-08-09', '14:00:00', 'IDLE', NULL, '2022-08-13 00:18:01', '2022-08-13 00:43:57'),
('muham@mail.ugm.ac.id', 'SKJ', 'itemF', '2022-08-08', '13:00:00', 'ACCEPT', NULL, '2022-08-13 04:31:05', NULL),
('nande@gmail.com', 'SKJ', 'itemG', '2022-08-05', '12:00:00', 'ACCEPT', NULL, '2022-08-13 01:19:56', NULL);

--
-- Triggers `d_access_proposal`
--
DELIMITER $$
CREATE TRIGGER `t_test` BEFORE INSERT ON `d_access_proposal` FOR EACH ROW SET new.confirmedBy = NULL
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `d_access_proposal`
--
ALTER TABLE `d_access_proposal`
  ADD PRIMARY KEY (`mahasiswaUsername`,`labCode`,`createdDate`) USING BTREE,
  ADD KEY `labCode` (`labCode`),
  ADD KEY `confirmedBy` (`confirmedBy`),
  ADD KEY `statusCode` (`statusCode`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
