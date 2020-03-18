-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Oct 19, 2016 at 01:53 PM
-- Server version: 5.7.15-0ubuntu0.16.04.1
-- PHP Version: 7.0.8-0ubuntu0.16.04.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `temaribet`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int(11) NOT NULL,
  `firstName` varchar(20) NOT NULL,
  `lastName` varchar(20) NOT NULL,
  `sex` char(1) NOT NULL,
  `email` varchar(30) NOT NULL,
  `password` varchar(16) NOT NULL,
  `profilePicture` varchar(50) DEFAULT NULL,
  `schoolId` int(11) NOT NULL,
  `phoneNumber` varchar(14) DEFAULT NULL,
  `registerDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `contribution` int(11) NOT NULL DEFAULT '0',
  `active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `firstName`, `lastName`, `sex`, `email`, `password`, `profilePicture`, `schoolId`, `phoneNumber`, `registerDate`, `contribution`, `active`) VALUES
(1, 'Haile', 'Zemed', 'M', 'haile@gmail.com', 'haile', NULL, 1, NULL, '2016-05-17 13:28:23', 0, 1);

-- --------------------------------------------------------

--
-- Stand-in structure for view `adminsview`
--
CREATE TABLE `adminsview` (
`id` int(11)
,`firstName` varchar(20)
,`lastName` varchar(20)
,`sex` char(1)
,`email` varchar(30)
,`password` varchar(16)
,`profilePicture` varchar(50)
,`schoolID` int(11)
,`phoneNumber` varchar(14)
,`registerDate` timestamp
,`contribution` int(11)
,`active` tinyint(1)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `completedmaterialsview`
--
CREATE TABLE `completedmaterialsview` (
`id` int(11)
,`materialID` int(11)
,`type` varchar(8)
,`numberOfQuestions` int(11)
,`year` year(4)
,`subjectID` int(11)
,`stream` varchar(8)
,`grade` int(11)
,`subjectName` varchar(15)
,`allowedTime` varchar(10)
,`remainingTime` varchar(20)
,`workingStatus` varchar(1000)
,`uploadDate` timestamp
,`path` varchar(50)
,`uploaderID` int(11)
,`userID` int(11)
,`openedDate` timestamp
);

-- --------------------------------------------------------

--
-- Table structure for table `inactiveusers`
--

CREATE TABLE `inactiveusers` (
  `id` int(11) NOT NULL,
  `firstName` varchar(20) NOT NULL,
  `lastName` varchar(20) NOT NULL,
  `sex` char(1) NOT NULL,
  `email` varchar(30) NOT NULL,
  `password` varchar(82) NOT NULL,
  `profilePicture` varchar(50) DEFAULT NULL,
  `schoolId` int(11) DEFAULT NULL,
  `phoneNumber` varchar(14) DEFAULT NULL,
  `registerDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `grade` int(11) NOT NULL,
  `stream` varchar(7) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='List of users making use of the resources';

--
-- Dumping data for table `inactiveusers`
--

INSERT INTO `inactiveusers` (`id`, `firstName`, `lastName`, `sex`, `email`, `password`, `profilePicture`, `schoolId`, `phoneNumber`, `registerDate`, `grade`, `stream`, `active`) VALUES
(2, 'sdf', 'asfd', 'M', 'aa@gmail.com', '$s0$e0801$78ybLPLRbHS2k//dhfzjyA==$xsbQZ1lX+svaqzimV6ehflTMXx7yo+VWKEGHfWkWr/8=', 'images/avatars/avatar_1.png', NULL, NULL, '2016-10-17 01:04:03', 10, NULL, 1),
(3, 'dfsa', 'df', 'M', 'hello@gmail.com', '$s0$e0801$kuWvIDxtqn+fiwPdVS+Trw==$NkYQMmwYHKaktDh8Ma40EvfFaKIJoSR8k0WAAtmuklo=', 'images/avatars/avatar_1.png', NULL, NULL, '2016-10-17 01:06:50', 9, NULL, 1);

-- --------------------------------------------------------

--
-- Stand-in structure for view `inactiveusersview`
--
CREATE TABLE `inactiveusersview` (
`id` int(11)
,`firstName` varchar(20)
,`lastName` varchar(20)
,`sex` char(1)
,`email` varchar(30)
,`password` varchar(82)
,`profilePicture` varchar(50)
,`schoolId` int(11)
,`phoneNumber` varchar(14)
,`registerDate` timestamp
,`grade` int(11)
,`stream` varchar(7)
,`active` tinyint(1)
);

-- --------------------------------------------------------

--
-- Table structure for table `materials`
--

CREATE TABLE `materials` (
  `id` int(11) NOT NULL,
  `type` varchar(8) NOT NULL,
  `numberOfQuestions` int(11) NOT NULL,
  `year` year(4) NOT NULL,
  `subjectId` int(11) NOT NULL,
  `stream` varchar(8) NOT NULL,
  `grade` int(11) NOT NULL,
  `allowedTime` varchar(10) NOT NULL,
  `uploadDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `path` varchar(50) NOT NULL,
  `uploaderId` int(11) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `materials`
--

INSERT INTO `materials` (`id`, `type`, `numberOfQuestions`, `year`, `subjectId`, `stream`, `grade`, `allowedTime`, `uploadDate`, `path`, `uploaderId`, `active`) VALUES
(1, 'Matric', 120, 2001, 6, 'Natural', 12, '2:0:0', '2016-07-29 04:03:39', 'WEB-INF/materials/english2003matric/index.html', 1, 1),
(2, 'Model', 110, 2007, 6, 'Natural', 12, '1:0:0', '2016-07-29 04:45:37', 'WEB-INF/materials/english2001matric/index.html', 1, 1),
(3, 'Matric', 80, 1999, 6, 'Natural', 12, '2:0:0', '2016-07-29 04:46:15', 'WEB-INF/materials/english2002matric/index.html', 1, 1),
(4, 'Matric', 120, 2001, 1, 'Natural', 12, '2:0:0', '2016-07-29 03:31:59', 'WEB-INF/materials/english2004matric/index.html', 1, 1),
(5, 'Matric', 120, 2003, 8, 'Natural', 12, '1:0:0', '2016-07-29 04:05:38', 'WEB-INF/materials/english2005matric/index.html', 1, 1),
(6, 'Matric', 2, 2008, 9, 'NULL', 10, '2:0:0', '2016-07-30 14:01:11', 'History2008Matric/question.json', 1, 1);

-- --------------------------------------------------------

--
-- Stand-in structure for view `materialsview`
--
CREATE TABLE `materialsview` (
`id` int(11)
,`type` varchar(8)
,`numberOfQuestions` int(11)
,`year` year(4)
,`subjectID` int(11)
,`stream` varchar(8)
,`grade` int(11)
,`subjectName` varchar(15)
,`allowedTime` varchar(10)
,`uploadDate` timestamp
,`path` varchar(50)
,`uploaderID` int(11)
,`active` tinyint(1)
);

-- --------------------------------------------------------

--
-- Table structure for table `openedmaterials`
--

CREATE TABLE `openedmaterials` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `materialId` int(11) NOT NULL,
  `openedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `remainingTime` varchar(20) DEFAULT NULL,
  `workingStatus` varchar(1000) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `openedmaterials`
--

INSERT INTO `openedmaterials` (`id`, `userId`, `materialId`, `openedDate`, `remainingTime`, `workingStatus`, `active`) VALUES
(8, 1, 2, '2016-10-18 17:15:49', '2.00.00', NULL, 1),
(9, 1, 4, '2016-10-18 17:15:49', '2.00.00', NULL, 0);

-- --------------------------------------------------------

--
-- Stand-in structure for view `openedmaterialsview`
--
CREATE TABLE `openedmaterialsview` (
`id` int(11)
,`materialID` int(11)
,`type` varchar(8)
,`numberOfQuestions` int(11)
,`year` year(4)
,`subjectID` int(11)
,`stream` varchar(8)
,`grade` int(11)
,`subjectName` varchar(15)
,`allowedTime` varchar(10)
,`remainingTime` varchar(20)
,`workingStatus` varchar(1000)
,`uploadDate` timestamp
,`path` varchar(50)
,`uploaderID` int(11)
,`userID` int(11)
,`openedDate` timestamp
);

-- --------------------------------------------------------

--
-- Table structure for table `pinnedmaterials`
--

CREATE TABLE `pinnedmaterials` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `materialId` int(11) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pinnedmaterials`
--

INSERT INTO `pinnedmaterials` (`id`, `userId`, `materialId`, `active`) VALUES
(1, 1, 3, 0);

-- --------------------------------------------------------

--
-- Stand-in structure for view `pinnedmaterialsview`
--
CREATE TABLE `pinnedmaterialsview` (
`id` int(11)
,`materialID` int(11)
,`type` varchar(8)
,`numberOfQuestions` int(11)
,`year` year(4)
,`subjectID` int(11)
,`stream` varchar(8)
,`grade` int(11)
,`subjectName` varchar(15)
,`allowedTime` varchar(10)
,`uploadDate` timestamp
,`path` varchar(50)
,`uploaderID` int(11)
,`userID` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `progress`
--

CREATE TABLE `progress` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `subjectId` int(11) NOT NULL,
  `points` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `active` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `progress`
--

INSERT INTO `progress` (`id`, `userId`, `subjectId`, `points`, `date`, `active`) VALUES
(1, 1, 1, 90, '2016-05-25 13:38:19', 1),
(2, 1, 2, 50, '2016-05-25 13:38:19', 1),
(3, 1, 4, 0, '2016-05-25 13:38:19', 1),
(4, 1, 5, 0, '2016-05-25 13:38:19', 1),
(5, 1, 6, 0, '2016-05-25 13:38:19', 1),
(6, 1, 7, 0, '2016-05-25 13:38:19', 1),
(7, 1, 8, 0, '2016-05-25 13:38:19', 1),
(8, 2, 1, 0, '2016-05-25 13:38:57', 1),
(9, 2, 2, 0, '2016-05-25 13:38:57', 1),
(10, 2, 3, 0, '2016-05-25 13:38:57', 1),
(11, 2, 4, 0, '2016-05-25 13:38:57', 1),
(12, 2, 5, 0, '2016-05-25 13:38:57', 1),
(13, 2, 6, 0, '2016-05-25 13:38:57', 1),
(14, 2, 7, 0, '2016-05-25 13:38:57', 1),
(15, 2, 9, 0, '2016-05-25 13:38:57', 1),
(16, 2, 10, 0, '2016-05-25 13:38:57', 1),
(17, 3, 1, 0, '2016-05-25 14:14:36', 1),
(18, 3, 2, 0, '2016-05-25 14:14:36', 1),
(19, 3, 3, 0, '2016-05-25 14:14:36', 1),
(20, 3, 4, 0, '2016-05-25 14:14:37', 1),
(21, 3, 5, 0, '2016-05-25 14:14:37', 1),
(22, 3, 6, 0, '2016-05-25 14:14:37', 1),
(23, 3, 7, 0, '2016-05-25 14:14:37', 1),
(24, 3, 9, 0, '2016-05-25 14:14:37', 1),
(25, 3, 10, 0, '2016-05-25 14:14:37', 1),
(26, 4, 1, 0, '2016-05-25 16:48:47', 1),
(27, 4, 2, 0, '2016-05-25 16:48:47', 1),
(28, 4, 3, 0, '2016-05-25 16:48:47', 1),
(29, 4, 4, 0, '2016-05-25 16:48:47', 1),
(30, 4, 5, 0, '2016-05-25 16:48:47', 1),
(31, 4, 6, 0, '2016-05-25 16:48:47', 1),
(32, 4, 7, 0, '2016-05-25 16:48:47', 1),
(33, 4, 9, 0, '2016-05-25 16:48:47', 1),
(34, 4, 10, 0, '2016-05-25 16:48:47', 1),
(35, 5, 1, 0, '2016-07-28 04:33:58', 1),
(36, 5, 2, 0, '2016-07-28 04:33:58', 1),
(37, 5, 3, 0, '2016-07-28 04:33:58', 1),
(38, 5, 4, 0, '2016-07-28 04:33:58', 1),
(39, 5, 5, 0, '2016-07-28 04:33:58', 1),
(40, 5, 6, 0, '2016-07-28 04:33:58', 1),
(41, 5, 7, 0, '2016-07-28 04:33:58', 1),
(42, 5, 9, 0, '2016-07-28 04:33:58', 1),
(43, 5, 10, 0, '2016-07-28 04:33:58', 1),
(44, 1, 3, 0, '2016-07-28 04:36:44', 1),
(45, 1, 9, 1, '2016-07-28 04:36:44', 1),
(46, 1, 10, 0, '2016-07-28 04:36:44', 1),
(47, 2, 11, 0, '2016-07-28 04:56:03', 1),
(48, 3, 11, 0, '2016-07-28 04:57:38', 1),
(49, 2, 8, 0, '2016-07-28 05:11:33', 1),
(50, 13, 1, 0, '2016-07-28 18:25:08', 1),
(51, 13, 2, 0, '2016-07-28 18:25:08', 1),
(52, 13, 3, 0, '2016-07-28 18:25:08', 1),
(53, 13, 4, 0, '2016-07-28 18:25:08', 1),
(54, 13, 5, 0, '2016-07-28 18:25:08', 1),
(55, 13, 6, 0, '2016-07-28 18:25:08', 1),
(56, 13, 7, 0, '2016-07-28 18:25:08', 1),
(57, 13, 9, 0, '2016-07-28 18:25:08', 1),
(58, 13, 10, 0, '2016-07-28 18:25:08', 1),
(59, 14, 1, 0, '2016-07-28 20:28:18', 1),
(60, 14, 2, 0, '2016-07-28 20:28:18', 1),
(61, 14, 4, 0, '2016-07-28 20:28:18', 1),
(62, 14, 9, 0, '2016-07-28 20:28:18', 1),
(63, 14, 10, 0, '2016-07-28 20:28:18', 1),
(64, 14, 11, 0, '2016-07-28 20:28:18', 1),
(65, 15, 1, 0, '2016-10-10 10:54:55', 1),
(66, 15, 2, 0, '2016-10-10 10:54:55', 1),
(67, 15, 4, 0, '2016-10-10 10:54:55', 1),
(68, 15, 9, 0, '2016-10-10 10:54:56', 1),
(69, 15, 10, 0, '2016-10-10 10:54:56', 1),
(70, 15, 11, 0, '2016-10-10 10:54:56', 1),
(71, 16, 1, 0, '2016-10-10 10:55:59', 1),
(72, 16, 2, 0, '2016-10-10 10:55:59', 1),
(73, 16, 4, 0, '2016-10-10 10:55:59', 1),
(74, 16, 5, 0, '2016-10-10 10:55:59', 1),
(75, 16, 6, 0, '2016-10-10 10:55:59', 1),
(76, 16, 7, 0, '2016-10-10 10:55:59', 1),
(77, 16, 8, 0, '2016-10-10 10:55:59', 1);

-- --------------------------------------------------------

--
-- Stand-in structure for view `progressview`
--
CREATE TABLE `progressview` (
`id` int(11)
,`userId` int(11)
,`subjectId` int(11)
,`subjectName` varchar(15)
,`points` int(11)
,`date` timestamp
);

-- --------------------------------------------------------

--
-- Table structure for table `rememberedusers`
--

CREATE TABLE `rememberedusers` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `seriesIdentifier` bigint(21) NOT NULL,
  `token` varchar(82) NOT NULL,
  `IssuedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rememberedusers`
--

INSERT INTO `rememberedusers` (`id`, `userId`, `seriesIdentifier`, `token`, `IssuedDate`, `active`) VALUES
(1, 1, -2796982640726700912, '$s0$e0801$ydbL6euOGeRE0CrhdP1q2g==$VLtWVTw0K647WWc8q/+cKC8qeTDSrzNXqsh4TQCA/IY=', '2016-10-18 11:34:58', 1);

-- --------------------------------------------------------

--
-- Stand-in structure for view `rememberedusersview`
--
CREATE TABLE `rememberedusersview` (
`id` int(11)
,`userId` int(11)
,`seriesIdentifier` bigint(21)
,`token` varchar(82)
,`IssuedDate` timestamp
,`active` tinyint(1)
);

-- --------------------------------------------------------

--
-- Table structure for table `schools`
--

CREATE TABLE `schools` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(30) NOT NULL,
  `password` varchar(16) NOT NULL,
  `logo` varchar(50) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `schools`
--

INSERT INTO `schools` (`id`, `name`, `email`, `password`, `logo`, `active`) VALUES
(1, 'Yekatit 23', 'contact@yekatit23.edu.et', 'yekatit', '', 1);

-- --------------------------------------------------------

--
-- Stand-in structure for view `schoolsview`
--
CREATE TABLE `schoolsview` (
`id` int(11)
,`name` varchar(100)
,`email` varchar(30)
,`password` varchar(16)
,`logo` varchar(50)
,`active` tinyint(1)
);

-- --------------------------------------------------------

--
-- Table structure for table `subjects`
--

CREATE TABLE `subjects` (
  `id` int(11) NOT NULL,
  `name` varchar(15) NOT NULL,
  `level` varchar(15) NOT NULL,
  `stream` varchar(8) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `subjects`
--

INSERT INTO `subjects` (`id`, `name`, `level`, `stream`, `active`) VALUES
(1, 'English', 'Both', 'Both', 1),
(2, 'Maths', 'Both', 'Both', 1),
(3, 'Amharic', 'HighSchool', NULL, 1),
(4, 'Civics', 'Both', 'Both', 1),
(5, 'Biology', 'Both', 'Natural', 1),
(6, 'Chemistry', 'Both', 'Natural', 1),
(7, 'Physics', 'Both', 'Natural', 1),
(8, 'Apptitude', 'Preparatory', 'Natural', 1),
(9, 'History', 'Both', 'Social', 1),
(10, 'Geography', 'Both', 'Social', 1),
(11, 'Economics', 'Preparatory', 'Social', 1);

-- --------------------------------------------------------

--
-- Stand-in structure for view `subjectsview`
--
CREATE TABLE `subjectsview` (
`id` int(11)
,`name` varchar(15)
,`level` varchar(15)
,`stream` varchar(8)
,`active` tinyint(1)
);

-- --------------------------------------------------------

--
-- Table structure for table `userpreferences`
--

CREATE TABLE `userpreferences` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `language` int(11) NOT NULL DEFAULT '0',
  `theme` varchar(50) DEFAULT NULL,
  `active` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `userpreferences`
--

INSERT INTO `userpreferences` (`id`, `userId`, `language`, `theme`, `active`) VALUES
(1, 1, 0, NULL, 1),
(2, 2, 1, NULL, 1),
(3, 13, 1, NULL, 1),
(4, 14, 1, NULL, 1),
(5, 15, 0, NULL, 1),
(6, 16, 0, NULL, 1);

-- --------------------------------------------------------

--
-- Stand-in structure for view `userpreferencesview`
--
CREATE TABLE `userpreferencesview` (
`id` int(11)
,`userId` int(11)
,`language` int(11)
,`theme` varchar(50)
);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `firstName` varchar(20) NOT NULL,
  `lastName` varchar(20) NOT NULL,
  `sex` char(1) NOT NULL,
  `email` varchar(30) NOT NULL,
  `password` varchar(82) NOT NULL,
  `profilePicture` varchar(50) DEFAULT NULL,
  `schoolId` int(11) DEFAULT NULL,
  `phoneNumber` varchar(14) DEFAULT NULL,
  `registerDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `grade` int(11) NOT NULL,
  `stream` varchar(7) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='List of users making use of the resources';

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `firstName`, `lastName`, `sex`, `email`, `password`, `profilePicture`, `schoolId`, `phoneNumber`, `registerDate`, `grade`, `stream`, `active`) VALUES
(1, 'haileyesus', 'zemed', 'M', 'haile@gmail.com', '$s0$e0801$MWaPZ+eYx0xfzg9ogh0MNQ==$SPIMc7BA7z4smrS21aVg0vFVL3EnXwHpyY7GMtgHzkc=', 'images/avatars/avatar_1.png', 1, NULL, '2016-10-18 01:07:53', 12, 'Natural', 1);

-- --------------------------------------------------------

--
-- Stand-in structure for view `usersview`
--
CREATE TABLE `usersview` (
`id` int(11)
,`firstName` varchar(20)
,`lastName` varchar(20)
,`sex` char(1)
,`email` varchar(30)
,`password` varchar(82)
,`profilePicture` varchar(50)
,`schoolID` int(11)
,`phoneNumber` varchar(14)
,`registerDate` timestamp
,`grade` int(11)
,`stream` varchar(7)
,`active` tinyint(1)
);

-- --------------------------------------------------------

--
-- Structure for view `adminsview`
--
DROP TABLE IF EXISTS `adminsview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `adminsview`  AS  select `admins`.`id` AS `id`,`admins`.`firstName` AS `firstName`,`admins`.`lastName` AS `lastName`,`admins`.`sex` AS `sex`,`admins`.`email` AS `email`,`admins`.`password` AS `password`,`admins`.`profilePicture` AS `profilePicture`,`admins`.`schoolId` AS `schoolID`,`admins`.`phoneNumber` AS `phoneNumber`,`admins`.`registerDate` AS `registerDate`,`admins`.`contribution` AS `contribution`,`admins`.`active` AS `active` from `admins` where (`admins`.`active` = 1) ;

-- --------------------------------------------------------

--
-- Structure for view `completedmaterialsview`
--
DROP TABLE IF EXISTS `completedmaterialsview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `completedmaterialsview`  AS  select `openedmaterials`.`id` AS `id`,`openedmaterials`.`materialId` AS `materialID`,`materials`.`type` AS `type`,`materials`.`numberOfQuestions` AS `numberOfQuestions`,`materials`.`year` AS `year`,`materials`.`subjectId` AS `subjectID`,`materials`.`stream` AS `stream`,`materials`.`grade` AS `grade`,`subjects`.`name` AS `subjectName`,`materials`.`allowedTime` AS `allowedTime`,`openedmaterials`.`remainingTime` AS `remainingTime`,`openedmaterials`.`workingStatus` AS `workingStatus`,`materials`.`uploadDate` AS `uploadDate`,`materials`.`path` AS `path`,`materials`.`uploaderId` AS `uploaderID`,`openedmaterials`.`userId` AS `userID`,`openedmaterials`.`openedDate` AS `openedDate` from (`openedmaterials` join (`materials` join `subjects` on((`materials`.`subjectId` = `subjects`.`id`))) on((`openedmaterials`.`materialId` = `materials`.`id`))) where (`openedmaterials`.`active` = 0) ;

-- --------------------------------------------------------

--
-- Structure for view `inactiveusersview`
--
DROP TABLE IF EXISTS `inactiveusersview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `inactiveusersview`  AS  select `inactiveusers`.`id` AS `id`,`inactiveusers`.`firstName` AS `firstName`,`inactiveusers`.`lastName` AS `lastName`,`inactiveusers`.`sex` AS `sex`,`inactiveusers`.`email` AS `email`,`inactiveusers`.`password` AS `password`,`inactiveusers`.`profilePicture` AS `profilePicture`,`inactiveusers`.`schoolId` AS `schoolId`,`inactiveusers`.`phoneNumber` AS `phoneNumber`,`inactiveusers`.`registerDate` AS `registerDate`,`inactiveusers`.`grade` AS `grade`,`inactiveusers`.`stream` AS `stream`,`inactiveusers`.`active` AS `active` from `inactiveusers` where (`inactiveusers`.`active` = 1) ;

-- --------------------------------------------------------

--
-- Structure for view `materialsview`
--
DROP TABLE IF EXISTS `materialsview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `materialsview`  AS  select `materials`.`id` AS `id`,`materials`.`type` AS `type`,`materials`.`numberOfQuestions` AS `numberOfQuestions`,`materials`.`year` AS `year`,`materials`.`subjectId` AS `subjectID`,`materials`.`stream` AS `stream`,`materials`.`grade` AS `grade`,`subjects`.`name` AS `subjectName`,`materials`.`allowedTime` AS `allowedTime`,`materials`.`uploadDate` AS `uploadDate`,`materials`.`path` AS `path`,`materials`.`uploaderId` AS `uploaderID`,`materials`.`active` AS `active` from (`materials` join `subjects` on((`materials`.`subjectId` = `subjects`.`id`))) where (`materials`.`active` = 1) ;

-- --------------------------------------------------------

--
-- Structure for view `openedmaterialsview`
--
DROP TABLE IF EXISTS `openedmaterialsview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `openedmaterialsview`  AS  select `openedmaterials`.`id` AS `id`,`openedmaterials`.`materialId` AS `materialID`,`materials`.`type` AS `type`,`materials`.`numberOfQuestions` AS `numberOfQuestions`,`materials`.`year` AS `year`,`materials`.`subjectId` AS `subjectID`,`materials`.`stream` AS `stream`,`materials`.`grade` AS `grade`,`subjects`.`name` AS `subjectName`,`materials`.`allowedTime` AS `allowedTime`,`openedmaterials`.`remainingTime` AS `remainingTime`,`openedmaterials`.`workingStatus` AS `workingStatus`,`materials`.`uploadDate` AS `uploadDate`,`materials`.`path` AS `path`,`materials`.`uploaderId` AS `uploaderID`,`openedmaterials`.`userId` AS `userID`,`openedmaterials`.`openedDate` AS `openedDate` from (`openedmaterials` join (`materials` join `subjects` on((`materials`.`subjectId` = `subjects`.`id`))) on((`openedmaterials`.`materialId` = `materials`.`id`))) where (`openedmaterials`.`active` = 1) ;

-- --------------------------------------------------------

--
-- Structure for view `pinnedmaterialsview`
--
DROP TABLE IF EXISTS `pinnedmaterialsview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pinnedmaterialsview`  AS  select `pinnedmaterials`.`id` AS `id`,`pinnedmaterials`.`materialId` AS `materialID`,`materials`.`type` AS `type`,`materials`.`numberOfQuestions` AS `numberOfQuestions`,`materials`.`year` AS `year`,`materials`.`subjectId` AS `subjectID`,`materials`.`stream` AS `stream`,`materials`.`grade` AS `grade`,`subjects`.`name` AS `subjectName`,`materials`.`allowedTime` AS `allowedTime`,`materials`.`uploadDate` AS `uploadDate`,`materials`.`path` AS `path`,`materials`.`uploaderId` AS `uploaderID`,`pinnedmaterials`.`userId` AS `userID` from (`pinnedmaterials` join (`materials` join `subjects` on((`materials`.`subjectId` = `subjects`.`id`))) on((`pinnedmaterials`.`materialId` = `materials`.`id`))) where (`pinnedmaterials`.`active` = 1) ;

-- --------------------------------------------------------

--
-- Structure for view `progressview`
--
DROP TABLE IF EXISTS `progressview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `progressview`  AS  select `progress`.`id` AS `id`,`progress`.`userId` AS `userId`,`progress`.`subjectId` AS `subjectId`,`subjects`.`name` AS `subjectName`,`progress`.`points` AS `points`,`progress`.`date` AS `date` from (`progress` join `subjects` on((`progress`.`subjectId` = `subjects`.`id`))) where (`progress`.`active` = 1) ;

-- --------------------------------------------------------

--
-- Structure for view `rememberedusersview`
--
DROP TABLE IF EXISTS `rememberedusersview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `rememberedusersview`  AS  select `rememberedusers`.`id` AS `id`,`rememberedusers`.`userId` AS `userId`,`rememberedusers`.`seriesIdentifier` AS `seriesIdentifier`,`rememberedusers`.`token` AS `token`,`rememberedusers`.`IssuedDate` AS `IssuedDate`,`rememberedusers`.`active` AS `active` from `rememberedusers` where (`rememberedusers`.`active` = 1) ;

-- --------------------------------------------------------

--
-- Structure for view `schoolsview`
--
DROP TABLE IF EXISTS `schoolsview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `schoolsview`  AS  select `schools`.`id` AS `id`,`schools`.`name` AS `name`,`schools`.`email` AS `email`,`schools`.`password` AS `password`,`schools`.`logo` AS `logo`,`schools`.`active` AS `active` from `schools` where (`schools`.`active` = 1) ;

-- --------------------------------------------------------

--
-- Structure for view `subjectsview`
--
DROP TABLE IF EXISTS `subjectsview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `subjectsview`  AS  select `subjects`.`id` AS `id`,`subjects`.`name` AS `name`,`subjects`.`level` AS `level`,`subjects`.`stream` AS `stream`,`subjects`.`active` AS `active` from `subjects` where (`subjects`.`active` = 1) ;

-- --------------------------------------------------------

--
-- Structure for view `userpreferencesview`
--
DROP TABLE IF EXISTS `userpreferencesview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `userpreferencesview`  AS  select `userpreferences`.`id` AS `id`,`userpreferences`.`userId` AS `userId`,`userpreferences`.`language` AS `language`,`userpreferences`.`theme` AS `theme` from `userpreferences` ;

-- --------------------------------------------------------

--
-- Structure for view `usersview`
--
DROP TABLE IF EXISTS `usersview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `usersview`  AS  select `users`.`id` AS `id`,`users`.`firstName` AS `firstName`,`users`.`lastName` AS `lastName`,`users`.`sex` AS `sex`,`users`.`email` AS `email`,`users`.`password` AS `password`,`users`.`profilePicture` AS `profilePicture`,`users`.`schoolId` AS `schoolID`,`users`.`phoneNumber` AS `phoneNumber`,`users`.`registerDate` AS `registerDate`,`users`.`grade` AS `grade`,`users`.`stream` AS `stream`,`users`.`active` AS `active` from `users` where (`users`.`active` = 1) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phoneNumber` (`phoneNumber`),
  ADD KEY `schoolID` (`schoolId`);

--
-- Indexes for table `inactiveusers`
--
ALTER TABLE `inactiveusers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phoneNumber` (`phoneNumber`),
  ADD KEY `schoolID` (`schoolId`);

--
-- Indexes for table `materials`
--
ALTER TABLE `materials`
  ADD PRIMARY KEY (`id`),
  ADD KEY `subjectID` (`subjectId`),
  ADD KEY `uploaderID` (`uploaderId`);

--
-- Indexes for table `openedmaterials`
--
ALTER TABLE `openedmaterials`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `userId_2` (`userId`,`materialId`),
  ADD KEY `userID` (`userId`),
  ADD KEY `materialID` (`materialId`);

--
-- Indexes for table `pinnedmaterials`
--
ALTER TABLE `pinnedmaterials`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `userId_2` (`userId`,`materialId`),
  ADD KEY `userID` (`userId`),
  ADD KEY `materialID` (`materialId`);

--
-- Indexes for table `progress`
--
ALTER TABLE `progress`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userIdConstraint` (`userId`),
  ADD KEY `subjectIdConstraint` (`subjectId`);

--
-- Indexes for table `rememberedusers`
--
ALTER TABLE `rememberedusers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `seriesIdentifier` (`seriesIdentifier`),
  ADD UNIQUE KEY `token` (`token`),
  ADD KEY `userIdConstraint` (`userId`);

--
-- Indexes for table `schools`
--
ALTER TABLE `schools`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `subjects`
--
ALTER TABLE `subjects`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `userpreferences`
--
ALTER TABLE `userpreferences`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UniqueUserId` (`userId`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phoneNumber` (`phoneNumber`),
  ADD KEY `schoolID` (`schoolId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `inactiveusers`
--
ALTER TABLE `inactiveusers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `materials`
--
ALTER TABLE `materials`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `openedmaterials`
--
ALTER TABLE `openedmaterials`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `pinnedmaterials`
--
ALTER TABLE `pinnedmaterials`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `progress`
--
ALTER TABLE `progress`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;
--
-- AUTO_INCREMENT for table `rememberedusers`
--
ALTER TABLE `rememberedusers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `schools`
--
ALTER TABLE `schools`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `subjects`
--
ALTER TABLE `subjects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `userpreferences`
--
ALTER TABLE `userpreferences`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `admins`
--
ALTER TABLE `admins`
  ADD CONSTRAINT `admins_ibfk_1` FOREIGN KEY (`schoolId`) REFERENCES `schools` (`id`);

--
-- Constraints for table `materials`
--
ALTER TABLE `materials`
  ADD CONSTRAINT `materials_ibfk_1` FOREIGN KEY (`subjectId`) REFERENCES `subjects` (`id`),
  ADD CONSTRAINT `materials_ibfk_2` FOREIGN KEY (`uploaderId`) REFERENCES `admins` (`id`);

--
-- Constraints for table `openedmaterials`
--
ALTER TABLE `openedmaterials`
  ADD CONSTRAINT `openedMaterialUserIdConstraint` FOREIGN KEY (`userId`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `openedMaterialsMaterialIdConstraint` FOREIGN KEY (`materialId`) REFERENCES `materials` (`id`);

--
-- Constraints for table `rememberedusers`
--
ALTER TABLE `rememberedusers`
  ADD CONSTRAINT `userIdConstraint` FOREIGN KEY (`userId`) REFERENCES `users` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
