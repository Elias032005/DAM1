
DELIMITER //
CREATE TRIGGER Act_habitacion
BEFORE INSERT ON habitaciones
FOR EACH ROW
BEGIN
	IF NEW.estado = 'RESERVADA' THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Esta habitación ya esta reservada';
    END IF;
    
	IF NEW.estado = 'MANTENIMIENTO' THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Esta habitación está en mantenimiento';
    END IF;
    
    -- Si el nuevo estado esta disponible y alguien lo reserva, cambiara automáticamente el estado de la habitación.
    
	IF NEW.estado = 'DISPONIBLE' THEN
		SET NEW.estado = 'RESERVA';
    END IF;

END;

//

DELIMITER //

CREATE TRIGGER elim_reserva
AFTER DELETE ON reservas
FOR EACH ROW
BEGIN 
    -- Actualizar el estado de la habitación asociada a la reserva eliminada
    UPDATE habitaciones
    SET estado = 'DISPONIBLE'
    WHERE id = OLD.habitacion_id;
END;

//


DELIMITER //
CREATE TRIGGER vali_fechas
BEFORE INSERT ON reservas
FOR EACH ROW
BEGIN
    -- Validación de fechas: Verificar solapamiento de reservas
    IF EXISTS (
        SELECT 1
        FROM reservas
        WHERE habitacion_id = NEW.habitacion_id
        AND (
            (NEW.fecha_inicio BETWEEN fecha_inicio AND fecha_fin) --  Verifica si la fecha de inicio de la nueva reserva (NEW.fecha_inicio) está dentro del rango de fechas de una reserva existente (entre fecha_inicio y fecha_fin de una reserva existente). 
																  --  Si la nueva reserva empieza el 5 de marzo y la reserva existente es del 1 de marzo al 10 de marzo, esta condición será verdadera.
                                                                  
            OR (NEW.fecha_fin BETWEEN fecha_inicio AND fecha_fin) -- Verifica si la fecha de fin de la nueva reserva (NEW.fecha_fin) está dentro del rango de fechas de una reserva existente.
																  -- Si la nueva reserva termina el 7 de marzo y la reserva existente es del 1 de marzo al 10 de marzo, esta condición será verdadera.
                                                                  
            OR (fecha_inicio BETWEEN NEW.fecha_inicio AND NEW.fecha_fin) --  Verifica si el inicio de la reserva existente (fecha_inicio) está dentro del rango de fechas de la nueva reserva.
																		 -- Si la nueva reserva es del 5 de marzo al 10 de marzo, y la reserva existente comienza el 3 de marzo y termina el 7 de marzo, esta condición será verdadera.
                                                                         
            OR (fecha_fin BETWEEN NEW.fecha_inicio AND NEW.fecha_fin)   --  Verifica si el fin de la reserva existente (fecha_fin) está dentro del rango de fechas de la nueva reserva.
																		--  Si la nueva reserva es del 5 de marzo al 10 de marzo, y la reserva existente termina el 8 de marzo, esta condición será verdadera. 
        )
    ) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Error: Las fechas se solapan con una reserva existente.';
    END IF;

    -- Actualización del estado de la habitación: Cambiar a 'RESERVADA'
    UPDATE habitaciones
    SET estado = 'RESERVADA'
    WHERE id = NEW.habitacion_id
    AND estado != 'MANTENIMIENTO';

    -- Registro en la auditoría: Registrar el cambio de estado de la habitación
    INSERT INTO auditoria_habitaciones (habitacion_id, estado_anterior, estado_nuevo, accion, cliente_id)
    SELECT NEW.habitacion_id, 
           (SELECT estado FROM habitaciones WHERE id = NEW.habitacion_id), 
           'RESERVADA', 
           'Nueva reserva realizada', 
           NEW.cliente_id;
END;

//
