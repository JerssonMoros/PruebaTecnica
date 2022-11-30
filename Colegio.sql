CREATE DATABASE Colegio  
GO  

USE Colegio
GO

CREATE TABLE dbo.Periodo  
   (periodoID int PRIMARY KEY IDENTITY(1,1),  
   nombrePeriodo varchar(25) NOT NULL)  
GO  

CREATE TABLE dbo.Estudiante  
   (estudianteID int PRIMARY KEY IDENTITY(1,1),  
   nombre varchar(25) NOT NULL,
   apellido varchar(25) NOT NULL,
   documento int NOT NULL,
   curso int NOT NULL)  
GO  

CREATE TABLE dbo.Materia  
   (materiaID int PRIMARY KEY IDENTITY(1,1),  
   nombreMateria varchar(25) NOT NULL,
   creditos int)  
GO  

Create Table dbo.MateriaxEstudianteXPeriodo
	(Id int PRIMARY KEY IDENTITY(1,1),
	IdPeriodo int,
	IdMateria int,
	IdEstudiante int,
	nota int,
	CONSTRAINT FK_Estudiante FOREIGN KEY (IDEstudiante)
    REFERENCES Estudiante(EstudianteID),
	CONSTRAINT FK_Materia FOREIGN KEY (IDMateria)
    REFERENCES Materia(MateriaID),
	CONSTRAINT FK_Periodo FOREIGN KEY (IDPeriodo)
    REFERENCES Periodo(PeriodoID)
	)
GO

INSERT dbo.Periodo(NombrePeriodo) VALUES ('Primero')
INSERT dbo.Periodo(NombrePeriodo) VALUES ('Segundo')
INSERT dbo.Periodo(NombrePeriodo) VALUES ('Tercero')
INSERT dbo.Periodo(NombrePeriodo) VALUES ('Cuarto')

INSERT dbo.Estudiante(Nombre, Apellido, Documento, Curso) VALUES ('Jersson','Garzon', 1000782894, 8)
INSERT dbo.Estudiante(Nombre, Apellido, Documento, Curso) VALUES ('Camilo','Diaz', 102212121, 6)
INSERT dbo.Estudiante(Nombre, Apellido, Documento, Curso) VALUES ('Juan','Perez', 100433131, 3)
INSERT dbo.Estudiante(Nombre, Apellido, Documento, Curso) VALUES ('Pablo','Escobar', 100455435, 4)

INSERT dbo.Materia(NombreMateria, Creditos) VALUES ('Matematicas',3)
INSERT dbo.Materia(NombreMateria, Creditos) VALUES ('Ciencias',3)
INSERT dbo.Materia(NombreMateria, Creditos) VALUES ('Deporte',2)
INSERT dbo.Materia(NombreMateria, Creditos) VALUES ('Tecnologia',3)

INSERT dbo.MateriaxEstudianteXPeriodo(IDEstudiante,IDMateria,IDPeriodo,Nota) VALUES (1,3,2,89)
INSERT dbo.MateriaxEstudianteXPeriodo(IDEstudiante,IDMateria,IDPeriodo,Nota) VALUES (2,1,4,100)
INSERT dbo.MateriaxEstudianteXPeriodo(IDEstudiante,IDMateria,IDPeriodo,Nota) VALUES (3,2,1,43)
INSERT dbo.MateriaxEstudianteXPeriodo(IDEstudiante,IDMateria,IDPeriodo,Nota) VALUES (4,4,3,70)
INSERT dbo.MateriaxEstudianteXPeriodo(IDEstudiante,IDMateria,IDPeriodo,Nota) VALUES (1,3,3,95)

Select e.Nombre, e.Apellido, m.NombreMateria, p.NombrePeriodo, mep.Nota
from MateriaxEstudianteXPeriodo as mep
inner join  Estudiante as e 
on e.EstudianteID = mep.IDEstudiante
inner join Materia as m
on m.MateriaID = mep.IDMateria
inner join Periodo as p
on p.PeriodoID = mep.IDPeriodo