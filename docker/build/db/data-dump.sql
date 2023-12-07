-- MariaDB dump 10.19  Distrib 10.6.12-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: soundplugs
-- ------------------------------------------------------
-- Server version	10.6.12-MariaDB-0ubuntu0.22.04.1

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
-- Table structure for table `doctrine_migration_versions`
--

DROP DATABASE IF EXISTS soundplugs;

CREATE DATABASE soundplugs;

USE soundplugs;

DROP TABLE IF EXISTS `doctrine_migration_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctrine_migration_versions`
--

LOCK TABLES `doctrine_migration_versions` WRITE;
/*!40000 ALTER TABLE `doctrine_migration_versions` DISABLE KEYS */;
INSERT INTO `doctrine_migration_versions` VALUES ('DoctrineMigrations\\Version20230905165031','2023-11-23 11:21:19',60),('DoctrineMigrations\\Version20230909184048','2023-11-23 11:21:19',112),('DoctrineMigrations\\Version20230910003305','2023-11-23 11:21:19',64),('DoctrineMigrations\\Version20230910135721','2023-11-23 11:21:19',12);
/*!40000 ALTER TABLE `doctrine_migration_versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messenger_messages`
--

DROP TABLE IF EXISTS `messenger_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messenger_messages` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `body` longtext NOT NULL,
  `headers` longtext NOT NULL,
  `queue_name` varchar(190) NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `available_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `delivered_at` datetime DEFAULT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`),
  KEY `IDX_75EA56E0FB7336F0` (`queue_name`),
  KEY `IDX_75EA56E0E3BD61CE` (`available_at`),
  KEY `IDX_75EA56E016BA31DB` (`delivered_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messenger_messages`
--

LOCK TABLES `messenger_messages` WRITE;
/*!40000 ALTER TABLE `messenger_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `messenger_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `price` double NOT NULL,
  `reference` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`),
  KEY `IDX_F52993989395C3F3` (`customer_id`),
  CONSTRAINT `FK_F52993989395C3F3` FOREIGN KEY (`customer_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (3,13,232,'admin20231207115230','2023-12-07 11:52:30'),(4,13,685,'admin20231207115412','2023-12-07 11:54:12');
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_product`
--

DROP TABLE IF EXISTS `order_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_product` (
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  PRIMARY KEY (`order_id`,`product_id`),
  KEY `IDX_2530ADE68D9F6D38` (`order_id`),
  KEY `IDX_2530ADE64584665A` (`product_id`),
  CONSTRAINT `FK_2530ADE64584665A` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_2530ADE68D9F6D38` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_product`
--

LOCK TABLES `order_product` WRITE;
/*!40000 ALTER TABLE `order_product` DISABLE KEYS */;
INSERT INTO `order_product` VALUES (3,1),(4,2);
/*!40000 ALTER TABLE `order_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(150) NOT NULL,
  `summary` varchar(255) DEFAULT NULL,
  `description` varchar(2000) NOT NULL,
  `publisher` varchar(50) NOT NULL,
  `price` double NOT NULL,
  `category` varchar(50) DEFAULT NULL,
  `genre` varchar(50) DEFAULT NULL,
  `image` varchar(1000) NOT NULL,
  `type` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `updated_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `file_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'sit','Ratione sit illum ipsum ratione. Nobis voluptatem deleniti culpa quis. Ducimus neque quasi qui et suscipit non. Accusantium et corporis quis voluptatem.','Nihil nemo rem earum animi molestias. Ut id et maxime voluptatibus voluptatibus architecto et. Quia cum quasi eos autem qui ab dolores. Aut sit corrupti ex qui.','Robert Roger',232,'effet','hip-hop','https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg','plugin','2023-11-23 11:21:30','2023-11-23 11:21:30',NULL),(2,'molestias','Odio corporis reiciendis tempore ut voluptatem perferendis accusamus. Quasi sint a accusamus est amet voluptatum.','Numquam quaerat recusandae a mollitia ullam et dicta aliquid. Omnis nemo est est. Quia ab eveniet dolor molestias iure et.','William Le Legrand',685,'traitement','hip-hop','https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg','plugin','2023-11-23 11:21:30','2023-11-23 11:21:30',NULL),(3,'veniam','Fugiat excepturi modi magnam repellendus harum distinctio. Et illo necessitatibus ullam quis vel in minus. Unde qui a aut molestias.','Voluptatem quod officiis debitis sed. Provident ratione quod architecto optio optio. Molestiae nemo vel recusandae ullam autem nihil quidem dolores.','Noémi Allard',609,'effet','hip-hop','https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg','sample','2023-11-23 11:21:30','2023-11-23 11:21:30',NULL),(4,'facilis','Et aliquid voluptatum exercitationem minus et. Autem odio et nihil. Ipsum dolore temporibus earum dolorem maiores accusantium labore. Cum dolorem pariatur et ducimus.','Illum quos ad quos porro. Nesciunt eius id molestiae ratione repudiandae est ratione.','René Valette',785,'effet','electro','https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg','sample','2023-11-23 11:21:30','2023-11-23 11:21:30',NULL),(5,'molestias','Ex esse ex nulla sed ipsam. Ad tempora nobis aut optio magnam numquam quo.','Facere eveniet officiis aliquid mollitia molestiae. Minima voluptates et dolores id. Blanditiis voluptate velit non expedita quibusdam ab.','Suzanne-Valentine Aubert',644,'traitement','electro','https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg','sample','2023-11-23 11:21:30','2023-11-23 11:21:30',NULL),(6,'earum','Esse eligendi omnis distinctio sint consequatur. Eum rerum sunt laboriosam consequatur quam ab eveniet. Et blanditiis qui ullam corrupti. Officia voluptas perspiciatis reprehenderit.','Non eum ab facere neque. Necessitatibus est eveniet impedit magni sed. Est est dolore perferendis perferendis.','Édouard Allain',397,'effet','electro','https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg','sample','2023-11-23 11:21:30','2023-11-23 11:21:30',NULL),(7,'est','Inventore doloremque enim consequuntur a aliquam consectetur. Similique ratione odio sint hic. Quos rerum et dignissimos et aperiam est.','Rem perspiciatis quia ab ut. Velit dolorum magni nihil beatae in dolores. Aut quis repudiandae doloremque repudiandae similique dolores non.','Christophe Pichon',959,'traitement','electro','https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg','plugin','2023-11-23 11:21:30','2023-11-23 11:21:30',NULL),(8,'tempore','Autem itaque sequi aut amet vitae et aut. Qui et sed quam quo ut aut. Accusamus consequuntur quam cupiditate illo dolor ab aut. Voluptatem officia et molestiae non et veritatis.','Ipsum velit et odio. Dolor ipsum velit et voluptatibus est voluptates. Laborum qui et facilis rerum. Provident debitis ut architecto quos.','Marcel-Bernard Lemaire',486,'traitement','hip-hop','https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg','plugin','2023-11-23 11:21:30','2023-11-23 11:21:30',NULL),(9,'eum','Eveniet autem velit consequuntur. Nesciunt facilis voluptatem atque repellat voluptatibus delectus. Impedit commodi enim quis ut. Mollitia quae sint consequatur in.','Impedit cupiditate ut aut atque. Asperiores dolores architecto beatae.','Patricia Bodin',876,'traitement','hip-hop','https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg','sample','2023-11-23 11:21:30','2023-11-23 11:21:30',NULL),(10,'qui','Aut temporibus quia ipsa ut quos omnis. Omnis ullam hic dolores illum officia enim. Voluptates voluptatibus et tempora sunt. Eum molestiae sed vero quis et ut est.','Maiores nobis impedit non aspernatur velit et sed. Eaque voluptatum ratione sit perspiciatis quas eum. Voluptatem non nobis facilis tenetur earum sapiente.','Martine Jean',912,'traitement','hip-hop','https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg','sample','2023-11-23 11:21:30','2023-11-23 11:21:30',NULL),(11,'tempora','Commodi adipisci nostrum qui ut. Error voluptatem hic sed dicta et.','Pariatur minima at tempora quia accusantium. Optio quibusdam voluptate delectus est quo.','Sébastien de Joseph',708,'effet','hip-hop','https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg','plugin','2023-11-23 11:21:30','2023-11-23 11:21:30',NULL),(12,'commodi','Dolores omnis repellat officiis quidem est quo. Rerum nisi quaerat qui voluptatem. Nulla atque earum magni pariatur aliquam. Sit et illo et autem non.','Velit laborum numquam accusamus et. Tenetur qui minus rerum doloribus aut. Laborum qui in veritatis. Asperiores veniam dolor est itaque qui vero. Modi aspernatur est reprehenderit ut in.','Denis-Alphonse Allain',742,'effet','hip-hop','https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg','plugin','2023-11-23 11:21:30','2023-11-23 11:21:30',NULL),(13,'tenetur','Numquam quos autem quasi eveniet quia debitis quia. Exercitationem velit suscipit nam consectetur illo. Ut ut voluptate quaerat consequatur natus accusantium.','Sit eum tempora assumenda ab nobis. Ut velit non sed sunt. Quia qui facilis fuga veniam dolorem quibusdam accusamus.','Alexandria de la Robin',309,'traitement','electro','https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg','sample','2023-11-23 11:21:30','2023-11-23 11:21:30',NULL),(14,'quasi','Et maxime omnis iusto fugiat dolores. In iste quia voluptate quia vel id. Cumque recusandae nisi distinctio veniam reiciendis pariatur. Perspiciatis dolorem rerum incidunt.','Libero dolorum consectetur autem. Eum nam dolorem placeat. At et ut libero eius veritatis nam. Aliquid harum quia voluptatum aliquid nemo.','Caroline Da Costa',980,'effet','hip-hop','https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg','sample','2023-11-23 11:21:30','2023-11-23 11:21:30',NULL),(15,'exercitationem','Excepturi et magnam nihil commodi eum omnis similique. Odit maiores distinctio vel. Quod ipsum odio omnis dolor nesciunt ullam quae voluptas.','Distinctio libero repudiandae inventore repellat. Magnam est eum alias corporis dignissimos non voluptatibus. Consectetur accusantium labore laborum.','Thibaut Leclercq',304,'effet','electro','https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg','sample','2023-11-23 11:21:30','2023-11-23 11:21:30',NULL),(16,'deleniti','Suscipit consequatur perspiciatis architecto amet. Deserunt officiis quibusdam et odit id ut. Aut blanditiis dolores cum quidem.','Dignissimos ut tempora repellat nemo corporis quae. Itaque aut et aliquid. Cupiditate enim facilis ea ut velit architecto. Maxime voluptatem corrupti autem rerum quos nisi qui.','Odette de Fernandez',624,'traitement','hip-hop','https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg','plugin','2023-11-23 11:21:30','2023-11-23 11:21:30',NULL),(17,'non','Ullam non molestias eaque molestiae fugit unde similique beatae. Quae occaecati quia tempore odio. Voluptatem eum quod quas et consectetur blanditiis dignissimos.','Incidunt porro et fugiat voluptas occaecati qui molestiae aut. Sit ullam quia rem nam. Optio exercitationem enim non optio minima neque.','Timothée Seguin-Evrard',835,'traitement','hip-hop','https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg','plugin','2023-11-23 11:21:30','2023-11-23 11:21:30',NULL),(18,'rerum','Omnis vel id dolores et praesentium rem. Rerum velit eos et voluptatem et aut. Nulla et assumenda expedita sunt et. Et molestias dolores rerum accusantium sunt autem perspiciatis.','Nesciunt sint omnis qui sed eius fugit quis. Unde id et omnis et neque aut. Ut ratione neque et nostrum in ratione. Aspernatur eveniet sed dolorem doloribus.','Paulette Thomas',153,'effet','electro','https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg','plugin','2023-11-23 11:21:30','2023-11-23 11:21:30',NULL),(19,'explicabo','Perferendis iusto magnam minima dolores inventore est. Similique qui enim est magnam incidunt enim sapiente. Laudantium maiores ut deleniti culpa placeat perferendis eveniet.','Dolor consectetur ipsam est sit velit est ut sit. Odit porro ea modi quod sunt quia est. Repellat recusandae voluptatum iste deleniti ratione dignissimos. Sit voluptatum beatae est consequatur.','Stéphane Morvan-Munoz',109,'effet','electro','https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg','sample','2023-11-23 11:21:30','2023-11-23 11:21:30',NULL),(20,'velit','Laborum animi sequi tenetur. Quis nisi odit veniam consectetur. Quidem nulla tenetur nulla voluptates dolorem est. Ut est suscipit repellat culpa eos officiis.','Maxime voluptas nisi omnis et ratione. Voluptatum sunt voluptatem sed aut voluptates autem excepturi. Inventore aut voluptatem omnis sit esse sunt architecto. Assumenda sed aut rerum aut qui.','Dorothée Delorme',326,'effet','hip-hop','https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg','sample','2023-11-23 11:21:30','2023-11-23 11:21:30',NULL),(21,'qui','Dolor aperiam voluptatum magni voluptatibus. Fuga aut est rerum rerum debitis repudiandae repudiandae facilis. Alias sunt et reiciendis nemo delectus. Numquam sed accusamus temporibus quas qui.','Magni aut sequi est ea. Fugit dolorum inventore explicabo quo id. Culpa non ad qui aut voluptas eum sunt. Praesentium quaerat ut quia. Cum vel qui quo qui.','Raymond Faure',946,'traitement','electro','https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg','plugin','2023-11-23 11:21:30','2023-11-23 11:21:30',NULL),(22,'qui','Commodi quae eum ullam totam. Dolorem animi debitis porro at rem.','Dolor quis tempore saepe ullam et molestiae. Odit sunt voluptatibus harum excepturi dolorem est. Consequatur quam sed ut unde asperiores et delectus. Quae praesentium ipsa quisquam ad.','Valentine Pichon',497,'effet','electro','https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg','plugin','2023-11-23 11:21:30','2023-11-23 11:21:30',NULL),(23,'non','Qui qui eligendi suscipit dolorum voluptas. Maxime in et possimus quibusdam accusantium cum. Eum beatae quia voluptatem quae eligendi. Atque velit voluptas nobis nam fuga eos ea.','Quia a voluptas libero soluta sint consequatur. Culpa non ut adipisci impedit tempore ullam. Magni ea ut natus nostrum omnis. Perspiciatis odio perferendis laborum eos dignissimos sit sed.','Lucy Jourdan',53,'effet','electro','https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg','plugin','2023-11-23 11:21:30','2023-11-23 11:21:30',NULL),(24,'facilis','Consequatur excepturi fugit placeat. Fugit deleniti dolores placeat blanditiis. Quod perspiciatis ut maiores eligendi veniam eum alias. Aspernatur enim voluptatem aliquid et odit.','Porro tempora et qui voluptatem. Nam cumque voluptas libero corrupti.','Jules de Nicolas',566,'traitement','hip-hop','https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg','sample','2023-11-23 11:21:30','2023-11-23 11:21:30',NULL),(25,'fugiat','Nostrum dolores esse aspernatur beatae commodi. Totam iure deserunt sapiente fugit ipsum. Voluptatem atque ut et consequatur sequi. Sed et ut iste.','Qui in et fugiat asperiores quidem aspernatur. Nesciunt sit in fuga et quos eos non possimus. Vel quia natus rerum omnis beatae excepturi. Architecto quas et enim.','Michel Lejeune',917,'traitement','hip-hop','https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg','sample','2023-11-23 11:21:30','2023-11-23 11:21:30',NULL),(26,'ducimus','Et magni minus consectetur ratione autem. Optio dolorem non dolorem ut neque. Harum eaque est impedit cumque ea sunt quasi ea.','Est dolorem voluptatibus rerum nemo. Eum quos rerum maiores. Fugit tempora et rem error id.','Élisabeth Cordier',271,'effet','hip-hop','https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg','sample','2023-11-23 11:21:30','2023-11-23 11:21:30',NULL),(27,'voluptatem','Laudantium illum saepe architecto fuga quo fuga. Pariatur quos eos vel dolor. Magnam consequuntur mollitia saepe provident tenetur adipisci. Ratione et et necessitatibus.','Temporibus itaque error nostrum sit consectetur eaque. Natus facere totam fugiat at molestias quod sequi. Eius quidem iste molestiae magnam facere excepturi.','Sophie Charpentier',85,'effet','electro','https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg','plugin','2023-11-23 11:21:30','2023-11-23 11:21:30',NULL),(28,'placeat','Omnis laboriosam odit quod harum aut. Nobis pariatur voluptate tempore rem et minima dolores. Velit tempore quidem voluptatem non quam numquam. Minus quod soluta autem nostrum vel autem.','Dolores tempora nam ea enim. Illum voluptas ut sunt reiciendis sunt sint neque. Et ipsam eum quibusdam.','Emmanuelle Dias',418,'effet','electro','https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg','plugin','2023-11-23 11:21:30','2023-11-23 11:21:30',NULL),(29,'exercitationem','Distinctio nihil doloribus ab ut et modi. Earum nostrum nisi repellendus recusandae consequatur ratione recusandae labore. Tenetur aut magnam iure architecto officia officia.','Omnis in architecto neque enim aut velit. Nobis qui sed velit iste fugit iure. Beatae cupiditate et qui perferendis.','Véronique Normand',34,'effet','electro','https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg','sample','2023-11-23 11:21:30','2023-11-23 11:21:30',NULL),(30,'eius','Sequi dicta voluptas adipisci illum suscipit corporis mollitia. Quas delectus ullam iusto soluta aspernatur et. Harum fugiat quia vitae repellendus rerum. Atque suscipit temporibus nihil nulla quas.','Et blanditiis voluptate dolore nihil excepturi velit et. Commodi ducimus laudantium in neque. Et aperiam voluptatibus debitis quia fugiat ut non.','Henri Mahe',6,'effet','electro','https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg','plugin','2023-11-23 11:21:30','2023-11-23 11:21:30',NULL),(31,'facere','Sed nisi voluptatem ut enim. Facere ipsam dolores et est. Reprehenderit molestiae consequuntur possimus dolores.','Officia omnis nihil eos aspernatur exercitationem. Voluptatem repudiandae vero eos. Iusto cumque vel sit. Et dicta vel nisi officiis sunt culpa aut ex.','Patricia-Anne Hebert',221,'effet','electro','https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg','sample','2023-11-23 11:21:30','2023-11-23 11:21:30',NULL),(32,'quia','Fugit ut ea aut. Iure aut impedit magnam quae. Explicabo harum temporibus delectus error.','Praesentium veniam quam repellat. Quis rerum facilis aperiam veniam. Repellendus dolorem et quod sit. Impedit eaque tempore aut nostrum consequatur.','Renée de la Mendes',806,'traitement','electro','https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg','sample','2023-11-23 11:21:30','2023-11-23 11:21:30',NULL),(33,'dolor','Minus perspiciatis magnam voluptatem accusantium aperiam. Sit beatae sint quo in maiores ratione. Numquam quis consectetur assumenda esse recusandae iste voluptatem.','Mollitia quia accusantium officia tempore. Ea et impedit doloribus suscipit nostrum quos qui repellendus. Sapiente rem totam natus quod. Magnam quo aliquid dolorum nisi ut eveniet quo molestiae.','Jacqueline Chauvin',299,'effet','electro','https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg','plugin','2023-11-23 11:21:30','2023-11-23 11:21:30',NULL),(34,'quam','Temporibus consequatur eum sed non placeat architecto culpa. Assumenda enim repudiandae eos quae. Delectus velit magnam aut provident ut. Alias nisi doloremque ad at est corporis blanditiis.','Veniam rerum quia commodi numquam harum eius. Odio corrupti perferendis quae natus. Qui non id assumenda aut facere aut veniam magnam. Quis rerum totam dicta dolorem provident.','Honoré Boulanger',277,'traitement','hip-hop','https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg','plugin','2023-11-23 11:21:30','2023-11-23 11:21:30',NULL),(35,'repudiandae','Officiis facere saepe cum eos et. Quis omnis ipsum neque dolor eaque a. Explicabo id cum consequatur et quo.','Ea fugit non ipsam ad. Sequi assumenda omnis totam dignissimos nostrum ut. Nostrum dolorem quis perspiciatis beatae minus expedita nobis.','Colette Torres',572,'effet','hip-hop','https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg','plugin','2023-11-23 11:21:30','2023-11-23 11:21:30',NULL),(36,'itaque','Ut esse incidunt ratione eveniet. Corrupti id ipsam enim et. Similique mollitia laborum non minima.','Voluptatem voluptatibus nulla perspiciatis occaecati eos commodi. Quo autem et possimus provident. Qui pariatur dignissimos omnis tenetur adipisci blanditiis.','Marc-Édouard Perrin',408,'traitement','hip-hop','https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg','sample','2023-11-23 11:21:30','2023-11-23 11:21:30',NULL),(37,'qui','Et a dolores exercitationem sit excepturi saepe fugiat recusandae. Quo labore molestias ea laboriosam rerum repudiandae in. Sint sunt laboriosam id consequatur quae reiciendis cum sapiente.','Veniam sed sed sit dolor. Eos nam aut odit porro aut culpa aperiam sequi. Omnis dolore eius fuga quos.','Pierre Riviere',471,'effet','electro','https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg','sample','2023-11-23 11:21:30','2023-11-23 11:21:30',NULL),(38,'maiores','Ut pariatur facere laudantium. Cum vitae rerum consectetur commodi sed cum quia. A dolorem vitae cumque est.','Eum tempore occaecati eius iste et atque odio. Vitae velit et dolor reiciendis optio dolorem nostrum et. Delectus debitis veritatis autem a maxime sequi et.','Anouk Martel',703,'traitement','hip-hop','https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg','sample','2023-11-23 11:21:30','2023-11-23 11:21:30',NULL),(39,'et','Deleniti et ratione qui quod quaerat. Sit esse quis dolorem et facere sed aut. Fuga cupiditate sed id debitis enim.','Architecto ut molestias ea quisquam. Eius id esse enim. Rerum quis dolores eaque qui corporis molestias.','Patricia Legros',595,'effet','hip-hop','https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg','plugin','2023-11-23 11:21:30','2023-11-23 11:21:30',NULL),(40,'expedita','Consequatur ab enim assumenda. Molestiae delectus voluptates voluptas ut delectus saepe et. Doloribus est quaerat vero ratione ab repellat itaque.','Est accusamus voluptas cum nisi voluptatibus. Consectetur at non recusandae qui. Tempora ut sint incidunt dolorem hic ut.','Michel du Cordier',854,'effet','electro','https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg','plugin','2023-11-23 11:21:30','2023-11-23 11:21:30',NULL),(41,'dolorum','Totam et et eos numquam facilis ut. Fugiat et exercitationem totam accusantium et. Iure quos aut quia perspiciatis sapiente. Non nemo nobis omnis vero rem. Eum provident placeat ut iste.','Numquam illum possimus pariatur ea delectus quos. Iste voluptates non rerum incidunt. Tempore nemo sint consequatur quia iure.','Emmanuel Picard-Dupuis',530,'traitement','hip-hop','https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg','sample','2023-11-23 11:21:30','2023-11-23 11:21:30',NULL),(42,'quia','Commodi autem aspernatur praesentium nulla odio voluptatem voluptas. Sunt libero sapiente earum excepturi distinctio. Ut quo sed corrupti.','Provident enim modi consequuntur cupiditate. Aperiam animi iste sequi dolor labore animi. Rerum iste sunt neque ratione nesciunt. Et qui quibusdam aut voluptatibus quis maiores.','Agnès Lenoir-Leleu',334,'effet','hip-hop','https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg','sample','2023-11-23 11:21:30','2023-11-23 11:21:30',NULL),(43,'occaecati','Corporis et velit nemo ea dolores rerum voluptatum. Autem sit eum maxime dolorem id. Maiores reprehenderit laborum voluptate consequuntur ad quod. Dolorum voluptates nihil repellat laboriosam.','Et veniam sint hic voluptate sapiente. Illo impedit eveniet molestias perspiciatis. Non dolorem et qui amet quibusdam aut neque.','Eugène de la Maurice',758,'effet','electro','https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg','sample','2023-11-23 11:21:30','2023-11-23 11:21:30',NULL),(44,'blanditiis','Magni in dolor sit aliquam enim. Non cumque odio dolores porro et. Facilis suscipit vel aliquid aliquid vel.','Odio non ut est quia itaque. Odit quia quidem velit distinctio. Aut quae est reprehenderit in officia. Et excepturi quo molestiae nihil. Dolor et deleniti sequi et odio et eius.','Agathe Le Auger',628,'effet','hip-hop','https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg','plugin','2023-11-23 11:21:30','2023-11-23 11:21:30',NULL),(45,'harum','Voluptatem adipisci eius beatae sit necessitatibus nulla ipsum. Qui non aut est tempora dolores architecto. Ipsa aut ratione eligendi sint est qui non.','Officiis nam necessitatibus in debitis accusamus odio. Architecto ex consectetur aliquam sed beatae rem distinctio officia. Doloremque aut nihil enim ut facilis laboriosam.','Lucie Hoareau',550,'traitement','hip-hop','https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg','sample','2023-11-23 11:21:30','2023-11-23 11:21:30',NULL),(46,'veniam','Laboriosam architecto in quia eligendi. Quas incidunt qui veritatis autem nihil eaque sit delectus. Deserunt adipisci ut dicta fuga eligendi velit. Illum inventore et ut possimus aut consequatur ea.','In nulla sint voluptatem enim. Eius totam et est distinctio asperiores corporis est. Est consectetur molestias eum natus.','Bertrand Guilbert',337,'traitement','electro','https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg','plugin','2023-11-23 11:21:30','2023-11-23 11:21:30',NULL),(47,'voluptatem','Omnis eum temporibus harum quasi placeat. Dignissimos quidem accusamus voluptatem. Ullam recusandae suscipit eos nostrum. Commodi vero nemo corporis.','Porro consequatur quis temporibus possimus nobis a sit. Harum itaque et harum maiores molestiae possimus reiciendis. Est molestias quaerat debitis vero eveniet dolor. Ipsam voluptatem sunt non ipsum.','Madeleine Girard',548,'traitement','hip-hop','https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg','sample','2023-11-23 11:21:30','2023-11-23 11:21:30',NULL),(48,'et','Dolor ullam occaecati dignissimos dolor vero nostrum magni. Fuga at itaque accusamus nam.','Quod rerum voluptatem voluptates ad. Sunt cum fuga aut distinctio incidunt dicta fuga.','Sabine-Catherine Rousset',319,'effet','hip-hop','https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg','plugin','2023-11-23 11:21:30','2023-11-23 11:21:30',NULL),(49,'ut','Rerum inventore iure rerum fuga tempora error quam natus. Cum aut magnam sit nesciunt dolores. Voluptates omnis officiis et quasi ab enim. Quasi pariatur et libero.','Dolores enim exercitationem similique et hic saepe. Nihil eos sit ex illum modi. Molestias sapiente sit a adipisci neque neque nihil. Nemo magnam nostrum odit voluptatem nemo iure.','Vincent Laroche',834,'traitement','hip-hop','https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg','sample','2023-11-23 11:21:30','2023-11-23 11:21:30',NULL),(50,'et','Eum asperiores nihil et doloribus. Consequatur voluptatem voluptatem ipsa et libero officiis. Veritatis blanditiis quis quam aut. Ipsa non maxime dolore placeat voluptas est quas.','Distinctio at illo doloremque nulla. Deserunt ipsa ducimus placeat impedit dolorem. Porro impedit ducimus est unde. Iusto est consectetur enim harum sed.','Aimée Le Goff',438,'traitement','electro','https://www.native-instruments.com/typo3temp/pics/img-homepage-bazzazian-tapes-homepage-t2_03-79c8fbe572f0dda7b21bef0787d74037-d.jpg','sample','2023-11-23 11:21:30','2023-11-23 11:21:30',NULL);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(180) NOT NULL,
  `roles` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`roles`)),
  `password` varchar(255) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `updated_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_8D93D649E7927C74` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'olivie26@noos.fr','[\"ROLE_USER\"]','$2y$13$5f6Fd/DoNu8k.UlT7e3OQeQPMXJ6xEqgEDsQrp.J1qRgrzikUTnJm','Anastasie de Lucas','Robert-Nicolas Pasquier','2023-11-23 11:21:26','2023-11-23 11:21:26'),(2,'carpentier.audrey@laposte.net','[\"ROLE_USER\"]','$2y$13$0OyyaYQ2WnqryTmZjgzYJugIjurXzBNf4jY81tdMLn7uJ8fvWSVJi','Diane Aubry','Laurence Martinez','2023-11-23 11:21:26','2023-11-23 11:21:26'),(3,'roland.rousseau@laposte.net','[\"ROLE_USER\"]','$2y$13$1siEA.W0VQqiDLadWdU1JOWMR6ctyBbDy21V0qq33f.L/iOI/wgyW','Noémi-Jeannine Leveque','Adrien-Léon Neveu','2023-11-23 11:21:26','2023-11-23 11:21:26'),(4,'josette.leconte@free.fr','[\"ROLE_USER\"]','$2y$13$5OgLZ.urKqhjnkmgC9Lj7.8C6RBzcrN2RuaImfMN9/dlqh.sNYtbK','Julie-Diane Tessier','Léon Paul','2023-11-23 11:21:27','2023-11-23 11:21:27'),(5,'ggonzalez@orange.fr','[\"ROLE_USER\"]','$2y$13$V7R7ax7BUFky5wed3EW1p.L/wiSiXIHBeAijQyuUhFw8pv6RcrhDm','Alfred Clement','Victoire Meyer','2023-11-23 11:21:27','2023-11-23 11:21:27'),(6,'victor.guerin@bruneau.com','[\"ROLE_USER\"]','$2y$13$iTfzI0u8As2liyI9cLbSOuFxbw7Qu/8sQG3f4hJNXg08gyBXq6RK6','Jeannine Lejeune','Frédéric Guibert','2023-11-23 11:21:28','2023-11-23 11:21:28'),(7,'david60@tele2.fr','[\"ROLE_USER\"]','$2y$13$Rp9CCukadal/QoqH4QShd.4rHCS5UTvQ03omenmKlbj8WDOpq2IMW','Laure Guillaume','Jérôme Deschamps','2023-11-23 11:21:28','2023-11-23 11:21:28'),(8,'cguichard@live.com','[\"ROLE_USER\"]','$2y$13$0bbaspyibrEpHN8rZrY3wuR6qCygAVrIb1N3l06GJnujiPqD5Kb0i','Xavier Delattre-Gillet','Jeannine Carlier-Didier','2023-11-23 11:21:28','2023-11-23 11:21:28'),(9,'chantal94@fabre.fr','[\"ROLE_USER\"]','$2y$13$sJ./f/LcMbF9efmOkoQ3puGyALEqBSG.Qo/9toboKjlBLRZW0rYym','Marie Guichard','Jacques Raymond','2023-11-23 11:21:29','2023-11-23 11:21:29'),(10,'marcel72@laposte.net','[\"ROLE_USER\"]','$2y$13$yv/7XkZvT3EwbNFZotdPseyn4sgPP.D7NmRSHz0/xa8uHNh7zuI9q','Chantal Dubois','Adrienne Delahaye','2023-11-23 11:21:29','2023-11-23 11:21:29'),(13,'admin@admin.admin','{\"2\":\"ROLE_USER\",\"4\":\"ROLE_ADMIN\"}','$2y$13$wqxd8rg5OVVRJnt9ETXtNOJWWdnmNdy6dhydFT9h1KAoThcPWcYhu','admin','admin','2023-12-07 09:50:42','2023-12-07 09:48:00'),(14,'admin1@admin.admin','{\"1\":\"ROLE_ADMIN\"}','password','rosny','chum','2023-12-07 10:00:56','2023-12-07 10:00:00'),(15,'admin2@admin.admin','[]','password','azer','azer','2023-12-07 11:47:00','2023-12-07 11:46:00');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_product`
--

DROP TABLE IF EXISTS `user_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_product` (
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`product_id`),
  KEY `IDX_8B471AA7A76ED395` (`user_id`),
  KEY `IDX_8B471AA74584665A` (`product_id`),
  CONSTRAINT `FK_8B471AA74584665A` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_8B471AA7A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_product`
--

LOCK TABLES `user_product` WRITE;
/*!40000 ALTER TABLE `user_product` DISABLE KEYS */;
INSERT INTO `user_product` VALUES (13,1),(13,2);
/*!40000 ALTER TABLE `user_product` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-07 13:13:23
