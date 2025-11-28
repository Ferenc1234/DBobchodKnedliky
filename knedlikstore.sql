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

CREATE TABLE `user_types` (
  `utype_id` int PRIMARY KEY AUTO_INCREMENT,
  `type` varchar(255),
  `permissions` int
);

CREATE TABLE `permissions` (
  `perm_id` int PRIMARY KEY AUTO_INCREMENT
);

CREATE TABLE `dumpling_type` (
  `dtype_id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255),
  `description` text
);

CREATE TABLE `dumpling` (
  `dumpling_id` int PRIMARY KEY AUTO_INCREMENT,
  `type` int,
  `description` text
);

CREATE TABLE `orders` (
  `order_id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int,
  `city` varchar(255),
  `address` varchar(255),
  `zipcode` int,
  `ordered` int,
  `vat` bool
);

CREATE TABLE `ordered_list` (
  `ordered_id` int PRIMARY KEY AUTO_INCREMENT,
  `dumpling_id` int,
  `quantity` int
);

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

CREATE TABLE `products` (
  `product_id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255)
);

CREATE TABLE `distributor_products` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `distributor_id` int,
  `product_id` int
);

ALTER TABLE `orders` ADD FOREIGN KEY (`order_id`) REFERENCES `ordered_list` (`ordered_id`);

ALTER TABLE `users` ADD FOREIGN KEY (`user_type`) REFERENCES `user_types` (`utype_id`);

ALTER TABLE `user_types` ADD FOREIGN KEY (`permissions`) REFERENCES `permissions` (`perm_id`);

ALTER TABLE `dumpling` ADD FOREIGN KEY (`type`) REFERENCES `dumpling_type` (`dtype_id`);

ALTER TABLE `orders` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

ALTER TABLE `orders` ADD FOREIGN KEY (`ordered`) REFERENCES `ordered_list` (`ordered_id`);

ALTER TABLE `ordered_list` ADD FOREIGN KEY (`dumpling_id`) REFERENCES `dumpling` (`dumpling_id`);

ALTER TABLE `distributors` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

ALTER TABLE `distributor_products` ADD FOREIGN KEY (`distributor_id`) REFERENCES `distributors` (`distributor_id`);

ALTER TABLE `distributor_products` ADD FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);
