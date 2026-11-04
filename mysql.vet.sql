CREATE DATABASE  IF NOT EXISTS `vetcare_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `vetcare_db`;
-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: vetcare_db
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `consulta`
--

DROP TABLE IF EXISTS `consulta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consulta` (
  `id_consulta` int NOT NULL AUTO_INCREMENT,
  `data_hora` datetime NOT NULL,
  `diagnostico` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_consulta` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `valor_consulta` decimal(10,2) NOT NULL,
  `id_pet` int NOT NULL,
  `id_veterinario` int NOT NULL,
  PRIMARY KEY (`id_consulta`),
  KEY `fk_consulta_pet` (`id_pet`),
  KEY `fk_consulta_vet` (`id_veterinario`),
  CONSTRAINT `fk_consulta_pet` FOREIGN KEY (`id_pet`) REFERENCES `pet` (`id_pet`),
  CONSTRAINT `fk_consulta_vet` FOREIGN KEY (`id_veterinario`) REFERENCES `veterinario` (`id_veterinario`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consulta`
--

LOCK TABLES `consulta` WRITE;
/*!40000 ALTER TABLE `consulta` DISABLE KEYS */;
INSERT INTO `consulta` VALUES (1,'2025-10-01 09:00:00','Check-up anual e imunização','Realizada',180.00,1,1),(2,'2025-10-03 14:30:00','Dermatite alérgica à picada de pulga','Realizada',210.00,3,2),(3,'2025-10-08 10:15:00','Gastrite leve, solicitado ultrassom','Realizada',200.00,2,3),(4,'2025-10-12 16:00:00','Aparagem de bico e avaliação nutricional','Realizada',190.00,5,4),(5,'2025-10-18 11:00:00','Infecção bacteriana ocular','Realizada',200.00,4,3),(6,'2025-10-25 09:30:00','Displasia coxofemoral leve','Realizada',250.00,1,5),(7,'2025-11-05 15:00:00','Retorno agendado para revisão','Agendada',180.00,6,4);
/*!40000 ALTER TABLE `consulta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `especie`
--

DROP TABLE IF EXISTS `especie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `especie` (
  `id_especie` int NOT NULL AUTO_INCREMENT,
  `nome_especie` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_especie`),
  UNIQUE KEY `nome_especie` (`nome_especie`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `especie`
--

LOCK TABLES `especie` WRITE;
/*!40000 ALTER TABLE `especie` DISABLE KEYS */;
INSERT INTO `especie` VALUES (3,'Ave'),(1,'Canina'),(2,'Felina'),(5,'Réptil'),(4,'Roedor');
/*!40000 ALTER TABLE `especie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `itens_consulta`
--

DROP TABLE IF EXISTS `itens_consulta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `itens_consulta` (
  `id_consulta` int NOT NULL,
  `id_servico` int NOT NULL,
  `quantidade` int NOT NULL,
  `valor_aplicado` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_consulta`,`id_servico`),
  KEY `fk_item_servico` (`id_servico`),
  CONSTRAINT `fk_item_consulta` FOREIGN KEY (`id_consulta`) REFERENCES `consulta` (`id_consulta`) ON DELETE CASCADE,
  CONSTRAINT `fk_item_servico` FOREIGN KEY (`id_servico`) REFERENCES `servico_insumo` (`id_servico`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `itens_consulta`
--

LOCK TABLES `itens_consulta` WRITE;
/*!40000 ALTER TABLE `itens_consulta` DISABLE KEYS */;
INSERT INTO `itens_consulta` VALUES (1,1,1,110.00),(1,2,1,80.00),(2,3,1,95.00),(2,5,1,135.00),(3,3,1,95.00),(3,4,1,220.00),(4,3,1,95.00),(5,6,2,75.00),(6,6,1,75.00);
/*!40000 ALTER TABLE `itens_consulta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pet`
--

DROP TABLE IF EXISTS `pet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pet` (
  `id_pet` int NOT NULL AUTO_INCREMENT,
  `nome_pet` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data_nascimento` date NOT NULL,
  `peso_kg` decimal(5,2) NOT NULL,
  `sexo` char(1) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_tutor` int NOT NULL,
  `id_raca` int NOT NULL,
  PRIMARY KEY (`id_pet`),
  KEY `fk_pet_tutor` (`id_tutor`),
  KEY `fk_pet_raca` (`id_raca`),
  CONSTRAINT `fk_pet_raca` FOREIGN KEY (`id_raca`) REFERENCES `raca` (`id_raca`),
  CONSTRAINT `fk_pet_tutor` FOREIGN KEY (`id_tutor`) REFERENCES `tutor` (`id_tutor`),
  CONSTRAINT `pet_chk_1` CHECK ((`sexo` in (_utf8mb4'M',_utf8mb4'F')))
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pet`
--

LOCK TABLES `pet` WRITE;
/*!40000 ALTER TABLE `pet` DISABLE KEYS */;
INSERT INTO `pet` VALUES (1,'Thor','2021-05-10',32.50,'M',1,1),(2,'Luna','2022-08-15',4.20,'F',2,3),(3,'Bolinha','2020-02-20',12.80,'M',1,2),(4,'Mia','2023-01-12',3.80,'F',3,4),(5,'Piu','2023-06-01',0.11,'M',4,5),(6,'Amendoim','2022-11-30',0.95,'M',5,6),(7,'Casco','2018-04-05',5.40,'M',6,7);
/*!40000 ALTER TABLE `pet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `raca`
--

DROP TABLE IF EXISTS `raca`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `raca` (
  `id_raca` int NOT NULL AUTO_INCREMENT,
  `nome_raca` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_especie` int NOT NULL,
  PRIMARY KEY (`id_raca`),
  KEY `fk_raca_especie` (`id_especie`),
  CONSTRAINT `fk_raca_especie` FOREIGN KEY (`id_especie`) REFERENCES `especie` (`id_especie`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `raca`
--

LOCK TABLES `raca` WRITE;
/*!40000 ALTER TABLE `raca` DISABLE KEYS */;
INSERT INTO `raca` VALUES (1,'Golden Retriever',1),(2,'Bulldog Francês',1),(3,'Siamês',2),(4,'Persa',2),(5,'Calopsita Arlequim',3),(6,'Porquinho-da-índia Inglês',4),(7,'Jabuti-piranga',5);
/*!40000 ALTER TABLE `raca` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servico_insumo`
--

DROP TABLE IF EXISTS `servico_insumo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `servico_insumo` (
  `id_servico` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `preco_unitario` decimal(10,2) NOT NULL,
  `categoria` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_servico`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servico_insumo`
--

LOCK TABLES `servico_insumo` WRITE;
/*!40000 ALTER TABLE `servico_insumo` DISABLE KEYS */;
INSERT INTO `servico_insumo` VALUES (1,'Vacina Polivalente V10',110.00,'Vacina'),(2,'Vacina Antirrábica',80.00,'Vacina'),(3,'Hemograma Completo',95.00,'Exame'),(4,'Ultrassonografia Abdominal',220.00,'Exame'),(5,'Antipulgas e Carrapatos Mastigável',135.00,'Medicamento'),(6,'Antibiótico Veterinário 50mg',75.00,'Medicamento');
/*!40000 ALTER TABLE `servico_insumo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tutor`
--

DROP TABLE IF EXISTS `tutor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tutor` (
  `id_tutor` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cpf` char(11) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logradouro` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bairro` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cidade` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_tutor`),
  UNIQUE KEY `cpf` (`cpf`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tutor`
--

LOCK TABLES `tutor` WRITE;
/*!40000 ALTER TABLE `tutor` DISABLE KEYS */;
INSERT INTO `tutor` VALUES (1,'Carlos Eduardo Silva','12345678901','carlos.silva@email.com','Rua das Flores, 120','Centro','São Paulo'),(2,'Mariana Souza Oliveira','23456789012','mariana.souza@email.com','Av. Paulista, 1500','Bela Vista','São Paulo'),(3,'Roberto Almeida Santos','34567890123','roberto.santos@email.com','Rua Augusta, 450','Consolação','São Paulo'),(4,'Fernanda Lima Costa','45678901234','fernanda.costa@email.com','Rua Domingos de Morais, 800','Vila Mariana','São Paulo'),(5,'Lucas Pereira Gomes','56789012345','lucas.gomes@email.com','Av. Ibirapuera, 2100','Moema','São Paulo'),(6,'Patrícia Rocha Mendes','67890123456','patricia.mendes@email.com','Rua Voluntários da Pátria, 300','Santana','São Paulo');
/*!40000 ALTER TABLE `tutor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tutor_telefone`
--

DROP TABLE IF EXISTS `tutor_telefone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tutor_telefone` (
  `id_telefone` int NOT NULL AUTO_INCREMENT,
  `id_tutor` int NOT NULL,
  `numero_telefone` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_telefone`),
  KEY `fk_tel_tutor` (`id_tutor`),
  CONSTRAINT `fk_tel_tutor` FOREIGN KEY (`id_tutor`) REFERENCES `tutor` (`id_tutor`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tutor_telefone`
--

LOCK TABLES `tutor_telefone` WRITE;
/*!40000 ALTER TABLE `tutor_telefone` DISABLE KEYS */;
INSERT INTO `tutor_telefone` VALUES (1,1,'11988881111','WhatsApp'),(2,1,'1132221111','Fixo'),(3,2,'11977772222','WhatsApp'),(4,3,'11966663333','Celular'),(5,4,'11955554444','WhatsApp'),(6,5,'11944445555','WhatsApp'),(7,6,'11933336666','Celular');
/*!40000 ALTER TABLE `tutor_telefone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vet_especialidade`
--

DROP TABLE IF EXISTS `vet_especialidade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vet_especialidade` (
  `id_veterinario` int NOT NULL,
  `especialidade` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_veterinario`,`especialidade`),
  CONSTRAINT `fk_esp_vet` FOREIGN KEY (`id_veterinario`) REFERENCES `veterinario` (`id_veterinario`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vet_especialidade`
--

LOCK TABLES `vet_especialidade` WRITE;
/*!40000 ALTER TABLE `vet_especialidade` DISABLE KEYS */;
INSERT INTO `vet_especialidade` VALUES (1,'Cirurgia Geral'),(1,'Clínica Geral'),(2,'Dermatologia'),(3,'Medicina de Felinos'),(4,'Animais Silvestres e Exóticos'),(5,'Ortopedia');
/*!40000 ALTER TABLE `vet_especialidade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vet_turno`
--

DROP TABLE IF EXISTS `vet_turno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vet_turno` (
  `id_veterinario` int NOT NULL,
  `dia_turno` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_veterinario`,`dia_turno`),
  CONSTRAINT `fk_turno_vet` FOREIGN KEY (`id_veterinario`) REFERENCES `veterinario` (`id_veterinario`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vet_turno`
--

LOCK TABLES `vet_turno` WRITE;
/*!40000 ALTER TABLE `vet_turno` DISABLE KEYS */;
INSERT INTO `vet_turno` VALUES (1,'Quarta - Manhã'),(1,'Segunda - Manhã'),(2,'Terça - Tarde'),(3,'Quinta - Manhã'),(4,'Sexta - Tarde'),(5,'Sábado - Plantão 12h');
/*!40000 ALTER TABLE `vet_turno` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `veterinario`
--

DROP TABLE IF EXISTS `veterinario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `veterinario` (
  `id_veterinario` int NOT NULL AUTO_INCREMENT,
  `nome_vet` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `crmv` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data_contratacao` date NOT NULL,
  PRIMARY KEY (`id_veterinario`),
  UNIQUE KEY `crmv` (`crmv`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `veterinario`
--

LOCK TABLES `veterinario` WRITE;
/*!40000 ALTER TABLE `veterinario` DISABLE KEYS */;
INSERT INTO `veterinario` VALUES (1,'Dr. Henrique Vasconcelos','CRMV-SP 10234','2019-03-10'),(2,'Dra. Camila Figueiredo','CRMV-SP 20456','2020-07-15'),(3,'Dr. Rafael Monteiro','CRMV-SP 30789','2021-01-20'),(4,'Dra. Juliana Bernardes','CRMV-SP 40112','2022-05-05'),(5,'Dr. André Albuquerque','CRMV-SP 50998','2023-09-01');
/*!40000 ALTER TABLE `veterinario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-04  8:43:28
