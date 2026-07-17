-- Trabajo Práctico Final Gestión de Base de Datos

/*
1 - Crear una función llamada "calcular_total_ventas" que tome como parámetro el mes y el año, y devuelva el total de ventas realizadas
 en ese mes. Verificar mediante consulta.
*/
USE PUBS;


DELIMITER $$

CREATE FUNCTION calcular_total_ventas(
    p_mes INT,
    p_anio INT
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;

    SELECT COALESCE(SUM(qty), 0)
    INTO total
    FROM sales
    WHERE MONTH(ord_date) = p_mes
      AND YEAR(ord_date) = p_anio;

    RETURN total;
END$$

DELIMITER ;

select calcular_total_ventas(9,1990);
select * from sales;


/*
2 - Crear una función llamada "obtener_nombre_empleado" que tome como parámetro el ID de un empleado y devuelva su nombre completo.
 Verificar mediante consulta.

*/


DELIMITER //

CREATE FUNCTION obtener_nombre_empleado(p_id_empleado VARCHAR(11))
RETURNS VARCHAR(100)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE nombre VARCHAR(100);

    SELECT CONCAT(au_fname, ' ', au_lname)
    INTO nombre
    FROM authors
    WHERE au_id = p_id_empleado;

    RETURN nombre;
END //

DELIMITER ;

SELECT obtener_nombre_empleado('172-32-1176');

/*
3 - Crear un procedimiento almacenado llamado "obtener_promedio" que tome como parámetro de entrada el nombre de un curso 
y calcule el promedio de las calificaciones de todos los alumnos inscriptos en ese curso. Verificar mediante ejecución del procedimiento.

*/
create database ejercicio_3;

CREATE TABLE alumnos (
    id_alumno INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    fecha_nacimiento DATE
);

	CREATE TABLE cursos (
    id_curso INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    profesor VARCHAR(100)
);

CREATE TABLE inscripciones (
    id_alumno INT,
    id_curso INT,
    calificacion DECIMAL(4,2),

    PRIMARY KEY (id_alumno, id_curso),

    FOREIGN KEY (id_alumno) REFERENCES alumnos(id_alumno),

    FOREIGN KEY (id_curso) REFERENCES cursos(id_curso)
);

INSERT INTO alumnos(nombre, apellido, fecha_nacimiento) VALUES
('Juan', 'Pérez', '2002-05-10'),
('María', 'Gómez', '2001-08-20'),
('Carlos', 'López', '2003-01-15');

INSERT INTO cursos(nombre, profesor) VALUES
('Base de Datos', 'Ana Torres'),
('Programación', 'Luis García');

INSERT INTO inscripciones VALUES
(1, 1, 8.5),
(2, 1, 9.0),
(3, 1, 7.5),
(1, 2, 10.0),
(2, 2, 8.0);



select * from alumnos;
select * from cursos;
use ejercicio_3;

delimiter //

create procedure obtener_promedio(in p_id int)
begin
select avg(calificacion) as promedio
from inscripciones 
where id_alumno = p_id;

end //

delimiter ;	

CALL obtener_promedio(1);


/*
4 - Crear un procedimiento almacenado "actualizar_stock" que tome como parámetros de entrada el código del producto y 
	la cantidad a agregar al stock actual. El procedimiento debe actualizar el stock sumando la cantidad especificada
    al stock actual del producto correspondiente. Verificar mediante ejecución del procedimiento.
*/

create database ejercicio_4;
CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL
);

CREATE TABLE productos (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50) NOT NULL,
  descripcion VARCHAR(255) DEFAULT '',
  precio DECIMAL(10,2) NOT NULL,
  stock INT DEFAULT 0
);


CREATE TABLE ventas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL,
    fecha DATE NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id),
    FOREIGN KEY (producto_id) REFERENCES productos(id)
);


--  Insercion de registros
INSERT INTO clientes (nombre, direccion, telefono) VALUES
('Juan Pérez', 'Calle Falsa 123', '555-1234'),
('María García', 'Avenida Siempreviva 742', '555-5678'),
('Pedro González', 'Calle 13 No. 6-11', '555-9101'),
('Ana Hernández', 'Carrera 7 No. 32-60', '555-1212'),
('Luisa Rodríguez', 'Avenida Boyacá No. 64C-31', '555-1415'),
('Carlos Vargas', 'Carrera 15 No. 93-75', '555-1617'),
('Cristina Gómez', 'Carrera 45 No. 34-87', '555-1819'),
('Javier Torres', 'Calle 45 No. 23-09', '555-2022'),
('Laura Sánchez', 'Avenida 68 No. 56-18', '555-2225'),
('Andrés Díaz', 'Carrera 7 No. 11-07', '555-2428');


INSERT INTO productos (nombre, descripcion, precio, stock)
VALUES ('Laptop', 'Laptop HP 15", 8GB RAM, 1TB HDD', 1500.00, 10),
('Smartphone', 'Smartphone Samsung Galaxy S21', 1000.00, 15),
('Tablet', 'Tablet Apple iPad Pro 12.9"', 1200.00, 5),
('Monitor', 'Monitor LG 27", 1440p', 500.00, 20),
('Teclado', 'Teclado mecánico Logitech G513', 100.00, 30),
('Mouse', 'Mouse inalámbrico Logitech M720', 50.00, 25),
('Auriculares', 'Auriculares Sony WH-1000XM4', 300.00, 10),
('Altavoces', 'Altavoces Bose SoundLink Revolve+', 250.00, 8),
('Cámara', 'Cámara Canon EOS R5', 4000.00, 2),
('Impresora', 'Impresora multifunción HP LaserJet Pro M428fdw', 600.00, 5);


INSERT INTO ventas (cliente_id, producto_id, cantidad, fecha) VALUES
(1, 1, 5, '2022-01-01'),
(1, 2, 3, '2022-01-02'),
(2, 3, 2, '2022-01-03'),
(2, 1, 1, '2022-01-04'),
(3, 2, 4, '2022-01-05'),
(3, 3, 1, '2022-01-06'),
(4, 1, 3, '2022-01-07'),
(4, 2, 2, '2022-01-08'),
(5, 3, 6, '2022-01-09'),
(5, 1, 2, '2022-01-10');

	delimiter //
	CREATE PROCEDURE actualizar_stock(IN p_producto_id INT, IN p_cantidad INT, OUT p_nuevo_stock INT)
	BEGIN
		UPDATE productos
		SET stock = stock + p_cantidad
		WHERE id = p_producto_id;

		SELECT stock INTO p_nuevo_stock
		FROM productos
		WHERE id = p_producto_id;
	END //
	delimiter ;
call actualizar_stock(1, -2, @nuevo_stock);

/*
5 - Crear una vista que muestre el título, el autor, el precio y la editorial de todos los libros de cocina de la base pubs.
*/
use pubs;
create view vista3 as
select t.title_id titulo, au.au_fname nombre, t.price precio, pu.pub_name editorial, t.type tipo
from publishers pu
join  titles t
on pu.pub_id = t.pub_id
join titleauthor tau
on t.title_id = tau.title_id
join authors au
on au.au_id = tau.au_id
where t.type  like '%cook%';
select * from vista3;

-- 6   Dadas las siguientes tablas:
CREATE TABLE fabricantes (
    id_fabricante INT PRIMARY KEY,
    nombre_fabricante VARCHAR(255) NOT NULL
);

INSERT INTO fabricantes (id_fabricante, nombre_fabricante)
VALUES(1, 'Fabricante A'),(2, 'Fabricante B'),(3, 'Fabricante C');

CREATE TABLE productos (
    id_producto INT PRIMARY KEY,
    id_fabricante INT,
    nombre_producto VARCHAR(255) NOT NULL,
    fecha_lanzamiento DATE,
    FOREIGN KEY (id_fabricante) REFERENCES fabricantes(id_fabricante)
);

INSERT INTO productos (id_producto, id_fabricante, nombre_producto, fecha_lanzamiento)
VALUES(1, 1, 'Producto X', '2020-01-01'),(2, 2, 'Producto Y', '2019-12-01'), (3, 3, 'Producto Z', '2021-05-15');

create index fabricante_producto	
on productos (id_fabricante,nombre_producto);

create unique index index_unico	
on productos(id_producto);
				
alter table	productos
add unique index index_2 (id_fabricante,nombre_producto);

create unique index unico
on productos(id_fabricante);

drop index index_2
on productos;

/*
7 -  Se desea modificar un sistema de gestión de empleados para incluir  un mecanismo automático que transfiera a los 
	empleados que cumplen con ciertos criterios de jubilación a una tabla especializada llamada jubilados. 
	Los criterios de jubilación son: los empleados deben tener 30 años o más de antigüedad y 65 años o más de edad. 
	Además, se requiere que cualquier inserción en la tabla empleados que cumpla con estos criterios resulte en una inserción
    automática en la tabla jubilados.

*/

create database ejercicio_7;
use ejercicio_7;
CREATE TABLE empleados (
  nombre VARCHAR(50) NOT NULL,
  edad INT NOT NULL,
  antiguedad INT NOT NULL
);


CREATE TABLE jubilados (
  nombre VARCHAR(50) NOT NULL,
  edad INT NOT NULL,
  antiguedad INT NOT NULL
);

delimiter //

create trigger trigger_check_edad_before_insert2
before insert on empleados
for each row
begin
	if new.edad >= 65 and new.antiguedad >= 30 then
    insert into jubilados(nombre, edad, antiguedad)
    values (new.nombre, new.edad, new.antiguedad);

    end if;
end //

delimiter ;

drop trigger trigger_check_edad_before_insert;

insert into empleados values('elvis',25,1);
insert into empleados values ('dalto',70,30);
select * from empleados;
select * from jubilados;

/*
8 - Crear un procedimiento almacenado llamado ActualizarEmpleados que tome dos  parámetros de entrada:
*/
create database ejercicio_8;
use ejercicio_8;

CREATE TABLE empleados (
    codigo_empleado VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    salario DECIMAL(10,2) NOT NULL
);

INSERT INTO empleados (codigo_empleado, nombre, salario) VALUES
('EMP001', 'Juan Pérez', 250000.00),
('EMP002', 'María Gómez', 180000.00),
('EMP003', 'Carlos Díaz', 220000.00),
('EMP004', 'Ana López', 195000.00),
('EMP005', 'Pedro Ruiz', 210000.00);

delimiter //

create procedure ActualizarEmpleados(in codigo_emp VARCHAR(10), in salario_actualizado DECIMAL(10,2))
begin
	declare salario_actual decimal(10,2);
    
    start transaction;
    select salario
    into salario_actual
    from empleados
    where codigo_empleado = codigo_emp;
    
    if salario_actualizado < salario_actual then
		rollback;
        select 'salario actualizado menos que el actual' as mensaje;
	else
		update empleados 
		set	   salario = salario_actualizado
        where  codigo_empleado = codigo_emp;
        commit;
        select 'salario actualizado' as mensaje;
	end if;
end //

delimiter ;

select * from empleados;

CALL ActualizarEmpleados('EMP001', 300001.00);

/*
9 - Gestión de Usuarios

a) Crear un usuario sin privilegios específicos
b) Crear un usuario con privilegios de lectura sobre la base pubs
c) Crear un usuario con privilegios de escritura sobre la base pubs
d) Crear un usuario con todos los privilegios sobre la base pubs
e) Crear un usuario con privilegios de lectura sobre la tabla titles
f) Eliminar al usuario que tiene todos los privilegios sobre la base pubs
g) Eliminar a dos usuarios a la vez
h) Eliminar un usuario y sus privilegios asociados
i) Revisar los privilegios de un usuario

*/


create user 'max'@'localhost' identified by '123';

-- b) Crear un usuario con privilegios de lectura sobre la base pubs

create user 'elvis'@'localhost' identified by '123';

grant select on pubs.* to 'elvis'@'localhost';

REVOKE SELECT, INSERT, UPDATE, DELETE ON *.* FROM 'elvis'@'localhost';

-- c) Crear un usuario con privilegios de escritura sobre la base pubs

create user 'yamila'@'localhost' identified by '123';

grant insert on pubs.* to 'yamila'@'localhost';

REVOKE SELECT, INSERT, UPDATE, DELETE ON *.* FROM 'yamila'@'localhost';

-- d) Crear un usuario con todos los privilegios sobre la base pubs

create user 'jorge'@'localhost' identified by '123';

grant all privileges on pubs.* to 'jorge'@'localhost';

REVOKE all privileges ON pubs.* FROM 'jorge'@'localhost';

-- e) Crear un usuario con privilegios de lectura sobre la tabla titles

create user 'lautaro'@'localhost' identified by '123';

grant select on pubs.titles to 'lautaro'@'localhost';

REVOKE SELECT, INSERT, UPDATE, DELETE ON *.* FROM 'lautaro'@'localhost';

-- f) Eliminar al usuario que tiene todos los privilegios sobre la base pubs

drop user 'jorge'@'localhost';

-- g) Eliminar a dos usuarios a la vez

drop user 'lautaro'@'localhost', 'yamila'@'localhost';

-- h) Eliminar un usuario y sus privilegios asociados

drop user 'elvis'@'localhost';


-- i) Revisar los privilegios de un usuario

select * from mysql.user;
