/*Libros
LIBROS
Obtener todos los libros escritos por autores que cuenten con un seudónimo.
*/
SELECT autor_id, titulo FROM libros 
WHERE autor_id IN (SELECT autor_id FROM autores WHERE seudonimo IS NOT NULL) ORDER BY autor_id ASC;

/*
Obtener el título de todos los libros publicados en el año actual (usare 2007 solo para obtener algunos datos) cuyos autores poseen un pseudónimo.
*/
SELECT autor_id, titulo, fecha_publicacion FROM libros 
WHERE autor_id IN (SELECT autor_id FROM autores WHERE seudonimo IS NOT NULL) 
        AND fecha_publicacion >= '2007-01-01' ORDER BY autor_id ASC;

/*
Obtener todos los libros escritos por autores que cuenten con un seudónimo y que hayan nacido ante de 1965.
*/
SELECT libros.autor_id, libros.titulo, autores.nombre, autores.fecha_nacimiento FROM libros, autores
WHERE libros.autor_id = autores.autor_id AND libros.autor_id IN (SELECT autores.autor_id FROM autores WHERE seudonimo IS NOT NULL) 
        AND autores.fecha_nacimiento <= '1965-01-01' ORDER BY libros.autor_id ASC;

/*
Colocar el mensaje no disponible a la columna descripción, en todos los libros publicados antes del año 2000.
*/
UPDATE libros SET descripcion = 'no disponible' 
WHERE fecha_publicacion < '2000-01-01';

/*
Obtener la llave primaria de todos los libros cuya descripción sea diferente de no disponible.
*/
SELECT libro_id, titulo, descripcion FROM libros
WHERE descripcion <> 'no disponible';

/*
Obtener el título de los últimos 3 libros escritos por el autor con id 2.
*/
SELECT autor_id ,titulo, fecha_publicacion FROM libros 
WHERE autor_id = 2 ORDER BY fecha_publicacion DESC LIMIT 3;

/*
Obtener en un mismo resultado la cantidad de libros escritos por autores con seudónimo y sin seudónimo./
*/
/* PARA ENTENDERLE MEJOR
SET @con_seudonimo = (SELECT count(titulo) AS con_seudonimo FROM libros 
WHERE autor_id IN (SELECT autor_id FROM autores WHERE seudonimo IS NOT NULL));

SET @sin_seudonimo = (SELECT count(titulo) AS con_seudonimo FROM libros 
WHERE autor_id IN (SELECT autor_id FROM autores WHERE seudonimo IS NULL));

SELECT @con_seudonimo AS con_seudonimo, @sin_seudonimo AS sin_seudonimo;
*/
SELECT (SELECT COUNT(titulo) AS con_seudonimo FROM libros 
        WHERE autor_id IN (SELECT autor_id FROM autores WHERE seudonimo IS NOT NULL)) 
AS con_seudonimo,
        (SELECT COUNT(titulo) AS con_seudonimo FROM libros 
        WHERE autor_id IN (SELECT autor_id FROM autores WHERE seudonimo IS NULL)) 
AS sin_seudonimo;

/*
Obtener la cantidad de libros publicados entre enero del año 2000 y enero del año 2005.
*/
SELECT COUNT(titulo) AS books_between FROM libros
WHERE fecha_publicacion BETWEEN '2000-01-01' AND '2005-01-01';

/*
Obtener el título y el número de ventas de los cinco libros más vendidos.
*/
SELECT titulo, ventas FROM libros ORDER BY ventas DESC LIMIT 5;

/*
Obtener el título y el número de ventas de los cinco libros más vendidos de la última década.
*/
SELECT titulo, ventas, fecha_publicacion FROM libros 
WHERE fecha_publicacion > (CURRENT_TIMESTAMP - INTERVAL 10 YEAR) ORDER BY ventas DESC;

/*
Obtener la cantidad de libros vendidos por los autores con id 1, 2 y 3.
*/
SELECT autor_id, SUM(ventas) AS total_ventas FROM libros GROUP BY autor_id;

/*
Obtener el título del libro con más páginas.
*/
SELECT titulo, paginas FROM libros ORDER BY paginas DESC LIMIT 1;

/*
Obtener todos los libros cuyo título comience con la palabra “La”.
*/
SELECT titulo FROM libros WHERE titulo LIKE 'La%';

/*
Obtener todos los libros cuyo título comience con la palabra “La” y termine con la letra “a”.
*/
SELECT titulo FROM libros WHERE titulo LIKE 'La%' AND titulo LIKE '%a';

/*
Establecer el stock en cero a todos los libros publicados antes del año de 1995
*/
UPDATE libros SET stock = 0 WHERE YEAR(fecha_publicacion) < 1995;

/*
Mostrar el mensaje Disponible si el libro con id 1 posee más de 5 ejemplares en stock, en caso contrario mostrar el mensaje No disponible.
*/
SELECT IF (stock > 5, 'Disponible', 'No disponible') AS mensaje FROM libros WHERE libro_id = 1;
/*
Obtener el título los libros ordenador por fecha de publicación del más reciente al más viejo.*/
SELECT libro_id, titulo, fecha_publicacion FROM libros ORDER BY fecha_publicacion DESC;

/*
AUTORES
Obtener el nombre de los autores cuya fecha de nacimiento sea posterior a 1950
*/
SELECT nombre, fecha_nacimiento FROM autores WHERE YEAR(fecha_nacimiento) > 1950;

/*
Obtener la el nombre completo y la edad de todos los autores.
*/
SELECT CONCAT(nombre, ' ', apellido) AS nombreCompleto, 
(YEAR(CURRENT_TIMESTAMP) - YEAR(fecha_nacimiento)) AS edad
FROM autores;

/*
Obtener el nombre completo de todos los autores cuyo último libro publicado sea posterior al 2005
*/
SELECT CONCAT(autores.nombre, ' ', autores.apellido) AS nombreCompleto,
MAX(libros.fecha_publicacion) AS ultima_publicacion FROM autores, libros
WHERE autores.autor_id = libros.autor_id 
AND YEAR(fecha_publicacion) > 2005 GROUP BY nombreCompleto;
/*
Obtener el id de todos los escritores cuyas ventas en sus libros superen el promedio.
*/
SELECT autor_id AS id, AVG(ventas) AS promedio FROM libros 
GROUP BY id HAVING promedio > (SELECT AVG(ventas) FROM libros);

/*
Obtener el id de todos los escritores cuyas ventas en sus libros sean mayores a cien mil ejemplares.
*/
SELECT autor_id, SUM(ventas) AS totalVentas FROM libros 
GROUP BY autor_id HAVING totalVentas > 100000;

/*
FUNCIONES
Crear una función la cual nos permita saber si un libro es candidato a préstamo o no. Retornar “Disponible” si el libro posee por lo menos un ejemplar en stock, en caso contrario retornar “No disponible.”
*/

/* sentencia para que se pueda ejecutar una funcion si no se añade DETERMINIST, NO SQL ó READS SQL DATA antes del begin
SET GLOBAL log_bin_trust_function_creators = 1;*/
DELIMITER //

CREATE FUNCTION bookStatus(id INT)
RETURNS VARCHAR(20)
BEGIN
   SET @stock = (SELECT stock FROM libros WHERE libro_id = id);
   SET @answer = (CASE WHEN @stock > 1 THEN 'Disponible' ELSE 'No disponible' END);
   RETURN @answer;
END //

DELIMITER ;