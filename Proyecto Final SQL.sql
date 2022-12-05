-- AGUSTIN AGULLEIRO Comisión 34960
SET SQL_SAFE_UPDATES = 0;
DROP SCHEMA IF EXISTS Rast;

CREATE SCHEMA IF NOT EXISTS Rast;

USE Rast;



DROP TABLE IF EXISTS PAIS;


CREATE TABLE IF NOT EXISTS PAIS(
id_pais tinyint not null auto_increment,
Pais varchar(60) not null,
PRIMARY KEY (id_pais)
);


DROP TABLE IF EXISTS PROVINCIA;


CREATE TABLE IF NOT EXISTS PROVINCIA(
id_provincia smallint not null auto_increment,
Provincia varchar(60) not null,
id_pais tinyint not null,
PRIMARY KEY (id_provincia),
CONSTRAINT `Pais` FOREIGN KEY (id_pais) REFERENCES PAIS (id_pais) on delete cascade
);


DROP TABLE IF EXISTS LOCALIDAD;


CREATE TABLE IF NOT EXISTS LOCALIDAD(
id_localidad mediumint not null auto_increment,
Localidad varchar(60) not null,
id_provincia smallint not null,
PRIMARY KEY (id_localidad),
CONSTRAINT `Provincia` FOREIGN KEY (id_provincia) REFERENCES PROVINCIA (id_provincia) on delete cascade
);


DROP TABLE IF EXISTS DIRECCION;


CREATE TABLE IF NOT EXISTS DIRECCION(
id_direccion int not null auto_increment,
Direccion varchar(60) not null,
id_localidad mediumint not null,
PRIMARY KEY (id_direccion),
CONSTRAINT `Localidad` FOREIGN KEY (id_localidad) REFERENCES LOCALIDAD (id_localidad) on delete cascade
);

DROP TABLE IF EXISTS USUARIOS;

CREATE TABLE IF NOT EXISTS USUARIOS(
id_usuario int not null auto_increment,
DNI VARCHAR(50) not null,
Nombre VARCHAR(40) not null,
Apellido VARCHAR(40) not null,
Fecha_Nacimiento date not null,
Sexo enum ('Masculino','Femenino'),
Numero_Tel VARCHAR(40) not null,
Mail_Us VARCHAR(100) not null,
id_direccion int not null,
PRIMARY KEY (id_usuario),
CONSTRAINT `Direccion_Usu` FOREIGN KEY (id_direccion) REFERENCES DIRECCION (id_direccion) on delete cascade
);


DROP TABLE IF EXISTS MARCA;


CREATE TABLE IF NOT EXISTS MARCA(
id_marca tinyint not null auto_increment,
Marca varchar(80),
PRIMARY KEY (id_marca)
);


DROP TABLE IF EXISTS MODELO;


CREATE TABLE IF NOT EXISTS MODELO(
id_modelo int not null auto_increment,
Modelo varchar(80) not null,
id_marca tinyint not null,
PRIMARY KEY (id_modelo),
CONSTRAINT `Marca` FOREIGN KEY (id_marca) REFERENCES MARCA (id_marca) on delete cascade
);


DROP TABLE IF EXISTS AUTOMOVIL;


CREATE TABLE IF NOT EXISTS AUTOMOVIL(
id_automovil int not null auto_increment,
Color varchar(30),
Patente VARCHAR (20),
id_modelo int not null,
PRIMARY KEY (id_automovil),
CONSTRAINT `ModeloAut` FOREIGN KEY (id_modelo) REFERENCES MODELO (id_modelo) on delete cascade
);


DROP TABLE IF EXISTS REMISERIAS;


CREATE TABLE IF NOT EXISTS REMISERIAS(
id_remiseria int not null auto_increment,
Nombre_Remiseria varchar(100) not null,
Telefono VARCHAR(30),
id_direccion int not null,
PRIMARY KEY (id_remiseria),
CONSTRAINT `Direccion_Re` FOREIGN KEY (id_direccion) REFERENCES DIRECCION (id_direccion) on delete cascade
);


DROP TABLE IF EXISTS CHOFERES;


CREATE TABLE IF NOT EXISTS CHOFERES(
id_choferes int not null auto_increment,
DNI VARCHAR(50) NOT NULL,
Nombre VARCHAR(40) not null,
Apellido VARCHAR(40) not null,
Fecha_Nacimiento date not null,
Sexo enum ('Masculino','Femenino'),
Numero_Tel_Ch VARCHAR(60),
Mail_Ch VARCHAR(100),
id_remiseria int not null,
id_automovil int not null,
PRIMARY KEY (id_choferes),
CONSTRAINT `Remi` FOREIGN KEY (id_remiseria) REFERENCES REMISERIAS (id_remiseria) on delete cascade,
CONSTRAINT `Auto` FOREIGN KEY (id_automovil) REFERENCES AUTOMOVIL (id_automovil) on delete cascade
);


DROP TABLE IF EXISTS VIAJES;


CREATE TABLE IF NOT EXISTS VIAJES(
id_viajes int not null auto_increment,
id_usuario int not null,
id_choferes int not null,
Direccion_Destino int not null,
Kilometro_Recorrido float,
Precio int not null,
Fecha_Viaje DateTime,
PRIMARY KEY (id_viajes),
CONSTRAINT `Viaje_Usua` FOREIGN KEY (id_usuario) REFERENCES USUARIOS (id_usuario)on delete cascade,
CONSTRAINT `Viaje_Chof` FOREIGN KEY (id_choferes) REFERENCES CHOFERES (id_choferes)on delete cascade,
CONSTRAINT `Viaje_Dir_Dest` FOREIGN KEY (Direccion_Destino) REFERENCES DIRECCION (id_direccion) on delete cascade
);


/*------------------------------------------------------------------------------------------------------------------------*/
-- INSERCION DE DATOS
	-- PAISES
	INSERT INTO pais VALUES (1,'Argentina'),
									(2,'Uruguay'),
									(3,'España'),
									(4,'Brasil');
	-- Provincia
	INSERT INTO provincia VALUES (1,"Buenos Aires",1),
										  (2,"Santa Fe",1),
										  (3,'Cordoba',1),
										  (4,'Mendoza',1),
										  (5,'Montevideo',2),
										  (6,'Artigas',2),
										  (7,"Punta Del Este",2),
										  (9,"Sao Paulo",4),
										  (10,'Barcelona',3);
	-- Localidad
	INSERT INTO localidad VALUES (1,"San Martin",1),
										  (2,'Tandil',1),
										  (3,"Bahia Blanca",1),
										  (4,'Palermo',1),
										  (5,'Recoleta',1),
										  (6,'Rosario',2),
										  (7,"San Lorenzo",5),
										  (8,"Rio Cuarto",3),
										  (9,"Ciudad Vieja",5),
										  (10,"Vila Formosa",9),
										  (11,"El Raval",10);
	-- Direccion
	INSERT INTO direccion VALUES (1,"Av. 101 Dr. Ricardo Balbín 1723",1),
										  (2,"Av. 101 Dr. Ricardo Balbín 2404",1),
										  (3,"Matheu 4495",1),
										  (4,"Matheu 4008",1),
										  (5,"9 de Julio 393, Sarmiento 769",2),
										  (6,"Gral. Rodríguez 467",2),
										  (7,"Cabello 3019",4),
										  (8,"Av. Estado de Israel 4602",4),
										  (9,"San Lorenzo Oeste 68",7),
										  (10,"San Lorenzo Oeste 349",7),
										  (11,"Carrer de l'Hostal d'en Sol, 7, 8002",11),
										  (12,"Republica 6699",1),
										  (13,"Juan Francisco Seguí 4530",4),
										  (14,"Ugarteche, C1425 CABA",4),
										  (15,"Buenos Aires 6611",1),
										  (16,"Avellaneda 2416",1),
										  (17,"Juncal 2000",5),
										  (18,"Bv. Ballester 6272",1),
										  (19,"Soler 5668",4),
										  (20,"Arenales 2448",5),
										  (21,"B Mitre - 3776",6),
										  (22,"J F Seguí - 3920 ",6),
										  (23,"Santa Fe - 690",6),
										  (24,"Andrade - 625",6),
										  (25,"Bv Sarmiento Oeste - 474",6),
										  (26,"Dr Romang - 192",6),
										  (27,"Paraná - 467 - 1",6),
										  (28,"Almirón - 301",6),
										  (29,"J B Justo - 555",6),
										  (30,"Facundo Zuviría 3905",6),
										  (31,"passeig joan maragall n5",11),
										  (32,"carrer de gifré el pelós n3",11),
										  (33,"Urbanización Diaz Casanova, 35010",11),
										  (34,"Calle Perretagana, 24, 01015",11),
										  (35,"Paseo Independencia, 5, 50001",11),
										  (36,"Carretera Nacional 502, 45612",11),
										  (37,"Avenida Alfonso El Sabio, 27, 03001",11),
										  (38,"Avenida Txori Erri, 48150",11),
										  (39,"Calle Eguiluz, 6, 11402",11),
										  (40,"Calle La Pinta, 56, 41927",11),
										  (41,"Avenida Ricardo Soriano, 22, 29601",11),
										  (42,"Calle Cid, 22, 03803",11),
										  (43,"Rincon, 629",9),
										  (44,"Plaza Cagancha, 1335, 10",9),
										  (45,"Tomás Giribaldi, 2290",9),
										  (46,"Calle Libertad, 2738",9),
										  (47,"Avda. Brasil 2770",9),
										  (48,"Calle Yegros, 437, piso 6",9),
										  (49,"Blvd. Rondeau 711",6);
										  
	-- Usuarios
	INSERT INTO usuarios VALUES (1,43874709,'Agustin','Agulleiro','2002-01-01','Masculino',1161854171,'agustin_agulleiro@outlook.com',12),
										 (2,20063482,'Nora','Cortes','1980-05-25','Femenino',1121554471,'nora_cortes@hotmail.com',12),
										 (3,41618541,'Matias','Acosta','2001-06-02','Masculino',1131455682,'matias_acosta@hotmail.com',13),
										 (4,31858741,'Sofia','Caseres','2002-08-15','Femenino',1134578901,'sofia_caseres@outlook.com.ar',14),
										 (5,47656677,'Cony','Goalard','1990-05-29','Femenino',"11 532 65689009",'conyy_goalard@gmail.com',15),
										 (6,42457909,'Lucho','Gonzales','2001-12-21','Masculino',1134677901,'Luch_Gonzales@hotmail.com',16),
										 (7,'45128176Z','Martina','Cortes','2005-03-13','Femenino',"34 691 75 40 88",'Martu_cortes@hotmail.com',17),
										 (8,42118158,'Cami','Cortes','2004-03-13','Masculino',"9 2494 06-4277",'Cami_Cortes@hotmail.com',18),
										 (9,45118158,'Rafael','Guitierrez','2005-11-13','Masculino',"9 2592 06-4277",'Rafael_Gui@hotmail.com',19),
										 (10,47118158,'Julian','Ojeda','2003-03-19','Femenino',"9 244 08-4347",'JulianOjeda2@hotmail.com',20),
										 (11,46118158,'Christian','Coronado','2002-03-18','Masculino',"9 9411 26-4299",'Chris_Cor1@hotmail.com',21),
										 (12,43268158,'Agustin','Lopez','2000-03-21','Masculino',"9 2494 08-3523",'Lopez_Agustin@gmail.com',22),
										 --
										 (13,10118158,'Christian','López','2002-03-18','Masculino',"9 9111 26-4299",'Cris_Lopez@gmail.com',23),
										 (14,11118158,'Alejandro','Martínez','2002-03-18','Masculino',"9 9211 26-4299",'Alejandro_Mar@hotmail.com',24),
										 (15,12118158,'Raul','Díaz','2002-03-18','Masculino',"9 9311 26-4299",'Raul_Di@hotmail.com',25),
										 (16,13118158,'Julian','Martínez','2002-03-18','Masculino',"9 9511 26-4299",'Juli_Marti@hotmail.com',26),
										 (17,14118158,'Ricky','Díaz','2002-03-18','Masculino',"9 9611 26-4299",'Ricky_Diaz@hotmail.com',27),
										 (18,15118158,'Enrique','Benítez','2002-03-18','Masculino',"9 9711 26-4299",'EnriqueBeni@hotmail.com',28),
										 (19,16118158,'Matias','Benítez','2002-03-18','Masculino',"9 9811 26-4299",'Matias_Beni@hotmail.com',29),
										 (20,17118158,'Christina','Torres','2002-03-18','Masculino',"9 9911 26-4299",'ChrisTorr@hotmail.com',30),
										 (21,18118158,'Xiomara','Díaz','2002-03-18','Femenino',"9 1011 26-4299",'Xiomi_Dia@hotmail.com',31),
										 (22,19118158,'Azul','Acosta','2002-03-18','Femenino',"9 1111 26-4299",'Azul_Acosta@hotmail.com',32),
										 (23,20118158,'Jazmin','Álvarez','2002-03-18','Femenino',"9 1211 26-4299",'Jazmin_Alvarez@hotmail.com',33),
										 -- 28
										 (24,21118158,'Federico','Flores','2002-03-18','Masculino',"9 1311 26-4299",'Fede_Flores@hotmail.com',34),
										 (25,22118158,'Santiago','Torres','2002-03-18','Masculino',"9 1411 26-4299",'Santi_Torres@gmail.com',35),
										 (26,23118158,'Santino','Martínez','2002-03-18','Masculino',"9 1511 26-4299",'Santino_Marti@gmail.com',36),
										 (27,24118158,'Rodolfo','Pérez','2002-03-18','Masculino',"9 1611 26-4299",'Rodolf_Pere@gmail.com',37),
										 (28,25118158,'Julian','Pérez','2002-03-18','Masculino',"9 1711 26-4299",'JuliPerez@gmail.com',38),
										 (29,26118158,'Sami','Coronado','2002-03-18','Masculino',"9 1811 26-4299",'Sami_Coronado@gmail.com',39),
										 (30,27118158,'Gonzalo','López','2002-03-18','Masculino',"9 1911 26-4299",'Gonza_Lopez@gmail.com',40),
										 (31,28118158,'Emiliano','Sánchez ','2002-03-18','Masculino',"20 9411 26-4299",'Emi_Sanches@gmail.com',41),
										 (32,29118158,'Leonel','Sánchez ','2002-03-18','Masculino',"9 2111 26-4299",'LeonesSanches@gmail.com',42),
										 (33,30118158,'Leonel','Rojas','2002-03-18','Masculino',"9 2211 26-4299",'LeonRojas@gmail.com',43),
										 (34,31118158,'Agustin','Coronado','2002-03-18','Masculino',"9 2311 26-4299",'AgustinCoronado@gmail.com',44),
										 (35,32118158,'Franco','Díaz','2002-03-18','Masculino',"9 2411 26-4299",'FrancoDiaz@gmail.com',45),
										 (36,33118158,'Maximiliano','Rojas','2002-03-18','Masculino',"9 2511 26-4299",'Maxi_Rojas@gmail.com',46),
										 (37,34118158,'Christian','Romero','2002-03-18','Masculino',"9 2611 26-4299",'Chris_Ro@gmail.com',47),
										 (38,35118158,'Lucho','Romero','2002-03-18','Masculino',"9 9271 26-4299",'LuchoRomero@gmail.com',48),
										 (39,36118158,'Julieta','Sosa ','2002-03-18','Femenino',"9 2811 26-4299",'Juli_Sosa3@gmail.com',48),
										 (40,37118158,'Oriana','Sánchez ','2002-03-18','Femenino',"9 2911 26-4299",'Ori_Sanchez@gmail.com',48);
										 
	-- Remiserias
	INSERT INTO remiserias VALUES(1,"REMIS R8","4713-0259",1),
										  (2,"Remises Tribunal","4754-2234",2),
										  (3,"Remises Perla","4752-4844",3),
										  (4,"REMISES Matheu","4753-9810",4),
										  (5,"Remis Tandil","0249 442-3333",5),
										  (6,"Remises Alas","0249 444-2222",6),
										  (7,"Remises Royal","4754-2234",7),
										  (8,"Remises VLZ","4864-9326",8),
										  (9,"REMISSES SERVICIOS LIBRE","0345 422-2666",9),
										  (10,"Parada Remises","",10),
										  (11,"Asociación Taxi Solidario","34 668 55 50 00",11),
										  (12,"Remisería Distinción","0341 316-4420",49);
  -- Marca
  INSERT INTO Marca VALUES (1,'Peugeot'),
							 		(2,'Toyota'),
                           (3,'Ford'),
                           (4,'Volkswagen');
   -- Modelo
  INSERT INTO Modelo VALUES (1,'Etios Aibo',2),
									 (2,'Yaris',2),
                            (3,'Camry',2),
                            (4,'Expert',1),
                            (5,'Bipper',1),
                            (6,'Focus',3),
                            (7,'Mondeo',3),
									 (8,"Suran 2014",4),
									 (9,"Suran 2016",4),
									 (10,"Amarok V6",4);
	-- Automovil
    INSERT INTO Automovil VALUES (1,'Negro',"NJS 537",8),
								   		(2,'Blanco',"RDA 666",9),
                                 (3,'Rojo',"H NV 132",10),
                                 (4,'Verde',"RDA 231",3),
                                 (5,'Negro',"FKA 982",3),
                                 (6,'Rojo',"YTR 345",4),
                                 (7,'Blanco',"PNE 345",1),
											(8,'Gris',"RST 291",2),
											(9,'Negro',"RPT 391",3),
											(10,'Blaco',"RAT 292",4),
											(11,'Azul',"RSY 293",6),
											(12,'Gris',"RSS 294",5),
											(13,'Rojo',"RSQ 295",9),
											(14,'Verde',"RSW 296",9),
											(15,'Gris',"RSZ 297",8),
											(16,'Gris',"RTZ 397",8);										  
  -- Choferes
  INSERT INTO Choferes VALUES (1,36345267,'Alejandro','Diaz','200-04-30','Masculino',"11 239 31468903",'Alejandro_Diaz@hotmail.com',1,1),
  										(2,37545267,'Julian','Diaz','1999-02-12','Masculino',"11 123 623578009",'Julian_Diaz@hotmail.com',1,2),
  										(3,38645267,'Hernesto','Sosa','1975-01-12','Masculino',"11 473 61231133",'Hern_Sosa@hotmail.com',2,3),
  										(4,39745267,'Juan','Tripoli','1980-10-12','Masculino',"11 222 02231183",'Tripol_Juan@hotmail.com',3,4),
  										(5,31845267,'Ricardo','Acosta','1990-08-12','Masculino',"11 328 56231283",'Ricardo_Acos@hotmail.com',4,5),
  										(6,32945267,'Orduña','Fernandez','1987-04-12','Masculino',"11 41 90232583",'Orduña1_Fer@hotmail.com',5,6),
  										(7,33145267,'Mateo','Gonzales','1988-05-20','Masculino',"11 82 10018191",'MateoGonzales@hotmail.com',6,7),
  										(8,32945267,'Orduña','Frizzotti','1983-02-16','Masculino',"11 61459111",'Orduña1_Fer@hotmail.com',7,8),
  										(9,32945267,'Nicolas','Schtnai','1984-03-12','Masculino',"11 61459222",'NicoSch@hotmail.com',8,9),
  										(10,32945267,'Maximo','Hernandez','1985-07-21','Masculino',"11 61459333",'Maxi_Her@hotmail.com',9,10),
  										(11,33945267,'Ornella','Guitierrez','1986-11-12','Femenino',"11 61459444",'Ornella_Gui1@Gmail.com',10,11),
  										(12,34945267,'Federico','Alvarez','1987-10-12','Masculino',"11 61459444",'Fede.Alvarez@outlook.com',11,12),
  										(13,35945267,'Sofia','Fernandez','1998-04-21','Femenino',"11 61459555",'Sofia.Fernan@hotmail.com',5,13),
  										(14,36945267,'Camila','Ioca','1999-04-12','Femenino',"11 41 613529151",'CamilaIoca1@hotmail.com',1,14),
  										(15,37945267,'Micaela',"Villa Real",'1989-04-12','Femenino',"11 78459121",'Micaela_VillaR@outlook.com',2,15),
										(16,38945267,'Micaela',"Villa Real",'1989-04-12','Femenino',"11 78469121",'MicaVillaR@outlook.com',12,16);       
  -- Viajes
  INSERT INTO Viajes VALUES (1,1,1,12,'20','850','2022-04-14 00:00:00'),
									 (2,2,1,13,'30','1050','2022-03-22 00:00:00'),
									 (3,3,3,14,'62','1455','2022-04-14 00:00:00'),
                            (4,4,2,15,'58','1230','2022-11-05 00:00:00'),
                            (5,6,5,17,'238','8323','2022-9-25 00:00:00'),
                            (6,8,6,18,'160','3234','2022-01-21 00:00:00'),
									 (7,6,5,17,'248','8673','2022-11-24 00:00:00'),
									 (8,1,5,12,'100','2323','2022-11-24 00:00:00'),
									 (9,1,5,13,'22','900','2022-11-24 00:00:00'),
									 (10,11,1,14,'18','645','2022-11-24 00:00:00'),
									 (11,12,11,21,'15','599','2022-11-24 00:00:00'),
									 (12,12,11,22,'25','952','2022-01-25 00:00:00'),
									 (13,33,10,43,'60','285','2022-11-24 00:00:00'),
									 (14,34,10,44,'35','531','2022-11-24 00:00:00'),
									 (15,35,11,45,'40','413','2022-11-24 00:00:00'),
									 (16,36,10,46,'30','500','2022-11-24 00:00:00'),
									 (17,37,11,47,'10','599','2022-11-24 00:00:00'),
									 (18,38,11,48,'5','120','2022-11-24 00:00:00'),
									 (19,39,10,48,'6','130','2022-11-24 00:00:00'),
									 (20,40,10,48,'18','300','2022-11-24 00:00:00'),
									 (21,33,10,43,'9','250','2022-11-24 00:00:00'),
									 (22,21,12,31,'10','550','2022-11-24 00:00:00'),
									 (23,22,12,32,'21','650','2022-11-24 00:00:00'),
									 (24,23,12,33,'11','750','2022-11-24 00:00:00'),
									 (25,24,12,34,'5','220','2022-11-24 00:00:00'),
									 (26,25,12,35,'4','210','2022-11-24 00:00:00'),
									 (27,26,12,36,'8','230','2022-11-24 00:00:00'),
									 (28,27,12,37,'9','250','2022-11-24 00:00:00'),
									 (29,28,12,37,'25','250','2022-11-24 00:00:00'),
									 (30,29,12,39,'30','2350','2022-11-24 00:00:00'),
									 (31,30,12,40,'21','2250','2022-11-24 00:00:00'),
									 (32,31,12,41,'20','2560','2022-11-24 00:00:00'),
									 (33,32,12,42,'11','210','2022-11-24 00:00:00'),
									 (34,13,16,41,'21','2630','2022-11-24 00:00:00'),
									 (35,14,16,41,'30','259','2022-11-24 00:00:00'),
									 (36,15,16,41,'25','263','2022-11-24 00:00:00'),
									 (37,16,16,41,'23','291','2022-11-24 00:00:00'),
									 (38,17,16,41,'27','2500','2022-11-24 00:00:00'),
									 (39,18,16,41,'14','2561','2022-11-24 00:00:00'),
									 (40,19,16,41,'17','2912','2022-11-24 00:00:00'),
									 (41,20,16,41,'10','2921','2022-11-24 00:00:00');
										 
									  
/*------------------------------------------------------------------------------------------------------------------------*/
	-- VISTAS
/*TE MUESTRA QUIENES SON LOS CHOFERES QUE CONFORMAN A DICHA REMISERIA, LOS AUTOS QUE TIENE CADA REMISERIA Y LA PATENTE CON SU RESPECTIVO 
CHOFER.
ES PARA DAR UN PANORAMA GENERAL DE LO QUE PUEDE LLEGAR A OFRECER DICHA REMISERIA,
DONDE ESTA UBICADA Y QUE TAN EFICIENTE ES A LA HORA DE HACER VIAJES(MEDIANTE LA CANTIDAD DE CHOFERES).*/
DROP VIEW IF EXISTS vw_Datos_Empresa;

CREATE OR REPLACE VIEW vw_Datos_Empresa AS(
SELECT concat(Re.id_remiseria , "-" , Re.Nombre_Remiseria) AS id_Nombre_Remi , Re.Telefono , Di.Direccion , P.Pais , CONCAT(Ch.id_choferes, "-",Ch.Nombre, " ",Ch.Apellido) AS id_Nombre_Chof ,Au.Patente
FROM Automovil AS Au
JOIN choferes AS Ch ON Au.id_automovil = Ch.id_automovil
JOIN Remiserias AS Re ON Ch.id_remiseria = Re.id_remiseria
JOIN Direccion AS Di ON Re.id_direccion = Di.id_direccion
JOIN Localidad AS Lo ON Di.id_localidad = Lo.id_localidad
JOIN Provincia AS Pr ON Lo.id_provincia = Pr.id_provincia
JOIN Pais AS P ON Pr.id_pais = P.id_pais);


/*MUESTRA LA INFORMACION RENUMERADA DE CADA EMPRESA COMO LOS KILOMETROS RECORRIDOS TOTAL (POR CADA CHOFER) Y 
LA GANANCIA TOTAL GENERADA (NO NETA) DE LA EMPRESA.
*/
DROP VIEW IF EXISTS vw_Registro_Empresa;

CREATE OR REPLACE VIEW vw_Registro_Empresa as ( 
select concat(R.id_remiseria, " " , R.Nombre_Remiseria) as Id_Y_Nombre , sum(V.Kilometro_recorrido) as Total_Recorrido, sum(V.precio) as Ganancia_Total
from Remiserias as R
JOIN Choferes as C on C.id_remiseria = R.id_remiseria
JOIN Viajes as V on C.id_choferes = V.id_choferes
group by R.id_remiseria
);	


/*CANTIDAD DE USUARIOS EN CIERTO PAIS.
*/
DROP VIEW IF EXISTS vw_Cant_Pais;

CREATE OR REPLACE VIEW vw_Cant_Pais as (
select concat(P.id_pais," ",P.Pais) as Id_Pais ,count(P.id_pais) as Personas_Pais
from direccion as D
JOIN Localidad as L on D.id_localidad = L.id_localidad
JOIN Provincia as Pr on L.id_provincia = Pr.id_provincia
JOIN Pais as P on Pr.id_pais = P.id_pais
JOIN Usuarios as U on U.id_direccion = D.id_direccion
group by P.id_pais
);


/*CANTIDAD DE USUARIOS EN CIERTA PROVINCIA.
*/
DROP VIEW IF EXISTS vw_cant_Provincia;

CREATE OR REPLACE VIEW vw_cant_Provincia as (
select concat(Pr.id_provincia," ",Pr.Provincia) as id_Provincia ,count(Pr.id_provincia) as Personas_Provincia
from direccion as D
JOIN Localidad as L on D.id_localidad = L.id_localidad
JOIN Provincia as Pr on L.id_provincia = Pr.id_provincia
JOIN Pais as P on Pr.id_pais = P.id_pais
JOIN Usuarios as U on U.id_direccion = D.id_direccion
group by Pr.id_provincia
);


/*CANTIDAD DE USUARIOS EN CIERTA LOCALIDAD.
*/
DROP VIEW IF EXISTS vw_cant_Localidades;

CREATE OR REPLACE VIEW vw_cant_Localidades as (
select concat(L.id_localidad," ",L.Localidad) as id_Localidad ,count(L.id_localidad) as Personas_Provincia
from direccion as D
JOIN Localidad as L on D.id_localidad = L.id_localidad
JOIN Provincia as Pr on L.id_provincia = Pr.id_provincia
JOIN Pais as P on Pr.id_pais = P.id_pais
JOIN Usuarios as U on U.id_direccion = D.id_direccion
group by L.id_localidad
);


/*CANTIDAD DE VIAJES REALIZADOS POR CIERTO REMISERO.
*/
DROP VIEW IF EXISTS vw_Viajes_Totales;

CREATE OR REPLACE VIEW vw_Viajes_Totales as (
select concat(C.id_choferes , " " , C.Nombre , " " , C.Apellido) as Id_Nombre_Apellido, count(V.id_viajes) as Viajes_Totales
from viajes as V
JOIN Choferes as C on V.id_choferes = C.id_choferes
group by C.id_choferes
);


/*------------------------------------------------------------------------------------------------------------------------*/
-- -- -- -- FUNCIONES
/* LA IDEA DE ESTA FUNCION ES QUE POR CADA VIAJE, DEPENDIENDO DE LA EMPRESA, SE LLEVE UN PORCENTAJE POR CADA VIAJE HECHO. 
EJ; SI HACE UN VIAJE DE 850
PESOS Y LA EMPRESA POR CADA VIAJE LE QUITA UN 20% , DEL RESULTADO ESE, ESE RESULTADO SE LO QUEDA LA EMPRESA.*/

DROP FUNCTION IF EXISTS fn_Comision_Empresa

delimiter $$
CREATE FUNCTION fn_Comision_Empresa (porcent_empresa float, v_viaje int) 
returns float
 deterministic 
 begin
 
 declare comision_empresa float ;
 set comision_empresa =  
      (select V.precio * porcent_empresa
from viajes as V
JOIN choferes as C on C.id_choferes = V.id_choferes
JOIN Remiserias as R on C.id_remiseria = R.id_remiseria
where V.id_viajes = v_viaje
       );
   return  comision_empresa;   
 end$$ 
 
 delimiter ;

 
-- -- -- -- NUEVO ALTER -- -- -- --
ALTER TABLE viajes
ADD Ganancia_Empresa_Por_Viaje FLOAT AFTER Precio;


update viajes as V
JOIN choferes as C on C.id_choferes = V.id_choferes
JOIN Remiserias as R on C.id_remiseria = R.id_remiseria
SET Ganancia_Empresa_Por_Viaje = fn_Comision_Empresa(0.50,id_viajes)
WHERE R.Nombre_Remiseria LIKE '%Remis R8';

update viajes as V
JOIN choferes as C on C.id_choferes = V.id_choferes
JOIN Remiserias as R on C.id_remiseria = R.id_remiseria
SET Ganancia_Empresa_Por_Viaje = fn_Comision_Empresa(0.50,id_viajes)
WHERE R.Nombre_Remiseria LIKE '%Remises Tribunal';

update viajes as V
JOIN choferes as C on C.id_choferes = V.id_choferes
JOIN Remiserias as R on C.id_remiseria = R.id_remiseria
SET Ganancia_Empresa_Por_Viaje = fn_Comision_Empresa(0.50,id_viajes)
WHERE R.Nombre_Remiseria LIKE '%Remises Matheu';

update viajes as V
JOIN choferes as C on C.id_choferes = V.id_choferes
JOIN Remiserias as R on C.id_remiseria = R.id_remiseria
SET Ganancia_Empresa_Por_Viaje = fn_Comision_Empresa(0.50,id_viajes)
WHERE R.Nombre_Remiseria LIKE '%Remis Tandil';


-- -- -- -- ALTER VIEW -- -- -- --
CREATE OR REPLACE VIEW vw_Registro_Empresa as ( 
select concat(R.id_remiseria, " " , R.Nombre_Remiseria) as Id_Y_Nombre , sum(V.Kilometro_recorrido) as Total_Recorrido, sum(V.precio) as Ganancia_Total , sum(V.Ganancia_Empresa_Por_Viaje) AS Comision_Para_Empresa
from Remiserias as R
JOIN Choferes as C on C.id_remiseria = R.id_remiseria
JOIN Viajes as V on C.id_choferes = V.id_choferes
group by R.id_remiseria
);	


/*LA IDEA DE ESTA FUNCION ES AGREGARLE EL IVA AL PRECIO DEL VIAJE, DEPENDIENDO DEL PAIS TIENE DIFERENTE IVA*/

DROP FUNCTION IF EXISTS fn_agregar_iva;

delimiter $$
CREATE FUNCTION fn_agregar_iva (insert_iva float , v_viaje int) 
returns float
 deterministic 
 begin
 -- consulta y lógica sql
 declare agregar_iva float ;
 set agregar_iva=  
      (select V.precio * insert_iva
from viajes as V
JOIN choferes as C on C.id_choferes = V.id_choferes
JOIN Remiserias as R on C.id_remiseria = R.id_remiseria
where V.id_viajes = v_viaje
       );
       
   return  agregar_iva;   
 end$$ 
 
 delimiter ;

 
 -- -- -- -- NUEVO ALTER -- -- -- --
 ALTER TABLE viajes
 ADD Precio_Con_Iva FLOAT AFTER PRECIO;
 
UPDATE viajes AS V
JOIN choferes AS Ch ON V.id_choferes = Ch.id_choferes
JOIN remiserias AS Re ON Ch.id_remiseria = Re.id_remiseria
JOIN direccion AS D ON Re.id_direccion = D.id_direccion
JOIN localidad AS Lo ON D.id_localidad = Lo.id_localidad
JOIN provincia AS Pr ON Lo.id_provincia = Pr.id_provincia
JOIN pais AS P ON Pr.id_pais = P.id_pais
SET Precio_Con_Iva = fn_agregar_iva(1.21,id_viajes)
where P.Pais LIKE '%Argentina';

UPDATE viajes AS V
JOIN choferes AS Ch ON V.id_choferes = Ch.id_choferes
JOIN remiserias AS Re ON Ch.id_remiseria = Re.id_remiseria
JOIN direccion AS D ON Re.id_direccion = D.id_direccion
JOIN localidad AS Lo ON D.id_localidad = Lo.id_localidad
JOIN provincia AS Pr ON Lo.id_provincia = Pr.id_provincia
JOIN pais AS P ON Pr.id_pais = P.id_pais
SET Precio_Con_Iva = fn_agregar_iva(0.22,id_viajes)
where P.Pais LIKE '%Uruguay';


/*CUENTA LA CANTIDAD DE CHOFERES QUE TIENEN EL MISMO MODELO DE AUTO*/
DROP FUNCTION IF EXISTS fn_contar_modelo;

delimiter //
create function fn_contar_modelo (Modelo_A_Contar INT) returns int
deterministic 
begin
declare numero int;
set numero = (SELECT COUNT(A.id_Modelo)
	FROM automovil AS A
		JOIN modelo AS M ON A.id_modelo = M.id_modelo
			WHERE A.id_modelo = Modelo_A_Contar);
    return numero ;
    end //
    delimiter ;
    

-- -- -- -- STORE PROCEDURE -- -- -- --
/* MEDIANTE EL DOCUMENTO UNICO DE IDENTIDAD PODEMOS BUSCAR A LA PERSONA FACILMENTE Y QUE NOS DEVUELVA TODOS SUS DATOS*/

DROP PROCEDURE IF EXISTS sp_Busca_Documento;

delimiter //   
CREATE PROCEDURE sp_Busca_Documento (inout p_DNI int, 
					out p_Nombre varchar(60), 
                                     out p_Apellido varchar(60),
					out p_Fecha_Nacimiento date, 
                                     out p_sexo enum('Masculino','Femenino'), 
                                     out p_telefono varchar(60),
					out p_mail varchar(60),
                    out p_Tipo varchar(30))
BEGIN          
( SELECT U.DNI , U.Nombre , U.Apellido , U.Fecha_Nacimiento , U.Sexo , U.Numero_Tel , U.Mail_Us, CONCAT("Usuario") AS Tipo  
FROM usuarios AS U
WHERE DNI = p_DNI)
UNION
(SELECT C.DNI , C.Nombre , C.Apellido , C.Fecha_Nacimiento , C.Sexo , C.Numero_Tel_Ch , C.Mail_Ch, CONCAT("Chofer") AS Tipo FROM choferes AS C
WHERE DNI = p_DNI) 
into p_DNI , p_Nombre, p_Apellido, p_Fecha_Nacimiento , p_sexo , p_telefono , p_mail , p_Tipo;
end //         
delimiter ;  
               
-- set @p_DNI = 43874709
-- call sp_Busca_Documento(@p_DNI, @p_Nombre, @p_Apellido, @p_Fecha_Nacimiento, @p_sexo, @p_telefono, @p_mail, @p_Tipo);
-- select @p_DNI, @p_Nombre, @p_Apellido, @p_Fecha_Nacimiento, @p_sexo, @p_telefono, @p_mail, @p_Tipo;


/*BORRA EL ULTIMO USUARIO CON EL DOCUMENTO DUPLICADO Y SI NO HAY DUPLICADO, ESTE NO HACE NADA*/
DROP PROCEDURE IF EXISTS sp_Si_Hay_Duplicado;

delimiter //
create procedure sp_Si_Hay_Duplicado (in Persona_dni VARCHAR(50), out respuesta varchar(255))
begin
declare cuenta int;
declare id int;
	set cuenta = (select count(*) from usuarios where DNI = Persona_dni);
	if cuenta > 1 then
		set id = (select max(id_usuario) from usuarios where DNI = Persona_dni limit 1);
		select concat_ws(' ', 'El usuario llamado:',Nombre, Apellido, ', con Dni:', DNI, 'fue eliminado, porque otro usuario tiene el mismo dni' ) into respuesta from usuarios
        where id_usuario = id;
        delete from usuarios where id_usuario = id;
	else
		select concat('El dni no esta duplicado') into respuesta;
    
	end if;
  
end //
delimiter ;

-- insert into usuarios values (30, 43874709, "Agustin", "Agulleiro","2002-01-02","Masculino",1161854171,"AGMOAGMAOI",4);

-- set @respuesta = '0';
-- call rast3.sp_Si_Hay_Duplicado('43874709', @respuesta);
-- select @respuesta;

-- insert into usuarios values (30, 43874709, "Agustin", "Agulleiro","2002-01-02","Masculino",1161854171,"AGMOAGMAOI",4);


/*------------------------------------------------------------------------------------------------------------------------*/
-- -- -- -- TRIGGERS
/*CREO UNA TABLA DE CONTROL , POR SI ALGUN CHOFER QUIERE HACER UNA MODIFICACION*/
DROP TABLE IF EXISTS LOG_CHOF_UP;

CREATE TABLE IF NOT EXISTS LOG_CHOF_UP(
id_log int not null auto_increment,
Nombre_Tabla varchar (60),
-- id_choferes int,
campoanterior_camponuevo_chofer varchar(255),
-- DNI int,
campoanterior_camponuevo_dni varchar(255),
-- Nombre varchar(80),
-- Apellido varchar(80),
campoanterior_camponuevo_na varchar(255),
-- Fecha_Nacimiento date,
campoanterior_camponuevo_Fn VARCHAR(255),
-- Sexo enum('Masculino','Femenino'),
campoanterior_camponuevo_sexo varchar(255),
-- Numero_Tel_Ch,
campoanterior_camponuevo_Tel VARCHAR (255),
-- Mail_Ch
campoanterior_camponuevo_Ma VARCHAR(255),
-- id_remiseria int,
campoanterior_camponuevo_ir varchar(255),
-- id_automovil int,
campoanterior_camponuevo_ia varchar(255),
Nombre_De_Accion varchar(30),
Fecha_Update_New datetime,
Primary key (id_log));


DROP TRIGGER IF EXISTS TRG_LOG_CHOF;
delimiter //
CREATE TRIGGER TRG_LOG_CHOF AFTER UPDATE ON CHOFERES
for each row
begin
INSERT INTO LOG_CHOF_UP (Nombre_Tabla, campoanterior_camponuevo_chofer, campoanterior_camponuevo_dni, campoanterior_camponuevo_na,campoanterior_camponuevo_Fn ,campoanterior_camponuevo_sexo, campoanterior_camponuevo_Tel , campoanterior_camponuevo_Ma , campoanterior_camponuevo_ir , campoanterior_camponuevo_ia , Nombre_De_Accion , Fecha_Update_New)
VALUES ("CHOFERES", Concat("Old / New",OLD.id_choferes, "-", NEW.id_choferes), Concat(OLD.DNI,"-",NEW.DNI), Concat(Old.Nombre,"-",Old.Apellido ,"-" ,NEW.Nombre,"-",New.Apellido),CONCAT(OLD.Fecha_Nacimiento,"-",NEW.Fecha_Nacimiento),Concat(Old.Sexo,"-",New.Sexo),CONCAT(OLD.Numero_Tel_Ch,"-",NEW.Numero_Tel_Ch),CONCAT(OLD.Mail_Ch,"-",NEW.Mail_Ch),Concat(Old.id_remiseria,"-",New.id_remiseria),concat(old.id_automovil,"-",new.id_automovil),"UPDATE", now());
END //
delimiter ;

/*CREO UNA TABLA DE CONTROL , POR CADA USUARIO QUE INGRESE NUEVO A LA BASE DE DATOS*/
DROP TABLE IF EXISTS LOG_USU_IN;

CREATE TABLE IF NOT EXISTS LOG_USU_IN(
id_log INT NOT NULL AUTO_INCREMENT,
Nombre_Tabla VARCHAR(255),
-- id_Usuario
campoanterior_camponuevo_Usuario VARCHAR(255),
-- DNI
campoanterior_camponuevo_DNI VARCHAR(255),
-- NOMBRE
-- APELLIDO
campoanterior_camponuevo_na VARCHAR(255),
-- FECHA_NACIMIENTO date
campoanterior_camponuevo_Fn VARCHAR(255),
-- Sexo
campoanterior_camponuevo_Sexo VARCHAR(255),
-- Numero_Tel
campoanterior_camponuevo_Tel VARCHAR(255),
-- Mail_Us
campoanterior_camponuevo_Mail VARCHAR(255),
-- id_direccion
campoanterior_camponuevo_Id VARCHAR(255),
Nombre_Accion VARCHAR (30),
Fecha_Update_New datetime,
PRIMARY KEY (id_log));


DROP TRIGGER IF EXISTS TRG_LOG_USU_IN
delimiter //
CREATE TRIGGER TRG_LOG_USU_IN AFTER INSERT ON usuarios
FOR EACH ROW
begin
INSERT INTO LOG_USU_IN (Nombre_Tabla, campoanterior_camponuevo_Usuario, campoanterior_camponuevo_DNI , campoanterior_camponuevo_na , campoanterior_camponuevo_Fn, campoanterior_camponuevo_Sexo, campoanterior_camponuevo_Tel, campoanterior_camponuevo_Mail , campoanterior_camponuevo_Id,Nombre_Accion,Fecha_Update_New)
VALUES ("USUARIOS",NEW.id_usuario,NEW.DNI,CONCAT(NEW.Nombre,"-",NEW.Apellido),NEW.Fecha_Nacimiento,NEW.Sexo,NEW.Numero_Tel,NEW.Mail_Us,NEW.id_direccion,"INSERT" ,NOW());
 END//
delimiter ;

/*CREO UNA TABLA DE CONTROL , POR SI ALGUN USUARIO QUIERE HACER UNA MODIFICACION*/
DROP TABLE IF EXISTS LOG_USU_UP;

CREATE TABLE IF NOT EXISTS LOG_USU_UP(
id_log INT NOT NULL AUTO_INCREMENT,
Nombre_Tabla VARCHAR(255),
-- id_Usuario
campoanterior_camponuevo_Usuario VARCHAR(255),
-- DNI
campoanterior_camponuevo_DNI VARCHAR(255),
-- NOMBRE
-- APELLIDO
campoanterior_camponuevo_na VARCHAR(255),
-- FECHA_NACIMIENTO date
campoanterior_camponuevo_Fn VARCHAR(255),
-- Sexo
campoanterior_camponuevo_Sexo VARCHAR(255),
-- Numero_Tel
campoanterior_camponuevo_Tel VARCHAR(255),
-- Mail_Us
campoanterior_camponuevo_Mail VARCHAR(255),
-- id_direccion
campoanterior_camponuevo_Id VARCHAR(255),
Nombre_Accion VARCHAR (30),
Fecha_Update_New datetime,
PRIMARY KEY (id_log));


DROP TRIGGER IF EXISTS TRG_LOG_USU_UP
delimiter //
CREATE TRIGGER TRG_LOG_USU_UP BEFORE UPDATE ON usuarios
FOR EACH ROW
begin
INSERT INTO LOG_USU_IN (Nombre_Tabla, campoanterior_camponuevo_Usuario, campoanterior_camponuevo_DNI , campoanterior_camponuevo_na , campoanterior_camponuevo_Fn, campoanterior_camponuevo_Sexo, campoanterior_camponuevo_Tel, campoanterior_camponuevo_Mail , campoanterior_camponuevo_Id,Nombre_Accion,Fecha_Update_New)
VALUES ("USUARIOS",CONCAT(OLD.id_usuario,"-",NEW.id_usuario),CONCAT(OLD.DNI,"-",NEW.DNI),CONCAT(OLD.Nombre,"-",Old.Apellido,"-",NEW.Nombre,"-",NEW.Apellido),CONCAT(OLD.Fecha_Nacimiento,"-",NEW.Fecha_Nacimiento),CONCAT(OLD.Sexo,"-",NEW.Sexo),CONCAT(OLD.Numero_Tel,"-",NEW.Numero_Tel),CONCAT(OLD.Mail_Us,"-",NEW.Mail_Us),CONCAT(OLD.id_direccion,"-",NEW.id_direccion),"UPDATE",NOW());
END //
delimiter ;


/*------------------------------------------------------------------------------------------------------------------------*/
-- -- -- -- SUBLENGUAJE DCL -- -- -- --
-- Select * from Mysql.User;
-- Creo un usuario Para Rafael que ingresa como Junior a la Empresa
DROP USER IF EXISTS 'Rafael'@'localhost';
CREATE USER IF NOT EXISTS 'Rafael'@'localhost' IDENTIFIED BY 'Rafael123';

-- Creo un usuario Para Julian que ingresa como Semi-Senior a la Empresa
DROP USER IF EXISTS 'Julian'@'localhost';
CREATE USER IF NOT EXISTS 'Julian'@'localhost' IDENTIFIED BY 'Julian222';

-- Creo un usuario Para Sofia que ingresa como Semi-Senior a la Empresa
DROP USER IF EXISTS 'Sofia'@'localhost';
CREATE USER IF NOT EXISTS 'Sofia'@'localhost' IDENTIFIED BY 'Sofia999';

-- Creo un usuario llamado Recluters a modo de examen para la gente que incoporaria en esta empresa llamada Rast.
DROP USER IF EXISTS 'Recluters'@'localhost';
CREATE USER IF NOT EXISTS 'Recluters'@'localhost' identified by 'Recluters123';

-- Usuarios contratados de nivel basico, comenzando a generar experiencia en la base de datos.
DROP USER IF EXISTS 'Junior'@'locashost';
CREATE USER IF NOT EXISTS 'Junior'@'locashost' identified by 'Juniors123';

-- Usuarios Experimentados , Con nivel intermedio, ya con una facilidad para resolver problemas planteados.
DROP USER IF EXISTS 'Semi-Senior'@'localhost';
CREATE USER IF NOT EXISTS 'Semi-Senior'@'localhost'identified by 'Semi-Seniors123';

-- Usuarios Con una experencia solida y con una gran facilidad para desenvolverse en el area y con la capacidad de resolver problemas sin ninguna dificultad.
DROP USER IF EXISTS 'Senior'@'localhost';
CREATE USER IF NOT EXISTS 'Senior'@'localhost' identified by 'Senior123';

GRANT SELECT , insert , update ON rast3.* TO 'Rafael'@'localhost';

GRANT SELECT , INSERT , UPDATE, delete , references  ON RAST3.* TO 'Julian'@'localhost';

GRANT SELECT , INSERT , UPDATE , DELETE ,REFERENCES ON RAST3.* TO 'Sofia'@'localhost';

grant SELECT on rast2.* to 'Recluters'@'localhost';

grant select , insert , update on rast2.* to 'Junior'@'locashost';

grant select , insert , update , delete , references on rast2.* to 'Semi-Senior'@'localhost';

grant all on rast2.* to 'Senior'@'localhost';


-- -- -- -- Sublenguaje TCL
SELECT @@AUTOCOMMIT;
SET @@AUTOCOMMIT = 0;
START TRANSACTION;
-- SAVEPOINT INSERT0
INSERT INTO DIRECCION VALUES (51,'Emilio Castro 729',2);
INSERT INTO DIRECCION VALUES (52,'Av. Cabildo 4979',2);
INSERT INTO DIRECCION VALUES (53,'Conesa 3299',2);
INSERT INTO DIRECCION VALUES (54,'Av. García del Río 2482',2);
SAVEPOINT INSERT1;
INSERT INTO DIRECCION VALUES (55,'Av. Andrés Rolón 522',3);
INSERT INTO DIRECCION VALUES (56,'Av. Juan Segundo Fernández 68',3);
INSERT INTO DIRECCION VALUES (57,'25 de Mayo 116',3);
INSERT INTO DIRECCION VALUES (58,'Jorge Newbery 882',3);
SAVEPOINT INSERT2;
INSERT INTO REMISERIAS VALUES (13,'San Cristobal','2005-07-11',16);
INSERT INTO REMISERIAS VALUES (14,'Remises Ramallo','2007-08-01',17);
INSERT INTO REMISERIAS VALUES (15,'Olimpia Remises','2010-06-25',18);
INSERT INTO REMISERIAS VALUES (16,'Remises Delta','2006-05-30',19);
SAVEPOINT INSERT3;
INSERT INTO REMISERIAS VALUES (17,'Remises La Rotonda','2006-08-21',20);
INSERT INTO REMISERIAS VALUES (18,'Jockey Remis','2001-05-27',21);
INSERT INTO REMISERIAS VALUES (19,'Remises Turismo','2022-11-15',22);
INSERT INTO REMISERIAS VALUES (20,'Remises Newbery','2019-03-17',23);
COMMIT;
-- ROLLBACK TO INSERT2;
-- ROLLBACK;

START TRANSACTION;
DELETE FROM REMISERIAS WHERE id_remiseria = 13 AND 14 AND 15 AND 16;
DELETE FROM REMISERIAS WHERE id_remiseria = 17 AND 18 AND 19 AND 20;
DELETE FROM DIRECCION WHERE id_direccion = 51 AND 52 AND 53 AND 54;
UPDATE USUARIOS SET Sexo = 'Masculino' 
WHERE id_usuario = 10;
-- rollback;
COMMIT;
/*------------------------------------------------------------------------------------------------------------------------*/
SET @@AUTOCOMMIT = 1;
SET SQL_SAFE_UPDATES = 1;