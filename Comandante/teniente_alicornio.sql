CREATE DATABASE teniente_alicornio;

USE teniente_alicornio;

CREATE TABLE productos (
  cod_producto varchar(10) NOT NULL,
  nombre_producto varchar(45) NOT NULL,
  valor_producto decimal(10,2) NOT NULL,
  desc_producto varchar(45) NOT NULL,
  stock_producto int(11) NOT NULL,
  fk_tipo_prod varchar(20) NOT NULL,
  PRIMARY KEY(cod_producto)
);

CREATE TABLE tipo_producto (
  tipo_prod varchar(40) NOT NULL,
  estado_prod tinyint(1) NOT NULL,
  PRIMARY KEY(tipo_prod)
);

CREATE TABLE tipo_documento (
  tdoc varchar(10) NOT NULL,
  desc_tdoc varchar(30) NOT NULL,
  estado_tdoc tinyint(1) NOT NULL,
  PRIMARY KEY(tdoc)
);

CREATE TABLE persona (
  pk_fk_tdoc varchar(10) NOT NULL,
  id_persona int(11) NOT NULL,
  nom_persona varchar(25) NOT NULL,
  nom_persona2 varchar(20) NOT NULL,
  apellido_persona varchar(25) NOT NULL,
  direccion_persona varchar(45) NOT NULL,
  PRIMARY KEY(pk_fk_tdoc, id_persona),
  FOREIGN KEY (pk_fk_tdoc) REFERENCES tipo_documento(tdoc)
);

CREATE TABLE persona_has_roles (
  persona_tdoc varchar(10) NOT NULL,
  persona_id int(11) NOT NULL,
  persona_rol int(11) NOT NULL,
  estado_rol tinyint(1) NOT NULL
  PRIMARY KEY(persona_tdoc,persona_id,persona_rol),
  FOREIGN KEY(persona_tdoc,persona_id) REFERENCES persona(pk_fk_tdoc, id_persona),
  FOREIGN KEY(persona_rol) REFERENCES roles(cod_rol)
);

CREATE TABLE roles (
  cod_rol int(11) NOT NULL,
  desc_rol varchar(30) NOT NULL,
  PRIMARY KEY (cod_rol)
);

CREATE TABLE empleado (
  tdoc_empleado varchar(10) NOT NULL,
  id_empleado int(11) NOT NULL,
  nombre varchar(50) NOT NULL,
  apellido varchar(50) NOT NULL,
  puesto varchar(50) NOT NULL,
  sueldo_empleado decimal(10,2) NOT NULL,
  fecha_contratacion date NOT NULL,
  direccion varchar(100) NOT NULL,
  telefono varchar(15) NOT NULL,
  email varchar(50) NOT NULL,
  PRIMARY KEY(id_empleado,tdoc_empleado),
  FOREIGN KEY(tdoc_empleado,id_empleado) REFERENCES persona(pk_fk_tdoc, id_persona)
);

CREATE TABLE proveedor (
  tdoc_proveedor varchar(10) NOT NULL,
  id_proveedor int(11) NOT NULL,
  nombre_empresa varchar(100) NOT NULL,
  contacto_nombre varchar(50) NOT NULL,
  contacto_telefono varchar(15) NOT NULL,
  contacto_email varchar(50) NOT NULL,
  direccion varchar(100) NOT NULL,
  PRIMARY KEY(id_proveedor,tdoc_proveedor),
  FOREIGN KEY(tdoc_proveedor,id_proveedor) REFERENCES persona(pk_fk_tdoc, id_persona)
);

CREATE TABLE cliente (
  tdoc_cliente varchar(10) NOT NULL,
  id_cliente int(11) NOT NULL,
  nombre varchar(50) NOT NULL,
  apellido varchar(50) NOT NULL,
  direccion varchar(100) NOT NULL,
  telefono varchar(15) NOT NULL,
  email varchar(50) NOT NULL,
  PRIMARY KEY (id_cliente,tdoc_cliente),
  FOREIGN KEY(tdoc_cliente,id_cliente) REFERENCES persona(pk_fk_tdoc, id_persona)
);

CREATE TABLE factura_productos (
  fk_pk_n_factura int(11) NOT NULL,
  fk_pk_cod_producto varchar(10) NOT NULL,
  cantidad_prod int(11) NOT NULL,
  valor_prod_cant decimal(10,2) NOT NULL
  PRIMARY KEY (fk_pk_n_factura,fk_pk_cod_producto),
  FOREIGN KEY(fk_pk_n_factura) REFERENCES factura(n_factura),
  FOREIGN KEY(fk_pk_cod_producto) REFERENCES productos(cod_producto)
);

CREATE TABLE factura (
  n_factura int(11) NOT NULL,
  fecha_factura date NOT NULL,
  subtotal decimal(10,2) NOT NULL,
  iva decimal(10,2) NOT NULL,
  total_factura decimal(10,2) NOT NULL,
  PRIMARY KEY(n_factura)
);

CREATE TABLE factura_compra (
  n_factura_comp int(11) NOT NULL,
  empleado_tdoc varchar(10) NOT NULL,
  empleado_id int(11) NOT NULL,
  proveedor_tdoc varchar(10) NOT NULL,
  proveedor_id int(11) NOT NULL,
  PRIMARY KEY(n_factura_comp),
  FOREIGN KEY(empleado_tdoc,empleado_id) REFERENCES empleado(tdoc_empleado,id_empleado),
  FOREIGN KEY(proveedor_tdoc,proveedor_id) REFERENCES proveedor(tdoc_proveedor, id_proveedor)
);

CREATE TABLE factura_venta (
  n_factura_vent int(11) NOT NULL,
  cliente_tdoc varchar(10) NOT NULL,
  cliente_id int(11) NOT NULL,
  empleado_tdoc_v varchar(10) NOT NULL,
  empleado_id_v int(11) NOT NULL,
  PRIMARY KEY(n_factura_vent),
  FOREIGN KEY(cliente_tdoc,cliente_id) REFERENCES cliente(tdoc_cliente, id_cliente)
);

ALTER TABLE factura_venta ADD FOREIGN KEY(empleado_tdoc_v, empleado_id_v) REFERENCES empleado(tdoc_empleado,id_empleado);

ALTER TABLE factura_venta ADD FOREIGN KEY(n_factura_vent) REFERENCES factura(n_factura);

INSERT INTO cliente (tdoc_cliente, id_cliente, nombre, apellido, direccion, telefono, email) VALUES
('CE', 1, 'Carlos', 'Ramirez', 'Calle 45', '3187654321', 'carlos@example'),
('DNI', 2, 'Sofia', 'Lopez', 'Calle 30', '3157894562', 'sofia@example'),
('NI', 4, 'Luis', 'Fernandez', 'Calle 25', '3171234567', 'luis@example'),
('NIT', 5, 'Laura', 'Hernandez', 'Calle 55', '3129876543', 'laura@example'),
('OTR', 6, 'David', 'Perez', 'Calle 70', '3145678901', 'david@example'),
('PA', 7, 'Sara', 'Martinez', 'Calle 40', '3106789012', 'sara@example'),
('PAS', 8, 'Raul', 'Cruz', 'Calle 65', '3164567890', 'raul@example'),
('PP', 9, 'Katherine', 'Garcia', 'Calle 15', '3199876543', 'katherine@example'),
('RC', 10, 'Javier', 'Rojas', 'Calle 10', '3178765432', 'javier@example'),
('RUT', 11, 'Marly', 'Gomez', 'Calle 85', '3186543210', 'marly@example'),
('TI', 12, 'Sandra', 'Perez', 'Calle 28', '3123456789', 'sandra@example'),
('TIE', 13, 'Juan', 'Gutierrez', 'Calle 50', '3101234567', 'juan@example'),
('CC', 14, 'Daniel', 'Andres', 'Calle 75 ', '3208143928', 'danii@example'),
('TA', 15, 'Luis', 'Prieto', 'Calle 50', '6445975', 'luss@example'),
('TIA', 16, 'Dilan', 'Guevara', 'Calle 12', '2145645', 'teniente.comandante@example');

INSERT INTO empleado (tdoc_empleado, id_empleado, nombre, apellido, puesto, sueldo_empleado, fecha_contratacion, direccion, telefono, email) VALUES
('CE', 1, 'Carlos', 'Ramirez', 'Vendedor', 1200000.00, '2019-07-10', 'Calle 30', '3112345678', 'carlos@example'),
('DNI', 2, 'Sofia', 'Lopez', 'Vendedor', 1100000.00, '2021-01-05', 'Calle 45', '3187654321', 'sofia@example'),
('NI', 4, 'Luis', 'Fernandez', 'Cajero', 1300000.00, '2018-05-12', 'Calle 25', '3171234567', 'luis@example'),
('NIT', 5, 'Laura', 'Hernandez', 'Cajero', 1350000.00, '2019-11-28', 'Calle 55', '3129876543', 'laura@example'),
('OTR', 6, 'David', 'Perez', 'Reponedor', 1100000.00, '2020-03-08', 'Calle 70', '3145678901', 'david@example'),
('PA', 7, 'Sara', 'Martinez', 'Reponedor', 1000000.00, '2022-04-14', 'Calle 40', '3106789012', 'sara@example'),
('PAS', 8, 'Raul', 'Cruz', 'Mensajero', 900000.00, '2021-08-30', 'Calle 65', '3164567890', 'raul@example'),
('PP', 9, 'Katherine', 'Garcia', 'Mensajero', 950000.00, '2018-06-25', 'Calle 15', '3199876543', 'katherine@example'),
('RC', 10, 'Javier', 'Rojas', 'Limpieza', 850000.00, '2019-03-17', 'Calle 10', '3178765432', 'javier@example'),
('RUT', 11, 'Marly', 'Gomez', 'Limpieza', 880000.00, '2020-12-05', 'Calle 85', '3186543210', 'marly@example'),
('TI', 12, 'Sandra', 'Perez', 'Cajero', 1400000.00, '2021-11-10', 'Calle 28', '3123456789', 'sandra@example'),
('TIE', 13, 'Juan', 'Gutierrez', 'Reponedor', 1050000.00, '2017-09-01', 'Calle 50', '3101234567', 'juan@example'),
('CC', 14, 'Daniel', 'Andres', 'Cliente', 1500000.00, '2017-06-20', 'Calle 75 ', '3208143928', 'danii@example'),
('TA', 15, 'Luis', 'Prieto', 'Cliente', 896465.00, '2017-09-01', 'Calle 50', '6445975', 'luss@example'),
('TIA', 16, 'Dilan', 'Guevara', 'Proveedor', 400000.00, '2017-09-01', 'Calle 12', '2145645', 'teniente.comandante@example');

INSERT INTO factura (n_factura, fecha_factura, subtotal, iva, total_factura) VALUES
(1, '2016-09-01', 20000.00, 19.00, 12000.00),
(2, '2017-09-06', 40000.00, 19.00, 32000.00),
(3, '2018-07-03', 35000.00, 19.00, 27000.00),
(4, '2019-06-04', 40000.00, 19.00, 32000.00),
(5, '2016-05-05', 55000.00, 19.00, 44000.00),
(6, '2017-04-06', 60000.00, 19.00, 52000.00),
(7, '2018-03-07', 75000.00, 19.00, 67000.00),
(8, '2019-02-08', 90000.00, 19.00, 82000.00),
(9, '2016-01-09', 200000.00, 19.00, 12000.00),
(10, '2017-09-10', 21300.00, 19.00, 19600.00),
(11, '2018-12-11', 254000.00, 19.00, 246000.00),
(12, '2019-11-12', 24000.00, 19.00, 18000.00),
(13, '2016-01-19', 430000.00, 19.00, 142000.00),
(14, '2017-09-02', 40900.00, 19.00, 72000.00),
(15, '2018-08-03', 410000.00, 19.00, 95000.00);

INSERT INTO factura_compra (n_factura_comp, empleado_tdoc, empleado_id, proveedor_tdoc, proveedor_id) VALUES
(1, 'CC', 14, 'CC', 14),
(2, 'CE', 1, 'CE', 1),
(3, 'DNI', 2, 'DNI', 2),
(4, 'NI', 4, 'NI', 4);

INSERT INTO factura_productos (fk_pk_n_factura, fk_pk_cod_producto, cantidad_prod, valor_prod_cant) VALUES
(1, '02', 3, 12000.00),
(2, '04', 3, 14000.00),
(3, '06', 3, 16000.00),
(4, '08', 3, 18000.00),
(5, '01', 4, 20000.00),
(6, '03', 4, 22000.00),
(7, '05', 4, 26000.00),
(8, '07', 4, 28000.00),
(9, '09', 5, 30000.00),
(10, '10', 5, 32000.00),
(11, '11', 5, 34000.00),
(12, '12', 5, 36000.00);

INSERT INTO factura_venta (n_factura_vent, cliente_tdoc, cliente_id, empleado_tdoc_v, empleado_id_v) VALUES
(1, 'CC', 14, 'CC', 14),
(2, 'CE', 1, 'CE', 1),
(3, 'DNI', 2, 'DNI', 2),
(4, 'NI', 4, 'NI', 4),
(5, 'NIT', 5, 'NIT', 5),
(6, 'OTR', 6, 'OTR', 6),
(7, 'PA', 7, 'PA', 7),
(8, 'PAS', 8, 'PAS', 8),
(9, 'PP', 9, 'PP', 9),
(10, 'RC', 10, 'RC', 10),
(11, 'RUT', 11, 'RUT', 11),
(12, 'TI', 12, 'TI', 12),
(13, 'TIE', 13, 'TIE', 13),
(14, 'CC', 14, 'CC', 14),
(15, 'TIE', 13, 'TIE', 13);

INSERT INTO persona (pk_fk_tdoc, id_persona, nom_persona, nom_persona2, apellido_persona, direccion_persona) VALUES
('CC', 14, 'PEDRO', 'JOSE ', 'LINARES', 'AK 7 #2-17'),
('CE', 1, 'JUAN PABLO', 'PABLO', 'RODRIGUEZ', 'CALLE 47 #20A'),
('DNI', 2, 'CARLOS ', ' ANDRES', 'RODRIGUEZ', 'AVENIDA 5 #15B'),
('LC', 3, 'CLAUDIA ', 'LILIANA', 'PEREZ', 'CALLE 10 #30C'),
('NI', 4, 'SOFIA', '', 'TORRES', 'CALLE 25 #18D'),
('NIT', 5, 'LEONARDO', '', 'PINEDA PEREZ', 'CALLE 12 #22E'),
('OTR', 6, 'LAURA ', ' LILIANA', 'PEREZ PINEDA', 'AVENIDA 3 #14F'),
('PA', 7, 'FABIAN', ' ANDRES', 'RODRIGUEZ', 'CALLE 8 #27G'),
('PAS', 8, 'CLAUDIA', '', 'MARTINEZ TORRES', 'AVENIDA 7 #21H'),
('PP', 9, 'LAURA ', 'ANDREA', 'SANCHEZ', 'CALLE 15 #10I'),
('RC', 10, 'DIANA MILENA', 'MILENA', 'TORRES TORRES', 'CALLE 22 #19J'),
('RUT', 11, 'JAVIER LEONARDO', 'LEONARDO', 'PINEDA URIBE', 'AVENIDA 2 #16K'),
('TA', 15, 'ANDERSON', '', 'CUBIDES', 'Calle 72'),
('TI', 12, 'MARLY', '', 'PEREZ', 'CALLE 6 #25L'),
('TIA', 16, 'BRAYAN', '', 'GUTIRERREZ', 'Calle 25'),
('TIE', 13, 'SANDRA', '', 'TORRES PERES', 'AVENIDA 4 #20M');

INSERT INTO persona_has_roles (persona_tdoc, persona_id, persona_rol, estado_rol) VALUES
('CC', 14, 1, -1),
('CE', 1, 2, -1),
('DNI', 2, 3, -1),
('LC', 3, 4, -1),
('NI', 4, 1, -1),
('NIT', 5, 2, -1),
('OTR', 6, 3, -1),
('PA', 7, 4, -1),
('PAS', 8, 1, -1),
('PP', 9, 2, -1),
('RC', 10, 3, -1),
('RUT', 11, 4, -1),
('TA', 15, 4, -1),
('TI', 12, 1, -1),
('TIE', 13, 2, -1);

INSERT INTO productos (cod_producto, nombre_producto, valor_producto, desc_producto, stock_producto, fk_tipo_prod) VALUES
('01', 'Manzanas', 25000.00, 'Manzanas frescas y deliciosas, ideales para m', 20, 'Seccion Frutas'),
('02', 'Naranjas', 30000.00, 'Naranjas cítricas y jugosas, llenas de vitami', 20, 'Seccion Frutas'),
('03', 'Batidos', 35000.00, 'Batidos naturales y nutritivos, perfectos par', 20, 'Seccion Snacks Salud'),
('04', 'Fresas', 40000.00, 'Fresas rojas, jugosas y llenas de sabor, rica', 20, 'Seccion Frutas'),
('05', 'Almendras', 45000.00, 'Almendras crujientes y saludables, cargadas d', 20, 'Seccion Frutos Secos'),
('06', 'Zanahorias', 50000.00, 'Zanahorias frescas y crujientes, una opción i', 20, 'Seccion Verduras'),
('07', 'Espinaca', 55000.00, 'Espinacas verdes y llenas de nutrientes, perf', 20, 'Seccion Verduras'),
('08', 'Tomate', 60000.00, 'Tomates jugosos y versátiles, excelentes para', 20, 'Seccion Verduras'),
('09', 'Pimiento', 65000.00, 'Pimientos frescos y coloridos, ideales para d', 20, 'Seccion Verduras'),
('10', 'Avena', 70000.00, 'Avena natural y saludable, ideal para prepara', 20, 'Seccion Catalogo Sal'),
('11', 'Aguacates', 75000.00, 'Aguacates cremosos y llenos de grasas saludab', 20, 'Seccion Catalogo Sal'),
('12', 'Nueces', 80000.00, 'Nueces crujientes y llenas de ácidos grasos o', 20, 'Seccion Catalogo Sal'),
('13', 'Salmón', 85000.00, 'Salmón fresco y rico en ácidos grasos omega-3', 20, 'Seccion Catalogo Sal'),
('14', 'Tofu', 90000.00, 'Tofu versátil y rico en proteínas, excelente ', 20, 'Seccion Catalogo Sal'),
('15', 'Perejil', 100000.00, 'Perejil fresco y aromático, ideal para condim', 20, 'Seccion Hierbas y Co');

INSERT INTO proveedor (tdoc_proveedor, id_proveedor, nombre_empresa, contacto_nombre, contacto_telefono, contacto_email, direccion) VALUES
('CE', 1, 'SURTIFRUVER', 'EVELYN ROCHA', '54321098', 'proveetienda@surti.co', 'calle 45'),
('DNI', 2, 'Cooratiendas', 'SARA SANCHEZ', '7678459', 'coorafurta@cooratiendas.co', 'Calle 75'),
('LC', 3, 'Fresh Delight ', 'Daniel Torres', '591446841', 'fresh@example', 'Calle 22'),
('NI', 4, 'Green Valley ', 'Luis Sanchez', '285156484', 'green@example', 'Calle 16'),
('NIT', 5, 'Fresh Market', 'Sara Soto', '565484851', 'gluglu@example', 'Calle 6'),
('OTR', 6, 'Organic Oasis ', 'David Prieto', '484562568', 'tienda.a@example', 'Calle 21'),
('PA', 7, 'Tropical Treasures', 'Santiago Gutierrez', '748748978', 'sasa@example', 'Calle 22'),
('PAS', 8, 'Fresh Aroma', 'Raul Sanchez', '245463652', 'arra@example', 'Calle 7'),
('PP', 9, 'Local Fresh', 'Katherine Gutierrez', '6596654', 'tete@example', 'Calle 33'),
('RC', 10, 'Community Harvest', 'Luis Zea Cañon', '59641554', 'luisz@example', 'Calle 213'),
('RUT', 11, 'Community Harvard', 'Luis Alfedo Sanchez', '59642554', 'luiz@example', 'Calle 244'),
('TI', 12, 'SURTIFRUVER BILBAO', 'EVELYN ROCHA', '54321098', 'proveetienda@surti.co', 'calle 145'),
('TIE', 13, 'World Produce', 'Darlin Suarez', '288741455', 'dada@example', 'Calle 50'),
('CC', 14, 'SURTIFRUVER', 'EVELYN ROCHA', '54321098', 'proveetienda@surti.co', 'calle 45'),
('TA', 15, 'Fruteria San Mateo', 'Leidy Gomez', '5845259325', 'leydidi@example', 'Calle 33');

INSERT INTO roles (cod_rol, desc_rol) VALUES
(1, 'Cliente'),
(2, 'Empleado'),
(3, 'Proveedor'),
(4, 'Vendedor');

INSERT INTO tipo_documento (tdoc, desc_tdoc, estado_tdoc) VALUES
('CC', 'Cédula de Ciudadanía', 1),
('CE', 'Cédula de Extrajería', 1),
('DNI', 'Documento Nacional de Identida', 1),
('LC', 'Licencia de Conducir', 1),
('NI', 'Número de Identificación', 1),
('NIT', 'Número de Identificación Tribu', 1),
('OTR', 'Otro Documento de Identidad', 1),
('PA', 'Partida de Nacimiento', 0),
('PAS', 'Pasaporte', 1),
('PP', 'Pasaporte', -2),
('RC', 'Registro Civil', 0),
('RUT', 'Registro Único Tributario', 1),
('TA', 'tarjeta de adopcion', -1),
('TI', 'Tarjeta Identidad ', 1),
('TIA', 'Tarjeta Identidad Aprobada', -1),
('TIE', 'Tarjeta de Identidad Extranjer', 1);

INSERT INTO tipo_producto (tipo_prod, estado_prod) VALUES
('Seccion Catalogo Saludable', -3),
('Seccion Frutas', -1),
('Seccion Frutos Secos', -5),
('Seccion Hierbas y Condimentos', -4),
('Seccion Snacks Saludables', -6),
('Seccion Verduras', -2);
