USE proyectodb;

-- Procedimiento almacenado llamado con un parámetro IN llamado producto utilizado 
-- para el caso de coincidencia de codigo de producto.
DELIMITER //
       CREATE PROCEDURE codigo_producto (IN producto VARCHAR(15))
       BEGIN 
           SELECT 
               codigoProducto, precio
           FROM  detallecompra
           WHERE codigoProducto = producto;
       END//
DELIMITER ;


-- Llamada del store procedure
CALL codigo_producto('S18_1749');

-- Store procedure para determinar 
DELIMITER //
       CREATE PROCEDURE getCiudadCliente (IN numCliente INT)
       BEGIN 
           SELECT 
               estado
           FROM  clientes
           WHERE numeroCliente = numCliente;
       END//
DELIMITER ;

-- Llamada del store procedure para el cliente número 114, 
CALL getCiudadCliente(114);