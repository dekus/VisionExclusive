CREATE TABLE IF NOT EXISTS `marketplace` (
  `name` varchar(255) DEFAULT NULL,
  `spawn` varchar(255) DEFAULT NULL,
  `quantity` int(50) DEFAULT NULL,
  `price` int(50) DEFAULT NULL,
  `announcer` int(6) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `item_id` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;