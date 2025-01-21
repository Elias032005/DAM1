

USE tienda_deportes; -- Usamos la tabla con la que queremos que afecte el trigger

/* Crea los siguientes triggers para las funciones:
Trigger 1: Actualización Automática de Stock
Trigger 2: Auditoría de Cambios en Productos // update productos
Trigger 3: Validación de Stock Negativo
*/
-- TRIGGER 1
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

-- TRIGGER 2

DELIMITER //
CREATE TRIGGER Cambi_Produ
AFTER UPDATE ON productos
FOR EACH ROW
BEGIN
    -- Verificar si alguna de las columnas 'nombre', 'stock' o 'precio' ha cambiado
    IF OLD.nombre <> NEW.nombre OR OLD.stock <> NEW.stock OR OLD.precio <> NEW.precio THEN
        -- Insertar en la tabla de auditoría con los detalles del cambio
        INSERT INTO auditoria_productos (producto_id, cambio, fecha)
        VALUES (NEW.id, CONCAT('Nombre: ', OLD.nombre, ' -> ', NEW.nombre, ', Stock: ', OLD.stock, ' -> ', NEW.stock, ', Precio: ', OLD.precio, ' -> ', NEW.precio), NOW());
    END IF;
END;
//

-- OTRA VERSIÓN
	
DELIMITER // 
CREATE TRIGGER audit_cambios_prod
AFTER UPDATE ON productos
FOR EACH ROW
BEGIN
	INSERT INTO auditoria_producto (producto_id, accion)
    VALUES(OLD.id, CONCAT('Actualización de producto:',
    'Nombre: ', OLD.nombre, ' -> ', NEW.nombre, ',',
    'Stock: ', OLD.stock, ' -> ', NEW.stock, ',',
    'Precio: ', OLD.precio, ' -> ', NEW.precio, ','));
END;
//
-- TRIGGER 3
DELIMITER //
CREATE TRIGGER Vali_stock
AFTER UPDATE ON productos
FOR EACH ROW
BEGIN 
	IF NEW.stock < 0 THEN
      SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Error: El stock no puede ser negativo.';
    END IF;
END;
//
-- OTRA VERSIÓN
DELIMITER //
CREATE TRIGGER validar_stock_negativo
AFTER UPDATE ON productos
FOR EACH ROW
BEGIN
	IF NEW.stock < 0 THEN
    UPDATE productos SET stock = OLD.stock WHERE id = NEW.id;
    DELETE FROM transacciones WHERE producto_id = NEW.id AND cantidad = NEW.cantidad;
    END IF;
END;
//
