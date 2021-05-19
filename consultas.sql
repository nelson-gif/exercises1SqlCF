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

Obtener en un mismo resultado la cantidad de libros escritos por autores con seudónimo y sin seudónimo./
