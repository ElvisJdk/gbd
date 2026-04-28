drop database televisores;
create database televisores;
use televisores;
SET FOREIGN_KEY_CHECKS=1;

create table importadores(
	id_importador int not null auto_increment primary key,
    nombre varchar(50),
    direccion varchar(50),
    telefono varchar(40)
);

create table facturas(
	id_factura int not null auto_increment primary key,
    fecha date,
    numero varchar(40),
    id_importador int not null,
    foreign key fk_importador(id_importador) references importadores(id_importador)
    on delete cascade
    on update cascade
);

create table componentes(
	id_componente int not null auto_increment primary key,
    nombre varchar(50),
	tipo varchar(50),
    descripcion varchar(50)
);

create table detalle_facturas(
	id_factura int,
    id_componente int not null,
	cantidad int,
    precio_unitario DECIMAL(10,2),
    primary key (id_factura, id_componente),
    foreign key id_factura_detalle(id_factura) references facturas(id_factura),
    foreign key id_componente_detalle(id_componente) references componentes(id_componente)
	on delete cascade
    on update cascade
);

create table operarios(
	id_operario int not null auto_increment primary key,
    nombre varchar(50),
    dni int not null unique,
    especialidad varchar(50)
);

create table hoja_de_confecciones(
	id_hoja int not null auto_increment primary key,
    id_operario int not null,
    id_componente int not null,
    fecha date,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    foreign key id_operario_hoja(id_operario) references operarios(id_operario),
    foreign key id_componente_hoja(id_componente) references componentes(id_componente)
    on delete cascade
    on update cascade
);

create table televisores(
	id_televisor int not null auto_increment primary key,
    modelo varchar(50),
    descripcion varchar(50)
);

create table mapa_de_armados(
	id_mapa int not null auto_increment primary key,
    id_televisor int not null,
    id_componente int not null,
    orden_pieza varchar(50),
    ubicacion varchar(50),
    foreign key id_mapa_televisor(id_televisor) references televisores(id_televisor),
    foreign key id_mapa_componente(id_componente) references componentes(id_componente)
    on delete cascade
    on update cascade
);

INSERT INTO importadores (nombre, direccion, telefono) VALUES
('Importadora Sur', 'Av. Siempre Viva 123', '1122334455'),
('Electronica Patagonica', 'Calle Falsa 456', '2233445566');

INSERT INTO facturas (fecha, numero, id_importador) VALUES
('2024-01-10', 1001, 1),
('2024-01-15', 1002, 1),
('2024-02-01', 1003, 2);

INSERT INTO componentes (nombre, tipo, descripcion) VALUES
('Pantalla LED', 'Comprado', 'Pantalla 42 pulgadas'),
('Placa Madre', 'Fabricado', 'Control principal'),
('Fuente de Poder', 'Comprado', 'Fuente 220V'),
('Control Remoto', 'Fabricado', 'Dispositivo control');

INSERT INTO detalle_facturas (id_factura, id_componente, cantidad, precio_unitario) VALUES
(1, 1, 10, 50000.00),
(1, 3, 5, 20000.00),
(2, 1, 8, 48000.00),
(3, 3, 6, 21000.00);

INSERT INTO operarios (nombre, dni, especialidad) VALUES
('Juan Perez', 30111222, 'Electronica'),
('Maria Gomez', 28999888, 'Montaje'),
('Carlos Lopez', 31555666, 'Soldadura');


INSERT INTO hoja_de_confecciones (id_operario, id_componente, fecha, cantidad) VALUES
(1, 2, '2024-01-05', 20),
(2, 4, '2024-01-06', 15),
(1, 2, '2024-01-10', 25),
(3, 4, '2024-01-08', 10);

INSERT INTO televisores (modelo, descripcion) VALUES
('TV-42-A', 'Televisor 42 pulgadas HD'),
('TV-50-B', 'Televisor 50 pulgadas Full HD');

INSERT INTO mapa_de_armados (id_televisor, id_componente, orden_pieza, ubicacion) VALUES
(1, 1, '1', 'Frontal'),
(1, 2, '2', 'Interno'),
(1, 3, '3', 'Trasero'),
(2, 1, '1', 'Frontal'),
(2, 2, '2', 'Interno'),
(2, 4, '3', 'Accesorio');

SELECT 
    f.id_factura,
    f.numero,
    i.nombre AS importador,
    c.nombre AS componente,
    df.cantidad,
    df.precio_unitario
FROM facturas f
JOIN importadores i 
    ON f.id_importador = i.id_importador
JOIN detalle_facturas df 
    ON f.id_factura = df.id_factura
JOIN componentes c 
    ON df.id_componente = c.id_componente;
    
    SELECT 
    o.nombre AS operario,
    c.nombre AS componente,
    h.fecha,
    h.cantidad
FROM hoja_de_confecciones h
JOIN operarios o 
    ON h.id_operario = o.id_operario
JOIN componentes c 
    ON h.id_componente = c.id_componente;