SET FOREIGN_KEY_CHECKS=1;
create database elvis;
use elvis;
CREATE TABLE IF NOT EXISTS editoriales(
id_editorial INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
nombre_editorial varchar(50),
index(nombre_editorial)
)ENGINE=INNODB;


CREATE TABLE IF NOT EXISTS empleados(
id_empleado INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nombre_empleado varchar(50),
id_editorial int,
FOREIGN KEY fk_editorial(id_editorial) REFERENCES editoriales(id_editorial)
on delete cascade
on update cascade
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS libros(
id_libro INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
titulo_libro varchar(50),
id_editorial int,
foreign key fk_editorial(id_editorial) references editoriales(id_editorial)
on delete cascade
on update cascade
)ENGINE=INNODB;

drop table editoriales;
INSERT INTO editoriales (id_editorial, nombre_editorial)
VALUES
    (1, 'Editorial Planeta'),
    (2, 'Editorial Santillana'),
    (3, 'Editorial Anaya'),
    (4, 'Editorial Alfaguara'),
    (5, 'Editorial SM'),
    (6, 'Editorial Fondo de Cultura Económica'),
    (7, 'Editorial Siglo XXI'),
    (8, 'Editorial Cátedra'),
    (9, 'Editorial Tecnos'),
    (10, 'Editorial Ariel');



INSERT INTO empleados (id_empleado, nombre_empleado, id_editorial)
VALUES
    (1, 'Juan Pérez', 1),
    (2, 'María Rodríguez', 1),
    (3, 'Pedro López', 2),
    (4, 'Ana Martínez', 2),
    (5, 'Carlos García', 3),
    (6, 'Laura González', 3),
    (7, 'Luis Fernández', 4),
    (8, 'Elena Sánchez', 4),
    (9, 'Javier Ruiz', 5),
    (10, 'Sofía Torres', 5);


INSERT INTO libros (id_libro, titulo_libro, id_editorial)
VALUES
    (1, 'Cien años de soledad', 1),
    (2, 'Don Quijote de la Mancha', 1),
    (3, 'La sombra del viento', 2),
    (4, 'Rayuela', 2),
    (5, 'Crónica de una muerte anunciada', 3),
    (6, 'Los detectives salvajes', 3),
    (7, 'Ficciones', 4),
    (8, 'La casa de los espíritus', 4),
    (9, 'La ciudad y los perros', 5),
    (10, 'Cien años de soledad', 5);



select * from editoriales;
select * from empleados;
select * from libros;

/*
1.	Eliminar una editorial: Si se elimina una editorial de la tabla editoriales
, ¿qué sucede con los libros asociados? Escriba una consulta SQL que elimine una editorial y sus libros relacionados.
los libros asociados se eliminan, al igual que el empleado asociado
*/
select * from editoriales;
select * from empleados;
select * from libros;
delete from editoriales where id_editorial= 1;

/*2.  Actualizar el nombre de una editorial: Si se actualiza el nombre de una editorial en la tabla editoriales, 
¿qué sucede con los libros relacionados?
no sucede nada, por que estamos cambiando el nombre no la id	*/
update editoriales
set	nombre_editorial = 'Editorial Elvis'
where id_editorial = 10;

/*
3.	Eliminar un empleado: Si se elimina un empleado de la tabla empleados, ¿qué sucede con los libros relacionados con esa editorial?
no sucede nada, por que el empleado no esta relacionao con ningun libro
*/
select * from empleados;
select * from editoriales;
select * from libros;
create view empleado_editoriales_libros
as
select	ed.id_editorial,
		ed.nombre_editorial,
        e.id_empleado,
		e.nombre_empleado,
        e.id_editorial id_editorial_empleado,
        l.id_libro,
        l.titulo_libro,
        l.id_editorial librosid
from	empleados e
inner join editoriales ed
on e.id_editorial = ed.id_editorial
inner join libros l
on l.id_editorial = ed.id_editorial;

select * from empleado_editoriales_libros;
delete from empleados where id_empleado = 9;
drop view empleado_editoriales_libros;

/*
4.	Actualizar el nombre de un empleado: Si se actualiza el nombre de un empleado en la 
	tabla empleados, ¿qué sucede con los libros relacionados con esa editorial?
    no sucede nada    
*/

update empleados 
set  nombre_empleado = 'saraza'
where	id_empleado = 3;

/*
5.	Eliminar un libro: Si se elimina un libro de la tabla libros, ¿qué sucede con la relación con la editorial?
no sucede nada
*/


delete from libros
where id_libro = 1;

/*

6.	Cambiar la editorial de un libro: Si se cambia la editorial a la que está asociado un libro en la tabla libros,
 ¿qué sucede con la relación con la editorial anterior?
 no sucede nada
 
*/

update libros
set id_editorial = 2;
select * from empleado_editoriales_libros;

/*
7.	Eliminar una editorial con empleados: Si se intenta eliminar una editorial que tiene empleados asociados, ¿qué sucede?
	se eliminan los libros y los empleados asociados a la editorial 
*/
select * from libros;
select * from editoriales;
select * from libros;

delete from editoriales
where  id_editorial = 1;


/*
8.	Eliminar un empleado con libros: Si se intenta eliminar un empleado que tiene libros asociados, ¿qué sucede?
no pasa nadape causa
*/
delete from empleados
where	id_empleado = 2;

/*
9.	Eliminar una editorial y sus empleados: ¿Cómo se eliminaría una editorial y todos sus empleados?
se elimina los empleados por el detele cascade en la tabla empleados
*/

select * from empleado_editoriales_libros;

delete from editoriales
where id_editorial = 2;
select * from editoriales;

/*
10.	Eliminar una editorial y transferir sus 
empleados a otra editorial: ¿Cómo se eliminaría una editorial y reasignaría a sus empleados a otra editorial?
*/
update empleados
set id_editorial = 3
where id_editorial = 4;

select * from editoriales;
