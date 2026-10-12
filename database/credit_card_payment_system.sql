-- MySQL dump 10.13  Distrib 9.7.1, for Win64 (x86_64)
--
-- Host: localhost    Database: credit_card_payment_system
-- ------------------------------------------------------
-- Server version	9.7.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '98922b3e-7518-11f1-a915-005056c00001:1-984';

--
-- Current Database: `credit_card_payment_system`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `credit_card_payment_system` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `credit_card_payment_system`;

--
-- Table structure for table `audit_logs_adminlog`
--

DROP TABLE IF EXISTS `audit_logs_adminlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit_logs_adminlog` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `action` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `admin_user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `audit_logs_adminlog_admin_user_id_c80587f5_fk_auth_user_id` (`admin_user_id`),
  CONSTRAINT `audit_logs_adminlog_admin_user_id_c80587f5_fk_auth_user_id` FOREIGN KEY (`admin_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_logs_adminlog`
--

LOCK TABLES `audit_logs_adminlog` WRITE;
/*!40000 ALTER TABLE `audit_logs_adminlog` DISABLE KEYS */;
INSERT INTO `audit_logs_adminlog` VALUES (1,'EXPORT','Exported 2 transaction(s) to CSV.','2026-10-08 11:14:05.258257',3);
/*!40000 ALTER TABLE `audit_logs_adminlog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add Blacklisted Token',7,'add_blacklistedtoken'),(26,'Can change Blacklisted Token',7,'change_blacklistedtoken'),(27,'Can delete Blacklisted Token',7,'delete_blacklistedtoken'),(28,'Can view Blacklisted Token',7,'view_blacklistedtoken'),(29,'Can add Outstanding Token',8,'add_outstandingtoken'),(30,'Can change Outstanding Token',8,'change_outstandingtoken'),(31,'Can delete Outstanding Token',8,'delete_outstandingtoken'),(32,'Can view Outstanding Token',8,'view_outstandingtoken'),(33,'Can add card',9,'add_card'),(34,'Can change card',9,'change_card'),(35,'Can delete card',9,'delete_card'),(36,'Can view card',9,'view_card'),(37,'Can add transaction',10,'add_transaction'),(38,'Can change transaction',10,'change_transaction'),(39,'Can delete transaction',10,'delete_transaction'),(40,'Can view transaction',10,'view_transaction'),(41,'Can add admin log',11,'add_adminlog'),(42,'Can change admin log',11,'change_adminlog'),(43,'Can delete admin log',11,'delete_adminlog'),(44,'Can view admin log',11,'view_adminlog');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$1000000$xULxllROTKXjTOB1a26oaO$WgDse7swpTNYBOf9TzC60v85Ap7yP4vgWAd4YtaXrvI=',NULL,0,'thejesh','','','thejesh@example.com',0,1,'2026-10-08 04:06:09.649055'),(2,'pbkdf2_sha256$1000000$PBnU9lp26r1SGETlVboQhK$dcjzcVjy/Z1Es8ktnadyCp64bHUmhSDm2SAZ852WqO0=',NULL,0,'teja','','','teja@example.com',0,1,'2026-10-08 05:42:25.672786'),(3,'pbkdf2_sha256$1000000$wGQvCotPkAJhTzzTJJR1Sw$2q50JwMRhcUQoRfidVA78wtxoLz4twatANAKLQ/6rRI=','2026-10-08 15:04:12.484914',1,'admin','','','admin@example.com',1,1,'2026-10-08 10:52:19.220654'),(4,'pbkdf2_sha256$1000000$wActVmW59LtiTTfjhDdzjf$9jMY7Yc2Sr9JyDuOEB3a5xATu6auwxDDZRGP5nZv2bA=',NULL,0,'postmanuser','','','postmanuser@example.com',0,1,'2026-10-08 14:23:16.949378'),(5,'pbkdf2_sha256$1000000$dUDXS2CZmnZPbEDerbjMAS$u6cSbCAoSs7JSkd2kLNNcRZQ9KcynQf9ujOWonP/O0Y=',NULL,0,'gowtham','','','gowtham@gmail.com',0,1,'2026-10-08 14:25:16.328416'),(6,'pbkdf2_sha256$1000000$poTlnsVbF9YOgx1n0yyshL$F0wkc/OVZz5WHlDpm1MkkDNczfJFgqcxNKgDeIsrKng=',NULL,0,'suresh','','','suresg@gmail.com',0,1,'2026-10-09 07:39:11.222872'),(7,'pbkdf2_sha256$1000000$kfk4gW5U7YJPihtI97kbaf$9KgnJp8lHS3pPxA+AXuExmAnzTnByK/X5SJogMZHCoU=',NULL,0,'Venky','','','venky@gmail.com',0,1,'2026-10-11 14:30:03.226689');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cards_card`
--

DROP TABLE IF EXISTS `cards_card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cards_card` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `card_type` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `masked_card_number` varchar(19) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_four` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiry_month` smallint unsigned NOT NULL,
  `expiry_year` smallint unsigned NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cards_card_user_id_9c174339_fk_auth_user_id` (`user_id`),
  CONSTRAINT `cards_card_user_id_9c174339_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `cards_card_chk_1` CHECK ((`expiry_month` >= 0)),
  CONSTRAINT `cards_card_chk_2` CHECK ((`expiry_year` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cards_card`
--

LOCK TABLES `cards_card` WRITE;
/*!40000 ALTER TABLE `cards_card` DISABLE KEYS */;
INSERT INTO `cards_card` VALUES (6,'CREDIT','************1111','1111',12,2029,'2026-10-08 07:12:12.077740',1),(7,'CREDIT','************4444','4444',12,2029,'2026-10-08 07:23:44.685498',2),(8,'CREDIT','************1111','1111',12,2030,'2026-10-08 14:38:56.231769',5),(9,'CREDIT','************1111','1111',12,2030,'2026-10-09 07:42:06.059460',6),(10,'CREDIT','************1111','1111',12,2030,'2026-10-11 14:36:38.162591',7);
/*!40000 ALTER TABLE `cards_card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext COLLATE utf8mb4_unicode_ci,
  `object_repr` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(11,'audit_logs','adminlog'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(9,'cards','card'),(5,'contenttypes','contenttype'),(6,'sessions','session'),(7,'token_blacklist','blacklistedtoken'),(8,'token_blacklist','outstandingtoken'),(10,'transactions','transaction');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2026-10-07 09:47:09.141658'),(2,'auth','0001_initial','2026-10-07 09:47:09.703174'),(3,'admin','0001_initial','2026-10-07 09:47:09.878046'),(4,'admin','0002_logentry_remove_auto_add','2026-10-07 09:47:09.884489'),(5,'admin','0003_logentry_add_action_flag_choices','2026-10-07 09:47:09.890784'),(6,'contenttypes','0002_remove_content_type_name','2026-10-07 09:47:10.034566'),(7,'auth','0002_alter_permission_name_max_length','2026-10-07 09:47:10.085946'),(8,'auth','0003_alter_user_email_max_length','2026-10-07 09:47:10.102149'),(9,'auth','0004_alter_user_username_opts','2026-10-07 09:47:10.107308'),(10,'auth','0005_alter_user_last_login_null','2026-10-07 09:47:10.164140'),(11,'auth','0006_require_contenttypes_0002','2026-10-07 09:47:10.166294'),(12,'auth','0007_alter_validators_add_error_messages','2026-10-07 09:47:10.171649'),(13,'auth','0008_alter_user_username_max_length','2026-10-07 09:47:10.233057'),(14,'auth','0009_alter_user_last_name_max_length','2026-10-07 09:47:10.280440'),(15,'auth','0010_alter_group_name_max_length','2026-10-07 09:47:10.292416'),(16,'auth','0011_update_proxy_permissions','2026-10-07 09:47:10.300087'),(17,'auth','0012_alter_user_first_name_max_length','2026-10-07 09:47:10.356190'),(18,'sessions','0001_initial','2026-10-07 09:47:10.384769'),(19,'token_blacklist','0001_initial','2026-10-07 10:26:03.624488'),(20,'token_blacklist','0002_outstandingtoken_jti_hex','2026-10-07 10:26:03.686730'),(21,'token_blacklist','0003_auto_20171017_2007','2026-10-07 10:26:03.695150'),(22,'token_blacklist','0004_auto_20171017_2013','2026-10-07 10:26:03.769875'),(23,'token_blacklist','0005_remove_outstandingtoken_jti','2026-10-07 10:26:03.825815'),(24,'token_blacklist','0006_auto_20171017_2113','2026-10-07 10:26:03.842390'),(25,'token_blacklist','0007_auto_20171017_2214','2026-10-07 10:26:04.070005'),(26,'token_blacklist','0008_migrate_to_bigautofield','2026-10-07 10:26:04.278153'),(27,'token_blacklist','0010_fix_migrate_to_bigautofield','2026-10-07 10:26:04.287037'),(28,'token_blacklist','0011_linearizes_history','2026-10-07 10:26:04.289294'),(29,'token_blacklist','0012_alter_outstandingtoken_user','2026-10-07 10:26:04.295314'),(30,'token_blacklist','0013_alter_blacklistedtoken_options_and_more','2026-10-07 10:26:04.305433'),(31,'cards','0001_initial','2026-10-08 06:06:45.587424'),(32,'transactions','0001_initial','2026-10-08 08:16:46.244440'),(33,'audit_logs','0001_initial','2026-10-08 10:24:23.485039');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `session_data` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('yxrxp2gdylhefwmru2qrqljhm8wqm13e','.eJxVjEEOwiAQAP-yZ0NaWKD06N03kGUBqRpISnsy_t006UGvM5N5g6d9K37vafVLhBkUXH5ZIH6meoj4oHpvglvd1iWIIxGn7eLWYnpdz_ZvUKgXmMHSmHFC1NLl6DCqkIhIGhUwMQUio1ijRTsw5zCwzVM2UqPRZnQKDXy--Yk4BA:1xEpfI:Inuhih0VEFZe3LMzwUZQPTIOb0DP164U_KNxjEmIRrI','2026-10-22 15:04:12.517918');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `token_blacklist_blacklistedtoken`
--

DROP TABLE IF EXISTS `token_blacklist_blacklistedtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `token_blacklist_blacklistedtoken` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `blacklisted_at` datetime(6) NOT NULL,
  `token_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token_id` (`token_id`),
  CONSTRAINT `token_blacklist_blacklistedtoken_token_id_3cc7fe56_fk` FOREIGN KEY (`token_id`) REFERENCES `token_blacklist_outstandingtoken` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token_blacklist_blacklistedtoken`
--

LOCK TABLES `token_blacklist_blacklistedtoken` WRITE;
/*!40000 ALTER TABLE `token_blacklist_blacklistedtoken` DISABLE KEYS */;
INSERT INTO `token_blacklist_blacklistedtoken` VALUES (1,'2026-10-08 04:23:42.769445',1),(2,'2026-10-08 04:37:46.762886',2),(3,'2026-10-08 05:50:00.438070',3),(4,'2026-10-11 15:05:44.255595',19),(5,'2026-10-11 15:18:54.590531',23),(6,'2026-10-11 15:25:04.775330',24),(7,'2026-10-11 15:27:11.177260',25),(8,'2026-10-11 15:29:40.708835',27);
/*!40000 ALTER TABLE `token_blacklist_blacklistedtoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `token_blacklist_outstandingtoken`
--

DROP TABLE IF EXISTS `token_blacklist_outstandingtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `token_blacklist_outstandingtoken` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `token` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `expires_at` datetime(6) NOT NULL,
  `user_id` int DEFAULT NULL,
  `jti` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token_blacklist_outstandingtoken_jti_hex_d9bdf6f7_uniq` (`jti`),
  KEY `token_blacklist_outs_user_id_83bc629a_fk_auth_user` (`user_id`),
  CONSTRAINT `token_blacklist_outs_user_id_83bc629a_fk_auth_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token_blacklist_outstandingtoken`
--

LOCK TABLES `token_blacklist_outstandingtoken` WRITE;
/*!40000 ALTER TABLE `token_blacklist_outstandingtoken` DISABLE KEYS */;
INSERT INTO `token_blacklist_outstandingtoken` VALUES (1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MTUxOTA2NSwiaWF0IjoxNzkxNDMyNjY1LCJqdGkiOiJiOTgxOGEzOGNjZjY0NTBiYjdlYmY1YTUwYmE0ZGMzMSIsInVzZXJfaWQiOiIxIn0.Sz3cMyDG4djVsg6Yi0EZqnMkj7lmmKKfBtybtw8lWoE','2026-10-08 04:11:05.887145','2026-10-09 04:11:05.000000',1,'b9818a38ccf6450bb7ebf5a50ba4dc31'),(2,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MTUyMDM1OCwiaWF0IjoxNzkxNDMzOTU4LCJqdGkiOiJkMjcwODUwZmQyM2E0ZDJjOGNlMzEwMTg4YmQyYjc3NiIsInVzZXJfaWQiOiIxIn0.qv88CFL-xC3wmXQcsZRirOLlYKebW9tvUi9KG8QSVyA','2026-10-08 04:32:38.222899','2026-10-09 04:32:38.000000',1,'d270850fd23a4d2c8ce310188bd2b776'),(3,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MTUyNDY3NCwiaWF0IjoxNzkxNDM4Mjc0LCJqdGkiOiIxYjBmZWIzOTExNzU0NTI0YTAzZjVjNzZlZDkzYmNmYSIsInVzZXJfaWQiOiIyIn0.jL7MznwCkyNgeRc_RnkQVFJ2TAo2n8sa-LidQTjCC6Q','2026-10-08 05:44:34.971163','2026-10-09 05:44:34.000000',2,'1b0feb3911754524a03f5c76ed93bcfa'),(4,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MTUyNzU3NSwiaWF0IjoxNzkxNDQxMTc1LCJqdGkiOiI4N2IxODcxNWYxOGY0YTVlOWJkNzYzN2NmYzU1MmU4NCIsInVzZXJfaWQiOiIxIn0.h24JLUIPdU36-DqXKajB6uFzxW_pmlN4y_lKEByhvco','2026-10-08 06:32:55.993955','2026-10-09 06:32:55.000000',1,'87b18715f18f4a5e9bd7637cfc552e84'),(5,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MTUyNzYyMSwiaWF0IjoxNzkxNDQxMjIxLCJqdGkiOiI0MWExNDY0NzM3YTc0YjA2YTU1NDUwYWJiZTM2MDQwOSIsInVzZXJfaWQiOiIxIn0.M95Z-EbU0EGEFIebrAj708nhOXqWWFp0NwAuq1jzdeY','2026-10-08 06:33:41.294482','2026-10-09 06:33:41.000000',1,'41a1464737a74b06a55450abbe360409'),(6,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MTUyODYxNCwiaWF0IjoxNzkxNDQyMjE0LCJqdGkiOiIwYWJjN2I4MjhlNzk0ZTdhYWI5OWZmNGZmZmY2NWIyZiIsInVzZXJfaWQiOiIxIn0._kcamXH-xrWfkNGtVdxJ5LVhK1C2XyySUnHsiLsO95k','2026-10-08 06:50:14.612976','2026-10-09 06:50:14.000000',1,'0abc7b828e794e7aab99ff4ffff65b2f'),(7,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MTUyOTIzMSwiaWF0IjoxNzkxNDQyODMxLCJqdGkiOiI2MTFhYjIyNDNiMmM0MDUyYTYwNmFhODY0MGU2NDJjNiIsInVzZXJfaWQiOiIxIn0.QM_6SzJ0MuXkfEBDZC9Lxeso2h-u211Q53Z8N2roFok','2026-10-08 07:00:31.190694','2026-10-09 07:00:31.000000',1,'611ab2243b2c4052a606aa8640e642c6'),(8,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MTUyOTk4OSwiaWF0IjoxNzkxNDQzNTg5LCJqdGkiOiI3MDk1YmI3OTZjNWY0ODQ1OTBiYmI2MjliYzk2YzM3MCIsInVzZXJfaWQiOiIyIn0.Bt65_al_iaaEtKk7_ggMSO5n3JWh5XuMl6xxtnTjLLA','2026-10-08 07:13:09.191622','2026-10-09 07:13:09.000000',2,'7095bb796c5f484590bbb629bc96c370'),(9,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MTUzNzU3MSwiaWF0IjoxNzkxNDUxMTcxLCJqdGkiOiJjZjA1MDA5MmVjZjU0ZTIyYWFmZTUyNzRiNDcwMDE3MiIsInVzZXJfaWQiOiIxIn0.HcZgc0vJqRPulVlnaSue10AWpBxQuA_nSQ7rVSAtctg','2026-10-08 09:19:31.029622','2026-10-09 09:19:31.000000',1,'cf050092ecf54e22aafe5274b4700172'),(10,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MTU0MDU3NSwiaWF0IjoxNzkxNDU0MTc1LCJqdGkiOiIyM2ZjMDZmYjZjMWQ0YzRiYTU0YjExOWEzMDk2MDQ1OSIsInVzZXJfaWQiOiIyIn0.p8p7PV04iMCkLzhZW-5rAz0ZjTpY-GrkF6j1mg3yw_k','2026-10-08 10:09:35.671729','2026-10-09 10:09:35.000000',2,'23fc06fb6c1d4c4ba54b119a30960459'),(11,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MTU1NjA4MCwiaWF0IjoxNzkxNDY5NjgwLCJqdGkiOiIyNDZiOTIwMjBjNDQ0NTQwOTVhY2Y3MDhjYTE3NWU4MSIsInVzZXJfaWQiOiI1In0.u4qzkDe3AO44VU_BpxgD3EFfXL8eadkciI9D4RJSTrk','2026-10-08 14:28:00.051775','2026-10-09 14:28:00.000000',5,'246b92020c44454095acf708ca175e81'),(12,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MTYxNzk3NSwiaWF0IjoxNzkxNTMxNTc1LCJqdGkiOiJhMTM3ZmE5MGQyMGQ0Zjg5OTg5YTAzODUxMjdmYTNjNiIsInVzZXJfaWQiOiI2In0.TsLkDt0w8ydoSDcF2gOzpXZsmOzNl51ktv-Oxmuaqvo','2026-10-09 07:39:35.126164','2026-10-10 07:39:35.000000',6,'a137fa90d20d4f89989a0385127fa3c6'),(13,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MTYyNDYzMCwiaWF0IjoxNzkxNTM4MjMwLCJqdGkiOiJmNjIwYWFmMmU3YjU0MjFkOTE2NzhiZTMzNDRkYTU5OCIsInVzZXJfaWQiOiIzIn0.4PCiNPS0MlAofTgeR2fCfvnCEQMt1ldxwhvHrVF1NRU','2026-10-09 09:30:30.063246','2026-10-10 09:30:30.000000',3,'f620aaf2e7b5421d91678be3344da598'),(14,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MTgxMjk3MiwiaWF0IjoxNzkxNzI2NTcyLCJqdGkiOiI0MjZjZTlkOGQyZjA0ZTljODRkYTQ4NmI2OWFiNWM0MyIsInVzZXJfaWQiOiIzIn0.tnD5QpKWHZlZ1iZG25DRbO9uWqWAX6mwT7kHrJOqoBg','2026-10-11 13:49:32.605598','2026-10-12 13:49:32.000000',3,'426ce9d8d2f04e9c84da486b69ab5c43'),(15,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MTgxMzI0NSwiaWF0IjoxNzkxNzI2ODQ1LCJqdGkiOiIyN2E4NDRmNDZmOGM0OGVjYTRhZGNmNTdkNDEyYjNiMiIsInVzZXJfaWQiOiI2In0.beBmjOv9CSAaSGmNtPA7vnNszJBXRLbzBA5KaFeRcnI','2026-10-11 13:54:05.887579','2026-10-12 13:54:05.000000',6,'27a844f46f8c48eca4adcf57d412b3b2'),(16,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MTgxNTQ3NSwiaWF0IjoxNzkxNzI5MDc1LCJqdGkiOiI4OGY4M2Y4YTgyMGM0YTBkYmRmMzY1ODQ0YTNkM2ZjMiIsInVzZXJfaWQiOiI3In0.R1rTo2AINceFFrm3d4JwkDBmoqXvlGFMadstf_v3wlg','2026-10-11 14:31:15.835347','2026-10-12 14:31:15.000000',7,'88f83f8a820c4a0dbdf365844a3d3fc2'),(17,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MTgxNjUzMywiaWF0IjoxNzkxNzMwMTMzLCJqdGkiOiIyM2UzODA5MDdjYTU0YjUxOGI0ZmNhOWRiYzMxOThjZSIsInVzZXJfaWQiOiIzIn0.NlnrFEBCJx_b8_AdeIOMebDuhpgMU1pIZTBp5x_8Rbk','2026-10-11 14:48:53.618674','2026-10-12 14:48:53.000000',3,'23e380907ca54b518b4fca9dbc3198ce'),(18,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MTgxNjg4NSwiaWF0IjoxNzkxNzMwNDg1LCJqdGkiOiIzNmI0Y2VlYzk1Y2E0Yjc5YTVhOGU2YTYzNGMzYWZjOCIsInVzZXJfaWQiOiIxIn0.DBYS07pthxblP62yZwJCC4CA2MV8r-t0zuEn6bhH8y4','2026-10-11 14:54:45.972222','2026-10-12 14:54:45.000000',1,'36b4ceec95ca4b79a5a8e6a634c3afc8'),(19,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MTgxNzUwMSwiaWF0IjoxNzkxNzMxMTAxLCJqdGkiOiIxYTVmYmNmZGQ4MzA0NWMxODkwNjAwMjVhMjhiOGQ3MyIsInVzZXJfaWQiOiIxIn0.K-QS_mXx0ZZjIWpqOi9OPp-9YvV9DR5_3o0SdrTKX3E','2026-10-11 15:05:01.386367','2026-10-12 15:05:01.000000',1,'1a5fbcfdd83045c189060025a28b8d73'),(20,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MTgxNzY3MCwiaWF0IjoxNzkxNzMxMjcwLCJqdGkiOiI5ZDgxZjg4YjAyN2M0OTMxODljMzZlYjE3ZmFkNmEwYiIsInVzZXJfaWQiOiIxIn0.tfKqdYTN95kMdcQhzNFlB8B1K6O0flOeBdNOfYIJ-48','2026-10-11 15:07:50.670755','2026-10-12 15:07:50.000000',1,'9d81f88b027c493189c36eb17fad6a0b'),(21,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MTgxNzczOSwiaWF0IjoxNzkxNzMxMzM5LCJqdGkiOiJkZjJlMDU2ZTRiOTY0YzRmOGEyMTZkOWFjZjAwYjQyNCIsInVzZXJfaWQiOiIxIn0.fSKzsBnBCzoJxupYfhxNjrvarp511IXVvpAeaC87hII','2026-10-11 15:08:59.809178','2026-10-12 15:08:59.000000',1,'df2e056e4b964c4f8a216d9acf00b424'),(22,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MTgxNzc4MSwiaWF0IjoxNzkxNzMxMzgxLCJqdGkiOiJmOGU4MzU1MGFjYmU0NzhlOGUzMTdjM2RiNTc3NTRmZCIsInVzZXJfaWQiOiIxIn0.DGPzQSLevJooc_Z9P-nY5gnPUYH9zJDx0BiDJ0ND_Ag','2026-10-11 15:09:41.948703','2026-10-12 15:09:41.000000',1,'f8e83550acbe478e8e317c3db57754fd'),(23,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MTgxODI2OCwiaWF0IjoxNzkxNzMxODY4LCJqdGkiOiJhZmYwZTQ3OTFiM2Y0ZDU3YTc1MWNmYmJmNDVjMjU4NyIsInVzZXJfaWQiOiIxIn0.8bzIE4CD3RGGKbw04DnVP97OBEtbWjOHRcO1hFaJoj0','2026-10-11 15:17:48.541554','2026-10-12 15:17:48.000000',1,'aff0e4791b3f4d57a751cfbbf45c2587'),(24,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MTgxODY0OSwiaWF0IjoxNzkxNzMyMjQ5LCJqdGkiOiJmYmMzZWJjMGRjZGQ0ZThmYTdlZTk1N2UxZjNjYjRkMSIsInVzZXJfaWQiOiIxIn0.F8Hj9dXdjKIBolekAHnGETMzW9al98e5yxo6Baqn2sw','2026-10-11 15:24:09.689217','2026-10-12 15:24:09.000000',1,'fbc3ebc0dcdd4e8fa7ee957e1f3cb4d1'),(25,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MTgxODgwMSwiaWF0IjoxNzkxNzMyNDAxLCJqdGkiOiJlMWVmMGE1ZDFiZGU0MzAzYWI0YmZkOWVlNWQxOTU4ZSIsInVzZXJfaWQiOiIxIn0.tf24Qxmk0S05xoFGQaPjmTjd1DSQiebMaKYpBcFjRhA','2026-10-11 15:26:41.724941','2026-10-12 15:26:41.000000',1,'e1ef0a5d1bde4303ab4bfd9ee5d1958e'),(26,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MTgxODkzMiwiaWF0IjoxNzkxNzMyNTMyLCJqdGkiOiJmOWM4YWFlMDdlMGE0ODc5YTliMzc1NWEyZDE5OWZlYSIsInVzZXJfaWQiOiIxIn0.RWljEm0w_icpxfX8fOpVUqQALoDWHdaYggfr5NmqEKc','2026-10-11 15:28:52.852597','2026-10-12 15:28:52.000000',1,'f9c8aae07e0a4879a9b3755a2d199fea'),(27,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MTgxODk1NSwiaWF0IjoxNzkxNzMyNTU1LCJqdGkiOiIxZWI5ZjA5YzAzZTI0OTcyODI4ZmU4NjExYjcyM2RhZSIsInVzZXJfaWQiOiIxIn0.jUTYRUUeHT1bBmyfsF_C2Wu1gepLrKMlCnFpxr4BA0Q','2026-10-11 15:29:15.187723','2026-10-12 15:29:15.000000',1,'1eb9f09c03e24972828fe8611b723dae');
/*!40000 ALTER TABLE `token_blacklist_outstandingtoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions_transaction`
--

DROP TABLE IF EXISTS `transactions_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions_transaction` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `amount` decimal(10,2) NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaction_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `card_id` bigint NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transaction_id` (`transaction_id`),
  KEY `transactions_transaction_card_id_b6891695_fk_cards_card_id` (`card_id`),
  KEY `transactions_transaction_user_id_b9ecc248_fk_auth_user_id` (`user_id`),
  CONSTRAINT `transactions_transaction_card_id_b6891695_fk_cards_card_id` FOREIGN KEY (`card_id`) REFERENCES `cards_card` (`id`),
  CONSTRAINT `transactions_transaction_user_id_b9ecc248_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions_transaction`
--

LOCK TABLES `transactions_transaction` WRITE;
/*!40000 ALTER TABLE `transactions_transaction` DISABLE KEYS */;
INSERT INTO `transactions_transaction` VALUES (1,500.00,'SUCCESS','5433eecb-af45-4912-aa6d-46f049536d98','2026-10-08 09:39:56.835639','2026-10-08 09:39:56.895466',6,1),(2,500.00,'FAILED','c56b7a93-02b1-490c-a493-4d1fd3b94828','2026-10-08 10:15:45.125805','2026-10-08 10:15:45.172875',6,1),(3,500.00,'FAILED','fd047d3c-ecd0-4b45-836a-678d477ae7e2','2026-10-08 14:45:40.108714','2026-10-08 14:45:40.167556',8,5),(4,500.00,'FAILED','a0fb4271-c90f-4468-a2bf-555a8bb2d96c','2026-10-08 14:47:05.967173','2026-10-08 14:47:05.973745',8,5),(5,5000.00,'SUCCESS','222ab300-f017-4d2d-a372-b19b249a80f6','2026-10-08 14:47:16.339248','2026-10-08 14:47:16.346571',8,5),(6,500.00,'SUCCESS','fb1b79dc-75f7-406f-b75c-954fa6b70475','2026-10-08 14:48:08.678631','2026-10-08 14:48:08.692517',8,5),(7,500.00,'SUCCESS','d734874b-4fdf-48d0-a6a9-86138851bf67','2026-10-08 14:48:18.996350','2026-10-08 14:48:19.004760',8,5),(8,50.00,'FAILED','f8aed2b6-c1a0-47c0-a09d-86caa362bcb0','2026-10-08 14:48:26.351694','2026-10-08 14:48:26.360408',8,5),(9,1000.00,'SUCCESS','d8c4e9c6-469e-4e7f-a3af-23361dc58ec2','2026-10-11 13:55:27.167653','2026-10-11 13:55:27.226647',9,6),(10,1000.00,'SUCCESS','c1e92dd9-0bd7-4dc3-a493-ccd59ea13641','2026-10-11 13:55:35.374316','2026-10-11 13:55:35.386872',9,6),(11,2000.00,'SUCCESS','09c62a66-643e-4ba3-818f-2cdf519eb419','2026-10-11 13:55:44.354660','2026-10-11 13:55:44.363201',9,6),(12,1000.00,'FAILED','4a092e9c-0d7f-43fd-80da-56991c7215af','2026-10-11 14:41:30.451769','2026-10-11 14:41:30.495918',10,7),(13,2000.00,'FAILED','8cd4fa30-b33a-4af1-bdab-6b622cb45b93','2026-10-11 14:41:57.891078','2026-10-11 14:41:57.903438',10,7),(14,5000.00,'SUCCESS','b70b5b94-9385-468f-9c06-535e421149e8','2026-10-11 14:42:26.505886','2026-10-11 14:42:26.518076',10,7);
/*!40000 ALTER TABLE `transactions_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'credit_card_payment_system'
--
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-11 22:40:19
