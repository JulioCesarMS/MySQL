-- Vistas 
USE proyectodb;


--  Vista de los pagos totales hechos por cada cliente
CREATE VIEW clientes_pagos AS
SELECT c.numeroCliente, c.nombreCliente, c.contactoNombre, c.ciudad, c.limiteCredito,SUM(p.monto) AS MontoTotal
FROM clientes AS c
INNER JOIN pagos AS p
ON c.numeroCliente = p.numeroCliente
GROUP BY c.numeroCliente;

-- Observamos registros de la vista
SELECT *
FROM clientes_pagos;

-- Vista de ventas totales por oficina
CREATE VIEW clientesProd_pagos AS
SELECT c.numeroCliente, codigoProducto,SUM(p1.monto) AS MontoTotal
FROM clientes AS c
LEFT JOIN pagos AS p1
ON c.numeroCliente = p1.numeroCliente
LEFT JOIN orden AS o
ON p1.numeroCliente = o.numeroCliente
LEFT JOIN detallecompra AS d
ON o.numeroOrden = d.numeroOrden
LEFT JOIN pagos as p2
ON c.numeroCliente = p2.numeroCliente
GROUP BY numeroCliente, codigoProducto;

-- Observamos los primeros registros
select *
from clientesprod_pagos;

-- vista de productos más vendidos
CREATE VIEW producto_cantidad AS
SELECT d.codigoProducto, p.nombreProduct,  SUM(d.cantidadOrdenada) AS CantidadTotal, AVG(d.cantidadOrdenada) AS Promedio
FROM detallecompra AS d
LEFT JOIN productos AS p
ON d.codigoProducto = p.codigoProducto
GROUP BY d.codigoProducto;

-- Observamos los primeros registros
select *
from producto_cantidad;


-- Vista cantidad promedio de ventas por línea de producto
CREATE VIEW linea_cantidadProm AS
SELECT l.lineaProducto,  AVG(d.cantidadOrdenada) AS CantidadPromedio
FROM detallecompra AS d
LEFT JOIN productos AS p
ON d.codigoProducto = p.codigoProducto
LEFT JOIN lineaproductos AS l
ON p.lineaProducto = l.lineaProducto
GROUP BY l.lineaProducto;

-- Observamos los primeros registros
select *
from linea_cantidadProm;