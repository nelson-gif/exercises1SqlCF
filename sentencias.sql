DROP DATABASE IF EXISTS libreria_cf;
CREATE DATABASE IF NOT EXISTS libreria_cf;

USE libreria_cf;

CREATE TABLE IF NOT EXISTS autores(
  autor_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(25) NOT NULL,
  apellido VARCHAR(25) NOT NULL,
  seudonimo VARCHAR(50) UNIQUE,
  genero ENUM('M', 'F'),
  fecha_nacimiento DATE NOT NULL,
  pais_origen VARCHAR(40) NOT NULL,
  fecha_creacion DATETIME DEFAULT current_timestamp
);

CREATE TABLE libros(
  libro_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  autor_id INT UNSIGNED NOT NULL,
  titulo varchar(50) NOT NULL,
  descripcion varchar(250) NOT NULL DEFAULT '',
  paginas INTEGER UNSIGNED NOT NULL DEFAULT 0,
  fecha_publicacion Date NOT NUll,
  fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (autor_id) REFERENCES autores(autor_id) ON DELETE CASCADE
);

CREATE TABLE usuarios(
  usuario_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  nombre varchar(25) NOT NULL,
  apellidos varchar(25),
  username varchar(25) NOT NULL,
  email varchar(50) NOT NULL,
  fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE libros ADD ventas INT UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE libros ADD stock INT UNSIGNED DEFAULT 10;

INSERT INTO autores (nombre, apellido, seudonimo, fecha_nacimiento, genero, pais_origen )
  VALUES ('Stephen Edwin', 'King', 'Richard Bachman', '1947-09-27', 'M', 'USA'),
         ('Joanne', 'Rowling', 'J.K Rowling', '1947-09-27', 'F', 'Reino unido'),
         ('Daniel', 'Brown',  NULL, '1964-06-22', 'M', 'USA'),
         ('John', 'Katzenbach ', NULL,'1950-06-23', 'M', 'USA'),
         ('John Ronald', 'Reuel Tolkien', NULL, '1892-01-03', 'M', 'Reino unido'),
         ('Miguel', 'de Unamuno', NULL, '1892-01-03', 'M', 'USA'),
         ('Arturo', 'Pérez Reverte', NULL, '1951-11-25', 'M', 'España'),
         ('George Raymond', 'Richard Martin', NULL, '1948-09-20', 'M', 'USA');

INSERT INTO libros(autor_id, titulo, fecha_publicacion, ventas, paginas)
VALUES (1, 'Carrie','1974-01-01',55,46645),
      (1, 'El misterio de Salmes Lot','1975-01-01',66,5641),
      (1, 'El resplando','1977-01-01',155,635),
      (1, 'Rabia','1977-01-01',88,540),
      (1, 'El umbral de la noche','1978-01-01',45,52),
      (1, 'La danza de la muerte','1978-01-01',66,866),
      (1, 'La larga marcha','1979-01-01',85,2645),
      (1, 'La zona muerta','1979-01-01',635,245),
      (1, 'Ojos de fuego','1980-01-01',64,862),
      (1, 'Cujo','1981-01-01',641,2645),
      (1, 'La torre oscura 1 El pistolero','1982-01-01',687,567),
      (1, 'La torre oscura 2 La invocación','1987-01-01',354,5302),
      (1, 'Apocalipsis','1990-01-01',1354,7502),
      (1, 'La torre oscura 3 Las tierras baldías','1991-01-01',564,57),
      (1, 'La torre oscura 4 Bola de cristal','1997-01-01',65847,8502),
      (1, 'La torre oscura 5 Los de Calla','2003-01-01',564,75602),
      (1, 'La torre oscura 6 La torre oscura','2004-01-01',3564,6850),
      (1, 'La torre oscura 7 Canción de Susannah','2004-01-01',35647,650),
      (1, 'La niebla','1981-01-01',54,560),

      (2, 'Harry Potter y la Piedra Filosofal', '1997-06-30',56,57610),
      (2, 'Harry Potter y la Cámara Secreta', '1998-07-2',68,450),
      (2, 'Harry Potter y el Prisionero de Azkaban','1999-07-8',687,653),
      (2, 'Harry Potter y el Cáliz de Fuego','2000-03-20',54,750),
      (2, 'Harry Potter y la Orden del Fénix','2003-06-21',230,863),
      (2, 'Harry Potter y el Misterio del Príncipe','2005-06-16',450,650),
      (2, 'Harry Potter y las Reliquias de la Muerte','2007-07-21',2054,650),

      (3, 'Origen', '2017-01-01',1420,570),
      (3, 'Inferno', '2013-01-01',5302,471),
      (3, 'El simbolo perdido', '2009-01-01',20,863),
      (3, 'El código Da Vinci', '2006-01-01',554,4561),
      (3, 'La consipiración', '2003-01-01',5425,685),

      (4, 'Al calor del verano', '1982-01-01',2145,5674),
      (4, 'Un asunto pendiente', '1987-01-01',214,645),
      (4, 'Juicio Final', '1992-01-01',5240,546),
      (4, 'La sombra', '1995-01-01',2457,6845),
      (4, 'Juego de ingenios', '1997-01-01',425,786),
      (4, 'El psicoanalista', '2002-01-01',21,564),
      (4, 'La historia del loco', '2004-01-01',2452,54),
      (4, 'El hombre equivocado', '2006-01-01',5423,57),
      (4, 'El estudiante', '2014-01-01',542,68),

      (5, 'El hobbit','1937-01-01',120,456),
      (5, 'Las dos torres','1954-01-01',210,648),
      (5, 'El señor de los anillos','1954-01-01',54,54),
      (5, 'La comunidad del anillo','1954-01-01',521,54),
      (5, 'El retorno del rey','1955-01-01',542,648),

      (6, 'La niebla','1914-01-01',201,546),

      (7, 'Eva','2017-01-01',520,68),
      (7, 'Falcó','2016-01-01',5241,98),
      (7, 'Hombre buenos','2015-01-01',6530,684),
      (7, 'Los barcos se pierden en tierra','2011-01-01',4520,987),

      (8, 'Juego de tronos','1996-08-01',542,658),
      (8, 'Choque de reyes','1998-11-16',52,57),
      (8, 'Tormenta de espadas','2005-10-17',56,6987),
      (8, 'Festin de cuervos','2011-07-12',56,684),
      (8, 'Danza de dragones','2011-07-12',523,57);


INSERT INTO usuarios (nombre, apellidos, username, email)
VALUES  ('Eduardo', 'García', 'eduardogpg', 'eduardo@codigofacilito.com'),
        ('Codi1', 'Facilito', 'codigofacilito', 'ayuda@codigofacilito.com'),
        ('Codi2', 'Facilito', 'codigofacilito', 'ayuda@codigofacilito.com'),
        ('Codi3', 'Facilito', 'codigofacilito', 'ayuda@codigofacilito.com');

DESC autores;
DESC libros;
DESC usuarios;