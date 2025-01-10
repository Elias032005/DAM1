USE tienda_deportes; -- Usamos la tabla con la que queremos que afecte el trigger
/* Crea los siguientes triggers para las funciones:
Trigger 1: Actualización Automática de Stock
Trigger 2: Auditoría de Cambios en Productos
Trigger 3: Validación de Stock Negativo
*/

DELIMITER //
CREATE TRIGGER Act_auto_stock
AFTER INSERT ON transacciones 
FOR EACH ROW
BEGIN
	IF NEW.tipo = 'SALIDA'  THEN -- Usamos NEW.tipo porque sera un nuevo registro del tipo
    -- Actualizamos el stock dentro de la tabla productos
    -- Usamos el SET para guardar temporalmente el valor de las variables
    -- la variable stock se actualizara dependiendo si el tipo de registro es de entrada o de salida
		UPDATE productos SET stock = stock - NEW.cantidad WHERE id = NEW.producto_id;
        -- Usamos elconcat para concatenar diferentes tablas
	
        ELSE IF NEW.tipo = 'ENTRADA'  THEN
		UPDATE productos SET stock = stock + NEW.cantidad WHERE id = NEW.producto_id;
		-- Usamos elconcat para concatenar diferentes tablas
        
        END IF;
        END IF;
END;
//

