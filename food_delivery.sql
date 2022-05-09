-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 09, 2022 at 02:03 AM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `food_delivery`
--

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `customer_id` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  `address` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customer_id`, `name`, `address`) VALUES
(1, 'John', '1 Washington Sq.'),
(2, 'Tony', '698 Candlewood Lane');

-- --------------------------------------------------------

--
-- Stand-in structure for view `customerview`
-- (See below for the actual view)
--
CREATE TABLE `customerview` (
`name` varchar(128)
,`delivery_person_name` varchar(128)
,`food_name` varchar(128)
,`quantity` int(11)
,`ddate` date
,`payment` decimal(5,2)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `deliveryview`
-- (See below for the actual view)
--
CREATE TABLE `deliveryview` (
`name` varchar(128)
,`address` varchar(128)
,`delivery_person_name` varchar(128)
,`food_name` varchar(128)
,`quantity` int(11)
,`ddate` date
);

-- --------------------------------------------------------

--
-- Table structure for table `delivery_info`
--

CREATE TABLE `delivery_info` (
  `delivery_id` int(11) NOT NULL,
  `delivery_person_id` int(11) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `orders_id` int(11) DEFAULT NULL,
  `ddate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `delivery_info`
--

INSERT INTO `delivery_info` (`delivery_id`, `delivery_person_id`, `customer_id`, `orders_id`, `ddate`) VALUES
(1, 1, 1, 1, '2022-05-03'),
(2, 1, 1, 2, '2022-05-03'),
(3, 2, 2, 3, '2022-06-02');

-- --------------------------------------------------------

--
-- Table structure for table `delivery_person`
--

CREATE TABLE `delivery_person` (
  `delivery_person_id` int(11) NOT NULL,
  `delivery_person_name` varchar(128) DEFAULT NULL,
  `rating` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `delivery_person`
--

INSERT INTO `delivery_person` (`delivery_person_id`, `delivery_person_name`, `rating`) VALUES
(1, 'Ren', '9.80'),
(2, 'Bob', '7.20'),
(3, 'Tim', '8.30');

-- --------------------------------------------------------

--
-- Stand-in structure for view `employeeview`
-- (See below for the actual view)
--
CREATE TABLE `employeeview` (
`orders_id` int(11)
,`customer_id` int(11)
,`quantity` int(11)
,`food_name` varchar(128)
);

-- --------------------------------------------------------

--
-- Table structure for table `food_menu`
--

CREATE TABLE `food_menu` (
  `food_id` int(11) NOT NULL,
  `food_type_id` int(11) DEFAULT NULL,
  `food_name` varchar(128) DEFAULT NULL,
  `price` decimal(5,2) DEFAULT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `food_menu`
--

INSERT INTO `food_menu` (`food_id`, `food_type_id`, `food_name`, `price`, `description`) VALUES
(1, 1, 'The Home Depot', '10.49', 'Ham, Salami, Prosciutto, Provolone & Italian dressing'),
(2, 1, 'Tri-Tip Sandwich', '10.99', 'Tri Tip & Choice of Cheese'),
(3, 2, 'Sprite', '1.99', 'a soda'),
(4, 2, 'Coke', '1.99', 'a soda'),
(5, 3, 'brownie', '2.99', 'chocolatey goodness');

-- --------------------------------------------------------

--
-- Table structure for table `food_type`
--

CREATE TABLE `food_type` (
  `food_type_id` int(11) NOT NULL,
  `food_type_name` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `food_type`
--

INSERT INTO `food_type` (`food_type_id`, `food_type_name`) VALUES
(1, 'sandwich'),
(2, 'drinks'),
(3, 'desserts');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `orders_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `food_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`orders_id`, `customer_id`, `food_id`, `quantity`) VALUES
(1, 1, 1, 3),
(2, 1, 2, 1),
(3, 2, 3, 1);

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE `order_details` (
  `order_details_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `delivery_id` int(11) DEFAULT NULL,
  `payment` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `order_details`
--

INSERT INTO `order_details` (`order_details_id`, `customer_id`, `delivery_id`, `payment`) VALUES
(1, 1, 1, '31.47'),
(2, 1, 2, '10.99'),
(3, 2, 3, '0.99');

-- --------------------------------------------------------

--
-- Structure for view `customerview`
--
DROP TABLE IF EXISTS `customerview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `customerview`  AS SELECT `c`.`name` AS `name`, `dd`.`delivery_person_name` AS `delivery_person_name`, `f`.`food_name` AS `food_name`, `o`.`quantity` AS `quantity`, `d`.`ddate` AS `ddate`, `od`.`payment` AS `payment` FROM (((((`delivery_info` `d` join `customer` `c` on(`d`.`customer_id` = `c`.`customer_id`)) join `delivery_person` `dd` on(`d`.`delivery_person_id` = `dd`.`delivery_person_id`)) join `food_menu` `f` on(`d`.`orders_id` = `f`.`food_id`)) join `orders` `o` on(`d`.`orders_id` = `o`.`orders_id`)) join `order_details` `od` on(`od`.`delivery_id` = `d`.`delivery_id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `deliveryview`
--
DROP TABLE IF EXISTS `deliveryview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `deliveryview`  AS SELECT `c`.`name` AS `name`, `c`.`address` AS `address`, `dd`.`delivery_person_name` AS `delivery_person_name`, `f`.`food_name` AS `food_name`, `o`.`quantity` AS `quantity`, `d`.`ddate` AS `ddate` FROM ((((`delivery_info` `d` join `customer` `c` on(`d`.`customer_id` = `c`.`customer_id`)) join `delivery_person` `dd` on(`d`.`delivery_person_id` = `dd`.`delivery_person_id`)) join `food_menu` `f` on(`d`.`orders_id` = `f`.`food_id`)) join `orders` `o` on(`d`.`orders_id` = `o`.`orders_id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `employeeview`
--
DROP TABLE IF EXISTS `employeeview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `employeeview`  AS SELECT `orders`.`orders_id` AS `orders_id`, `orders`.`customer_id` AS `customer_id`, `orders`.`quantity` AS `quantity`, `food_menu`.`food_name` AS `food_name` FROM (`food_menu` join `orders` on(`food_menu`.`food_id` = `orders`.`orders_id`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `delivery_info`
--
ALTER TABLE `delivery_info`
  ADD PRIMARY KEY (`delivery_id`),
  ADD KEY `orders_id` (`orders_id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `delivery_person_id` (`delivery_person_id`);

--
-- Indexes for table `delivery_person`
--
ALTER TABLE `delivery_person`
  ADD PRIMARY KEY (`delivery_person_id`);

--
-- Indexes for table `food_menu`
--
ALTER TABLE `food_menu`
  ADD PRIMARY KEY (`food_id`),
  ADD KEY `food_type_id` (`food_type_id`);

--
-- Indexes for table `food_type`
--
ALTER TABLE `food_type`
  ADD PRIMARY KEY (`food_type_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`orders_id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `food_id` (`food_id`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`order_details_id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `delivery_id` (`delivery_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `delivery_info`
--
ALTER TABLE `delivery_info`
  MODIFY `delivery_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `delivery_person`
--
ALTER TABLE `delivery_person`
  MODIFY `delivery_person_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `food_menu`
--
ALTER TABLE `food_menu`
  MODIFY `food_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `food_type`
--
ALTER TABLE `food_type`
  MODIFY `food_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `orders_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `order_details`
--
ALTER TABLE `order_details`
  MODIFY `order_details_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `delivery_info`
--
ALTER TABLE `delivery_info`
  ADD CONSTRAINT `delivery_info_ibfk_1` FOREIGN KEY (`orders_id`) REFERENCES `orders` (`orders_id`),
  ADD CONSTRAINT `delivery_info_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  ADD CONSTRAINT `delivery_info_ibfk_3` FOREIGN KEY (`delivery_person_id`) REFERENCES `delivery_person` (`delivery_person_id`);

--
-- Constraints for table `food_menu`
--
ALTER TABLE `food_menu`
  ADD CONSTRAINT `food_menu_ibfk_1` FOREIGN KEY (`food_type_id`) REFERENCES `food_type` (`food_type_id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`food_id`) REFERENCES `food_menu` (`food_id`);

--
-- Constraints for table `order_details`
--
ALTER TABLE `order_details`
  ADD CONSTRAINT `order_details_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  ADD CONSTRAINT `order_details_ibfk_2` FOREIGN KEY (`delivery_id`) REFERENCES `delivery_info` (`delivery_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
