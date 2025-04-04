CREATE DATABASE desafio3_sebastian_duran_666

--1--

CREATE TABLE usuarios
(
  id SERIAL,
  email VARCHAR(255),
  nombre VARCHAR(255),
  apellido VARCHAR(255),
  rol VARCHAR(255)
);

INSERT INTO usuarios
  (id, email, nombre, apellido, rol)
VALUES
  (1, 'juan.perez@example.com', 'Juan', 'Pérez', 'administrador'),
  (2, 'maria.rodriguez@example.com', 'María', 'Rodríguez', 'usuario'),
  (3, 'carlos.gonzalez@example.com', 'Carlos', 'González', 'usuario'),
  (4, 'ana.martinez@example.com', 'Ana', 'Martínez', 'usuario'),
  (5, 'david.lopez@example.com', 'David', 'López', 'usuario');


CREATE TABLE posts
(
  id SERIAL,
  titulo VARCHAR(255),
  contenido TEXT,
  fecha_creacion TIMESTAMP,
  fecha_actualizacion TIMESTAMP,
  destacado BOOLEAN,
  usuario_id BIGINT
);

INSERT INTO posts
  (id,titulo, contenido, fecha_creacion, fecha_actualizacion, destacado, usuario_id)
VALUES
  (1, 'Primer post', 'Contenido del primer post', '2023-04-10 10:39:37', '2023-04-10 11:39:37', True, 1),
  (2, 'Segundo post', 'Contenido del segundo post', '2023-05-10 10:40:37', '2023-05-10 11:40:37', False, 1),
  (3, 'Tercer post', 'Contenido del tercer post', '2023-05-10 10:41:37', '2023-05-10 11:41:37', True, 3),
  (4, 'Cuarto post', 'Contenido del cuarto post', '2023-06-10 10:42:37', '2023-06-10 11:42:37', False, 4),
  (5, 'Quinto post', 'Contenido del quinto post', '2023-06-10 10:43:37', '2023-06-10 11:43:37', True, NULL)


CREATE TABLE comentarios
(
  id SERIAL,
  contenido TEXT,
  fecha_creacion TIMESTAMP,
  usuario_id BIGINT,
  post_id BIGINT
);

INSERT INTO comentarios
  (id,contenido,fecha_creacion,usuario_id,post_id)
VALUES
  (1, 'contenido 1', '2023-04-11 12:39:37', 1, 1),
  (2, 'contenido 2', '2023-04-11 12:39:38', 2, 1),
  (3, 'contenido 3', '2023-04-11 12:39:39', 3, 1),
  (4, 'contenido 4', '2023-04-11 12:39:40', 1, 2),
  (5, 'contenido 5', '2023-04-11 12:39:41', 2, 2)



--2--

SELECT usuarios.nombre, usuarios.email, posts.titulo, posts.contenido
FROM usuarios
INNER JOIN posts
ON usuarios.id = posts.usuario_id

--3--

SELECT usuarios.id, posts.titulo, posts.contenido
FROM usuarios
INNER JOIN posts
ON usuarios.id = posts.usuario_id
WHERE usuarios.rol = 'administrador'

--4--

SELECT usuarios.id, usuarios.email, COUNT(posts.id) AS cantidad_de_post
FROM usuarios
LEFT JOIN posts
ON usuarios.id = posts.usuario_id
GROUP BY usuarios.id,usuarios.email


--5--

SELECT usuarios.email
FROM usuarios
INNER JOIN posts
ON usuarios.id = posts.usuario_id
GROUP BY usuarios.id,usuarios.email
ORDER BY COUNT(posts.id) DESC
LIMIT 1

--6--

SELECT usuarios.id,usuarios.email,MAX(posts.fecha_creacion) AS ultimo_post
FROM usuarios
INNER JOIN posts
ON usuarios.id = posts.usuario_id
GROUP BY usuarios.id,usuarios.email

--7--

SELECT posts.titulo, posts.contenido
FROM posts
INNER JOIN comentarios
ON posts.id = comentarios.post_id
GROUP BY posts.id,posts.titulo,posts.contenido
ORDER BY COUNT(comentarios.id) DESC
LIMIT 1

--8--

SELECT posts.titulo, posts.contenido, comentarios.contenido AS comentario, usuarios.email
FROM posts
LEFT JOIN comentarios ON posts.id = comentarios.post_id
LEFT JOIN usuarios ON comentarios.usuario_id = usuarios.id;

--9--

SELECT usuarios.id, usuarios.email, comentarios.contenido AS ultimo_comentario
FROM usuarios
JOIN comentarios ON usuarios.id = comentarios.usuario_id
WHERE comentarios.fecha_creacion = (SELECT MAX(fecha_creacion)
FROM comentarios AS sub
WHERE sub.usuario_id = usuarios.id
);


--10--

SELECT usuarios.email
FROM usuarios
LEFT JOIN comentarios ON usuarios.id = comentarios.usuario_id
GROUP BY usuarios.id,usuarios.email
HAVING COUNT(comentarios.id) = 0;
