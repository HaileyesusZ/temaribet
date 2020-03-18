-- phpMyAdmin SQL Dump
-- version 4.6.4deb1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 09, 2016 at 08:51 PM
-- Server version: 5.7.16-0ubuntu0.16.10.1
-- PHP Version: 7.0.8-3ubuntu3

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

-- --------------------------------------------------------

--
-- Stand-in structure for view `adminsview`
-- (See below for the actual view)
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
-- (See below for the actual view)
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
-- Stand-in structure for view `expiredforgottenpasswordview`
-- (See below for the actual view)
--
CREATE TABLE `expiredforgottenpasswordview` (
`id` int(11)
,`userId` int(11)
,`resetId` varchar(82)
,`resetKey` varchar(82)
,`expirationDate` datetime
,`active` tinyint(1)
);

-- --------------------------------------------------------

--
-- Table structure for table `forgottenpassword`
--

CREATE TABLE `forgottenpassword` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `resetId` varchar(82) NOT NULL,
  `resetKey` varchar(82) NOT NULL,
  `expirationDate` datetime NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Stand-in structure for view `forgottenpasswordview`
-- (See below for the actual view)
--
CREATE TABLE `forgottenpasswordview` (
`id` int(11)
,`userId` int(11)
,`resetId` varchar(82)
,`resetKey` varchar(82)
,`expirationDate` datetime
,`active` tinyint(1)
);

-- --------------------------------------------------------

--
-- Table structure for table `inactiveusers`
--

CREATE TABLE `inactiveusers` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `activationId` varchar(82) NOT NULL,
  `activationKey` varchar(82) NOT NULL,
  `expirationDate` datetime NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Stand-in structure for view `inactiveusersview`
-- (See below for the actual view)
--
CREATE TABLE `inactiveusersview` (
`id` int(11)
,`userId` int(11)
,`activationId` varchar(82)
,`activationKey` varchar(82)
,`expirationDate` datetime
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
(6, 'Matric', 2, 2008, 9, 'NULL', 10, '2:0:0', '2016-10-30 13:17:17', 'History2008Matric/question.json', 1, 1);

-- --------------------------------------------------------

--
-- Stand-in structure for view `materialsview`
-- (See below for the actual view)
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

-- --------------------------------------------------------

--
-- Stand-in structure for view `openedmaterialsview`
-- (See below for the actual view)
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
-- Stand-in structure for view `pendingusersview`
-- (See below for the actual view)
--
CREATE TABLE `pendingusersview` (
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
-- Table structure for table `pinnedmaterials`
--

CREATE TABLE `pinnedmaterials` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `materialId` int(11) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Stand-in structure for view `pinnedmaterialsview`
-- (See below for the actual view)
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

-- --------------------------------------------------------

--
-- Stand-in structure for view `progressview`
-- (See below for the actual view)
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

-- --------------------------------------------------------

--
-- Stand-in structure for view `rememberedusersview`
-- (See below for the actual view)
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
-- (See below for the actual view)
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
-- (See below for the actual view)
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

-- --------------------------------------------------------

--
-- Stand-in structure for view `usersview`
-- (See below for the actual view)
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
-- Structure for view `expiredforgottenpasswordview`
--
DROP TABLE IF EXISTS `expiredforgottenpasswordview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `expiredforgottenpasswordview`  AS  select `forgottenpassword`.`id` AS `id`,`forgottenpassword`.`userId` AS `userId`,`forgottenpassword`.`resetId` AS `resetId`,`forgottenpassword`.`resetKey` AS `resetKey`,`forgottenpassword`.`expirationDate` AS `expirationDate`,`forgottenpassword`.`active` AS `active` from `forgottenpassword` where (`forgottenpassword`.`active` = 0) ;

-- --------------------------------------------------------

--
-- Structure for view `forgottenpasswordview`
--
DROP TABLE IF EXISTS `forgottenpasswordview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `forgottenpasswordview`  AS  select `forgottenpassword`.`id` AS `id`,`forgottenpassword`.`userId` AS `userId`,`forgottenpassword`.`resetId` AS `resetId`,`forgottenpassword`.`resetKey` AS `resetKey`,`forgottenpassword`.`expirationDate` AS `expirationDate`,`forgottenpassword`.`active` AS `active` from `forgottenpassword` where (`forgottenpassword`.`active` = 1) ;

-- --------------------------------------------------------

--
-- Structure for view `inactiveusersview`
--
DROP TABLE IF EXISTS `inactiveusersview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `inactiveusersview`  AS  select `inactiveusers`.`id` AS `id`,`inactiveusers`.`userId` AS `userId`,`inactiveusers`.`activationId` AS `activationId`,`inactiveusers`.`activationKey` AS `activationKey`,`inactiveusers`.`expirationDate` AS `expirationDate`,`inactiveusers`.`active` AS `active` from `inactiveusers` where (`inactiveusers`.`active` = 1) ;

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
-- Structure for view `pendingusersview`
--
DROP TABLE IF EXISTS `pendingusersview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pendingusersview`  AS  select `users`.`id` AS `id`,`users`.`firstName` AS `firstName`,`users`.`lastName` AS `lastName`,`users`.`sex` AS `sex`,`users`.`email` AS `email`,`users`.`password` AS `password`,`users`.`profilePicture` AS `profilePicture`,`users`.`schoolId` AS `schoolId`,`users`.`phoneNumber` AS `phoneNumber`,`users`.`registerDate` AS `registerDate`,`users`.`grade` AS `grade`,`users`.`stream` AS `stream`,`users`.`active` AS `active` from `users` where (`users`.`active` = 0) ;

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
-- Indexes for table `forgottenpassword`
--
ALTER TABLE `forgottenpassword`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `reset_id_key_unique` (`resetId`,`resetKey`),
  ADD KEY `forgottenpassword_user_id_constraint` (`userId`);

--
-- Indexes for table `inactiveusers`
--
ALTER TABLE `inactiveusers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_id_and_key` (`activationId`,`activationKey`),
  ADD KEY `inactiveuser_userid_to_user_id_constraint` (`userId`);

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
  ADD UNIQUE KEY `user_id_material_id_unique` (`userId`,`materialId`),
  ADD KEY `material_id_constraint_foreign_key` (`materialId`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `forgottenpassword`
--
ALTER TABLE `forgottenpassword`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `inactiveusers`
--
ALTER TABLE `inactiveusers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `materials`
--
ALTER TABLE `materials`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `openedmaterials`
--
ALTER TABLE `openedmaterials`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pinnedmaterials`
--
ALTER TABLE `pinnedmaterials`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `progress`
--
ALTER TABLE `progress`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `rememberedusers`
--
ALTER TABLE `rememberedusers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
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
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `admins`
--
ALTER TABLE `admins`
  ADD CONSTRAINT `admins_ibfk_1` FOREIGN KEY (`schoolId`) REFERENCES `schools` (`id`);

--
-- Constraints for table `forgottenpassword`
--
ALTER TABLE `forgottenpassword`
  ADD CONSTRAINT `forgottenpassword_user_id_constraint` FOREIGN KEY (`userId`) REFERENCES `users` (`id`);

--
-- Constraints for table `inactiveusers`
--
ALTER TABLE `inactiveusers`
  ADD CONSTRAINT `inactiveuser_userid_to_user_id_constraint` FOREIGN KEY (`userId`) REFERENCES `users` (`id`);

--
-- Constraints for table `materials`
--
ALTER TABLE `materials`
  ADD CONSTRAINT `materialUploaderIdConstraint` FOREIGN KEY (`uploaderId`) REFERENCES `admins` (`id`),
  ADD CONSTRAINT `subjectIdConstraint` FOREIGN KEY (`subjectId`) REFERENCES `subjects` (`id`);

--
-- Constraints for table `openedmaterials`
--
ALTER TABLE `openedmaterials`
  ADD CONSTRAINT `openedMaterialUserIdConstraint` FOREIGN KEY (`userId`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `openedMaterialsMaterialIdConstraint` FOREIGN KEY (`materialId`) REFERENCES `materials` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
