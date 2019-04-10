-- MySQL dump 10.13  Distrib 5.7.21, for Linux (x86_64)
--
-- Host: localhost    Database: laravel_db
-- ------------------------------------------------------
-- Server version	5.7.21

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `availability_zones`
--

DROP TABLE IF EXISTS `availability_zones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `availability_zones` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `region_id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `availability_zones_name_unique` (`name`),
  UNIQUE KEY `availability_zones_code_unique` (`code`),
  KEY `availability_zones_region_id_foreign` (`region_id`),
  CONSTRAINT `availability_zones_region_id_foreign` FOREIGN KEY (`region_id`) REFERENCES `regions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `availability_zones`
--

LOCK TABLES `availability_zones` WRITE;
/*!40000 ALTER TABLE `availability_zones` DISABLE KEYS */;
INSERT INTO `availability_zones` VALUES (1,1,'EU (Paris) - Pantin','eu-west-1a',NULL,'2019-01-04 12:07:53','2019-01-04 12:21:27'),(2,1,'EU (Paris) - Magny-les-Hameaux','eu-west-1b',NULL,'2019-01-04 12:12:41','2019-01-04 12:12:41');
/*!40000 ALTER TABLE `availability_zones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `departments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `number` int(10) unsigned DEFAULT NULL,
  `instance_quota` int(10) unsigned NOT NULL DEFAULT '5',
  `core_quota` int(10) unsigned NOT NULL DEFAULT '10',
  `memory_quota` int(10) unsigned NOT NULL DEFAULT '50',
  `volume_quota` int(10) unsigned NOT NULL DEFAULT '5',
  `gigabyte_quota` int(10) unsigned NOT NULL DEFAULT '1000',
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `environments`
--

DROP TABLE IF EXISTS `environments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `environments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `environments`
--

LOCK TABLES `environments` WRITE;
/*!40000 ALTER TABLE `environments` DISABLE KEYS */;
INSERT INTO `environments` VALUES (1,'DEV','DEVELOPMENT Environment','2018-12-18 09:51:11','2018-12-18 09:59:43'),(2,'PPD','PRE PRODUCTION Environment','2018-12-18 09:53:15','2018-12-18 09:53:15'),(3,'PRD','PRODUCTION Environment','2018-12-18 09:53:26','2018-12-18 09:53:26');
/*!40000 ALTER TABLE `environments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `short_name` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `environment_id` int(10) unsigned NOT NULL,
  `region` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_request_status` enum('pending','approved','rejected','cancelled') COLLATE utf8mb4_unicode_ci NOT NULL,
  `json_item_data` json DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `approved_by` int(10) unsigned NOT NULL,
  `crerated_by` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `items_environment_id_foreign` (`environment_id`),
  KEY `items_approved_by_foreign` (`approved_by`),
  KEY `items_crerated_by_foreign` (`crerated_by`),
  CONSTRAINT `items_approved_by_foreign` FOREIGN KEY (`approved_by`) REFERENCES `users` (`id`),
  CONSTRAINT `items_crerated_by_foreign` FOREIGN KEY (`crerated_by`) REFERENCES `users` (`id`),
  CONSTRAINT `items_environment_id_foreign` FOREIGN KEY (`environment_id`) REFERENCES `environments` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_10_12_000000_create_users_table',1),(2,'2014_10_12_100000_create_password_resets_table',1),(3,'2016_06_01_000001_create_oauth_auth_codes_table',1),(4,'2016_06_01_000002_create_oauth_access_tokens_table',1),(5,'2016_06_01_000003_create_oauth_refresh_tokens_table',1),(6,'2016_06_01_000004_create_oauth_clients_table',1),(7,'2016_06_01_000005_create_oauth_personal_access_clients_table',1),(8,'2018_12_06_072357_create_products_table',2),(9,'2018_12_07_103746_add_votes_to_products_table',3),(10,'2018_12_07_134451_create_env_table',4),(11,'2018_12_07_134723_create_environments_table',4),(12,'2018_12_10_133402_create_environments_table',5),(13,'2018_12_10_134215_create_product_versions_table',6),(14,'2018_12_10_134307_create_tags_table',7),(15,'2018_12_10_133555_create_items_table',8),(16,'2018_12_10_133706_create_servers_table',9),(17,'2018_12_10_134037_create_volumes_table',10),(18,'2018_12_14_103343_create_departments_table',11),(19,'2018_12_20_114903_add_boot_index_to_volumes',12),(20,'2018_12_21_063130_add_volume_id_to_volumes',13),(21,'2018_12_21_064737_rename_size_to_volume_size_volumes',14),(28,'2018_12_21_105253_create_regions_table',15),(29,'2018_12_21_122849_create_availability_zones_table',16),(30,'2019_01_04_081644_modify_description_regions_table',17),(31,'2019_01_04_120542_modify_description_availability_zones_table',18),(32,'2019_04_10_094940_create_items_table',19),(33,'2019_04_10_122019_add_more_column_items_table',20);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_access_tokens`
--

DROP TABLE IF EXISTS `oauth_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `client_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_access_tokens_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_access_tokens`
--

LOCK TABLES `oauth_access_tokens` WRITE;
/*!40000 ALTER TABLE `oauth_access_tokens` DISABLE KEYS */;
INSERT INTO `oauth_access_tokens` VALUES ('07fe64e676881b2c0c720178c3e144b882d2d748d6370ec5330165b73c8cdcc4e779d2ebef47cfe5',4,1,'MyApp','[]',0,'2018-12-06 12:09:22','2018-12-06 12:09:22','2019-12-06 12:09:22'),('524df5964fb077d138ea72d5ace46ee6db15590c29f4aeb44c24b9af4aa34184ab6238b39065d815',4,2,NULL,'[]',0,'2018-12-06 13:37:23','2018-12-06 13:37:23','2019-12-06 13:37:23'),('9072569bceb565014755587a0007d919737e762c1175b11d85b0327f084033708f62838d1cf4fd70',8,1,'MyApp','[]',0,'2018-12-06 12:52:58','2018-12-06 12:52:58','2019-12-06 12:52:58'),('c0541ed1efa408d6097d033cf094429681be435e144e7841f3379c7fdae4f707c98798851eaf010b',7,1,'MyApp','[]',0,'2018-12-06 12:34:54','2018-12-06 12:34:54','2019-12-06 12:34:54'),('d214e2b3568c48e37bd9173f7649e730cb62551ae8e181ad778fae2620f4ad4418d29b708fbcaac4',4,2,NULL,'[]',0,'2018-12-07 09:24:43','2018-12-07 09:24:43','2019-12-07 09:24:43'),('ef2706eab325ccb8720b6414dae2c3f946bedb5738b8e565653a3e080b6d951af19620a04e121fd5',4,2,NULL,'[]',0,'2018-12-07 09:25:09','2018-12-07 09:25:09','2019-12-07 09:25:09');
/*!40000 ALTER TABLE `oauth_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_auth_codes`
--

DROP TABLE IF EXISTS `oauth_auth_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_auth_codes`
--

LOCK TABLES `oauth_auth_codes` WRITE;
/*!40000 ALTER TABLE `oauth_auth_codes` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_auth_codes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_clients`
--

DROP TABLE IF EXISTS `oauth_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_clients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_clients_user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_clients`
--

LOCK TABLES `oauth_clients` WRITE;
/*!40000 ALTER TABLE `oauth_clients` DISABLE KEYS */;
INSERT INTO `oauth_clients` VALUES (1,NULL,'Laravel Personal Access Client','AfrmKW6QG5wFyfAgSZ1UaAwL8ztJXLfmBmFOTQVT','http://localhost',1,0,0,'2018-12-05 12:49:53','2018-12-05 12:49:53'),(2,NULL,'Laravel Password Grant Client','QZVUh0lF9A1nDD6Gc9ceojEZXR4lXonDvohwwItu','http://localhost',0,1,0,'2018-12-05 12:49:53','2018-12-05 12:49:53');
/*!40000 ALTER TABLE `oauth_clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_personal_access_clients`
--

DROP TABLE IF EXISTS `oauth_personal_access_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_personal_access_clients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_personal_access_clients_client_id_index` (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_personal_access_clients`
--

LOCK TABLES `oauth_personal_access_clients` WRITE;
/*!40000 ALTER TABLE `oauth_personal_access_clients` DISABLE KEYS */;
INSERT INTO `oauth_personal_access_clients` VALUES (1,1,'2018-12-05 12:49:53','2018-12-05 12:49:53');
/*!40000 ALTER TABLE `oauth_personal_access_clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_refresh_tokens`
--

DROP TABLE IF EXISTS `oauth_refresh_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_refresh_tokens`
--

LOCK TABLES `oauth_refresh_tokens` WRITE;
/*!40000 ALTER TABLE `oauth_refresh_tokens` DISABLE KEYS */;
INSERT INTO `oauth_refresh_tokens` VALUES ('b9c71820f9161eba4d0cc6a4cd6ff971e8a4b619d11c11292c70ab84673c49f5eabd78a2adfe83c8','d214e2b3568c48e37bd9173f7649e730cb62551ae8e181ad778fae2620f4ad4418d29b708fbcaac4',0,'2019-12-07 09:24:43'),('ebe98ab741dedaafe92305e7f0dedb2c4dd96d2a1f137c36e1acd4d76d0ab1f9819b3471bda897a9','524df5964fb077d138ea72d5ace46ee6db15590c29f4aeb44c24b9af4aa34184ab6238b39065d815',0,'2019-12-06 13:37:23'),('f63200313ddfb9a970492d1a45b5f8efbeb036e5d2e31984a0e1be8822e9ed426cf0dbb3bd2e7d48','ef2706eab325ccb8720b6414dae2c3f946bedb5738b8e565653a3e080b6d951af19620a04e121fd5',0,'2019-12-07 09:25:09');
/*!40000 ALTER TABLE `oauth_refresh_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_resets`
--

LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_versions`
--

DROP TABLE IF EXISTS `product_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_versions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(10) unsigned NOT NULL,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `salt_config_data` longtext COLLATE utf8mb4_unicode_ci,
  `ansible_config_data` longtext COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_versions_product_id_foreign` (`product_id`),
  CONSTRAINT `product_versions_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_versions`
--

LOCK TABLES `product_versions` WRITE;
/*!40000 ALTER TABLE `product_versions` DISABLE KEYS */;
INSERT INTO `product_versions` VALUES (1,1,'10.4',NULL,NULL,NULL,'2018-12-17 10:20:03','2018-12-18 07:58:14'),(5,1,'10.1',NULL,NULL,NULL,'2018-12-17 10:38:53','2018-12-17 10:38:53'),(6,4,'6.0',NULL,NULL,NULL,'2018-12-18 07:42:01','2018-12-18 07:59:53'),(7,4,'7.0',NULL,NULL,NULL,'2018-12-18 07:42:26','2018-12-18 07:42:26'),(8,4,'8.0',NULL,NULL,NULL,'2018-12-18 07:42:32','2018-12-18 07:42:32'),(9,4,'9.0',NULL,NULL,NULL,'2018-12-18 07:42:38','2018-12-18 07:42:38');
/*!40000 ALTER TABLE `product_versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `multiple_servers` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'MySQL','MySQL is an open. source relational database management system.',0,'2018-12-07 10:41:29','2018-12-17 08:44:15'),(4,'Tomcat','It is an open-source Java Servlet Container developed by the Apache Software Foundation',0,'2018-12-18 07:41:08','2018-12-18 07:45:35');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `regions`
--

DROP TABLE IF EXISTS `regions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `regions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` enum('ec2','rds') COLLATE utf8mb4_unicode_ci NOT NULL,
  `region` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `endpoint` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `protocol` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'http',
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `regions_name_unique` (`name`),
  UNIQUE KEY `regions_region_unique` (`region`),
  UNIQUE KEY `regions_endpoint_unique` (`endpoint`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `regions`
--

LOCK TABLES `regions` WRITE;
/*!40000 ALTER TABLE `regions` DISABLE KEYS */;
INSERT INTO `regions` VALUES (1,'EU (Paris)','ec2','eu-west-1','ec2.eu-west-1.dsone.3ds.com','http',NULL,'2019-01-04 08:23:27','2019-01-04 08:23:27'),(2,'Asia Pacific (Pune)','ec2','ap-south-1','ec2.ap-south-1.dsone.3ds.com','http',NULL,'2019-01-04 08:29:54','2019-01-04 10:50:25'),(3,'Asia Pacific  (Mumbai)','ec2','ap-south-2','ec2.ap-south-2.dsone.3ds.com','http',NULL,'2019-01-04 09:59:28','2019-01-04 09:59:28');
/*!40000 ALTER TABLE `regions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servers`
--

DROP TABLE IF EXISTS `servers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `servers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `instance_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `region` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `availability_zone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_id` int(10) unsigned NOT NULL,
  `ram` mediumint(8) unsigned NOT NULL,
  `cpu` smallint(5) unsigned NOT NULL,
  `os` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `domain` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `terraform_json_output` longtext COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `servers_item_id_foreign` (`item_id`),
  CONSTRAINT `servers_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servers`
--

LOCK TABLES `servers` WRITE;
/*!40000 ALTER TABLE `servers` DISABLE KEYS */;
/*!40000 ALTER TABLE `servers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tag_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tag_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tags_tag_type_tag_id_index` (`tag_type`,`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'zdAigv4n','uh2HUAYh0qIl@gmail.com',NULL,'$2y$10$Cb7m1SkFzq1Npq2Wv6yjLeofnlFUvzOEVVXZB7HzGNRZRWS1yphAS',NULL,'2018-12-06 11:07:52','2018-12-06 11:07:52'),(2,'Dy3p8I01','pHDnd1WSyTuF@gmail.com',NULL,'$2y$10$SqUz69A5WT6PLh2QO8fYye4Outmd1.amLfsHi/MYoadoNbr/FP9Ge',NULL,'2018-12-06 11:07:52','2018-12-06 11:07:52'),(3,'7JHjd5x6','iTMqyhvPD066@gmail.com',NULL,'$2y$10$o4lShWFN/fdbbZooK9bWtOs.vg6ZNR2OplLYuEN9xqcmhZ3JpNQoG',NULL,'2018-12-06 11:07:52','2018-12-06 11:07:52'),(4,'Pankaj','ghadge.pankaj@gmail.com',NULL,'$2y$10$YvsuPfsE6DHWITh5Q2vXOOfxCsKTJpY3ooVV3w3N48utxL1nByh1e',NULL,'2018-12-06 12:09:21','2018-12-06 12:09:21'),(7,'Pankaj1','ghadge1.pankaj@gmail.com',NULL,'$2y$10$03l7PwaquFgUibutdZ6syu9uOg4esWs8C6j65VcBGYpyS7u1eMDQu',NULL,'2018-12-06 12:34:54','2018-12-06 12:34:54'),(8,'Pankaj2','ghadge2.pankaj@gmail.com',NULL,'$2y$10$JjkHdteRZDTJ28kpQ1vCNuI2TOO0YCvtDLaRi0rveuwUgmkqV21Am',NULL,'2018-12-06 12:52:58','2018-12-06 12:52:58');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `volumes`
--

DROP TABLE IF EXISTS `volumes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volumes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `volume_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `volume_size` int(10) unsigned NOT NULL,
  `device_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `boot_index` smallint(6) DEFAULT NULL,
  `delete_on_termination` tinyint(1) NOT NULL DEFAULT '0',
  `mount_folder` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `filesystem` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `region` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `availability_zone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `server_id` int(10) unsigned NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `guest_format` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `volumes_server_id_foreign` (`server_id`),
  CONSTRAINT `volumes_server_id_foreign` FOREIGN KEY (`server_id`) REFERENCES `servers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `volumes`
--

LOCK TABLES `volumes` WRITE;
/*!40000 ALTER TABLE `volumes` DISABLE KEYS */;
/*!40000 ALTER TABLE `volumes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-04-10 12:29:48
