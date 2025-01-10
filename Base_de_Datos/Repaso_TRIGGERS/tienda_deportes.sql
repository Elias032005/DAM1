Dadas las siguientes tablas:

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

  fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  FOREIGN KEY (producto_id) REFERENCES productos(id)

);



CREATE TABLE auditoria_productos (

  id INT AUTO_INCREMENT PRIMARY KEY,

  producto_id INT NOT NULL,

  accion VARCHAR(50) NOT NULL,

  fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);





Crea los siguientes triggers para las funciones:

Trigger 1: Actualización Automática de Stock
Trigger 2: Auditoría de Cambios en Productos
Trigger 3: Validación de Stock Negativo
