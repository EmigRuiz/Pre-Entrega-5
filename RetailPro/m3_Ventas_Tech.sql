--Creamos las tablas--
CREATE TABLE dbo.categorias(
  id_categoria INT NOT NULL PRIMARY KEY,
  nombre_categoria VARCHAR(50) NOT NULL UNIQUE,
  descripcion VARCHAR(200)
);

CREATE TABLE dbo.territorios(
    id_territorio INT NOT NULL PRIMARY KEY,
    ciudad VARCHAR(50) NOT NULL UNIQUE,
    pais VARCHAR (50) NOT NULL,
    region VARCHAR (50) NULL
);


CREATE TABLE dbo.clientes(
    id_cliente INT NOT NULL PRIMARY KEY,
    nombre_cliente VARCHAR (100) NOT NULL,
    email VARCHAR (100) UNIQUE,
    id_territorio INT NULL,
    segmento VARCHAR (50) NULL,
    fecha_registro DATE NOT NULL,
    CONSTRAINT FK_clientes_territorios FOREIGN KEY (id_territorio)
        REFERENCES dbo.territorios(id_territorio)
);


CREATE TABLE dbo.productos(
  id_producto INT NOT NULL PRIMARY KEY,
  nombre_producto VARCHAR (100) NOT NULL,
  categoria VARCHAR (50) NULL,
  subcategoria VARCHAR (50) NULL,
  precio NUMERIC (10,2)  NULL,
  costo NUMERIC (10,2) NULL,
  stock INT DEFAULT 0,
  activo TINYINT DEFAULT 1,
  CONSTRAINT FK_productos_categorias FOREIGN KEY (categoria)
        REFERENCES dbo.categorias(nombre_categoria)
);


CREATE TABLE dbo.ventas(
    id_venta INT NOT NULL PRIMARY KEY,
    fecha_venta DATE NOT NULL,
    id_cliente INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario NUMERIC(10,2) NOT NULL,
    descuento NUMERIC(5,2) NOT NULL DEFAULT 0,
    total_venta NUMERIC(10,2) NOT NULL,
    canal VARCHAR(20) NOT NULL,
    CONSTRAINT FK_ventas_clientes FOREIGN KEY (id_cliente) REFERENCES dbo.clientes(id_cliente),
    CONSTRAINT FK_ventas_productos FOREIGN KEY (id_producto) REFERENCES dbo.productos(id_producto)
);




--- INSERTAR DATA
--- Territorios
INSERT INTO dbo.territorios (id_territorio, ciudad, pais, region) VALUES
(1, 'Buenos Aires', 'Argentina', 'Cono Sur'),
(2, 'Córdoba', 'Argentina', 'Cono Sur'),
(3, 'Santiago', 'Chile', 'Cono Sur'),
(4, 'Montevideo', 'Uruguay', 'Cono Sur'),
(5, 'Rosario', 'Argentina', 'Cono Sur'),
(6, 'Lima', 'Perú', 'Región Andina'),
(7, 'Bogotá', 'Colombia', 'Región Andina'),
(8, 'Mendoza', 'Argentina', 'Cono Sur'),
(9, 'Asunción', 'Paraguay', 'Cono Sur'),
(10, 'Río de Janeiro', 'Brasil', 'Sudeste de Brasil'),
(11, 'Caracas', 'Venezuela', 'Región Andina');

SELECT * FROM dbo.territorios


--- Categorias
INSERT INTO dbo.categorias VALUES (1, 'Computación', 'Laptops, PCs y monitores');
INSERT INTO dbo.categorias VALUES (2, 'Accesorios', 'Periféricos y complementos');
INSERT INTO dbo.categorias VALUES (3, 'Audio', 'Auriculares y parlantes');
INSERT INTO dbo.categorias VALUES (4, 'Almacenamiento', 'Discos y memorias');

SELECT * FROM dbo.categorias

--- Clientes
INSERT INTO dbo.clientes (id_cliente, nombre_cliente, email, id_territorio, segmento, fecha_registro) VALUES
(1, 'María López',   'maria@mail.com', 1, 'Retail', '2024-01-05'),
(2, 'Carlos Ruiz',   'carlos@mail.com', 2, 'Corporativo', '2024-02-10'),
(3, 'Ana Gómez',     'ana@mail.com', 3, 'Retail', '2024-03-01'),
(4, 'Pedro Sanz',    'pedro@mail.com', 4, 'Corporativo', '2024-04-15'),
(5, 'Laura Torres',  'laura@mail.com', 5, 'Retail',    '2024-05-01'),
(6, 'Diego Mora',  'diego@mail.com', 6, 'Mayorista', '2024-06-15'),
(7, 'Ludmila Saracho', 'lidmila@mail.com', 7, 'Retail', '2024-07-04'),
(8, 'Martín Giménez', 'martin@mail.com', 8, 'Corporativo', '2024-08-06'),
(9, 'Sergio Gonzalez', 'sergio@mail.com', 9, 'Retail', '2024-09-02'),
(10, 'Abril Cisneros', 'abril@mail.com', 1, 'Mayorista', '2024-10-19'),
(11, 'Roberto Díaz', 'roberto@mail.com', NULL, 'Retail', '2024-11-03'),
(12, 'Silvia Gómez', 'silvia@mail.com', 8, 'Mayorista', '2024-12-15');


--- Productos
INSERT INTO dbo.productos(id_producto, nombre_producto, categoria, subcategoria, precio, costo, stock, activo) VALUES
(101, 'Laptop Pro 15', 'Computación', 'Laptops', 1200, 850, 15, 1),
(102, 'Mouse Inalámbrico', 'Accesorios', 'Periféricos', 28, 12, 80, 1),
(103, 'Monitor 4K 27"', 'Computación', 'Monitores', 450, 300, 12, 1),
(104, 'Teclado Mecánico', 'Accesorios', 'Periféricos', 95, 48, 40, 1),
(105, 'Laptop Basic 14', 'Computación', 'Laptops', 650, 420, 20, 1),
(106, 'Auriculares BT Pro', 'Audio', 'Auriculares', 120, 62, 35, 1),
(107, 'Hub USB-C 7p', 'Accesorios', 'Periféricos', 45, 20, 60, 1),
(108, 'Webcam HD 1080p', 'Accesorios', 'Periféricos', 85, 42, 25, 1),
(109, 'SSD Externo 1TB', 'Almacenamiento', 'Discos', NULL, 75, 18, 1),
(110, 'Parlante Bluetooth', 'Audio', 'Parlantes', 60, 28, 45, 1),
(111, 'Laptop Gaming Pro', 'Computación', 'Laptops', 1800, 1350, 8, 1),
(112, 'Pad Mouse XL', 'Accesorios', 'Periféricos', 22, 8, 0, 0);


--- Ventas
INSERT INTO dbo.ventas (id_venta, fecha_venta, id_cliente, id_producto, cantidad, precio_unitario, descuento, total_venta, canal) VALUES
(1000, '2024-01-08', 1, 101, 1, 1200, 0, 1200, 'Online'),
(1001, '2024-01-15', 2, 102, 2, 28, 0, 56, 'Presencial'),
(1002, '2024-01-22', 3, 103, 1, 450, 0.05, 427.50, 'Online'),
(1003, '2024-02-03', 4, 104, 2, 95, 0.10, 171, 'Presencial'),
(1004, '2024-02-11', 5, 105, 1, 650, 0, 650, 'Online'),
(1005, '2024-02-19', 6, 106, 2, 120, 0.05, 228, 'Presencial'),
(1006, '2024-02-27', 7, 107, 3, 45, 0, 135, 'Online'),
(1007, '2024-03-05', 8, 108, 1, 85, 0.10, 76.50, 'Presencial'),
(1008, '2024-03-12', 9, 110, 2, 60, 0, 120, 'Online'),
(1009, '2024-03-20', 10, 111, 1, 1800, 0.05, 1710, 'Presencial'),
(1010, '2024-04-02', 11, 101, 1, 1200, 0.10, 1080, 'Online'),
(1011, '2024-04-10', 12, 102, 4, 28, 0, 112, 'Presencial'),
(1012, '2024-04-18', 1, 103, 2, 450, 0.05, 855, 'Online'),
(1013, '2024-04-25', 2, 104, 1, 95, 0, 95, 'Presencial'),
(1014, '2024-05-03', 3, 105, 2, 650, 0.10, 1170, 'Online'),
(1015, '2024-05-11', 4, 106, 1, 120, 0, 120, 'Presencial'),
(1016, '2024-05-19', 5, 107, 2, 45, 0.05, 85.50, 'Online'),
(1017, '2024-05-27', 6, 108, 3, 85, 0, 255, 'Presencial'),
(1018, '2024-06-04', 7, 110, 2, 60, 0.10, 108, 'Online'),
(1019, '2024-06-12', 8, 111, 1, 1800, 0, 1800, 'Presencial'),
(1020, '2024-06-20', 9, 101, 2, 1200, 0.05, 2280, 'Online'),
(1021, '2024-06-28', 10, 102, 5, 28, 0, 140, 'Presencial'),
(1022, '2024-07-06', 11, 103, 1, 450, 0.10, 405, 'Online'),
(1023, '2024-07-14', 12, 104, 2, 95, 0.05, 180.50, 'Presencial'),
(1024, '2024-07-22', 1, 105, 1, 650, 0, 650, 'Online'),
(1025, '2024-07-30', 2, 106, 3, 120, 0.10, 324, 'Presencial'),
(1026, '2024-08-07', 3, 107, 2, 45, 0, 90, 'Online'),
(1027, '2024-08-15', 4, 108, 1, 85, 0.05, 80.75, 'Presencial'),
(1028, '2024-08-23', 5, 110, 4, 60, 0, 240, 'Online'),
(1029, '2024-08-31', 6, 111, 1, 1800, 0.10, 1620, 'Presencial'),
(1030, '2024-09-08', 7, 101, 1, 1200, 0, 1200, 'Online'),
(1031, '2024-09-16', 8, 102, 3, 28, 0.05, 79.80, 'Presencial'),
(1032, '2024-09-24', 9, 103, 2, 450, 0, 900, 'Online'),
(1033, '2024-10-02', 10, 104, 1, 95, 0.10, 85.50, 'Presencial'),
(1034, '2024-10-10', 11, 105, 2, 650, 0.05, 1235, 'Online'),
(1035, '2024-10-18', 12, 106, 1, 120, 0, 120, 'Presencial'),
(1036, '2024-10-26', 1, 107, 3, 45, 0.10, 121.50, 'Online'),
(1037, '2024-11-03', 2, 108, 2, 85, 0.05, 161.50, 'Presencial'),
(1038, '2024-11-11', 3, 110, 1, 60, 0, 60, 'Online'),
(1039, '2024-11-19', 4, 111, 1, 1800, 0.05, 1710, 'Presencial'),
(1040, '2024-11-27', 5, 101, 2, 1200, 0.10, 2160, 'Online'),
(1041, '2024-12-01', 6, 102, 6, 28, 0, 168, 'Presencial'),
(1042, '2024-12-05', 7, 103, 1, 450, 0.05, 427.50, 'Online'),
(1043, '2024-12-09', 8, 104, 2, 95, 0, 190, 'Presencial'),
(1044, '2024-12-12', 9, 105, 1, 650, 0.10, 585, 'Online'),
(1045, '2024-12-15', 10, 106, 2, 120, 0.05, 228, 'Presencial'),
(1046, '2024-12-18', 11, 107, 4, 45, 0, 180, 'Online'),
(1047, '2024-12-21', 12, 108, 2, 85, 0.10, 153, 'Presencial'),
(1048, '2024-12-27', 1, 110, 3, 60, 0.05, 171, 'Online'),
(1049, '2024-12-30', 2, 111, 1, 1800, 0, 1800, 'Presencial');
