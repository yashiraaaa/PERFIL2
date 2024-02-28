-- MariaDB dump 10.19  Distrib 10.4.28-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: db_perfil_2
-- ------------------------------------------------------
-- Server version	10.4.28-MariaDB

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
-- Table structure for table `tb_clientes`
--

DROP TABLE IF EXISTS `tb_clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_clientes` (
  `cliente_id` varchar(36) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `telefono` varchar(10) NOT NULL,
  `direccion` varchar(255) NOT NULL,
  PRIMARY KEY (`cliente_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_clientes`
--

LOCK TABLES `tb_clientes` WRITE;
/*!40000 ALTER TABLE `tb_clientes` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_detalles_pedidos`
--

DROP TABLE IF EXISTS `tb_detalles_pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_detalles_pedidos` (
  `detalle_id` varchar(36) NOT NULL,
  `pedido_id` varchar(36) NOT NULL,
  `producto_id` varchar(36) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  PRIMARY KEY (`detalle_id`),
  KEY `pedido_id` (`pedido_id`),
  KEY `producto_id` (`producto_id`),
  CONSTRAINT `tb_detalles_pedidos_ibfk_1` FOREIGN KEY (`pedido_id`) REFERENCES `tb_pedidos` (`pedido_id`),
  CONSTRAINT `tb_detalles_pedidos_ibfk_2` FOREIGN KEY (`producto_id`) REFERENCES `tb_productos` (`producto_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_detalles_pedidos`
--

LOCK TABLES `tb_detalles_pedidos` WRITE;
/*!40000 ALTER TABLE `tb_detalles_pedidos` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_detalles_pedidos` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tg_descuento_existencias
AFTER INSERT ON tb_detalles_pedidos
FOR EACH ROW
UPDATE tb_productos
SET existencia = existencia - NEW.cantidad
WHERE producto_id = NEW.producto_id */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tb_empleados`
--

DROP TABLE IF EXISTS `tb_empleados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_empleados` (
  `empleado_id` varchar(36) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `cargo` varchar(50) NOT NULL,
  `fecha_contratacion` date NOT NULL,
  `salario` decimal(10,2) NOT NULL,
  PRIMARY KEY (`empleado_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_empleados`
--

LOCK TABLES `tb_empleados` WRITE;
/*!40000 ALTER TABLE `tb_empleados` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_empleados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_pedidos`
--

DROP TABLE IF EXISTS `tb_pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_pedidos` (
  `pedido_id` varchar(36) NOT NULL,
  `cliente_id` varchar(36) NOT NULL,
  `fecha_pedido` date NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `estado` varchar(20) NOT NULL,
  `empleado_id` varchar(36) NOT NULL,
  PRIMARY KEY (`pedido_id`),
  KEY `fk_cliente_pedido` (`cliente_id`),
  KEY `fk_empleado_pedido` (`empleado_id`),
  CONSTRAINT `fk_cliente_pedido` FOREIGN KEY (`cliente_id`) REFERENCES `tb_clientes` (`cliente_id`),
  CONSTRAINT `fk_empleado_pedido` FOREIGN KEY (`empleado_id`) REFERENCES `tb_empleados` (`empleado_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_pedidos`
--

LOCK TABLES `tb_pedidos` WRITE;
/*!40000 ALTER TABLE `tb_pedidos` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_productos`
--

DROP TABLE IF EXISTS `tb_productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_productos` (
  `producto_id` varchar(36) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `existencia` int(11) NOT NULL,
  PRIMARY KEY (`producto_id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_productos`
--

LOCK TABLES `tb_productos` WRITE;
/*!40000 ALTER TABLE `tb_productos` DISABLE KEYS */;
INSERT INTO `tb_productos` VALUES ('7fb4f5d5-d663-11ee-b2bb-a4bb6ddd8379','Laptop Dell XPS 13','Potente laptop para productividad',1299.99,50),('7fb5abdc-d663-11ee-b2bb-a4bb6ddd8379','Smartphone Samsung Galaxy S21','Teléfono Android de gama alta',899.99,100),('7fb660dd-d663-11ee-b2bb-a4bb6ddd8379','Mochila para Portátil SwissGear','Compartimentos organizados y durabilidad',89.99,30),('7fb6ff85-d663-11ee-b2bb-a4bb6ddd8379','Smartwatch Apple Watch Series 7','Seguimiento avanzado de salud y fitness',399.99,20),('7fb787aa-d663-11ee-b2bb-a4bb6ddd8379','Impresora 3D Creality Ender 3','Creación de prototipos y proyectos',249.99,15),('7fb7fa87-d663-11ee-b2bb-a4bb6ddd8379','Aspiradora Robot Roomba i7+','Navegación inteligente y autolimpieza',599.99,10),('7fb87c18-d663-11ee-b2bb-a4bb6ddd8379','Bicicleta de Montaña Trek Fuel EX','Suspensión completa y rendimiento off-road',1899.99,5),('7fb8c990-d663-11ee-b2bb-a4bb6ddd8379','Altavoces Bluetooth JBL','Sonido potente y portátil',79.99,80),('7fb9246d-d663-11ee-b2bb-a4bb6ddd8379','Monitor Curvo Samsung 27\"','Experiencia visual inmersiva',299.99,40),('7fb97545-d663-11ee-b2bb-a4bb6ddd8379','Cámara Mirrorless Sony A7III','Captura profesional de imágenes',1999.99,15),('7fb9c3c3-d663-11ee-b2bb-a4bb6ddd8379','Teclado Mecánico Corsair K95 RGB','Rendimiento y retroiluminación personalizable',169.99,60),('7fba1850-d663-11ee-b2bb-a4bb6ddd8379','Licuadora Vitamix Professional Series 750','Potencia para preparar batidos y más',599.99,25),('7fba66a7-d663-11ee-b2bb-a4bb6ddd8379','Monitor Curvo Samsung 27','Experiencia visual inmersiva',299.99,40),('7fbab509-d663-11ee-b2bb-a4bb6ddd8379','Cámara Mirrorless A7III','Captura profesional de imágenes',1999.99,15),('7fbb0492-d663-11ee-b2bb-a4bb6ddd8379','Teclado Mecánico Corsair','Rendimiento y retroiluminación personalizable',169.99,60),('7fbb5828-d663-11ee-b2bb-a4bb6ddd8379','Licuadora Series 750','Potencia para preparar batidos y más',599.99,25),('7fbbb762-d663-11ee-b2bb-a4bb6ddd8379','Refrigerador Samsung 25 pies cúbicos','Amplio espacio y eficiencia energética',1299.99,15),('7fbc42f9-d663-11ee-b2bb-a4bb6ddd8379','Tablet Apple iPad Pro 12.9\"','Potencia y pantalla impresionante',1099.99,25),('7fbc9cbd-d663-11ee-b2bb-a4bb6ddd8379','Cámara DSLR Canon EOS 80D','Captura imágenes de alta calidad',1199.99,20);
/*!40000 ALTER TABLE `tb_productos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-02-28 12:04:27
