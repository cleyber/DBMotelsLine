-- fechaCreacion 05/06/2016
-- Version 0.0.1

create database if not exists `motelsline`;

use `motelsline`;

create table if not exists motel(
   id_motel int unsigned primary key auto_increment,
   nombre varchar(30) not null,
   direccion varchar(50) not null,
   telefono varchar(30) not null,
   correo varchar(50) not null,
   facebook varchar(100),
   whatsapp varchar(20),
   twitter varchar(100),
   instagram varchar(100),
   youtube varchar(100)
);

create table if not exists habitaciones(
   id_habitacion  int unsigned primary key auto_increment,
   id_motel int unsigned not null,
   nombre varchar(30) not null,
   cantidad int not null,
   descripcion text not null,
   precio double not null,
   cantidad_horas int not null,
   hora_adicional double not null,
   persona_adicional double,
   foreign key(id_motel ) references motel(id_motel) ON DELETE CASCADE
);

create table if not exists servicios(
   id_servicio int unsigned primary key auto_increment,
   nombre varchar(30) not null,
   descripcion text not null,
   precio double not null
);

create table if not exists precio_amanecidas(
   id_precio_amanecida int unsigned primary key auto_increment,
   id_habitacion int unsigned not null,
   horario varchar(50) not null,
   precio double not null,
   foreign key(id_habitacion) references habitaciones(id_habitacion) ON DELETE CASCADE
);

create table if not exists usuarios (
   id_usuario int unsigned primary key auto_increment,
   id_motel int unsigned,
   nombres varchar(50) not null,
   apellidos varchar(50),
   cedula bigint unsigned not null,
   correo varchar(50) unique not null,
   clave varchar(100) not null,
   rol enum('administrador', 'empleado', 'cliente') default 'cliente',
   foreign key (id_motel) references motel(id_motel) ON DELETE CASCADE
);

create table if not exists fotos_habitaciones(
   id_foto int unsigned primary key auto_increment,
   id_habitacion int unsigned not null,
   nombre varchar(100) not null,
   foreign key(id_habitacion) references habitaciones(id_habitacion) ON DELETE CASCADE
);

create table if not exists reservas(
   id_reserva int unsigned primary key auto_increment,
   id_habitacion int unsigned not null,
   id_usuario int unsigned not null,
   fecha date not null,
   hora time not null,
   horas_extras int default '0',
   personas_extras int default '0',
   foreign key(id_habitacion) references habitaciones(id_habitacion) ON DELETE CASCADE,
   foreign key(id_usuario) references usuarios(id_usuario) ON DELETE CASCADE
);

create table if not exists reservas_x_servicios(
   id_reserva int unsigned not null,
   id_servicio int unsigned not null,
   foreign key(id_reserva) references reservas(id_reserva) ON DELETE CASCADE,
   foreign key(id_servicio) references servicios(id_servicio) ON DELETE CASCADE
);

create table if not exists fotos_motel(
   id_foto int unsigned primary key auto_increment,
   id_motel int unsigned not null,
   nombre varchar(100) not null,
   foreign key(id_motel) references motel(id_motel) ON DELETE CASCADE
);

create table if not exists fotos_servicios(
   id_foto int unsigned primary key auto_increment,
   id_servicio int unsigned not null,
   nombre varchar(100) not null,
   foreign key(id_servicio) references servicios(id_servicio) ON DELETE CASCADE
);
