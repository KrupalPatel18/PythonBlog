-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 30, 2021 at 05:34 PM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 8.0.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pythonblog`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `name` text NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone_num` varchar(50) NOT NULL,
  `msg` text NOT NULL,
  `sno` int(11) NOT NULL,
  `date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`name`, `email`, `phone_num`, `msg`, `sno`, `date`) VALUES
('first', 'first@gmail.com', '1234567890', 'first post', 1, '2021-05-29 01:40:24'),
('krupal', 'krupalpatel1611@gmail.com', '123-45-678', 'jbjhhk', 3, '2021-05-29 02:17:42');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `sno` int(11) NOT NULL,
  `title` text NOT NULL,
  `subheading` text NOT NULL,
  `slug` varchar(25) NOT NULL,
  `content` text NOT NULL,
  `img_file` varchar(12) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`sno`, `title`, `subheading`, `slug`, `content`, `img_file`, `date`) VALUES
(1, 'Planet Python', 'The go-to Python blog', 'planet_python', 'Planet Python is probably one of the first sources you’ll ever consult for all your Python needs. The reason for this is quite simple—it’s immensely comprehensive.\r\n\r\nWith several posts a day on average, Planet Python’s incredible range is owed to the fact that it brings together recent Python-related posts from various other blogs. All the sources are reputable and the posts themselves have been carefully selected as well, resulting in a blog that gets you a good range of news and tutorials all across the board.', 'post-bg.jpg', '2021-05-30 01:37:38'),
(3, 'Full Stack Python', 'A comprehensive resource by multiple Python bloggers', 'full_stack_python', 'If you’re looking for a dedicated resource that will help you get your latest Python-based app up and running in no time, Full Stack Python definitely lives up to its name.\r\n\r\nIt’s true that updates happen quite haphazardly—some months have multiple updates, followed by a month of two or silence. Nevertheless, each new post is a detailed, very nicely presented tutorial on one of the many platforms utilizing Python that will help you get your project off the ground.', 'post-bg.jpg', '2021-05-30 01:46:04'),
(4, 'Mouse vs. Python', 'A Python blog with undeniable charm', 'mouse_vs_python', 'Don’t let the disarmingly cute name deceive you—Mouse vs. Python is one of the best sources if you’re looking for the latest scoop on all things Python. With posts on all the latest updates and announcements, as well as interviews with notable Python developers, this blog will keep you up to speed on everything you need to know about the latest goings-on in the Python world from a less technical standpoint. The endearing art found throughout is also a plus.', 'post-bg.jpg', '2021-05-30 01:46:04'),
(5, 'Doug Hellmann', 'Run by a prominent Python blogger', 'doug_hellmann', 'Run by the creator of Python Module of the Week, this blog acts as more of a database for the many Python libraries available. Though the posts don’t come regularly, they’re always very robust rundowns of what can be found in the latest updates. Occasionally, you’ll be treated to longer posts written by Doug, which act more as an assortment of think pieces and guides related to Python.', 'post-bg.jpg', '2021-05-30 01:48:05'),
(6, 'Real Python', 'A comprehensive Python programming blog', 'real_python', 'Real Python is fantastic if you want a robust course that’s very easy to digest. With eye-catching infographics, videos, and an overall fun vibe, this course (because that’s what this blog is, essentially) will show you the ropes and give you all the necessary tools to start your Python adventure, while still whetting your appetite for more.', 'post-bg.jpg', '2021-05-30 01:48:05');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`sno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
