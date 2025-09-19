/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.13-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: myjuicepackagingdatabase.cj2ka46iwypj.eu-central-1.rds.amazonaws.com    Database: myjuicedatabase
-- ------------------------------------------------------
-- Server version       11.4.5-MariaDB-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Accounts`
--

DROP TABLE IF EXISTS `Accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Accounts` (
`id` varchar(50) NOT NULL,
`password` varchar(255) NOT NULL,
PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

-- Insert default accounts
INSERT INTO `Accounts` (`id`, `password`) VALUES
('admin', 'admin123'),
('employee', 'employee123');


--
-- Table structure for table `Boxes`
--

DROP TABLE IF EXISTS `Boxes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Boxes` (
`box_id` varchar(64) NOT NULL,
`customer_id` varchar(36) DEFAULT NULL,
`city` text DEFAULT NULL,
`pallet_id` varchar(36) DEFAULT NULL,
`created_at` datetime DEFAULT current_timestamp(),
`pouch_count` int(11) DEFAULT 0,
`shelf_id` varchar(255) DEFAULT NULL,
PRIMARY KEY (`box_id`),
KEY `customer_id` (`customer_id`),
KEY `idx_boxes_pallet` (`pallet_id`),
KEY `idx_boxes_shelf_id` (`shelf_id`),
CONSTRAINT `Boxes_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `Customers` (`customer_id`),
CONSTRAINT `fk_boxes_pallet` FOREIGN KEY (`pallet_id`) REFERENCES `Pallets` (`pallet_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Cities`
--

DROP TABLE IF EXISTS `Cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Cities` (
`city_id` int(11) NOT NULL AUTO_INCREMENT,
`name` varchar(255) NOT NULL,
PRIMARY KEY (`city_id`),
UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

-- Insert default cities
INSERT INTO `Cities` (`name`) VALUES
('Kuopio'),
('Mikkeli'),
('Varkaus'),
('Lapinlahti'),
('Joensuu'),
('Lahti');


--
-- Table structure for table `Crates`
--

DROP TABLE IF EXISTS `Crates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Crates` (
`crate_id` varchar(36) NOT NULL,
`customer_id` varchar(36) DEFAULT NULL,
`status` varchar(50) DEFAULT NULL,
`created_at` datetime NOT NULL DEFAULT current_timestamp(),
`crate_order` varchar(10) DEFAULT NULL,
PRIMARY KEY (`crate_id`),
KEY `customer_id` (`customer_id`),
KEY `idx_crates_created_at` (`created_at`),
CONSTRAINT `Crates_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `Customers` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Customers`
--

DROP TABLE IF EXISTS `Customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Customers` (
`customer_id` varchar(36) NOT NULL,
`name` varchar(255) NOT NULL,
`address` text DEFAULT NULL,
`phone` varchar(50) DEFAULT NULL,
`email` varchar(255) DEFAULT NULL,
`city` text DEFAULT NULL,
`created_at` datetime NOT NULL DEFAULT current_timestamp(),
PRIMARY KEY (`customer_id`),
KEY `idx_customers_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Orders`
--

DROP TABLE IF EXISTS `Orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Orders` (
`order_id` varchar(36) NOT NULL,
`customer_id` varchar(36) NOT NULL,
`status` varchar(50) DEFAULT NULL,
`weight_kg` decimal(10,2) DEFAULT NULL,
`crate_count` int(11) DEFAULT NULL,
`boxes_count` int(11) NOT NULL DEFAULT 0,
`total_cost` decimal(10,2) DEFAULT NULL,
`pouches_count` int(11) DEFAULT NULL,
`notes` text DEFAULT NULL,
`created_at` date DEFAULT NULL,
`ready_at` datetime DEFAULT NULL,
PRIMARY KEY (`order_id`),
UNIQUE KEY `unique_customer_id` (`customer_id`),
KEY `idx_orders_ready_at` (`ready_at`),
CONSTRAINT `Orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `Customers` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Pallets`
--

DROP TABLE IF EXISTS `Pallets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Pallets` (
`pallet_id` varchar(36) NOT NULL,
`location` varchar(255) DEFAULT NULL,
`created_at` date DEFAULT curdate(),
`status` enum('available','loading','full','shipped') DEFAULT 'available',
`capacity` int(11) DEFAULT 8,
`holding` int(11) DEFAULT 0,
`shelf_id` text DEFAULT NULL,
PRIMARY KEY (`pallet_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

-- Insert default pallets for each city with random UUIDs
INSERT INTO `Pallets` (`pallet_id`, `location`, `status`, `capacity`, `holding`) VALUES
(UUID(), 'Kuopio', 'available', 8, 0),
(UUID(), 'Kuopio', 'available', 8, 0),
(UUID(), 'Mikkeli', 'available', 8, 0),
(UUID(), 'Mikkeli', 'available', 8, 0),
(UUID(), 'Varkaus', 'available', 8, 0),
(UUID(), 'Varkaus', 'available', 8, 0),
(UUID(), 'Lapinlahti', 'available', 8, 0),
(UUID(), 'Lapinlahti', 'available', 8, 0),
(UUID(), 'Joensuu', 'available', 8, 0),
(UUID(), 'Joensuu', 'available', 8, 0),
(UUID(), 'Lahti', 'available', 8, 0),
(UUID(), 'Lahti', 'available', 8, 0);


--
-- Table structure for table `Shelves`
--

DROP TABLE IF EXISTS `Shelves`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Shelves` (
`shelf_id` varchar(36) NOT NULL,
`location` varchar(255) DEFAULT NULL,
`shelf_name` varchar(64) NOT NULL,
`status` varchar(50) DEFAULT NULL,
`capacity` int(11) DEFAULT NULL,
`holding` int(11) DEFAULT NULL,
`created_at` datetime DEFAULT current_timestamp(),
PRIMARY KEY (`shelf_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


-- Insert default shelves for each city with random UUIDs
INSERT INTO `Shelves` (`shelf_id`, `location`, `shelf_name`, `status`) VALUES
(UUID(), 'Kuopio', 'Shelf 1', 'available'),
(UUID(), 'Kuopio', 'Shelf 2', 'available'),
(UUID(), 'Mikkeli', 'Shelf 1', 'available'),
(UUID(), 'Mikkeli', 'Shelf 2', 'available'),
(UUID(), 'Varkaus', 'Shelf 1', 'available'),
(UUID(), 'Varkaus', 'Shelf 2', 'available'),
(UUID(), 'Lapinlahti', 'Shelf 1', 'available'),
(UUID(), 'Lapinlahti', 'Shelf 2', 'available'),
(UUID(), 'Joensuu', 'Shelf 1', 'available'),
(UUID(), 'Joensuu', 'Shelf 2', 'available'),
(UUID(), 'Lahti', 'Shelf 1', 'available'),
(UUID(), 'Lahti', 'Shelf 2', 'available');

--
-- Table structure for table `SmsStatus`
--

DROP TABLE IF EXISTS `SmsStatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `SmsStatus` (
`customer_id` char(36) NOT NULL,
`sent_count` int(11) NOT NULL DEFAULT 0,
`last_status` enum('sent','skipped','not_sent') NOT NULL DEFAULT 'not_sent',
`updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
PRIMARY KEY (`customer_id`),
CONSTRAINT `fk_sms_customer` FOREIGN KEY (`customer_id`) REFERENCES `Customers` (`customer_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-19  0:27:32