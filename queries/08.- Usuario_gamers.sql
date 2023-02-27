USE gamers;


-- Ingresamos un registro en level_game
insert into level_game (id_level, description) values (16, 'level 1');

-- Observamos la tabla
SELECT *
FROM class;

-- Ingresamos un registro en level_game
insert into class (id_level, id_class, description) values (1, 1, 'A');

-- Eliminamos el registro
DELETE 
FROM class
WHERE id_level = 1; 

-- Observamos la tabla
SELECT *
FROM class;