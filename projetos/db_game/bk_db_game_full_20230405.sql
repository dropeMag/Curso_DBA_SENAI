-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: db_game
-- ------------------------------------------------------
-- Server version	8.0.32

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

--
-- Table structure for table `tb_console`
--

DROP TABLE IF EXISTS `tb_console`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_console` (
  `id_console` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(35) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id_console`),
  UNIQUE KEY `uq_nome_console` (`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_console`
--

LOCK TABLES `tb_console` WRITE;
/*!40000 ALTER TABLE `tb_console` DISABLE KEYS */;
INSERT INTO `tb_console` VALUES (5,'PlayStation 2'),(4,'PlayStation 3'),(7,'Playstation 4'),(3,'PSP'),(6,'Wii'),(1,'Xbox'),(2,'Xbox 360');
/*!40000 ALTER TABLE `tb_console` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_jogo`
--

DROP TABLE IF EXISTS `tb_jogo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_jogo` (
  `id_jogo` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(35) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id_jogo`),
  UNIQUE KEY `uq_nome_jogo` (`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_jogo`
--

LOCK TABLES `tb_jogo` WRITE;
/*!40000 ALTER TABLE `tb_jogo` DISABLE KEYS */;
INSERT INTO `tb_jogo` VALUES (49,'24h'),(36,'BioShock'),(26,'Black'),(19,'Borderlands'),(48,'Breakdown'),(38,'Bully'),(22,'Dantes Inferno'),(17,'Daxter'),(2,'Dead or Alive 3'),(24,'Destiny'),(21,'Fable'),(4,'Fallout 3'),(41,'Far Cry 3'),(5,'FIFA 14'),(23,'Fifa 17'),(9,'Final Fantasy X'),(42,'God Hand'),(8,'God of War'),(18,'God of War: Chains of Olympus'),(3,'GTA V'),(6,'GTA: Vice City Stories'),(27,'Half Minute Hero'),(16,'Halo 2'),(1,'Halo: Combat Evolved'),(43,'Just Dance 3'),(12,'Just Dance 4'),(47,'Lego Indiana Jones'),(25,'Lego O Hobbit'),(34,'LEGO Star Wars II'),(31,'Lumines'),(46,'Mario Kart 8'),(39,'Mario Kart Wii'),(32,'Max Payne'),(7,'Minecraft'),(33,'Mortal Kombat'),(51,'NBA 2K22'),(50,'NBA 2K23'),(44,'Nintendo Land'),(14,'Persona 3'),(37,'Portal 2'),(35,'Prince of Persia The Sands of Time'),(29,'Psychonauts'),(20,'Sonic Lost World'),(15,'Spider Man 3'),(11,'Splatoon'),(40,'Steel Battalion'),(10,'Super Mario Galaxy'),(13,'Tekken 6'),(30,'The Last of Us'),(45,'The Legend of Zelda'),(28,'X-Men Legends II: Rise of Apoc.');
/*!40000 ALTER TABLE `tb_jogo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_jogo_console`
--

DROP TABLE IF EXISTS `tb_jogo_console`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_jogo_console` (
  `id_jogo` int NOT NULL,
  `id_console` int NOT NULL,
  PRIMARY KEY (`id_jogo`,`id_console`),
  KEY `fk_id_console` (`id_console`),
  CONSTRAINT `fk_id_console` FOREIGN KEY (`id_console`) REFERENCES `tb_console` (`id_console`),
  CONSTRAINT `fk_id_jogo` FOREIGN KEY (`id_jogo`) REFERENCES `tb_jogo` (`id_jogo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_jogo_console`
--

LOCK TABLES `tb_jogo_console` WRITE;
/*!40000 ALTER TABLE `tb_jogo_console` DISABLE KEYS */;
INSERT INTO `tb_jogo_console` VALUES (1,1),(2,1),(16,1),(21,1),(26,1),(29,1),(32,1),(35,1),(40,1),(48,1),(3,2),(4,2),(7,2),(15,2),(16,2),(19,2),(23,2),(24,2),(29,2),(34,2),(47,2),(5,3),(6,3),(13,3),(14,3),(15,3),(17,3),(18,3),(22,3),(27,3),(28,3),(31,3),(34,3),(47,3),(3,4),(7,4),(15,4),(18,4),(23,4),(30,4),(33,4),(35,4),(36,4),(37,4),(41,4),(47,4),(8,5),(9,5),(15,5),(28,5),(29,5),(33,5),(34,5),(35,5),(38,5),(42,5),(47,5),(10,6),(11,6),(12,6),(20,6),(25,6),(39,6),(43,6),(44,6),(45,6),(46,6),(47,6),(7,7),(23,7),(49,7);
/*!40000 ALTER TABLE `tb_jogo_console` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'db_game'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_console` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`Pedro`@`%` PROCEDURE `sp_insert_console`(console VARCHAR(255))
BEGIN
	INSERT INTO tb_console
		(nome)
    VALUES
		(console);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_jogo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`Pedro`@`%` PROCEDURE `sp_insert_jogo`(nome_jogo VARCHAR(35))
BEGIN
	DECLARE jogo VARCHAR(35);
	
    SET jogo = (SELECT nome 
				FROM tb_jogo 
                WHERE nome = nome_jogo);

    IF (UPPER(jogo) = UPPER(nome_jogo)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Jogo já cadastrado.';
    ELSE
		IF (LENGTH(nome_jogo) < 2) OR (nome_jogo IS NULL) THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nome de jogo inválido.';
		ELSE
			INSERT INTO tb_jogo
				(nome)
			VALUES
				(nome_jogo);
        END IF;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_jogo_console` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`Pedro`@`%` PROCEDURE `sp_insert_jogo_console`(cod_jogo INTEGER, cod_console INTEGER)
BEGIN
	DECLARE jogo INTEGER;
	DECLARE console INTEGER;
	
    SET jogo = (SELECT id_jogo 
				FROM tb_jogo 
                WHERE id_jogo = cod_jogo);
	
    SET console = (SELECT id_console 
				   FROM tb_console 
                   WHERE id_console = cod_console);
	
	IF (jogo = cod_jogo) AND (console = cod_console) THEN
		BEGIN
			IF NOT EXISTS (SELECT id_jogo, id_console FROM tb_jogo_console WHERE id_jogo = jogo AND id_console = console) THEN
                INSERT INTO tb_jogo_console
					(id_jogo, id_console)
				VALUES
					(jogo, console);
			ELSE
				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Registro já existe';
            END IF;
        END;
    ELSE
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Jogo ou Console inválido';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-04-05 22:23:33
