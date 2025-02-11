

CREATE DATABASE Pokedex;
USE Pokedex;



CREATE TABLE pokedex (
  id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único para cada entrada de la Pokédex
  numero_dex INT NOT NULL UNIQUE,  -- Número oficial en la Pokédex
  nombre VARCHAR(100) NOT NULL,   -- Nombre del Pokémon
  tipo_primario VARCHAR(50) NOT NULL, -- Tipo principal (Agua, Fuego, etc.)
  tipo_secundario VARCHAR(50),    -- Tipo secundario (puede ser NULL)
  descripcion TEXT          -- Breve descripción del Pokémon
);


CREATE TABLE habilidades (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL UNIQUE, -- Nombre de la habilidad
  descripcion TEXT           -- Descripción detallada de la habilidad
);


CREATE TABLE pokemon_habilidades (
  id INT AUTO_INCREMENT PRIMARY KEY,
  pokemon_id INT NOT NULL,       -- Relación con la tabla Pokédex
  habilidad_id INT NOT NULL,      -- Relación con la tabla Habilidades
  FOREIGN KEY (pokemon_id) REFERENCES pokedex(id),
  FOREIGN KEY (habilidad_id) REFERENCES habilidades(id)
);

ALTER TABLE pokemon_habilidades
ADD COLUMN Num_habilidades INT CHECK (Num_habilidades <4); -- Con esto, limitamos el num de movimientos que puede tener un pokemon

CREATE TABLE evoluciones (
  id INT AUTO_INCREMENT PRIMARY KEY,
  pokemon_base_id INT NOT NULL,    -- Pokémon que evoluciona
  pokemon_evolucion_id INT NOT NULL, -- Pokémon resultante de la evolución
  nivel_requerido INT,        -- Nivel necesario para evolucionar (puede ser NULL)
  metodo VARCHAR(100),        -- Método de evolución (Piedra, Amistad, etc.)
  FOREIGN KEY (pokemon_base_id) REFERENCES pokedex(id),
  FOREIGN KEY (pokemon_evolucion_id) REFERENCES pokedex(id)
);


CREATE TABLE movimientos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL UNIQUE, -- Nombre del movimiento
  tipo VARCHAR(50) NOT NULL,      -- Tipo del movimiento
  potencia INT,            -- Potencia del movimiento (puede ser NULL)
  precision_mov INT,            -- Precisión del movimiento (puede ser NULL)
  descripcion TEXT           -- Descripción detallada
);


CREATE TABLE pokemon_movimientos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  pokemon_id INT NOT NULL,       -- Relación con la tabla Pokédex
  movimiento_id INT NOT NULL,     -- Relación con la tabla Movimientos
  FOREIGN KEY (pokemon_id) REFERENCES pokedex(id),
  FOREIGN KEY (movimiento_id) REFERENCES movimientos(id)
);

CREATE TABLE auditoria_evoluciones (
id INT AUTO_INCREMENT PRIMARY KEY,
Id_evolucion INT,
accion VARCHAR(255),
fecha_registro DATE DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY (Id_evolucion) REFERENCES pokedex(id)
);




-- CONSULTAS
-- Consulta para listar todos los pokemon y sus habilidades
SELECT pokedex.id, pokedex.nombre AS pokemon, habilidades.nombre AS habilidad  -- Selecionamos las tablas que queremos implicar en este SELECT
FROM pokedex -- Indicamos la tabla 
INNER JOIN pokemon_habilidades ON pokedex.id = pokemon_habilidades.pokemon_id -- Indicamos primero la tabla que queremos que "compare" y le asignamos que el pokemon.id sea igual al pokemon_habilidades.pokemon_id
INNER JOIN habilidades ON pokemon_habilidades.habilidad_id = habilidades.id;  -- Indicamos primero la tabla que queremos que "compare" y le asignamos que el pokemonpokemon_habilidades-habilidades_id sea igual al habilidades.id

-- Después del ON la nomenglatura de (pokemon_habilidades) es LA TABLA DONDE APARECE EL DATO  y (habilidades.id) es el nombre de la columna

-- Consulta par alistar todos los pokemos con sus movimientos incluso si no tienen ninguno asignado

SELECT pokedex.id, pokedex.nombre AS pokemon, movimientos.nombre AS movimiento  -- Selecionamos la tabla y las tablas
FROM pokedex  -- Indicamos la tabla
LEFT JOIN pokemon_movimientos ON pokedex.id = pokemon_movimientos.pokemon_id  -- Indicamos la tabla y las columnas que queremos que implique
LEFT JOIN movimientos ON pokemon_movimientos.movimiento_id = movimientos.id; -- Indicamos la tabla y las columnas que queremos que implique

-- 

SELECT 
-- Renombramos las tablas para asignarlas mejor
    movimientos.nombre AS movimiento, 
    movimientos.tipo AS tipo_movimiento, 
    pokedex.nombre AS pokemon, 
    pokedex.tipo_primario AS tipo_primario
    
FROM movimientos -- La tabla de donde sale la información principal
RIGHT JOIN pokemon_movimientos ON movimientos.id = pokemon_movimientos.movimiento_id -- La segunda tabla que compara/relaciona con la tabla movimientos
RIGHT JOIN pokedex ON pokemon_movimientos.pokemon_id = pokedex.id; -- La segunda tabla que compara/relaciona con la tabla movimientos
 
