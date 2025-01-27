-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jan 26, 2025 at 03:05 PM
-- Server version: 9.1.0
-- PHP Version: 8.2.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cycle_test`
--

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) NOT NULL,
  `time_executed` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `migrations_index_migration_created_at_67935b1630d48` (`migration`,`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `time_executed`, `created_at`) VALUES
(13, '0_default_change_orders_add_store_store_id_add_product_product_id_add_index_orders_index_store_storeid_679523eb3a8cf_add_index_ord', '2025-01-25 17:50:03', '2025-01-25 17:48:27'),
(14, '0_default_create_users', '2025-01-25 17:51:28', '2023-02-22 13:24:57'),
(15, 'default_stores', '2025-01-25 17:51:28', '2025-01-25 16:37:24'),
(16, 'default_products', '2025-01-25 17:51:28', '2025-01-25 16:37:31'),
(17, 'default_orders', '2025-01-25 17:51:28', '2025-01-25 16:37:37');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
CREATE TABLE IF NOT EXISTS `orders` (
  `order_id` bigint NOT NULL AUTO_INCREMENT,
  `customer_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `order_date` date NOT NULL,
  `store_id` bigint NOT NULL,
  PRIMARY KEY (`order_id`),
  KEY `orders_index_store_id_6790d290a19b9` (`store_id`),
  KEY `orders_index_product_id_6790d290a1b17` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `customer_id`, `product_id`, `quantity`, `unit_price`, `order_date`, `store_id`) VALUES
(1, 1, 1, 10, 2.00, '2024-02-02', 1),
(2, 1, 1, 10, 2.00, '2024-02-02', 1),
(3, 1, 1, 10, 2.00, '2024-02-02', 1),
(4, 1, 1, 10, 2.00, '2024-03-02', 1),
(5, 1, 1, 10, 2.00, '2024-03-02', 1),
(6, 1, 1, 10, 2.00, '2024-03-02', 1),
(7, 1, 1, 10, 2.00, '2024-03-02', 1),
(8, 1, 1, 10, 2.00, '2024-03-02', 1),
(9, 1, 1, 10, 2.00, '2024-03-02', 1),
(10, 1, 1, 10, 2.00, '2024-03-02', 1),
(11, 1, 1, 10, 2.00, '2024-03-02', 1),
(12, 1, 1, 10, 2.00, '2024-03-02', 1),
(13, 1, 1, 10, 2.00, '2024-03-02', 1),
(14, 1, 1, 10, 2.00, '2024-04-02', 3),
(15, 1, 1, 10, 2.00, '2024-04-02', 3),
(16, 1, 1, 10, 2.00, '2024-04-02', 3),
(17, 1, 1, 10, 2.00, '2024-04-02', 3),
(18, 1, 1, 10, 2.00, '2024-04-02', 3),
(19, 1, 1, 10, 2.00, '2024-04-02', 3),
(20, 1, 1, 10, 2.00, '2024-04-02', 3),
(21, 1, 1, 10, 2.00, '2024-04-02', 3),
(22, 1, 1, 10, 2.00, '2024-04-02', 3),
(23, 1, 1, 10, 2.00, '2024-04-02', 3),
(24, 1, 1, 10, 2.00, '2024-03-02', 2),
(25, 1, 1, 10, 2.00, '2024-03-02', 2),
(26, 1, 1, 10, 2.00, '2024-03-02', 2),
(27, 1, 1, 10, 2.00, '2024-03-02', 2),
(28, 1, 1, 10, 2.00, '2024-03-02', 2),
(29, 1, 1, 10, 2.00, '2024-03-02', 2),
(30, 1, 1, 10, 2.00, '2024-03-02', 2),
(31, 1, 1, 10, 2.00, '2024-03-02', 2),
(32, 1, 1, 10, 2.00, '2024-03-02', 2),
(33, 1, 1, 10, 2.00, '2024-03-02', 2);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
CREATE TABLE IF NOT EXISTS `products` (
  `product_id` bigint NOT NULL AUTO_INCREMENT,
  `category_id` bigint NOT NULL,
  `product_name` varchar(255) NOT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `category_id`, `product_name`) VALUES
(1, 1, 'Prosuct 1');

-- --------------------------------------------------------

--
-- Table structure for table `stores`
--

DROP TABLE IF EXISTS `stores`;
CREATE TABLE IF NOT EXISTS `stores` (
  `store_id` bigint NOT NULL AUTO_INCREMENT,
  `region_id` bigint NOT NULL,
  `store_name` varchar(255) NOT NULL,
  PRIMARY KEY (`store_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `stores`
--

INSERT INTO `stores` (`store_id`, `region_id`, `store_name`) VALUES
(1, 1, 'Store 1'),
(2, 2, 'Store 2'),
(3, 1, 'Store 2'),
(4, 2, 'Store 1');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_product_id_fk` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_store_id_fk` FOREIGN KEY (`store_id`) REFERENCES `stores` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
