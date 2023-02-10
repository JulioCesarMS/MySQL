/* Creación de base de datos  */
create database proyectoDB;

use proyectodb;

-- Tabla de clientes
CREATE TABLE `clientes` (
  `numeroCliente` int NOT NULL,
  `nombreCliente` varchar(50) NOT NULL,
  `contactoNombre` varchar(50) NOT NULL,
  `contactoApellido` varchar(50) NOT NULL,
  `telefono` varchar(50) NOT NULL,
  `direccionLine1` varchar(50) NOT NULL,
  `direccionLine2` varchar(50) DEFAULT NULL,
  `ciudad` varchar(50) NOT NULL,
  `estado` varchar(50) DEFAULT NULL,
  `codigoPostal` varchar(15) DEFAULT NULL,
  `pais` varchar(50) NOT NULL,
  `vendedorRepNumero` int DEFAULT NULL,
  `limiteCredito` double DEFAULT NULL,
  PRIMARY KEY (`numeroCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- Tabla oficinas
CREATE TABLE `oficinas` (
  `codigoOficina` varchar(10) NOT NULL,
  `ciudad` varchar(50) NOT NULL,
  `telefono` varchar(50) NOT NULL,
  `direccionLine1` varchar(50) NOT NULL,
  `direccionLine2` varchar(50) DEFAULT NULL,
  `estado` varchar(50) DEFAULT NULL,
  `pais` varchar(50) NOT NULL,
  `codigoPostal` varchar(15) NOT NULL,
  `territorio` varchar(10) NOT NULL,
  PRIMARY KEY (`codigoOficina`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- Tabla de empleados
CREATE TABLE `empleados` (
  `numeroEmpleado` int(11) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `extension` varchar(10) NOT NULL,
  `email` varchar(100) NOT NULL,
  `codigoOficina` varchar(10) NOT NULL,
  `reportaA` int(11) DEFAULT NULL,
  `tituloTrabajo` varchar(50) NOT NULL,
  PRIMARY KEY (`numeroEmpleado`),
  KEY `reportaA` (`reportaA`),
  KEY `codigoOficina` (`codigoOficina`),
  CONSTRAINT `empleados_2` FOREIGN KEY (`codigoOficina`) REFERENCES `oficinas` (`codigoOficina`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



-- sobre linea de productos
CREATE TABLE `lineaproductos` (
  `lineaProducto` varchar(50) NOT NULL,
  `descripcionTexto` varchar(4000) DEFAULT NULL,
  `descriptionHTML` mediumtext,
  `imagen` mediumblob,
  PRIMARY KEY (`lineaProducto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- sobre los productos
CREATE TABLE `productos` (
  `codigoProducto` varchar(15) NOT NULL,
  `nombreProduct` varchar(70) NOT NULL,
  `lineaProducto` varchar(50) NOT NULL,
  `escalaProducto` varchar(10) NOT NULL,
  `proveedorProducto` varchar(50) NOT NULL,
  `descripcionProducto` text NOT NULL,
  `cantidadStock` smallint(6) NOT NULL,
  `precioCompra` decimal(10,2) NOT NULL,
  `MSRP` decimal(10,2) NOT NULL,
  PRIMARY KEY (`codigoProducto`),
  KEY `lineaProducto` (`lineaProducto`),
  CONSTRAINT `productos_1` FOREIGN KEY (`lineaProducto`) REFERENCES `lineaProductos` (`lineaProducto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `orden` (
  `numeroOrden` int(11) NOT NULL,
  `fechaOrden` date NOT NULL,
  `fechaRequerida` date NOT NULL,
  `fechaEmbarque` date DEFAULT NULL,
  `estatus` varchar(15) NOT NULL,
  `comentarios` text,
  `numeroCliente` int(11) NOT NULL,
  PRIMARY KEY (`numeroOrden`),
  KEY `numeroCliente` (`numeroCliente`),
  CONSTRAINT `compra_1` FOREIGN KEY (`numeroCliente`) REFERENCES `clientes` (`numeroCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Tabla de ordenes
CREATE TABLE `detallecompra` (
  `numeroOrden` int(11) NOT NULL,
  `codigoProducto` varchar(15) NOT NULL,
  `cantidadOrdenada` int(11) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `numeroLinea` smallint(6) NOT NULL,
  `numeroVendedor` int(11) NOT NULL,
  PRIMARY KEY (`numeroOrden`,`codigoProducto`),
  KEY `codigoProducto` (`codigoProducto`),
  KEY `numeroVendedor` (`numeroVendedor`),
  CONSTRAINT `orden_1` FOREIGN KEY (`numeroOrden`) REFERENCES `orden` (`numeroOrden`),
  CONSTRAINT `orden_2` FOREIGN KEY (`codigoProducto`) REFERENCES `productos` (`codigoProducto`),
  CONSTRAINT `orden_3` FOREIGN KEY (`numeroVendedor`) REFERENCES `empleados` (`numeroEmpleado`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- hacerca del pago
CREATE TABLE `pagos` (
  `numeroCliente` int(11) NOT NULL,
  `numeroCheque` varchar(50) NOT NULL,
  `fechaPago` date NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  PRIMARY KEY (`numeroCliente`,`numeroCheque`),
  CONSTRAINT `pagos_1` FOREIGN KEY (`numeroCliente`) REFERENCES `clientes` (`numeroCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



