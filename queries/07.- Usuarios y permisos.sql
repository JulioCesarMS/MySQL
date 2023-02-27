
-- Crear un usuario
CREATE USER 'coder'@'localhost' IDENTIFIED BY 'coder';

--  id : nombre de columna
GRANT SELECT ON gamers.class TO 'coder'@'localhost';

USE mysql;
SELECT * from user;