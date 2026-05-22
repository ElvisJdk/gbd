drop database editoriales;
create database editoriales;
use editoriales;
CREATE TABLE editoriales (
    id_editorial INT PRIMARY KEY,
    nombre_editorial VARCHAR(255) NOT NULL
);

INSERT INTO editoriales (id_editorial, nombre_editorial)
VALUES
    (1, 'Editorial Santillana'),
    (2, 'Editorial Anagrama'),
    (3, 'Editorial Planeta'),
    (4, 'Editorial Alfaguara'),
    (5, 'Editorial SM'),
    (6, 'Editorial Penguin Random House'),
    (7, 'Editorial Norma'),
    (8, 'Editorial Ediciones B'),
    (9, 'Editorial Aguilar'),
    (10, 'Editorial Fondo de Cultura Económica');

CREATE TABLE libros (
    id_libro INT PRIMARY KEY,
    id_editorial INT,
    titulo VARCHAR(255) NOT NULL,
    fecha_publicacion DATE,
    FOREIGN KEY (id_editorial) REFERENCES editoriales(id_editorial)
);

INSERT INTO libros (id_libro, id_editorial, titulo, fecha_publicacion)
VALUES
    (1, 1, 'Cien años de soledad', '1967-05-30'),
    (2, 2, 'Rayuela', '1963-07-23'),
    (3, 3, 'La sombra del viento', '2001-04-27'),
    (4, 4, 'Pedro Páramo', '1955-11-30'),
    (5, 5, 'Don Quijote de la Mancha', '1605-01-16'),
    (6, 6, 'Harry Potter y la piedra filosofal', '1997-06-26'),
    (7, 7, 'Crimen y castigo', '1866-01-29'),
    (8, 8, 'Los detectives salvajes', '1998-09-01'),
    (9, 9, 'La casa de los espíritus', '1982-01-01'),
    (10, 10, 'Ficciones', '1944-05-01');
    
-- 1
    create index I_compuesto
    on libros(id_editorial,titulo);
    
-- 2
create index I_fecha
on libros(fecha_publicacion);

-- 3
drop index I_compuesto on libros;
-- no se puede eliminar por que el indice I_compuesto tiene una fk


-- 4

create index id_unico
on libros(id_editorial);

-- 5
-- no se puede usar alter para modificar el indice diretamente, se debe eliminar y luego alterar

-- 6
create unique index id_indice_unico
on	editoriales(id_editorial);

-- 7
alter table libros add primary key (id_libro);

    
    
