-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 10, 2026 at 08:02 PM
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
('Mojang Studios', 'Stockholm, Sweden'),
('Nintendo', '4600 150th Ave NE, Redmond WA'),
('PUBG Studios', '12, Seocho-daero 38-gil, Seocho-gu, Seoul'),
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
  `company_name` varchar(100) NOT NULL
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
  `date` int(11) NOT NULL,
  `title` varchar(100) NOT NULL
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
  `company` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `videogames`
--

INSERT INTO `videogames` (`title`, `year`, `platform`, `age_rec`, `company`) VALUES
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
  ADD PRIMARY KEY (`teamID`,`company_name`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `videogames`
--
ALTER TABLE `videogames`
  ADD PRIMARY KEY (`title`,`company`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
