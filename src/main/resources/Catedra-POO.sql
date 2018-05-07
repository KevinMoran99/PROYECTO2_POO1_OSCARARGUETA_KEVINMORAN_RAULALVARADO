create database pooC;

use pooC;

create table user_types(
id int not null primary key auto_increment,
name varchar (100) unique not null
);

create table users(
id int primary key not null auto_increment,
name varchar (100) not null,
lastname varchar (100) not null,
email varchar (255) unique not null,
pass varchar (100) not null,
user_type_id int not null,
state bool not null default 1,
foreign key (user_type_id) references user_types(id)
);

create table complaint_types(
id int not null primary key auto_increment,
name varchar (100) unique not null,
taken_action enum('Remitir con autoridad competente', 'Tomar contacto con ISP y colegio') not null,
state bool not null default 1
);

create table schools(
id int not null primary key auto_increment,
name varchar(100) unique not null,
address varchar(255) not null,
state bool not null default 1
);

create table authorities(
id int not null primary key auto_increment,
name varchar(100) unique not null,
state bool not null default 1
);

create table providers(
id int not null primary key auto_increment,
name varchar(100) unique not null,
state bool not null default 1
);

create table calls(
id int not null primary key auto_increment,
school_id int not null,
viable bool not null default 0,
complaint_id int not null,
user_id int not null default 1,
description text not null default '',
call_date date not null,
talk_given bool not null default 0,
code varchar(15) not null,
foreign key (school_id) references schools(id),
foreign key (complaint_id) references complaint_types(id),
foreign key (user_id) references users(id)
);

create table authority_asigns(
id int not null primary key auto_increment,
call_id int not null,
authority_id int not null,
foreign key (call_id) references calls(id),
foreign key (authority_id) references authorities(id)
);

create table provider_asigns(
id int not null primary key auto_increment,
call_id int not null,
provider_id int not null,
content_removed bool not null default 0,
foreign key (call_id) references calls(id),
foreign key (provider_id) references providers(id)
);

-- INSERTS PROVISIONALES
insert into user_types values (null, "Administrador");
insert into user_types values (null, "Personal");

-- Contraseñas: 123456
insert into users values (null, "Oscar", "Méndez", "admin@gmail.com", "jXUeI9FKyL76dUcDOy296g==", 1, 1);
insert into users values (null, "Kevin", "Morán", "user@gmail.com", "jXUeI9FKyL76dUcDOy296g==", 2, 1);

insert into complaint_types values (null, "Pornografía Infantil", "Remitir con autoridad competente", 1);
insert into complaint_types values (null, "Grooming (proposiciones sexuales a menores de edad)", "Remitir con autoridad competente", 1);
insert into complaint_types values (null, "Anuncios con fines de explotación y turismo sexual infantil", "Remitir con autoridad competente", 1);
insert into complaint_types values (null, "Acoso: Bullying o Cyberbullying", "Tomar contacto con ISP y colegio", 1);
insert into complaint_types values (null, "Otros contenidos nocivos", "Tomar contacto con ISP y colegio", 1);

insert into schools values (null, "Instituto Técnico Ricaldone", "Avenida Aguilares 218, San Salvador", 1);
insert into schools values (null, "Colegio Salesiano Santa Cecilia", "Calle Don Bosco y Av. Manuel Gallardo, 1-1, Santa Tecla", 1);
insert into schools values (null, "Colegio Don Bosco", "Soyapango", 1);
insert into schools values (null, "Instituto Nacional General Francisco Menendez (INFRAMEN)", "20 Avenida Norte, El Salvador", 1);
insert into schools values (null, "Escuela Americana", "San Salvador", 1);

insert into authorities values (null, "Policía Nacional Civil", 1);
insert into authorities values (null, "Procuraduría para la Defensa de los Derechos Humanos", 1);
insert into authorities values (null, "Instituto Salvadoreño Para El Desarrollo Integral De La Niñez Y La Adolescencia", 1);
insert into authorities values (null, "Asociación Nueva Vida Pro-Niñez y Juventud", 1);
insert into authorities values (null, "Buró Federal de Investigaciones", 1);

insert into providers values (null, "Facebook", 1);
insert into providers values (null, "Google", 1);
insert into providers values (null, "Twitter", 1);
insert into providers values (null, "Youtube", 1);
insert into providers values (null, "4chan", 1);




