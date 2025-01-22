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



