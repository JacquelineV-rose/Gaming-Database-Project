-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 21, 2026 at 01:59 AM
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
('Capcom', '120 Harbor Street, San Mateo, CA'),
('Electronic Arts', '900 Victory Lane, Redwood City, CA'),
('Epic Games', '88 Founders Plaza, Cary, NC'),
('Game Freak', 'Japan'),
('Mojang Studios', 'Stockholm, Sweden'),
('Nintendo', '4600 150th Ave NE, Redmond WA'),
('PUBG Studios', '12, Seocho-daero 38-gil, Seocho-gu, Seoul'),
('Roblox Corporation', 'California'),
('Rockstar Games', '622 Broadway, New York'),
('Sega', '300 Sky Arcade Road, Irvine, CA'),
('Sony Interactive Entertainment', '220 Console Court, San Mateo, CA'),
('Square Enix', '15 Crystal Avenue, Los Angeles, CA'),
('The Tetris Company', '77 Geary St Ste 500, San Francisco, California '),
('Ubisoft', '77 Riverside Park, Montreal, QC'),
('Valve', '2048 Steam Way, Bellevue, WA');

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
(61011, 2023, 'Cross-Platform', 240, 'Capcom'),
(61012, 2011, 'PC', 120, 'Valve'),
(61013, 2017, 'Cross-Platform', 410, 'Epic Games'),
(61014, 2023, 'Cross-Platform', 260, 'Ubisoft'),
(61015, 2024, 'PS5', 230, 'Square Enix'),
(61016, 2022, 'Cross-Platform', 190, 'Sega'),
(61017, 2023, 'PS5', 300, 'Sony Interactive Entertainment'),
(61018, 2024, 'Cross-Platform', 350, 'Electronic Arts'),
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

--
-- Dumping data for table `hasa`
--

INSERT INTO `hasa` (`gameTitle`, `date`) VALUES
('Animal Crossing', '2026-04-01'),
('Tetris', '2026-04-02'),
('Minecraft', '2026-04-03'),
('Fortnite', '2026-04-04'),
('Portal 2', '2026-04-05'),
('Wii Sports', '2026-04-06'),
('Assassin\'s Creed Mirage', '2026-04-07'),
('Marvel\'s Spider-Man 2', '2026-04-08'),
('EA Sports FC 25', '2026-04-09'),
('Roblox', '2026-04-10'),
('Sonic Frontiers', '2026-04-11'),
('PUBG: Battlegrounds', '2026-04-12'),
('Grand Theft Auto', '2026-04-13'),
('Street Fighter 6', '2026-04-14'),
('Final Fantasy VII Rebirth', '2026-04-15'),
('Red Dead Redemption', '2026-04-16');

-- --------------------------------------------------------

--
-- Table structure for table `ownedby`
--

CREATE TABLE `ownedby` (
  `companyName` varchar(100) NOT NULL,
  `gameName` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ownedby`
--

INSERT INTO `ownedby` (`companyName`, `gameName`) VALUES
('Nintendo', 'Animal Crossing'),
('Activision', 'Call of Duty'),
('Rockstar Games', 'Grand Theft Auto'),
('Mojang Studios', 'Minecraft'),
('Game Freak', 'Pokemon'),
('PUBG Studios', 'PUBG: Battlegrounds'),
('Rockstar Games', 'Red Dead Redemption'),
('Roblox Corporation', 'Roblox'),
('The Tetris Company', 'Tetris'),
('Nintendo', 'Wii Sports'),
('Capcom', 'Street Fighter 6'),
('Valve', 'Portal 2'),
('Epic Games', 'Fortnite'),
('Ubisoft', 'Assassin\'s Creed Mirage'),
('Square Enix', 'Final Fantasy VII Rebirth'),
('Sega', 'Sonic Frontiers'),
('Sony Interactive Entertainment', 'Marvel\'s Spider-Man 2'),
('Electronic Arts', 'EA Sports FC 25');

-- --------------------------------------------------------

--
-- Table structure for table `plays`
--

CREATE TABLE `plays` (
  `username` varchar(100) NOT NULL,
  `title` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `plays`
--

INSERT INTO `plays` (`username`, `title`) VALUES
('ellap', 'Grand Theft Auto'),
('ellap', 'Red Dead Redemption'),
('arcadeamy', 'Animal Crossing'),
('arcadeamy', 'Street Fighter 6'),
('pixelpete', 'Tetris'),
('pixelpete', 'Portal 2'),
('stealthsam', 'Assassin\'s Creed Mirage'),
('stealthsam', 'Marvel\'s Spider-Man 2'),
('racingria', 'Grand Theft Auto'),
('racingria', 'EA Sports FC 25'),
('questquinn', 'Portal 2'),
('questquinn', 'Final Fantasy VII Rebirth'),
('craftcora', 'Minecraft'),
('craftcora', 'Roblox'),
('coopchris', 'PUBG: Battlegrounds'),
('coopchris', 'Fortnite'),
('simsage', 'Roblox'),
('simsage', 'Animal Crossing'),
('jayfps', 'Call of Duty'),
('jayfps', 'Fortnite'),
('lunaindie', 'Sonic Frontiers'),
('lunaindie', 'Tetris'),
('mariofan22', 'Pokemon'),
('mariofan22', 'Wii Sports'),
('zelda_zoe', 'Animal Crossing'),
('zelda_zoe', 'Assassin\'s Creed Mirage'),
('sportsmax', 'EA Sports FC 25'),
('sportsmax', 'Wii Sports'),
('battlerbee', 'PUBG: Battlegrounds'),
('battlerbee', 'Fortnite');

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

--
-- Dumping data for table `review`
--

INSERT INTO `review` (`rating`, `caption`, `date`, `gameTitle`, `username`) VALUES
(9, 'Unexpectedly relaxing and polished.', '2026-04-01', 'Animal Crossing', 'arcadeamy'),
(8, 'Simple loop, still impossible to put down.', '2026-04-02', 'Tetris', 'pixelpete'),
(10, 'Building with friends is still the best part.', '2026-04-03', 'Minecraft', 'craftcora'),
(7, 'Great movement, but I get matched too hard.', '2026-04-04', 'Fortnite', 'jayfps'),
(9, 'The puzzles stay clever even on a replay.', '2026-04-05', 'Portal 2', 'questquinn'),
(8, 'Fast matches and a perfect party game vibe.', '2026-04-06', 'Wii Sports', 'mariofan22'),
(7, 'Open world is gorgeous, story pacing is uneven.', '2026-04-07', 'Assassin\'s Creed Mirage', 'zelda_zoe'),
(9, 'The combat is flashy and feels fantastic.', '2026-04-08', 'Marvel\'s Spider-Man 2', 'stealthsam'),
(8, 'Career mode is decent and local matches are fun.', '2026-04-09', 'EA Sports FC 25', 'sportsmax'),
(6, 'Very creative, but some servers are chaotic.', '2026-04-10', 'Roblox', 'simsage'),
(9, 'The music and boss fights really landed for me.', '2026-04-11', 'Sonic Frontiers', 'lunaindie'),
(8, 'Tense matches when our squad actually talks.', '2026-04-12', 'PUBG: Battlegrounds', 'battlerbee'),
(9, 'Huge world and lots to do when I just want to drive around.', '2026-04-13', 'Grand Theft Auto', 'ellap'),
(10, 'The fights feel sharp and the roster is great.', '2026-04-14', 'Street Fighter 6', 'arcadeamy'),
(9, 'Rebirth is massive and surprisingly heartfelt.', '2026-04-15', 'Final Fantasy VII Rebirth', 'questquinn'),
(10, 'Still one of the most immersive worlds ever made.', '2026-04-16', 'Red Dead Redemption', 'stealthsam');

-- --------------------------------------------------------

--
-- Table structure for table `unitof`
--

CREATE TABLE `unitof` (
  `teamId` int(11) NOT NULL,
  `companyName` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `unitof`
--

INSERT INTO `unitof` (`teamId`, `companyName`) VALUES
(14156, 'Nintendo'),
(19305, 'PUBG Studios'),
(39285, 'Rockstar Games'),
(42986, 'Nintendo'),
(48296, 'Rockstar Games'),
(57390, 'Roblox Corporation'),
(69402, 'The Tetris Company'),
(82948, 'Game Freak'),
(93857, 'Mojang Studios'),
(98749, 'Activision'),
(61011, 'Capcom'),
(61012, 'Valve'),
(61013, 'Epic Games'),
(61014, 'Ubisoft'),
(61015, 'Square Enix'),
(61016, 'Sega'),
(61017, 'Sony Interactive Entertainment'),
(61018, 'Electronic Arts');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `username` varchar(100) NOT NULL,
  `age` int(11) NOT NULL,
  `interest` varchar(100) NOT NULL,
  `password_hash` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`username`, `age`, `interest`, `password_hash`) VALUES
('arcadeamy', 24, 'platformers', '$2y$10$WqF8YgyV2Kah/yW394goUOCqxH4GqwD.A5dItiSQCdVk5fbjWyuA.'),
('battlerbee', 30, 'battle royales', '$2y$10$WqF8YgyV2Kah/yW394goUOCqxH4GqwD.A5dItiSQCdVk5fbjWyuA.'),
('coopchris', 26, 'co-op games', '$2y$10$WqF8YgyV2Kah/yW394goUOCqxH4GqwD.A5dItiSQCdVk5fbjWyuA.'),
('craftcora', 20, 'sandbox games', '$2y$10$WqF8YgyV2Kah/yW394goUOCqxH4GqwD.A5dItiSQCdVk5fbjWyuA.'),
('ellap', 19, 'cars', '$2y$10$WqF8YgyV2Kah/yW394goUOCqxH4GqwD.A5dItiSQCdVk5fbjWyuA.'),
('jayfps', 21, 'shooters', '$2y$10$WqF8YgyV2Kah/yW394goUOCqxH4GqwD.A5dItiSQCdVk5fbjWyuA.'),
('lunaindie', 25, 'indie games', '$2y$10$WqF8YgyV2Kah/yW394goUOCqxH4GqwD.A5dItiSQCdVk5fbjWyuA.'),
('mariofan22', 18, 'Nintendo games', '$2y$10$WqF8YgyV2Kah/yW394goUOCqxH4GqwD.A5dItiSQCdVk5fbjWyuA.'),
('pixelpete', 31, 'retro games', '$2y$10$WqF8YgyV2Kah/yW394goUOCqxH4GqwD.A5dItiSQCdVk5fbjWyuA.'),
('questquinn', 29, 'RPGs', '$2y$10$WqF8YgyV2Kah/yW394goUOCqxH4GqwD.A5dItiSQCdVk5fbjWyuA.'),
('racingria', 22, 'open-world driving', '$2y$10$WqF8YgyV2Kah/yW394goUOCqxH4GqwD.A5dItiSQCdVk5fbjWyuA.'),
('simsage', 34, 'simulation games', '$2y$10$WqF8YgyV2Kah/yW394goUOCqxH4GqwD.A5dItiSQCdVk5fbjWyuA.'),
('sportsmax', 28, 'sports games', '$2y$10$WqF8YgyV2Kah/yW394goUOCqxH4GqwD.A5dItiSQCdVk5fbjWyuA.'),
('stealthsam', 27, 'action-adventure', '$2y$10$WqF8YgyV2Kah/yW394goUOCqxH4GqwD.A5dItiSQCdVk5fbjWyuA.'),
('zelda_zoe', 23, 'adventure games', '$2y$10$WqF8YgyV2Kah/yW394goUOCqxH4GqwD.A5dItiSQCdVk5fbjWyuA.');

-- --------------------------------------------------------

--
-- Table structure for table `videogames`
--

CREATE TABLE `videogames` (
  `title` varchar(100) NOT NULL,
  `year` int(11) NOT NULL,
  `platform` varchar(100) NOT NULL,
  `age_rec` int(11) NOT NULL,
  `genre` varchar(100) NOT NULL,
  `companyName` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `videogames`
--

INSERT INTO `videogames` (`title`, `year`, `platform`, `age_rec`, `genre`, `companyName`) VALUES
('Animal Crossing', 2001, 'Nintendo Switch', 3, 'simulation', 'Nintendo'),
('Assassin\'s Creed Mirage', 2023, 'Cross-Platform', 17, 'adventure', 'Ubisoft'),
('Call of Duty', 2003, 'Gaming Console', 17, 'shooter', 'Activision'),
('EA Sports FC 25', 2024, 'Cross-Platform', 3, 'sports', 'Electronic Arts'),
('Final Fantasy VII Rebirth', 2024, 'PS5', 16, 'rpg', 'Square Enix'),
('Fortnite', 2017, 'Cross-Platform', 13, 'shooter', 'Epic Games'),
('Grand Theft Auto', 1997, 'Gaming console', 17, 'open world', 'Rockstar Games'),
('Marvel\'s Spider-Man 2', 2023, 'PS5', 13, 'action', 'Sony Interactive Entertainment'),
('Minecraft', 2009, 'PC', 7, 'sandbox', 'Mojang Studios'),
('Pokemon', 1996, 'Nintendo', 6, 'rpg', 'Game Freak'),
('Portal 2', 2011, 'PC', 10, 'puzzle', 'Valve'),
('PUBG: Battlegrounds', 2017, 'PC', 16, 'shooter', 'PUBG Studios'),
('Red Dead Redemption', 2010, 'Gaming Console', 17, 'open world', 'Rockstar Games'),
('Roblox', 2006, 'PC', 13, 'sandbox', 'Roblox Corporation'),
('Sonic Frontiers', 2022, 'Cross-Platform', 10, 'adventure', 'Sega'),
('Street Fighter 6', 2023, 'Cross-Platform', 13, 'fighting', 'Capcom'),
('Tetris', 1984, 'PC', 0, 'puzzle', 'The Tetris Company'),
('Wii Sports', 2006, 'Wii Console', 5, 'sports', 'Nintendo');

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
