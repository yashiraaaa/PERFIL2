DROP DATABASE IF EXISTS db_perfil_2;
CREATE DATABASE db_perfil_2;
USE db_perfil_2;
 
CREATE TABLE tb_productos(
   producto_id VARCHAR(36) PRIMARY KEY,
   nombre VARCHAR(100) UNIQUE NOT NULL,
   descripcion VARCHAR(255),
   precio DECIMAL(10,2) NOT NULL,
   existencia INT NOT NULL
);
 
CREATE TABLE tb_clientes(
   cliente_id VARCHAR(36) PRIMARY KEY,
   nombre VARCHAR(50) NOT NULL,
   apellido VARCHAR(50) NOT NULL,
   telefono VARCHAR(10) NOT NULL,
   direccion VARCHAR(255) NOT NULL
);
 
CREATE TABLE tb_empleados(
   empleado_id VARCHAR(36) PRIMARY KEY,
   nombre VARCHAR(50) NOT NULL,
   apellido VARCHAR(50) NOT NULL,
   cargo VARCHAR(50) NOT NULL,
   fecha_contratacion DATE NOT NULL,
   salario DECIMAL(10,2) NOT NULL
);
 
CREATE TABLE tb_pedidos(
   pedido_id VARCHAR(36) PRIMARY KEY,
   cliente_id VARCHAR(36) NOT NULL,
   fecha_pedido DATE NOT NULL,
   total DECIMAL(10,2) NOT NULL,
   estado VARCHAR(20) NOT NULL,
   empleado_id VARCHAR(36) NOT NULL
);
 
CREATE TABLE tb_detalles_pedidos(
   detalle_id VARCHAR(36) PRIMARY KEY,
   pedido_id VARCHAR(36) NOT NULL,
   producto_id VARCHAR(36) NOT NULL,
   cantidad INT NOT NULL,
   precio_unitario DECIMAL(10,2) NOT NULL,
   subtotal DECIMAL(10,2) NOT NULL
);
 
##SELECT UUID();
 
ALTER TABLE tb_pedidos
ADD CONSTRAINT fk_cliente_pedido 
FOREIGN KEY (cliente_id) REFERENCES tb_clientes(cliente_id),
ADD CONSTRAINT fk_empleado_pedido 
FOREIGN KEY (empleado_id) REFERENCES tb_empleados(empleado_id);
 
ALTER TABLE tb_detalles_pedidos
ADD FOREIGN KEY (pedido_id) REFERENCES tb_pedidos(pedido_id),
ADD FOREIGN KEY (producto_id) REFERENCES tb_productos(producto_id);
 
 
CREATE TRIGGER tg_descuento_existencias
AFTER INSERT ON tb_detalles_pedidos
FOR EACH ROW
UPDATE tb_productos
SET existencia = existencia - NEW.cantidad
WHERE producto_id = NEW.producto_id;
 
 
DELIMITER //
CREATE PROCEDURE tg_insertar_producto(
   IN producto_id_param VARCHAR(36),
   IN nombre_param VARCHAR(100),
   IN descripcion_param VARCHAR(255),
   IN precio_param DECIMAL(10,2),
   IN existencia_param INT
)
BEGIN
	INSERT INTO tb_productos (
		producto_id, nombre, descripcion, precio, existencia
		) 
	VALUES (
      producto_id_param, nombre_param, descripcion_param, precio_param, existencia_param
		);
END //
DELIMITER ;
 
DELIMITER //
CREATE PROCEDURE tg_insertar_cliente(
    IN cliente_id_param VARCHAR(36),
    IN nombre_param VARCHAR(50),
    IN apellido_param VARCHAR(50),
    IN telefono_param VARCHAR(10),
    IN direccion_param VARCHAR(255)
)
BEGIN
    INSERT INTO tb_clientes (
        cliente_id, nombre, apellido, telefono, direccion
    ) VALUES (
        cliente_id_param, nombre_param, apellido_param, telefono_param, direccion_param
    );
END //
DELIMITER ;
 
DELIMITER //
CREATE PROCEDURE tg_insertar_empleado(
    IN empleado_id_param VARCHAR(36),
    IN nombre_param VARCHAR(50),
    IN apellido_param VARCHAR(50),
    IN cargo_param VARCHAR(50),
    IN fecha_contratacion_param DATE,
    IN salario_param DECIMAL(10,2)
)
BEGIN
    INSERT INTO tb_empleados (
        empleado_id, nombre, apellido, cargo, fecha_contratacion, salario
    ) VALUES (
        empleado_id_param, nombre_param, apellido_param, cargo_param, fecha_contratacion_param, salario_param
    );
END //
DELIMITER ;
 
DELIMITER //
CREATE PROCEDURE tg_insertar_pedido(
    IN pedido_id_param VARCHAR(36),
    IN cliente_id_param VARCHAR(36),
    IN fecha_pedido_param DATE,
    IN total_param DECIMAL(10,2),
    IN estado_param VARCHAR(20),
    IN empleado_id_param VARCHAR(36)
)
BEGIN
    INSERT INTO tb_pedidos (
        pedido_id, cliente_id, fecha_pedido, total, estado, empleado_id
    ) VALUES (
        pedido_id_param, cliente_id_param, fecha_pedido_param, total_param, estado_param, empleado_id_param
    );
END //
DELIMITER ;
 
DELIMITER //
CREATE PROCEDURE tg_insertar_detalle_pedido(
    IN detalle_id_param VARCHAR(36),
    IN pedido_id_param VARCHAR(36),
    IN producto_id_param VARCHAR(36),
    IN cantidad_param INT,
    IN precio_unitario_param DECIMAL(10,2),
    IN subtotal_param DECIMAL(10,2)
)
BEGIN
    INSERT INTO tb_detalles_pedidos (
        detalle_id, pedido_id, producto_id, cantidad, precio_unitario, subtotal
    ) VALUES (
        detalle_id_param, pedido_id_param, producto_id_param, cantidad_param, precio_unitario_param, subtotal_param
    );
END //
DELIMITER ;
 
##PRODCUTOS
CALL tg_insertar_producto(UUID(), 'Laptop Dell XPS 13', 'Potente laptop para productividad', 1299.99, 50);
CALL tg_insertar_producto(UUID(), 'Smartphone Samsung Galaxy S21', 'Teléfono Android de gama alta', 899.99, 100);
CALL tg_insertar_producto(UUID(), 'Mochila para Portátil SwissGear', 'Compartimentos organizados y durabilidad', 89.99, 30);
CALL tg_insertar_producto(UUID(), 'Smartwatch Apple Watch Series 7', 'Seguimiento avanzado de salud y fitness', 399.99, 20);
CALL tg_insertar_producto(UUID(), 'Impresora 3D Creality Ender 3', 'Creación de prototipos y proyectos', 249.99, 15);
CALL tg_insertar_producto(UUID(), 'Aspiradora Robot Roomba i7+', 'Navegación inteligente y autolimpieza', 599.99, 10);
CALL tg_insertar_producto(UUID(), 'Bicicleta de Montaña Trek Fuel EX', 'Suspensión completa y rendimiento off-road', 1899.99, 5);
CALL tg_insertar_producto(UUID(), 'Altavoces Bluetooth JBL', 'Sonido potente y portátil', 79.99, 80);
CALL tg_insertar_producto(UUID(), 'Monitor Curvo Samsung 27"', 'Experiencia visual inmersiva', 299.99, 40);
CALL tg_insertar_producto(UUID(), 'Cámara Mirrorless Sony A7III', 'Captura profesional de imágenes', 1999.99, 15);
CALL tg_insertar_producto(UUID(), 'Teclado Mecánico Corsair K95 RGB', 'Rendimiento y retroiluminación personalizable', 169.99, 60);
CALL tg_insertar_producto(UUID(), 'Licuadora Vitamix Professional Series 750', 'Potencia para preparar batidos y más', 599.99, 25);
CALL tg_insertar_producto(UUID(), 'Monitor Curvo Samsung 27', 'Experiencia visual inmersiva', 299.99, 40);
CALL tg_insertar_producto(UUID(), 'Cámara Mirrorless A7III', 'Captura profesional de imágenes', 1999.99, 15);
CALL tg_insertar_producto(UUID(), 'Teclado Mecánico Corsair', 'Rendimiento y retroiluminación personalizable', 169.99, 60);
CALL tg_insertar_producto(UUID(), 'Licuadora Series 750', 'Potencia para preparar batidos y más', 599.99, 25);
CALL tg_insertar_producto(UUID(), 'Refrigerador Samsung 25 pies cúbicos', 'Amplio espacio y eficiencia energética', 1299.99, 15);
CALL tg_insertar_producto(UUID(), 'Tablet Apple iPad Pro 12.9"', 'Potencia y pantalla impresionante', 1099.99, 25);
CALL tg_insertar_producto(UUID(), 'Cámara DSLR Canon EOS 80D', 'Captura imágenes de alta calidad', 1199.99, 20);