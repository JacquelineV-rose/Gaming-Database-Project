-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 16, 2026 at 06:22 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `videogame_project`
--

-- --------------------------------------------------------

--
-- Table structure for table `company`
--

CREATE TABLE `company` (
  `name` varchar(100) NOT NULL,
  `address` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `company`
--

INSERT INTO `company` (`name`, `address`) VALUES
('Activision', '2701 Olympic Boulevard, Santa Monica, California'),
('Game Freak', 'Japan'),
('Mojang Studios', 'Stockholm, Sweden'),
('Nintendo', '4600 150th Ave NE, Redmond WA'),
('PUBG Studios', '12, Seocho-daero 38-gil, Seocho-gu, Seoul'),
('Roblox Corporation', 'California'),
('Rockstar Games', '622 Broadway, New York'),
('The Tetris Company', '77 Geary St Ste 500, San Francisco, California ');

-- --------------------------------------------------------

--
-- Table structure for table `developer`
--

CREATE TABLE `developer` (
  `teamID` int(11) NOT NULL,
  `year` int(11) NOT NULL,
  `platform` varchar(100) NOT NULL,
  `size` int(11) NOT NULL,
  `companyName` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `developer`
--

INSERT INTO `developer` (`teamID`, `year`, `platform`, `size`, `companyName`) VALUES
(14156, 2001, 'Nintendo Switch', 184, 'Nintendo'),
(19305, 2017, 'PC', 189, 'PUBG Studios'),
(39285, 2010, 'Gaming Console', 74, 'Rockstar Games'),
(42986, 2006, 'Wii Console', 270, 'Nintendo'),
(48296, 1997, 'Gaming Console', 312, 'Rockstar Games'),
(57390, 2006, 'PC', 417, 'Roblox Corporation'),
(69402, 1984, 'PC', 248, 'The Tetris Company'),
(82948, 1996, 'Nintendo', 99, 'Game Freak'),
(93857, 2009, 'PC', 200, 'Mojang Studios'),
(98749, 2003, 'Gaming Console', 154, 'Activision');

-- --------------------------------------------------------

--
-- Table structure for table `hasa`
--

CREATE TABLE `hasa` (
  `gameTitle` varchar(100) NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ownedby`
--

CREATE TABLE `ownedby` (
  `companyName` varchar(100) NOT NULL,
  `gameName` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `plays`
--

CREATE TABLE `plays` (
  `username` varchar(100) NOT NULL,
  `title` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `review`
--

CREATE TABLE `review` (
  `rating` int(11) NOT NULL,
  `caption` varchar(100) NOT NULL,
  `date` date NOT NULL,
  `gameTitle` varchar(100) NOT NULL,
  `username` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `unitof`
--

CREATE TABLE `unitof` (
  `teamId` int(11) NOT NULL,
  `companyName` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `username` varchar(100) NOT NULL,
  `age` int(11) NOT NULL,
  `interest` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`username`, `age`, `interest`) VALUES
('ellap', 19, 'cars');

-- --------------------------------------------------------

--
-- Table structure for table `videogames`
--

CREATE TABLE `videogames` (
  `title` varchar(100) NOT NULL,
  `year` int(11) NOT NULL,
  `platform` varchar(100) NOT NULL,
  `age_rec` int(11) NOT NULL,
  `companyName` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `videogames`
--

INSERT INTO `videogames` (`title`, `year`, `platform`, `age_rec`, `companyName`) VALUES
('Animal Crossing', 2001, 'Nintendo Switch', 3, 'Nintendo'),
('Call of Duty', 2003, 'Gaming Console', 17, 'Activision'),
('Grand Theft Auto', 1997, 'Gaming console', 17, 'Rockstar Games'),
('Minecraft', 2009, 'PC', 7, 'Mojang Studios'),
('Pokemon', 1996, 'Nintendo', 6, 'Game Freak'),
('PUBG: Battlegrounds', 2017, 'PC', 16, 'PUBG Studios'),
('Red Dead Redemption', 2010, 'Gaming Console', 17, 'Rockstar Games'),
('Roblox', 2006, 'PC', 13, 'Roblox Corporation'),
('Tetris', 1984, 'PC', 0, 'The Tetris Company'),
('Wii Sports', 2006, 'Wii Console', 5, 'Nintendo');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `company`
--
ALTER TABLE `company`
  ADD PRIMARY KEY (`name`);

--
-- Indexes for table `developer`
--
ALTER TABLE `developer`
  ADD PRIMARY KEY (`teamID`,`companyName`),
  ADD KEY `companyName` (`companyName`);

--
-- Indexes for table `hasa`
--
ALTER TABLE `hasa`
  ADD KEY `gameTitle` (`gameTitle`),
  ADD KEY `date` (`date`);

--
-- Indexes for table `ownedby`
--
ALTER TABLE `ownedby`
  ADD KEY `companyName` (`companyName`),
  ADD KEY `gameName` (`gameName`);

--
-- Indexes for table `plays`
--
ALTER TABLE `plays`
  ADD KEY `username` (`username`),
  ADD KEY `title` (`title`);

--
-- Indexes for table `review`
--
ALTER TABLE `review`
  ADD PRIMARY KEY (`date`,`gameTitle`,`username`),
  ADD KEY `gameTitle` (`gameTitle`),
  ADD KEY `username` (`username`);

--
-- Indexes for table `unitof`
--
ALTER TABLE `unitof`
  ADD KEY `companyName` (`companyName`),
  ADD KEY `teamId` (`teamId`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `videogames`
--
ALTER TABLE `videogames`
  ADD PRIMARY KEY (`title`,`companyName`),
  ADD KEY `companyName` (`companyName`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `developer`
--
ALTER TABLE `developer`
  ADD CONSTRAINT `developer_ibfk_1` FOREIGN KEY (`companyName`) REFERENCES `company` (`name`);

--
-- Constraints for table `hasa`
--
ALTER TABLE `hasa`
  ADD CONSTRAINT `hasa_ibfk_1` FOREIGN KEY (`gameTitle`) REFERENCES `videogames` (`title`),
  ADD CONSTRAINT `hasa_ibfk_2` FOREIGN KEY (`date`) REFERENCES `review` (`date`);

--
-- Constraints for table `ownedby`
--
ALTER TABLE `ownedby`
  ADD CONSTRAINT `ownedby_ibfk_1` FOREIGN KEY (`companyName`) REFERENCES `company` (`name`),
  ADD CONSTRAINT `ownedby_ibfk_2` FOREIGN KEY (`gameName`) REFERENCES `videogames` (`title`);

--
-- Constraints for table `plays`
--
ALTER TABLE `plays`
  ADD CONSTRAINT `plays_ibfk_1` FOREIGN KEY (`username`) REFERENCES `users` (`username`),
  ADD CONSTRAINT `plays_ibfk_2` FOREIGN KEY (`title`) REFERENCES `videogames` (`title`);

--
-- Constraints for table `review`
--
ALTER TABLE `review`
  ADD CONSTRAINT `review_ibfk_1` FOREIGN KEY (`gameTitle`) REFERENCES `videogames` (`title`),
  ADD CONSTRAINT `review_ibfk_2` FOREIGN KEY (`username`) REFERENCES `users` (`username`);

--
-- Constraints for table `unitof`
--
ALTER TABLE `unitof`
  ADD CONSTRAINT `unitof_ibfk_1` FOREIGN KEY (`companyName`) REFERENCES `company` (`name`),
  ADD CONSTRAINT `unitof_ibfk_2` FOREIGN KEY (`teamId`) REFERENCES `developer` (`teamID`);

--
-- Constraints for table `videogames`
--
ALTER TABLE `videogames`
  ADD CONSTRAINT `videogames_ibfk_1` FOREIGN KEY (`companyName`) REFERENCES `company` (`name`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
