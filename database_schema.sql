-- Permissions table (no dependencies)
CREATE TABLE `permissions` (
  `perm_id` int PRIMARY KEY AUTO_INCREMENT
);

-- User types table (depends on permissions)
CREATE TABLE `user_types` (
  `utype_id` int PRIMARY KEY AUTO_INCREMENT,
  `type` varchar(255),
  `permissions` int
);

-- Users table (depends on user_types)
CREATE TABLE `users` (
  `user_id` int PRIMARY KEY AUTO_INCREMENT,
  `username` varchar(255),
  `firstname` varchar(255),
  `lastname` varchar(255),
  `birth_date` date,
  `registration` timestamp,
  `city` varchar(255),
  `address` varchar(255),
  `zipcode` int,
  `vat` bool,
  `user_type` int
);

-- Dumpling type table (no dependencies)
CREATE TABLE `dumpling_type` (
  `dtype_id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255),
  `description` text
);

-- Dumpling table (depends on dumpling_type)
CREATE TABLE `dumpling` (
  `dumpling_id` int PRIMARY KEY AUTO_INCREMENT,
  `type` int,
  `description` text
);

-- Ordered list table (depends on dumpling)
CREATE TABLE `ordered_list` (
  `ordered_id` int PRIMARY KEY AUTO_INCREMENT,
  `dumpling_id` int,
  `quantity` int
);

-- Orders table (depends on users, ordered_list)
CREATE TABLE `orders` (
  `order_id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int,
  `city` varchar(255),
  `address` varchar(255),
  `zipcode` int,
  `ordered` int,
  `vat` bool
);

-- Distributors table (depends on users)
CREATE TABLE `distributors` (
  `distributor_id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int,
  `name` varchar(255),
  `description` text,
  `city` varchar(255),
  `address` varchar(255),
  `zipcode` int,
  `vat` bool
);

-- Products table (no dependencies)
CREATE TABLE `products` (
  `product_id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255)
);

-- Distributor products table (depends on distributors, products)
CREATE TABLE `distributor_products` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `distributor_id` int,
  `product_id` int
);

-- Foreign key constraints
ALTER TABLE `user_types` ADD FOREIGN KEY (`permissions`) REFERENCES `permissions` (`perm_id`);

ALTER TABLE `users` ADD FOREIGN KEY (`user_type`) REFERENCES `user_types` (`utype_id`);

ALTER TABLE `dumpling` ADD FOREIGN KEY (`type`) REFERENCES `dumpling_type` (`dtype_id`);

ALTER TABLE `ordered_list` ADD FOREIGN KEY (`dumpling_id`) REFERENCES `dumpling` (`dumpling_id`);

ALTER TABLE `orders` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

ALTER TABLE `orders` ADD FOREIGN KEY (`ordered`) REFERENCES `ordered_list` (`ordered_id`);

ALTER TABLE `distributors` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

ALTER TABLE `distributor_products` ADD FOREIGN KEY (`distributor_id`) REFERENCES `distributors` (`distributor_id`);

ALTER TABLE `distributor_products` ADD FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);
