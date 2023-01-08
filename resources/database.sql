-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 08, 2023 at 03:15 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.1.12

SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `todos`
--
CREATE DATABASE IF NOT EXISTS `todos` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `todos`;

-- --------------------------------------------------------

--
-- Table structure for table `todos`
--

CREATE TABLE `todos` (
  `id` int(4) NOT NULL,
  `id_user` int(4) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `completed` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `todos`
--

INSERT INTO `todos` (`id`, `id_user`, `title`, `description`, `completed`) VALUES
(132, 1, 'odit minima dolorem maiores ut in doloremque laboriosam inventore qui nesciunt sapiente consequuntur necessitatibus', 'sed temporibus perspiciatis', 1),
(133, 1, 'ut qui laborum a', 'culpa est natus ipsum eligendi aliquid maxime suscipit recusandae minus eligendi quis quae', 0),
(134, 1, 'soluta aspernatur', 'ad sed labore eaque aspernatur fugiat blanditiis', 1),
(135, 1, 'nemo atque ex placeat quasi', 'officiis est nesciunt et unde dicta laudantium qui doloribus nobis aperiam incidunt fugit magnam fuga', 0),
(136, 1, 'impedit ex dicta ducimus asperiores amet numquam qui expedita saepe non repudiandae voluptatibus possimus', 'exercitationem ipsum veritatis autem excepturi explicabo', 1),
(137, 1, 'magni impedit ex natus amet accusantium minus fuga inventore ab libero quod reiciendis ratione', 'nostrum reiciendis blanditiis excepturi dolore maiores porro minima quas ut', 0),
(138, 1, 'possimus aperiam tempore velit quibusdam atque', 'adipisci reprehenderit', 1),
(139, 1, 'aspernatur odit velit perspiciatis quia voluptas accusantium corporis harum a officiis placeat', 'nihil illum sapiente laboriosam impedit', 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(4) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `active`) VALUES
(1, 'User1', '*196BDEDE2AE4F84CA44C47D54D78478C7E2BD7B7', 1),
(2, 'User2', '*94BDCEBE19083CE2A1F959FD02F964C7AF4CFC29', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `todos`
--
ALTER TABLE `todos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `iduser` (`id_user`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `todos`
--
ALTER TABLE `todos`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=140;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `todos`
--
ALTER TABLE `todos`
  ADD CONSTRAINT `fkiduser` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
SET FOREIGN_KEY_CHECKS=1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
