-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 09, 2020 at 02:54 PM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `allboard`
--

-- --------------------------------------------------------

--
-- Table structure for table `my_fevorite`
--

CREATE TABLE `my_fevorite` (
  `id` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  `id_product` int(11) NOT NULL,
  `id_user` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `my_fevorite`
--

INSERT INTO `my_fevorite` (`id`, `score`, `id_product`, `id_user`) VALUES
(3, 4, 2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `product_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `image_product` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `id_type` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `product_name`, `image_product`, `description`, `id_type`) VALUES
(1, 'ยาพารา', 'cemol.jpg', 'พาราเซตามอล หรือ อะเซตามีโนเฟน ทั้งหมดย่อมาจาก para-acetylaminophenol เป็นยาที่สามารถจำหน่ายได้โดยไม่ต้องมีใบสั่งแพทย์ มีฤทธิ์แก้ปวดและลดไข้ ซึ่งเป็นยาพื้นฐานที่มักใช้เพื่อบรรเทาไข้ อาการปวดศีรษะ และอาการปวดเมื่อย และรักษาให้หายจากโรคหวัดและไข้หวัด', 1),
(2, 'มิสทีน', 'lipstick.jpg', 'ลิปทินท์ ที่มอบสีสันสดใส ช่วยแต่งแต้มริมฝีปากให้แลดูสุขภาพดีอย่างเป็นธรรมชาติ ด้วยเนื้อสัมผัสบางเบา ไม่เหนอะหนะ ง่ายต่อการเกลี่ยทา พร้อมทั้งอุดมไปด้วยสารสกัดจากวิตามิน E ที่ช่วยกักเก็บความชุ่มชื่นบนริมฝีปาก ชะลอการเกิดริ้วรอยก่อนวัย จึงช่วยให้เรียวปากดูสุขภาพดีอยู่ตลอดเวลา', 2),
(3, 'ข้าวซอย น้ำเงี้ยว', 'rice.jpg', 'แค่เอ่ยถึงเมนูข้าวซอยก็น้ำลายสอแล้ว ใครอยากทำกินเองขอนำเสนอเมนูข้าวซอยไก่ สูตรจาก คุณเนินน้ำ อาหารบ้าน ๆ ที่บ้านเนินน้ำ เนื้อไก่เปื่อยนุ่มต้มกับน้ำแกงข้าวซอย กินกับเส้นข้าวซอยและกรอบข้าวซอย ตัดเลี่ยนด้วยเครื่องเคียงต่าง ๆ', 3),
(4, 'นมเย็น', 'milk.jpg', 'เริ่มต้นกันที่เครื่องดื่มนมเย็นสุดคลาสสิก จับนมสดเติมน้ำหวานสีแดง ใครจะเติมนมข้นหวานหรือไม่เติมก็ได้ ก่อนเสิร์ฟราดนมข้นจืดหน่อย แหม… แก้วนี้สีชมพูสวยฟรุ้งฟริ้งเชียวล่ะ\r\n', 4);

-- --------------------------------------------------------

--
-- Table structure for table `type_product`
--

CREATE TABLE `type_product` (
  `id` int(11) NOT NULL,
  `type_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `type_product`
--

INSERT INTO `type_product` (`id`, `type_name`) VALUES
(1, 'ผลิตภัณฑ์ยา'),
(2, 'เครื่องสําอาง'),
(3, 'อาหาร'),
(4, 'เครื่องดื่ม');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `first_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `e_mail` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `image_name` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `role` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `first_name`, `last_name`, `e_mail`, `password`, `image_name`, `role`) VALUES
(5, 'test', 'test', 'test@awd.com', '$2b$10$5oteTNjyH/b4PH5QgASPJ.aCp/M3bVMUT9IcJ4KXjuUpyUhvXScAu', 'a0843d09-90b9-4cae-93df-e0fb0c4713a2.png', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `my_fevorite`
--
ALTER TABLE `my_fevorite`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_type` (`id_type`);

--
-- Indexes for table `type_product`
--
ALTER TABLE `type_product`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `my_fevorite`
--
ALTER TABLE `my_fevorite`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `type_product`
--
ALTER TABLE `type_product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`id_type`) REFERENCES `type_product` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
