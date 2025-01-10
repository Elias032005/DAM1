-- Crear la base de datos
CREATE DATABASE pruebaphp;

-- Seleccionar la base de datos
USE pruebaphp;

-- Crear la tabla usuarios
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre_usuario VARCHAR(50) NOT NULL,
    primer_apellido VARCHAR(100) NOT NULL,
    segundo_apellido VARCHAR(100) NOT NULL,
    edad INT NOT NULL,
    contrasena VARCHAR(255) NOT NULL
);

-- Insertar un usuario de ejemplo
INSERT INTO usuarios (nombre_usuario, primer_apellido, segundo_apellido, edad, contrasena)
VALUES ('juanperez', 'Juan', 'Pérez', 30, 'contrasenaSegura');
