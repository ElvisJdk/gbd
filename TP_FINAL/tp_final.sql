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
truncate cursos;

select * from alumnos;
select * from cursos;
