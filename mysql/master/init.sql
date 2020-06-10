-- 创建 data_copy 数据库
DROP DATABASE IF EXISTS `data_copy`;
CREATE DATABASE `data_copy` /*!40100 DEFAULT CHARACTER SET utf8mb4 collate utf8mb4_general_ci */;

-- 创建 person 表
USE `data_copy`;
DROP TABLE IF EXISTS `person`;
CREATE TABLE `person` (
  `id` int(32) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;