USE proyectodb;

-- -----------------------------------------------------------------------------------------
--  Trigger 1
-- -----------------------------------------------------------------------------------------
SELECT *
FROM clientes;

/*
El siguiente disparador comprueba el valor de las columnas contactNombre, contactApellido 
antes de insertar un nuevo registro en la tabla clientes,  y
- Si hay algún espacio antes o después de contactNombre, contactApellido, la función TRIM() los eliminará.
*/
DELIMITER //
CREATE TRIGGER `clean_contact` 
BEFORE INSERT 
ON clientes FOR EACH ROW
BEGIN
	SET NEW.contactoNombre = TRIM(NEW.contactoNombre);
	SET NEW.contactoApellido = TRIM(NEW.contactoApellido);
END;
//

-- Verificación
insert into clientes (numeroCliente, nombreCliente, contactoNombre,contactoApellido,telefono,direccionLine1,direccionLine2,ciudad,estado,codigoPostal,pais,vendedorRepNumero,limiteCredito) values 
(497,'Atelier graphique','  Schmitt','  Carine ','40.32.2555','54, rue Royale',NULL,'Nantes',NULL,'44000','France',1370,'21000.00');

-- Podemos comprobar que los espacios en blanco se eliminan 
SELECT *
FROM clientes
ORDER BY numeroCliente DESC;


-- -----------------------------------------------------------------------------------------
--  Trigger 2
-- -----------------------------------------------------------------------------------------

SELECT *
FROM pagos;

/*
El siguiente disparador comprueba el valor de la columna numeroCheque antes de insertar un nuevo 
registro en la tabla pagos,  y
- Si hay está escrito en minúsculas numeroCheque, la función UPPER() lo convertirá en mayúsculas.
*/
DELIMITER //
CREATE TRIGGER `clean_numeroCheque` 
BEFORE INSERT 
ON pagos FOR EACH ROW
BEGIN
	SET NEW.numeroCheque = UPPER(NEW.numeroCheque);
END;
//

-- Verificación
insert  into `pagos`(`numeroCliente`,`numeroCheque`,`fechaPago`,`monto`) values 
(497,'pq336336','2005-10-19','6066.78');

-- Podemos comprobar que los espacios en blanco se eliminan 
SELECT *
FROM pagos
ORDER BY numeroCliente DESC;

-- -----------------------------------------------------------------------------------------
--  Trigger 3
-- -----------------------------------------------------------------------------------------

SELECT *
FROM Clientes;

/*
El siguiente disparador comprueba el valor de la columna limiteCredito antes de insertar un nuevo 
clasificándolos en dos clases:
- If limiteCredito >= AVG(limiteCredito) -> 'Alto'
- If limiteCredito < AVG(limiteCredito) -> 'Bajo'
*/

-- Creamos la columna tipoDeuda
ALTER TABLE Clientes
ADD COLUMN tipoDeuda VARCHAR(15) DEFAULT 'Unknown' AFTER limiteCredito;

-- DROP TRIGGER IF EXISTS tipo_deuda;
DELIMITER //
CREATE TRIGGER `tipo_deuda` 
BEFORE INSERT 
ON clientes FOR EACH ROW
BEGIN 
	IF NEW.limiteCredito > 15000 THEN
		SET NEW.tipoDeuda = 'Alto';
	ELSE 
		SET NEW.tipoDeuda = 'Bajo';
	END IF;
END;
//

-- Verificamos ingresando registros
insert into clientes (numeroCliente, nombreCliente, contactoNombre,contactoApellido,telefono,direccionLine1,direccionLine2,ciudad,estado,codigoPostal,pais,vendedorRepNumero,limiteCredito) values 
(512,'Atelier graphique','  Schmitt','  Carine ','40.32.2555','54, rue Royale',NULL,'Nantes',NULL,'44000','France',1370,'23000.00');

-- Podemos comprobar que los espacios en blanco se eliminan 
SELECT *
FROM clientes
ORDER BY numeroCliente DESC;




