USE gamers;

select @@autocommit;
set autocommit = 0;

-- insertamos registros
insert into game (id_game,name,description,id_level,id_class) values 
(101, "Cyberpunk2", "futurist", 12, 115);
insert into game (id_game,name,description,id_level,id_class) values 
(102, "Cyberpunk3", "futurist", 12, 115);
insert into game (id_game,name,description,id_level,id_class) values 
(103, "Cyberpunk4", "futurist", 12, 115);

-- Observamos los datos de la tabla game
select *
from game;
-- iniciamos la transacción
start transaction;
-- 1) eliminacion de 3 registros
delete from game where id_game = 103;
delete from game where id_game = 102;
delete from game where id_game = 101;

-- 2) Validamos la eliminación de los datos
select *
from game;

-- 3) Revertimos los últimos registros
rollback;

-- Volvemos a validar la eliminación de los datos
select *
from game;

-- iniciamos la transacción
start transaction;

-- 4) Insertar lote de registros
insert into game (id_game,name,description,id_level,id_class) values 
(101, "Cyberpunk2", "futurist", 12, 115);
insert into game (id_game,name,description,id_level,id_class) values 
(102, "Cyberpunk3", "futurist", 12, 115);
insert into game (id_game,name,description,id_level,id_class) values 
(103, "Cyberpunk4", "futurist", 12, 115);
insert into game (id_game,name,description,id_level,id_class) values 
(104, "Cyberpunk5", "futurist", 12, 115);
insert into game (id_game,name,description,id_level,id_class) values 
(105, "Cyberpunk6", "futurist", 12, 115);
savepoint lote1;

insert into game (id_game,name,description,id_level,id_class) values 
(106, "Cyberpunk7", "futurist", 12, 115);
insert into game (id_game,name,description,id_level,id_class) values 
(107, "Cyberpunk8", "futurist", 12, 115);
insert into game (id_game,name,description,id_level,id_class) values 
(108, "Cyberpunk9", "futurist", 12, 115);
insert into game (id_game,name,description,id_level,id_class) values 
(109, "Cyberpunk10", "futurist", 12, 115);
insert into game (id_game,name,description,id_level,id_class) values 
(110, "Cyberpunk11", "futurist", 12, 115);
savepoint lote2;

insert into game (id_game,name,description,id_level,id_class) values 
(111, "Cyberpunk12", "futurist", 12, 115);
insert into game (id_game,name,description,id_level,id_class) values 
(112, "Cyberpunk13", "futurist", 12, 115);
insert into game (id_game,name,description,id_level,id_class) values 
(113, "Cyberpunk14", "futurist", 12, 115);
insert into game (id_game,name,description,id_level,id_class) values 
(114, "Cyberpunk15", "futurist", 12, 115);
insert into game (id_game,name,description,id_level,id_class) values 
(115, "Cyberpunk16", "futurist", 12, 115);


-- 5) Volvemos a validar la eliminación de los datos
select *
from game;

-- 6) eliminamos segundo lote
rollback to lote2;

-- 7) Volvemos a validar la eliminación de los datos
select *
from game;