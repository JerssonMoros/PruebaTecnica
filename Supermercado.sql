CREATE DATABASE Supermercado  
GO  

USE Supermercado
GO

--Creacion de tablas

CREATE TABLE dbo.Cliente
   (clienteID int PRIMARY KEY IDENTITY(1,1),  
   nombreCliente varchar(25) NOT NULL,
   direccion varchar(25) NOT NULL,
)  
GO  

CREATE TABLE dbo.Producto
	(productoID int PRIMARY KEY IDENTITY(1,1),
	nombreProducto varchar(30) NOT NULL,
	valor int
	)
GO

CREATE TABLE dbo.cabeza_factura
   (numero int PRIMARY KEY IDENTITY(1,1),   
   fecha datetime NOT NULL,
   IdCliente int NOT NULL,
   total int,
   CONSTRAINT FK_Cliente FOREIGN KEY (IdCliente)
    REFERENCES Cliente(clienteID)
)  
GO  

CREATE TABLE dbo.detalle_factura
   (IdDetalle int PRIMARY KEY,
   IdNumero int,  
   IdProducto int NOT NULL,
   cantidad int NOT NULL,
   valor int,
   CONSTRAINT FK_Producto FOREIGN KEY (IdProducto)
    REFERENCES Producto(ProductoID),
	CONSTRAINT FK_factura FOREIGN KEY (IdNumero)
    REFERENCES cabeza_factura(Numero)
)  
GO

CREATE TRIGGER TR_valorxcant ON dbo.detalle_factura FOR INSERT
AS 
BEGIN
	DECLARE @cantidad AS int
	DECLARE @id_detalle AS int
	DECLARE @id_producto_factura AS int
	DECLARE @valor_producto AS int

set @cantidad = (SELECT cantidad FROM inserted)
set @id_detalle = (SELECT IdDetalle FROM inserted)
set @id_producto_factura = (SELECT Idproducto FROM inserted)
set @valor_producto = (SELECT Valor FROM dbo.Producto AS pr WHERE @id_producto_factura = pr.ProductoID)

UPDATE dbo.detalle_factura
set valor = @cantidad * @valor_producto
WHERE @id_detalle = IdDetalle
PRINT('valor')
END
GO

CREATE TRIGGER TR_Calculo_total ON dbo.detalle_factura AFTER INSERT
AS
BEGIN
	DECLARE @idnumero AS int
	DECLARE @id_detalle AS int
	DECLARE @valor AS int

set @idnumero = (SELECT Idnumero FROM inserted)
set @id_detalle = (SELECT IdDetalle FROM inserted)
set @valor = (SELECT valor FROM dbo.detalle_factura AS df WHERE df.IdDetalle = @id_detalle)

UPDATE dbo.cabeza_factura
set Total = Total + @valor
WHERE @idnumero = Numero
print('Total')
END
GO

INSERT dbo.Cliente(nombreCliente,Direccion) VALUES ('Juan Toche','Calle a')
INSERT dbo.Cliente(nombreCliente,Direccion) VALUES ('Camilo Diaz','Calle b')
INSERT dbo.Cliente(nombreCliente,Direccion) VALUES ('Tomas Moros','Calle c')
INSERT dbo.Cliente(nombreCliente,Direccion) VALUES ('Abu David','Calle d')

INSERT dbo.Producto(nombreProducto,Valor) VALUES ('Televisor',5800)
INSERT dbo.Producto(nombreProducto,Valor) VALUES ('Telefono',970)
INSERT dbo.Producto(nombreProducto,Valor) VALUES ('Camisa',520)
INSERT dbo.Producto(nombreProducto,Valor) VALUES ('Computador',3500)
INSERT dbo.Producto(nombreProducto,Valor) VALUES ('Cama',1290)

INSERT dbo.cabeza_factura(Fecha,IdCliente, Total) VALUES ('11-10-2022',1,0)
INSERT dbo.cabeza_factura(Fecha,IdCliente, Total) VALUES ('10-24-2022',2,0)
INSERT dbo.cabeza_factura(Fecha,IdCliente, Total) VALUES ('09-12-2021',3,0)
INSERT dbo.cabeza_factura(Fecha,IdCliente, Total) VALUES ('01-24-2005',2,0)
INSERT dbo.cabeza_factura(Fecha,IdCliente, Total) VALUES ('02-12-2005',3,0)

INSERT dbo.detalle_factura(IdDetalle, Idnumero, Idproducto, cantidad) VALUES (4,1,2,4)
INSERT dbo.detalle_factura(IdDetalle, Idnumero, Idproducto, cantidad) VALUES (5,1,4,6)
INSERT dbo.detalle_factura(IdDetalle, Idnumero, Idproducto, cantidad) VALUES (1,2,2,4)
INSERT dbo.detalle_factura(IdDetalle, Idnumero, Idproducto, cantidad) VALUES (2,2,3,2)
INSERT dbo.detalle_factura(IdDetalle, Idnumero, Idproducto, cantidad) VALUES (3,2,5,3)
INSERT dbo.detalle_factura(IdDetalle, Idnumero, Idproducto, cantidad) VALUES (6,3,1,6)
INSERT dbo.detalle_factura(IdDetalle, Idnumero, Idproducto, cantidad) VALUES (7,3,2,3)
INSERT dbo.detalle_factura(IdDetalle, Idnumero, Idproducto, cantidad) VALUES (8,4,2,4)
INSERT dbo.detalle_factura(IdDetalle, Idnumero, Idproducto, cantidad) VALUES (9,4,3,2)
INSERT dbo.detalle_factura(IdDetalle, Idnumero, Idproducto, cantidad) VALUES (10,5,5,3)
INSERT dbo.detalle_factura(IdDetalle, Idnumero, Idproducto, cantidad) VALUES (11,5,1,6)
INSERT dbo.detalle_factura(IdDetalle, Idnumero, Idproducto, cantidad) VALUES (12,5,2,3)

SELECT * FROM cabeza_factura