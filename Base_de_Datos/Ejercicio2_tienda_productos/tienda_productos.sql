-- EJERCICIO 2, VAMOS A PRACTICAR LA GESTIÓN BÁSICA DE UNA TIENDA DE PRODUCTOS
-- GESTIONAR CLIENTES, PRODUCTOS, PEDIDIOS Y DETALLES_PEDIDOS
-- clientes: Nombre, email, telefono y una dirección.
-- productos: Nombre_comercial_producto, descripcion_producto, precio_unitario_producto, stock_productos.
-- pedidos: que cliente ha sido y en que fecha se ha enviado.
-- detalles_pedido se informará de la cantidad de productos en cada pedido el precio unitario de cada uno de los productos.


-- CONSULTAS a realizar una vez creada la bd y completada con 10 clientes, 20 productos y 15 pedidos:

-- CONSULTA 1: Obtener todos los clientes y cúantos pedidos han realizado.
-- CONSULTA 2: Obtener los productos específicos de un pedido mostrando la cantidad pedida y el precio de ese producto por la cantidad pedida.
-- CONSULTA 3: Obtener el gasto total de cada uno de los clientes.
-- CONSULTA 4: Obtener el nombre, telefono y dirección del cliente que a realizado el último pedido registrado.
-- CONSULTA 5: Obtener el producto más vendido.

CREATE DATABASE tienda_productos; /*CREAMOS LA BASE DE DATOS*/
USE tienda_productos; /*USAMOS LA BASE DE DATOS*/

CREATE TABLE clientes(
	ID_clientes INT AUTO_INCREMENT NOT NULL PRIMARY KEY, /*SERA LA PK, PORQUE SERA ÚNICO Y ATÓMICO*/
    nombre_cliente VARCHAR(45) NOT NULL,
    email_cliente VARCHAR(150) NOT NULL,
    num_telefono_cliente int(9) NOT NULL, /*LIMITAMOS EL NÚMERO DE TELEFONO AL MÁXIMO PERMITIDO*/
    direccion_cliente VARCHAR(150) NOT NULL /*PONEMOS COMO MÁXIMO 150 CARÁCTERES*/
);

CREATE TABLE productos (
	ID_producto INT AUTO_INCREMENT NOT NULL PRIMARY KEY, /*SERA LA PK, PORQUE SERA ÚNICO Y ATÓMICO*/
	nombre_comercial_productos VARCHAR(45) NOT NULL,
    descripcion_productos VARCHAR(100) NOT NULL,
    precio_unitario_producto FLOAT(5,2) NOT NULL, /*LIMITAMOS EL NÚMERO DE DECIMALES*/
    stock_productos INT NOT NULL
);

CREATE TABLE pedidos (
	ID_pedido INT AUTO_INCREMENT NOT NULL PRIMARY KEY, /*SERA LA PK, PORQUE SERA ÚNICO Y ATÓMICO*/
    fecha_pedido DATE NOT NULL
);

/*MOSTRAMOS LAS TRES TABLAS SIN INFORMACIÓN AÑADIDA*/

SELECT * FROM clientes;
SELECT * FROM productos;
SELECT * FROM pedidos;

/*AGREGAMOS EL ID DEL CLIENTE A LA TABLA PEDIDOS*/
 /*PRIMERO, CREAMOS EL ATRIBUTO*/
ALTER TABLE pedidos
ADD COLUMN id_cliente INT;
/*SEGUNDO, PONEMOS ESE ATRIBUTO COMO FK*/
ALTER TABLE pedidos
ADD CONSTRAINT FK_Id_clientes FOREIGN KEY (Id_cliente) REFERENCES clientes(ID_clientes);

/*MOSTRAMOS LA TABLA PEDIDOS MODIFICADA*/
SELECT * FROM pedidos;

/*PRIMERO CREAMOS LA TABLA UNICAMENTE CON EL ID DE DETALLES DEL PORDUCTO*/
CREATE TABLE detalles_pedidos(
	ID_detalles_pedidos INT AUTO_INCREMENT NOT NULL PRIMARY KEY /*SERA LA PK, PORQUE SERA ÚNICO Y ATÓMICO*/
);

/*Alteramos la tabla detalles_pedido*/
ALTER TABLE detalles_pedidos
ADD COLUMN id_pedido INT,
ADD COLUMN id_producto INT,
ADD COLUMN cantidad INT,
ADD COLUMN precio_unitario FLOAT(5,2);

/*MOSTRAMOS LAS TABLAS*/
SELECT * FROM clientes;
SELECT * FROM productos;
SELECT * FROM pedidos;
SELECT * FROM detalles_pedidos;

/*Relacionamos con FK */
ALTER TABLE detalles_pedidos
ADD CONSTRAINT FK_id_pedido FOREIGN KEY (id_pedido) REFERENCES pedidos(ID_pedido),
ADD CONSTRAINT FK_id_producto FOREIGN KEY (id_producto) REFERENCES productos(ID_producto);


/*HACEMOS LOS REGISTROS*/
/*                            */
                                                                                                                                
                                                                                                                                
                                                                                                                                
/*AÑADIMOS LA INFORMACIÓN/REGISTROS DE LOS CLIENTES*/

INSERT INTO clientes(ID_clientes,nombre_cliente,email_cliente,num_telefono_cliente, direccion_cliente) VALUES
(1, 'Elias', 'elias@gmail.com', 759418264, 'Tarragona C/Mayor'),
(2, 'Diego', 'diego@gmail.com', 647819248, 'Hospitalet C/Menor'),
(3, 'Jorge', 'jorge@gmail.com', 974851348, 'Barcelona C/Arriba'),
(4, 'Carmen', 'carmen@gmail.com', 149758249, 'Madrid C/Barbaro'),
(5, 'Joseluis', 'joseluis@gmail.com', 847291543, 'Barcelona C/Caro'),
(6, 'Matias', 'matias@gmail.com', 947152684, 'Barcelona C/Barbo'),
(7, 'Fernando', 'fernando@gmail.com', 452978146, 'Lleida C/Pecador'),
(8, 'Alba', 'alba@gmail.com', 654159753, 'Girona C/Llegadero'),
(9, 'Carla', 'carla@gmail.com', 357159482, 'Tarragona C/Perone'),
(10, 'Ona', 'ona@gmail.com', 741852963, 'Tarragona C/Porque');

/*MOSTRAMOS LOS REGISTROS DE LA TABLA CLIENTES*/
SELECT * FROM clientes;

/*AÑADIMOS LA INFORMACIÓN/REGISTRO DE LOS PRODUCTOS*/

/*MODIFICAMOS EL TAMAÑO DE LA DESCRIPCIÓN PAR AQUE SE PUEDA AÑADIR MAS INFORMACIÓN*/
ALTER TABLE productos
MODIFY COLUMN descripcion_productos VARCHAR(1000);


INSERT INTO productos(ID_producto,nombre_comercial_productos, descripcion_productos,precio_unitario_producto,stock_productos ) VALUES
(1,'7_days_to_die','Videojuego perteneciente al género de Videojuego de terror, mundo abierto, sandbox basado en voxel y supervivencia, creado por la empresa The Fun Pimps.', 15.5, 10 ),
(2, 'Ark', 'Videojuego de acción-aventura y supervivencia desarrollado por Studio Wildcard, Instinct Games, Efecto Studio y Virtual Basement.', 35.5, 15),
(3, 'Stardew Valley', 'Videojuego de simulación de granja inspirado en juegos como Harvest Moon.​ Al principio del juego, el jugador crea su personaje, pudiendo elegir el sexo del mismo, color y tipo de cabello, entre otros. El jugador recibe la granja en ruinas que alguna vez poseyó su abuelo.', 9.99, 5),
(4, 'Dave the diver', 'Videojuego casual de rol y aventuras para un solo jugador que incluye elementos de pesca y exploración del fondo marino durante el día y de gestión de un restaurante de sushi durante la noche', 15.99, 20),
(5, 'Terraria', ' videojuego de mundo abierto en 2D. Contiene elementos de construcción, exploración, aventura y combate, muy similar a juegos clásicos de la consola Super NES, como por ejemplo la serie Metroid, y a otras entregas no tan antiguas como Minecraft. El juego comienza en un mundo creado de forma aleatoria.', 5.99, 15),
(6, 'The Binding of Isaac', 'Videojuego de rol de acción, videojuego de mazmorras, y videojuego de disparos de palancas gemelas, creado como concepto por Edmund McMillen como un proyecto secundario mientras seguía trabajando en Super Meat Boy junto con Tommy Refenes.', 20.99, 25),
(7, "Don't Starve Together", "Expansión multijugador independiente del juego de supervivencia en la naturaleza sin límites Don't Starve. Entra en un extraño e inexplorado mundo lleno de criaturas extrañas, peligros y sorpresas.", 8.99, 15),
(8, "Golft Ii!", "Videojuego de minigolf multijugador centrado en una experiencia multijugador dinámica, divertida y creativa.", 15.99, 12),
(9, "Grand Theft auto V","Un joven estafador callejero, un ladrón de bancos retirado y un psicópata aterrador se ven involucrados con lo peor y más desquiciado del mundo criminal, del gobierno de los EE. UU", 15.99, 25),
(10, "Oxygen Not Included", "Videojuego de simulación que recrea una colonia espacial. En lo más profundo de una roca espacial alienígena, tu trabajadora tripulación tendrá que dominar la ciencia, vencer a nuevas y extrañas formas de vida y aprovechar la increíble tecnología espacial", 13.99, 16 ),
(11, "Rust", "Es una aventura de acción y supervivencia en primera persona de corte sandbox en el que debemos colaborar con otros jugadores en un mundo persistente en el que el único objetivo es sobrevivir.", 35.99, 30),
(12, "Raft", "Protocolo de consenso que trabaja eligiendo un líder central sobre el que se hacen las peticiones y coordina al resto de nodos (seguidores) para implementarlas. El ejemplo típico de uso de este algoritmo es para la escritura de mensajes en un log replicado.", 18.99, 25),
(13, "Ultimate Chiken Horse", "Videojuego de plataforma en grupo en el que tú y tus amigos construís el nivel mientras vais jugando, colocando trampas mortales antes de intentar alcanzar el final del nivel. Si lo consigues y tus amigos no, ¡ganas puntos!", 14.99, 25),
(14, "Phasmophobia", "videojuego de aventura y acción de terror psicológico compatible con realidad virtual a cargo de Kinetic Games para PC, PlayStation 5 y Xbox Series en el que hasta 4 jugadores cooperan online para encontrar al fantasma de una casa embrujada.", 15.99, 35),
(15, "Marvel's Spider-Man Remastered", "En Marvel's Spider-Man Remasterizado, la vida de Peter Parker se topa con la de Spider-Man en una historia original repleta de acción. Ponte en la piel de un Peter Parker veterano que ha pulido sus habilidades en la lucha contra el crimen y los villanos en la Nueva York de Marvel.", 15.99, 25),
(16, "Project Zomboid", "RPG survival horror tipo sandbox a cargo de The Indie Stone para PC en el que debemos sobrevivir a un apocalipsis zombi, solos o en modo cooperativo. Busca recursos, construye armas y equipamiento, lucha por tu vida y mucho más en un mundo infestado de zombis.", 18.99, 25),
(17, "Astroner", "videojuego de aventura y exploración espacial desarrollado por System Era Softworks. Lanzado en 2019 tras un período de acceso anticipado, el juego invita a los jugadores a explorar, construir y sobrevivir en varios planetas con entornos alienígenas únicos.", 25.99, 25),
(18, "Elden ring", "ELDEN RING ofrece vastos parajes de fantasía y sombrías e intricadas mazmorras que están conectadas de forma fluida y sin interrupciones. Recorre este impresionante mundo a pie o a caballo, en solitario u online con otros jugadores.", 45.99, 30),
(19, "Dark Souls III", "videojuego de rol de acción desarrollado por FromSoftware y publicado por Bandai Namco Entertainment para PlayStation 4, Xbox One y Microsoft Windows. Es la tercera y última entrega en la saga Souls, lanzándose en Japón el 24 de marzo de 2016, y de manera mundial en abril del mismo año.​", 45.99, 35),
(20, "Farming Simulator 25", " Videojuego de granjas desarrollado y publicado por Giants Software para PlayStation 5, Xbox Series y PC.", 59.99, 35);

/*MOSTRAMOS LOS REGISTROS DE LOS PRODUCTOS*/
SELECT * FROM productos;

/*HACEMOS LOS REGISTROS DE LOS PEDIDOS*/
INSERT INTO pedidos(ID_pedido, fecha_pedido, id_cliente) VALUES
(1, "2024-06-25", 1),
(2, "2024-03-05", 4),
(3, "2024-01-24", 9),
(4, "2024-09-12", 6),
(5, "2024-07-17", 7),
(6, "2024-08-15", 8),
(7, "2024-02-21", 3),
(8, "2024-08-17", 8),
(9, "2024-11-27", 3),
(10, "2024-07-12", 7),
(11, "2024-09-16", 4),
(12, "2024-08-11", 6),
(13, "2024-02-19", 3),
(14, "2024-04-02", 3),
(15, "2024-06-30", 1);

/*Ingresamos los detalles_pedidos*/
-- Insertamos detalles para el pedido 1
INSERT INTO detalles_pedidos(id_pedido, id_producto, cantidad, precio_unitario) VALUES
(1, 1, 2, 15.5),  -- Pedido 1, Producto 1, 2 unidades
(1, 2, 1, 35.5);  -- Pedido 1, Producto 2, 1 unidad

-- Insertamos detalles para el pedido 2
INSERT INTO detalles_pedidos(id_pedido, id_producto, cantidad, precio_unitario) VALUES
(2, 3, 3, 9.99),  -- Pedido 2, Producto 3, 3 unidades
(2, 4, 2, 15.99); -- Pedido 2, Producto 4, 2 unidades

-- Insertamos detalles para el pedido 3
INSERT INTO detalles_pedidos(id_pedido, id_producto, cantidad, precio_unitario) VALUES
(3, 5, 1, 5.99),  -- Pedido 3, Producto 5, 1 unidad
(3, 6, 2, 20.99); -- Pedido 3, Producto 6, 2 unidades

-- Insertamos detalles para el pedido 4
INSERT INTO detalles_pedidos(id_pedido, id_producto, cantidad, precio_unitario) VALUES
(4, 7, 1, 8.99),  -- Pedido 4, Producto 7, 1 unidad
(4, 8, 3, 15.99); -- Pedido 4, Producto 8, 3 unidades

-- Insertamos detalles para el pedido 5
INSERT INTO detalles_pedidos(id_pedido, id_producto, cantidad, precio_unitario) VALUES
(5, 9, 2, 15.99),  -- Pedido 5, Producto 9, 2 unidades
(5, 10, 1, 13.99); -- Pedido 5, Producto 10, 1 unidad


/*MOSTRAMOS LOS REGISTORS DE PEDIDOS*/
SELECT * FROM pedidos;

-- CONSULTA 1,  Obtener todos los clientes y cúantos pedidos han realizado.
SELECT 
    c.ID_clientes, 
    c.nombre_cliente, 
    COUNT(p.ID_pedido) AS num_pedidos /*Utilizamos un count para contar cuántos pedidos (de la tabla pedidos) tiene cada cliente.*/
FROM 
    clientes c /*Decimos de donde tiene que buscar esta información.*/
LEFT JOIN  /*Hacemos un LEFT JOIN entre las dos tablas para que nos aparezcan igualmente los clientes que no hayan realizado ningún pedido.*/
    pedidos p ON c.ID_clientes = p.id_cliente
GROUP BY 
    c.ID_clientes, c.nombre_cliente /*Agrupamos el ID del cliente con su nombre para contar cuántos pedidos tiene cada uno*/
ORDER BY 
    c.ID_clientes; /*Ordenamos los registros por el ID, de menor a mayor.*/


-- CONSULTA 2 Obtener los productos específicos de un pedido mostrando la cantidad pedida y el precio de ese producto por la cantidad pedida.

SELECT 
    p.nombre_comercial_productos, /*Contiene el nombre de los videojuegos*/
    dp.cantidad, /*Indica la cantidad que productos que quiere */
    dp.precio_unitario,
    (dp.cantidad * dp.precio_unitario) AS total_por_producto, /*HAcemos una operación matemática simple, multiplicamos la cantidad por el precio unitario y como resultado sera el precio final*/
    c.ID_clientes /*Contiene el id del cliente*/
FROM 
    detalles_pedidos dp /*Indicamos de que tabla queremos hacer la consulta*/
    
    /*Usamos JOIN para agregar más información a los registros*/
JOIN 
    productos p ON dp.id_producto = p.ID_producto
JOIN 
    pedidos ped ON dp.id_pedido = ped.ID_pedido
JOIN 
    clientes c ON ID_clientes = ped.ID_cliente
    /*Ponemos un WHERE que indicara el ID_pedido*/
WHERE 
    ped.ID_pedido = 2;  /* <-- Puedes cambiar el registro de búsqueda cambiando el número de pedido*/

-- CONSULTA 3 el gasto total de cada uno de los clientes
SELECT 
    c.ID_clientes, 
    c.nombre_cliente, 
    SUM(dp.cantidad * dp.precio_unitario) AS gasto_total /*hacemos una operación matemática simple, primero multiplicamos la cantidad por precio unitario para que despues se sume todo en gasto_total por cliente*/
FROM 
    detalles_pedidos dp /*Indicamos de que tabla viene*/
    /*Agregamos más informacón con los JOIN*/
JOIN 
    productos p ON dp.id_producto = p.ID_producto
JOIN 
    pedidos ped ON dp.id_pedido = ped.ID_pedido
JOIN 
    clientes c ON c.ID_clientes = ped.id_cliente
GROUP BY 
    c.ID_clientes, c.nombre_cliente
    /*Ordenamos los registros en orden descendiente*/
ORDER BY 
    gasto_total DESC;
    
    -- CONSULTA 4: Obtener el nombre, telefono y dirección del cliente que a realizado el último pedido registrado.
SELECT 
    c.nombre_cliente, 
    c.num_telefono_cliente, 
    c.direccion_cliente
FROM 
    clientes c
JOIN 
    pedidos p ON c.ID_clientes = p.id_cliente
WHERE 
    p.fecha_pedido = (SELECT MAX(fecha_pedido) FROM pedidos); 
    /*La función MAX nos devuelve el valor máximo de la fecha, indicamos que queremos que nos coga de máximos y despues le indicamos de que tabla queremos que coga ese dato.*/

-- CONSULTA 5: Obtener el producto más vendido
SELECT 
    p.nombre_comercial_productos, /* Nombre del producto */
    SUM(dp.cantidad) AS total_vendido /* Sumamos la cantidad de cada producto vendida */
FROM 
    detalles_pedidos dp /* Detalles de los productos en cada pedido */
JOIN 
    productos p ON dp.id_producto = p.ID_producto /* Relacionamos con la tabla productos */
GROUP BY 
    p.ID_producto, p.nombre_comercial_productos /* Agrupamos por ID de producto y nombre */
ORDER BY 
    total_vendido DESC /* Ordenamos de mayor a menor según la cantidad vendida */
	LIMIT 1; /* Limitamos el resultado al primer producto más vendido */



	