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
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS libros(
id_libro INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
titulo_libro varchar(50),
id_editorial int,
foreign key fk_editorial(id_editorial) references editoriales(id_editorial)
on delete cascade
)ENGINE=INNODB;

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
        l.id_libro,
        l.titulo_libro
from	empleados e
inner join editoriales ed
on e.id_editorial = ed.id_editorial
inner join libros l
on l.id_editorial = ed.id_editorial;

select * from empleado_editoriales_libros;
delete from empleados where id_empleado = 9;


/*
4.	Actualizar el nombre de un empleado: Si se actualiza el nombre de un empleado en la 
	tabla empleados, ¿qué sucede con los libros relacionados con esa editorial?
*/

