

-- Cada vez que se agrega una evolución nyeva, se registra en la tabla auditría indicando que se ha aádido
DELIMITER //
CREATE TRIGGER Reg_evo
AFTER INSERT ON evoluciones
FOR EACH ROW
BEGIN
    -- Registramos una nueva evolución con los siguientes parámetros
    INSERT INTO auditoria_evoluciones (accion, fecha_registro) VALUES 
    ('Se ha añadido una nueva evolución.', NOW());
END;
//

-- Antes de asignar un movimiento a un Pokémon, valida que el tipo del movimiento coincida con al menos uno de los tipos.

DELIMITER //
CREATE TRIGGER Val_movimiento
BEFORE INSERT ON pokemon_movimientos
FOR EACH ROW
BEGIN
   -- Declarar las variables necesarias
    DECLARE tipo_primario VARCHAR(50);
    DECLARE tipo_secundario VARCHAR(50);
    DECLARE tipo_movimiento VARCHAR(50);
    DECLARE Num_habilidades INT;

    -- Obtener los tipos del Pokémon
    SELECT tipo_primario, tipo_secundario INTO tipo_primario, tipo_secundario FROM pokedex WHERE numero_dex = (SELECT numero_dex FROM pokedex WHERE id = NEW.pokemon_id);
		-- El trigger coge el pokemon_id del registro que se está integrado en pokemon_movimientos (usando NEW.pokemon_id) y lo usa para obtener los tipos (tipo_primario y tipo_secundario) del Pokémon correspondiente en la tabla pokedex. No se crea ningún nuevo id, solo se recuperan los tipos del Pokémon con base en su pokemon_id ya existente.
    -- Obtener el tipo del movimiento
    SELECT tipo INTO tipo_movimiento FROM movimientos WHERE id = NEW.id;

    -- Verificar si el tipo del movimiento coincide con alguno de los tipos del Pokémon
    IF tipo_primario != tipo_movimiento OR tipo_secundario != tipo_movimiento THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El tipo de movimiento no coincide con alguno de los dos tipos del Pokémon.';
    END IF;

    -- Obtener el número de habilidades del Pokémon
    SELECT COUNT(*) INTO Num_habilidades FROM pokemon_movimientos WHERE pokemon_id = NEW.pokemon_id;

    -- Verificar si el Pokémon ya tiene 4 movimientos
    IF Num_habilidades >= 4 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El Pokémon ya tiene 4 movimientos.';
    END IF;
    
    IF  EXISTS (SELECT 1 FROM Pokemon_movimientos WHERE pokemon_id = NEW.pokemon_id AND id = NEW.id ) THEN 
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Este movimiento ya lo conoce.';
    END IF;
END;
//

DELIMITER //
CREATE TRIGGER Act_evoluciones
AFTER UPDATE ON evoluciones
FOR EACH ROW 
BEGIN 
	IF OLD.nivel_requerido = NEW.nivel.requerido THEN
    INSERT INTO auditoria_movimientos (Id_evolucion, accion) VALUES
    (NEW.Id, CONCAT('Nivel requerido acutalizado de: ', IFNULL(OLD.nivel_requerido, 'NULL'), ' a ', IFNULL(NEW.nivel_requerido, 'NULL')));
    -- El IFNULL sirve para manejar con posibles valores null en nivel_requerido
	END IF;
END;
//
