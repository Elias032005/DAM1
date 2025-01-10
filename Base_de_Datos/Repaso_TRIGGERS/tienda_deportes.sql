/*
DELIMITER //
CREATE TRIGGER nombre_trigger
{BEFORE | AFTER} (INSERT | UPDATE | DELETE)
ON nombre_tabla
BEGIN
	-- cuerpo del trigger
END;
//
-- Por cada if se tiene que cerrar. 


con el comando concat ('texto personalizado',NEW.texto,'texto personalizado');  Esto sirve para cambiar el texto. 
EJ:
concat('se ha cambiado el atributo'),NEW.atributo,'nuevo nombre de atributo') 
*/

CREATE DATABASE tienda_deportes;
USE  tienda_deportes;
-- Dadas las siguientes tablas:

CREATE TABLE productos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  stock INT NOT NULL,
  precio DECIMAL(10, 2) NOT NULL
);

CREATE TABLE transacciones (
  id INT AUTO_INCREMENT PRIMARY KEY,
  producto_id INT NOT NULL,
  cantidad INT NOT NULL,
  tipo ENUM('ENTRADA', 'SALIDA') NOT NULL,
  fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Con el default current_timestamp sirve para que si el usuario no indica la fecha, el propio ordenador le dara la información de fecha y hora del registro
  FOREIGN KEY (producto_id) REFERENCES productos(id)
);

CREATE TABLE auditoria_productos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  producto_id INT NOT NULL,
  accion VARCHAR(50) NOT NULL,
  fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Hacemos los inserts

INSERT INTO productos (nombre,stock,precio) VALUES
('Pelota_futbol', 35, 12.99),
('Pelota_basquet', 35, 15.99),
('Botas_futbol', 10, 35.99),
('Petos', 15, 8.99),
('Pantalones', 20 ,14.99 );

INSERT INTO transacciones (producto_id,cantidad,tipo) VALUES 
(1, 5, 'SALIDA'),
(1, 3, 'ENTRADA'),
(2, 7, 'SALIDA'),
(2, 6, 'ENTRADA'),
(3, 8, 'SALIDA'),
(3, 3, 'ENTRADA'),
(4, 6, 'SALIDA'),
(4, 4, 'ENTRADA'),
(5, 9, 'SALIDA'),
(5, 4, 'ENTRADA');

INSERT INTO  auditoria_productos (producto_id,accion) VALUES
(1,'Productos vendido'),
(1,'Productos recibido'),
(2,'Productos vendido'),
(2,'Productos recibido'),
(3,'Productos vendido'),
(3,'Productos recibido'),
(4,'Productos vendido'),
(4,'Productos recibido'),
(5,'Productos vendido'),
(5,'Productos recibido');

-- CONSULTAS:
SELECT * FROM productos;
SELECT * FROM transacciones;
SELECT * FROM  auditoria_productos;

/* Crea los siguientes triggers para las funciones:
Trigger 1: Actualización Automática de Stock
Trigger 2: Auditoría de Cambios en Productos
Trigger 3: Validación de Stock Negativo
*/
