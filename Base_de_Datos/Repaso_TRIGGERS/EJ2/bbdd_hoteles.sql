CREATE DATABASE hoteles;
USE hoteles;

CREATE TABLE clientes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  telefono VARCHAR(15),
  email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE habitaciones (
  id INT AUTO_INCREMENT PRIMARY KEY,
  numero_habitacion INT UNIQUE NOT NULL,
  tipo ENUM('SIMPLE', 'DOBLE', 'SUITE') NOT NULL,
  precio DECIMAL(10, 2) NOT NULL,
  estado ENUM('DISPONIBLE', 'RESERVADA', 'MANTENIMIENTO') DEFAULT 'DISPONIBLE' NOT NULL
);

CREATE TABLE reservas (
  id INT AUTO_INCREMENT PRIMARY KEY,
  cliente_id INT NOT NULL,
  habitacion_id INT NOT NULL,
  fecha_inicio DATE NOT NULL,
  fecha_fin DATE NOT NULL,
  FOREIGN KEY (cliente_id) REFERENCES clientes(id),
  FOREIGN KEY (habitacion_id) REFERENCES habitaciones(id)
);


INSERT INTO clientes (nombre, telefono, email) VALUES
('Juan Pérez', '1234567890', 'juan.perez@example.com'),
('Julia López', '0987654321', 'maria.lopez@example.com'),
('Carlos Martínez', '1122334455', 'carlos.martinez@example.com'),
('Ana García', '2233445566', 'ana.garcia@example.com'),
('Luis Fernández', '3344556677', 'luis.fernandez@example.com'),
('Sofía Sánchez', '4455667788', 'sofia.sanchez@example.com'),
('Pedro Rodríguez', '5566778899', 'pedro.rodriguez@example.com'),
('Elena Díaz', '6677889900', 'elena.diaz@example.com'),
('Antonio García', '7788990011', 'antonio.garcia@example.com'),
('Isabel Martínez', '8899001122', 'isabel.martinez@example.com');

INSERT INTO habitaciones (numero_habitacion, tipo, precio, estado) VALUES
(101, 'SIMPLE', 50.00, 'DISPONIBLE'),
(102, 'DOBLE', 80.00, 'RESERVADA'),
(103, 'SUITE', 150.00, 'MANTENIMIENTO'),
(104, 'SIMPLE', 55.00, 'DISPONIBLE'),
(105, 'DOBLE', 90.00, 'DISPONIBLE'),
(106, 'SUITE', 200.00, 'RESERVADA'),
(107, 'SIMPLE', 60.00, 'DISPONIBLE'),
(108, 'DOBLE', 85.00, 'MANTENIMIENTO'),
(109, 'SUITE', 180.00, 'DISPONIBLE'),
(110, 'SIMPLE', 45.00, 'RESERVADA');

INSERT INTO reservas (cliente_id, habitacion_id, fecha_inicio, fecha_fin) VALUES
(1, 101, '2025-02-01', '2025-02-05'),
(2, 102, '2025-02-10', '2025-02-15'),
(3, 103, '2025-03-01', '2025-03-03'),
(4, 104, '2025-03-05', '2025-03-10'),
(5, 105, '2025-03-12', '2025-03-16'),
(6, 106, '2025-04-01', '2025-04-05'),
(7, 107, '2025-04-10', '2025-04-12'),
(8, 108, '2025-04-15', '2025-04-18'),
(9, 109, '2025-05-01', '2025-05-07'),
(10, 110, '2025-05-10', '2025-05-15');


select * from reservas;

