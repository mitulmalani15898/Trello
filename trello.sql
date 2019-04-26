CREATE DATABASE  IF NOT EXISTS `trello` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */;
USE `trello`;
-- MySQL dump 10.13  Distrib 8.0.13, for Win64 (x86_64)
--
-- Host: localhost    Database: trello
-- ------------------------------------------------------
-- Server version	8.0.13

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `board`
--

DROP TABLE IF EXISTS `board`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `board` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL,
  `teamId` int(11) DEFAULT '0',
  `boardName` varchar(255) DEFAULT NULL,
  `scope` tinyint(1) DEFAULT '1',
  `createdBy` int(11) DEFAULT '0',
  `createdDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedBy` int(11) DEFAULT '0',
  `updatedDate` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `userId_idx` (`userId`),
  KEY `teamId_idx` (`teamId`),
  CONSTRAINT `teamId` FOREIGN KEY (`teamId`) REFERENCES `team` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board`
--

LOCK TABLES `board` WRITE;
/*!40000 ALTER TABLE `board` DISABLE KEYS */;
INSERT INTO `board` VALUES (11,5,1,'My Board',1,0,'2019-04-17 12:31:01',0,'2019-04-17 12:31:01'),(12,5,1,'hello board',1,0,'2019-04-17 12:32:44',0,'2019-04-17 12:32:44'),(13,5,8,'my team board',1,0,'2019-04-17 12:32:59',0,'2019-04-17 12:32:59'),(14,5,8,'hello my team',1,0,'2019-04-17 13:04:20',0,'2019-04-17 13:04:20'),(15,5,1,'my personal',1,0,'2019-04-17 13:06:22',0,'2019-04-17 13:06:22'),(16,5,9,'team2 board',1,0,'2019-04-17 13:08:22',0,'2019-04-17 13:08:22'),(17,5,8,'hello team board',1,0,'2019-04-17 13:09:47',0,'2019-04-17 13:09:47');
/*!40000 ALTER TABLE `board` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `card`
--

DROP TABLE IF EXISTS `card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `card` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `listId` int(11) DEFAULT NULL,
  `cardName` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `createdBy` int(11) DEFAULT '0',
  `createdDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedBy` int(11) DEFAULT '0',
  `updatedDate` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `listId_idx` (`listId`),
  CONSTRAINT `listId` FOREIGN KEY (`listId`) REFERENCES `list` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `card`
--

LOCK TABLES `card` WRITE;
/*!40000 ALTER TABLE `card` DISABLE KEYS */;
INSERT INTO `card` VALUES (14,10,'hiii','fgfgdg',0,'2019-04-17 13:15:20',0,'2019-04-17 13:15:20'),(15,9,'hey you','it\'s all about card',0,'2019-04-17 13:15:30',0,'2019-04-17 13:15:30'),(16,9,'hey you',NULL,0,'2019-04-17 13:16:25',0,'2019-04-17 13:16:25'),(17,11,'how are you',NULL,0,'2019-04-17 13:16:43',0,'2019-04-17 13:16:43'),(18,10,'what?',NULL,0,'2019-04-17 13:16:54',0,'2019-04-17 13:16:54'),(19,10,'how?',NULL,0,'2019-04-17 13:16:59',0,'2019-04-17 13:16:59'),(20,13,'list testing',NULL,0,'2019-04-17 13:18:40',0,'2019-04-17 13:18:40'),(21,13,'testing',NULL,0,'2019-04-17 13:18:51',0,'2019-04-17 13:18:51'),(22,14,'when?',NULL,0,'2019-04-17 13:19:32',0,'2019-04-17 13:19:32'),(23,11,'My Card',NULL,0,'2019-04-19 14:13:13',0,'2019-04-19 14:13:13'),(25,15,'dsddo',NULL,0,'2019-04-26 11:21:20',0,'2019-04-26 11:21:20');
/*!40000 ALTER TABLE `card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `checklist`
--

DROP TABLE IF EXISTS `checklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `checklist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cardId` int(11) DEFAULT NULL,
  `checkListName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cardId_idx` (`cardId`),
  CONSTRAINT `cardId1` FOREIGN KEY (`cardId`) REFERENCES `card` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `checklist`
--

LOCK TABLES `checklist` WRITE;
/*!40000 ALTER TABLE `checklist` DISABLE KEYS */;
/*!40000 ALTER TABLE `checklist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `checklistitem`
--

DROP TABLE IF EXISTS `checklistitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `checklistitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `checkListId` int(11) DEFAULT NULL,
  `checkListItemName` varchar(255) DEFAULT NULL,
  `completed` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `checkListId_idx` (`checkListId`),
  CONSTRAINT `checkListId` FOREIGN KEY (`checkListId`) REFERENCES `checklist` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `checklistitem`
--

LOCK TABLES `checklistitem` WRITE;
/*!40000 ALTER TABLE `checklistitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `checklistitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cardId` int(11) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cardId` (`cardId`),
  CONSTRAINT `cardId` FOREIGN KEY (`cardId`) REFERENCES `card` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (5,15,'hi comment',5),(6,16,'hey ',5),(7,14,'hiii card',5),(9,15,'hello',5);
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `list`
--

DROP TABLE IF EXISTS `list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `boardId` int(11) DEFAULT NULL,
  `listName` varchar(255) DEFAULT NULL,
  `createdBy` int(11) DEFAULT '0',
  `createdDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedBy` int(11) DEFAULT '0',
  `updatedDate` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `boardId_idx` (`boardId`),
  CONSTRAINT `boardId` FOREIGN KEY (`boardId`) REFERENCES `board` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `list`
--

LOCK TABLES `list` WRITE;
/*!40000 ALTER TABLE `list` DISABLE KEYS */;
INSERT INTO `list` VALUES (9,11,'hey list',0,'2019-04-17 13:13:24',0,'2019-04-17 13:13:24'),(10,11,'hola list',0,'2019-04-17 13:13:44',0,'2019-04-17 13:13:44'),(11,11,'to list',0,'2019-04-17 13:13:55',0,'2019-04-17 13:13:55'),(12,11,'to do list',0,'2019-04-17 13:14:43',0,'2019-04-17 13:14:43'),(13,14,'list test12',0,'2019-04-17 13:18:14',0,'2019-04-17 13:18:14'),(14,14,'test ',0,'2019-04-17 13:18:23',0,'2019-04-17 13:18:23'),(15,14,'demo',0,'2019-04-17 13:18:28',0,'2019-04-17 13:18:28'),(17,14,'hrdf',0,'2019-04-26 11:21:00',0,'2019-04-26 11:21:00');
/*!40000 ALTER TABLE `list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team`
--

DROP TABLE IF EXISTS `team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `team` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL,
  `teamName` varchar(255) DEFAULT NULL,
  `teamDescription` varchar(255) DEFAULT NULL,
  `createdBy` int(11) DEFAULT '0',
  `createdDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedBy` int(11) DEFAULT '0',
  `updatedDate` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `userId_idx` (`userId`),
  CONSTRAINT `userId` FOREIGN KEY (`userId`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team`
--

LOCK TABLES `team` WRITE;
/*!40000 ALTER TABLE `team` DISABLE KEYS */;
INSERT INTO `team` VALUES (1,3,'Personal','Personal',0,'2019-04-10 12:05:59',0,'2019-04-10 12:05:59'),(8,5,'My Team','team description',0,'2019-04-17 12:32:10',0,'2019-04-17 12:32:10'),(9,5,'team2','team2 descrip',0,'2019-04-17 13:08:07',0,'2019-04-17 13:08:07'),(10,5,'mitul','project1',0,'2019-04-20 11:42:11',0,'2019-04-20 11:42:11');
/*!40000 ALTER TABLE `team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `isActive` tinyint(1) DEFAULT '1',
  `createdBy` int(11) DEFAULT '0',
  `createdDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedBy` int(11) DEFAULT '0',
  `updatedDate` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (3,'mitul','mitul123@gmail.com','$2b$08$mbRR39SaKAjAFYvymZIJC.cLpGzGlDkXSFB/3GPKTBKTMBGU8JBgm',1,0,'2019-04-05 11:41:28',0,'2019-04-05 11:41:28'),(5,'Mitul','mitul@gmail.com','$2b$08$fZnXxx2LG.Q3ZsQdhacb3uU/ihUn0tn/ye0jmDQAW3gcoJzDazOYi',1,0,'2019-04-17 12:26:17',0,'2019-04-17 12:26:17'),(6,'Amit','amit@gmail.com','$2b$08$ZzOg3yoYP0XVB/d3ei8WuuAeS5n1JCfx/kZ3gjFg4JPBpi2gEU0SG',1,0,'2019-04-17 12:26:53',0,'2019-04-17 12:26:53');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-04-26 21:04:16
