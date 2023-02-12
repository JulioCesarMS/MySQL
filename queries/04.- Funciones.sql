use proyectodb;

SELECT *
FROM detallecompra;

-- -----------------------------------------------
-- Función 1:  función para obtener el total
-- -----------------------------------------------
DELIMITER //
CREATE FUNCTION total(cantidad INT, precio decimal(10,2)) 
RETURNS decimal(10,2)
deterministic
BEGIN
	return cantidad*precio;
END; //

-- Creamos una vista empleando la función
CREATE VIEW total AS
SELECT cantidadOrdenada, precio, total(cantidadOrdenada, precio) AS total
FROM detallecompra;

-- Observamos los registros
SELECT *
from total;


-- ---------------------------------------------------------------------------------------------
-- Función 2: Función para determinar si una compra estuvo por encima o por debajo de la media
-- ---------------------------------------------------------------------------------------------

DELIMITER //
CREATE FUNCTION clasificaCompra(total INT, mean decimal(10,2)) 
RETURNS VARCHAR(10)
deterministic
BEGIN

	IF total > mean THEN
		RETURN 'above';
	ELSE 
		RETURN 'below';
	END IF;
END; //

-- Observamos los registros
SELECT cantidadOrdenada, precio, total, (SELECT AVG(total) FROM total) AS mean, clasificaCompra(total, (SELECT AVG(total) FROM total)) AS indicador
FROM total;


