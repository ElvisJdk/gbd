create database testDisparador;
use testDisparador;

create table alumnos(
id int not null auto_increment,
nombre varchar(50),
apellido varchar(50),
nota int,
primary key (id)
);


/*
Trigger 1: trigger_check_nota_before_insert
Se ejecuta sobre la tabla alumnos.
Se ejecuta antes de una operación de inserción.
Si el nuevo valor de la nota que se quiere insertar es negativo, se guarda como 0.
Si el nuevo valor de la nota que se quiere insertar es mayor que 10, se guarda como 10.

Trigger2 : trigger_check_nota_before_update
	
Se ejecuta sobre la tabla alumnos.
Se ejecuta antes de una operación de actualización.
Si el nuevo valor de la nota que se quiere actualizar es negativo, se guarda como 0.
Si el nuevo valor de la nota que se quiere actualizar es mayor que 10, se guarda como 10.
Una vez creados los triggers escriba 3 sentencias de inserción y actualización sobre la tabla alumnos y verifica que los triggers se están ejecutando correctamente.

*/

delimiter //
create trigger trigger_check_nota_before_insert
before insert
on alumnos
for each row
begin
if new.nota < 0 then
	SET new.nota = 0;
    end if;
    
    if new.nota >= 10 then
    set new.nota  = 10;
    end if;
end //

delimiter ;

insert into alumnos (nombre, apellido , nota)
values('elvis','morales', -1);	

select * from alumnos;		

delimiter //
create trigger trigger_check_nota_before_update
before update
on alumnos
for each row
begin
if new.nota < 0 then
	SET new.nota = 0;
    end if;
    
    if new.nota >= 10 then
    set new.nota  = 10;
    end if;
end //

delimiter ;


select * from alumnos;		

update alumnos set nota = -8 where id = 2;
update alumnos set nota = 15 where id = 1;
update alumnos set nota = 2 where id = 2;