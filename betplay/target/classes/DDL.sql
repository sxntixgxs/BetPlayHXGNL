## SCRIPT 

USE railway;

CREATE TABLE estadio(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    ubicacion VARCHAR(100) NOT NULL,
    capacidad INT NOT NULL
);
CREATE TABLE equipo(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    ciudad VARCHAR(50) NOT NULL,
    idEstadio INT NOT NULL,
    FOREIGN KEY (idEstadio) REFERENCES estadio(id) 
);

CREATE TABLE entrenador(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(20) NOT NULL,
    apellido1 VARCHAR(20) NOT NULL,
    apellido2 VARCHAR(20),
    edad INT NOT NULL,
    idEquipo INT NOT NULL,
    FOREIGN KEY (idEquipo) REFERENCES equipo(id)
);

CREATE TABLE partido(
    id INT PRIMARY KEY AUTO_INCREMENT,
    idLocal INT NOT NULL,
    idVisitante INT NOT NULL,
    idEstadio INT NOT NULL,
    fecha DATETIME NOT NULL,
    FOREIGN KEY (idLocal) REFERENCES equipo(id),
    FOREIGN KEY (idVisitante) REFERENCES equipo(id),
    FOREIGN KEY (idEstadio) REFERENCES estadio(id)
);
CREATE TABLE jugador(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(20) NOT NULL,
    apellido1 VARCHAR(20) NOT NULL,
    apellido2 VARCHAR(20),
    edad INT NOT NULL,
    posicion VARCHAR(10) NOT NULL,
    nacionalidad VARCHAR(10) NOT NULL,
    dorsal INT NOT NULL,
    idEquipo INT NOT NULL,
    FOREIGN KEY (idEquipo) REFERENCES equipo(id)
);
CREATE TABLE lesion(
    id INT PRIMARY KEY AUTO_INCREMENT,
    idJugador INT NOT NULL,
    tipo VARCHAR(10) NOT NULL,
    gravedad INT NOT NULL,
    fechaInicio DATE NOT NULL,
    fechaFin DATE,
    FOREIGN KEY(idJugador) REFERENCES jugador(id)
);
CREATE TABLE gol(
    id INT PRIMARY KEY AUTO_INCREMENT,
    idJugador INT NOT NULL,
    idEquipo INT NOT NULL,
    idPartido INT NOT NULL,
    minuto INT NOT NULL,
    FOREIGN KEY (idJugador) REFERENCES jugador(id),
    FOREIGN KEY (idEquipo) REFERENCES equipo(id),
    FOREIGN KEY (idPartido) REFERENCES partido(id)
);
CREATE TABLE asistencia(
    id INT PRIMARY KEY AUTO_INCREMENT,
    idJugador INT NOT NULL,
    idEquipo INT NOT NULL,
    idPartido INT NOT NULL,
    minuto INT NOT NULL,
    FOREIGN KEY (idJugador) REFERENCES jugador(id),
    FOREIGN KEY (idEquipo) REFERENCES equipo(id),
    FOREIGN KEY (idPartido) REFERENCES partido(id)
);
CREATE TABLE tarjeta(
    id INT PRIMARY KEY AUTO_INCREMENT,
    minuto INT NOT NULL,
    tipo ENUM('A','R'),
    idPartido INT NOT NULL,
    idJugador INT NOT NULL,
    FOREIGN KEY (idPartido) REFERENCES partido(id),
    FOREIGN KEY (idJugador) REFERENCES jugador(id)
);

CREATE TABLE incidente(
    id INT PRIMARY KEY AUTO_INCREMENT,
    idPartido INT NOT NULL,
    minuto INT NOT NULL,
    descripcion TEXT NOT NULL,
    FOREIGN KEY (idPartido) REFERENCES partido(id)
);
CREATE TABLE rendimiento(
    id INT PRIMARY KEY AUTO_INCREMENT,
    idJugador INT NOT NULL,
    idPartido INT NOT NULL,
    minutosJugados INT NOT NULL,
    goles INT NOT NULL,
    asistencias INT NOT NULL,
    tarjetasAmarillas INT NOT NULL,
    tarjetasRojas INT NOT NULL,
    FOREIGN KEY (idJugador) REFERENCES jugador(id),
    FOREIGN KEY (idPartido) REFERENCES partido(id)
);

CREATE TABLE entrenamiento(
    id INT PRIMARY KEY AUTO_INCREMENT,
    idEquipo INT NOT NULL,
    fecha DATETIME NOT NULL,
    lugar VARCHAR(50) NOT NULL,
    FOREIGN KEY (idEquipo) REFERENCES equipo(id)
);
CREATE TABLE jugadorConvocadoEntrenamiento(
    idJugador INT NOT NULL,
    idEntrenamiento INT NOT NULL,
    PRIMARY KEY (idJugador,idEntrenamiento),
    FOREIGN KEY(idJugador) REFERENCES jugador(id),
    FOREIGN KEY (idEntrenamiento) REFERENCES entrenamiento(id)
);

CREATE TABLE actividad(
    id INT PRIMARY KEY AUTO_INCREMENT,
    descripcion TEXT NOT NULL,
    duracion INT NOT NULL
);
CREATE TABLE actividad_entrenamiento(
    idActividad INT NOT NULL,
    idEntrenamiento INT NOT NULL,
    PRIMARY KEY(idActividad,idEntrenamiento),
    FOREIGN KEY (idActividad) REFERENCES actividad(id),
    FOREIGN KEY (idEntrenamiento) REFERENCES entrenamiento(id)
);
CREATE TABLE transferencia(
    id INT PRIMARY KEY AUTO_INCREMENT,
    idJugador INT NOT NULL,
    idActual INT NOT NULL,
    idNuevo INT NOT NULL,
    monto INT NOT NULL,
    fecha DATE NOT NULL,
    FOREIGN KEY (idJugador) REFERENCES jugador(id),
    FOREIGN KEY (idActual) REFERENCES equipo(id),
    FOREIGN KEY (idNuevo) REFERENCES equipo(id)
);
CREATE TABLE permiso(
    id INT PRIMARY KEY AUTO_INCREMENT,
    descripcion TEXT NOT NULL
);
CREATE TABLE rol(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(20) NOT NULL,
    idPermiso INT NOT NULL,
    FOREIGN KEY (idPermiso) REFERENCES permiso(id)
);

CREATE TABLE usuario(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nick VARCHAR(20) NOT NULL,
    nombre VARCHAR(20) NOT NULL,
    apellido1 VARCHAR(20) NOT NULL,
    apellido2 VARCHAR(20),
    email VARCHAR(20) NOT NULL,
    password VARCHAR(10) NOT NULL,
    idRol INT NOT NULL,
    FOREIGN KEY (idRol) REFERENCES rol(id)
);
CREATE TABLE tipoPatrocinador(
    id INT PRIMARY KEY AUTO_INCREMENT,
    tipo VARCHAR(20) NOT NULL
);
CREATE TABLE patrocinador(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    idTipo INT NOT NULL,
    monto INT NOT NULL,
    fechaInicio DATE NOT NULL,
    fechaFin DATE NOT NULL,
    FOREIGN KEY (idTipo) REFERENCES tipoPatrocinador(id)
);
CREATE TABLE comunicado(
    id INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(100) NOT NULL,
    contenido TEXT NOT NULL,
    fechaPublicacion DATETIME NOT NULL
);
CREATE TABLE comunicadoXusuarios(
    idComunicado INT NOT NULL,
    idRol INT NOT NULL,
    PRIMARY KEY(idComunicado,idRol),
    FOREIGN KEY(idComunicado) REFERENCES comunicado(id),
    FOREIGN KEY (idRol) REFERENCES rol(id)
);

CREATE TABLE entrada(
    id INT PRIMARY KEY AUTO_INCREMENT,
    idPartido INT NOT NULL,
    idComprador INT NOT NULL,
    fechaCompra DATETIME NOT NULL,
    cantidad INT NOT NULL,
    precioTotal INT NOT NULL,
    ubicacion VARCHAR(30) NOT NULL,
    FOREIGN KEY (idPartido) REFERENCES partido(id),
    FOREIGN KEY (idComprador) REFERENCES usuario(id)
);