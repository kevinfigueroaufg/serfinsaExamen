CREATE DATABASE [db_serfinsa]
ON
PRIMARY
(
  NAME = N'db_serfinsa',
  FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\db_serfinsa.ndf',
  SIZE = 8MB,
  MAXSIZE = UNLIMITED,
  FILEGROWTH = 64MB
)
LOG ON
(
  NAME = N'db_serfinsa_log',
  FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\db_serfinsa_log.ldf',
  SIZE = 8MB,
  MAXSIZE = UNLIMITED,
  FILEGROWTH = 64MB
)
GO

ALTER DATABASE [db_serfinsa] COLLATE Latin1_General_100_CI_AI_SC_UTF8

CREATE TABLE rol (
  id INT IDENTITY PRIMARY KEY,
  nombre NVARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE usuario (
  id INT IDENTITY PRIMARY KEY,
  mail NVARCHAR(50) NOT NULL UNIQUE,
  contrasenia NVARCHAR(60) NOT NULL
);

CREATE TABLE usuario_rol (
  usuario_id INT NOT NULL,
  rol_id INT NOT NULL,
  CONSTRAINT FK_usuario FOREIGN KEY(usuario_id) REFERENCES usuario(id),
  CONSTRAINT FK_rol FOREIGN KEY(rol_id) REFERENCES rol(id),
  PRIMARY KEY(usuario_id, rol_id)
);


-- ----------------------------
-- Records of usuario
-- ----------------------------
SET IDENTITY_INSERT [dbo].[usuario] ON
GO

INSERT INTO [dbo].[usuario] ([id], [mail], [contrasenia]) VALUES (N'2', N'kevin@correo.com', N'$2a$10$gxA6CorKTkxqWnxnq7zZkOL9v.gu85gRVIdTK8gRRMi8T46qh/G/G')
GO

INSERT INTO [dbo].[usuario] ([id], [mail], [contrasenia]) VALUES (N'3', N'guess@correo.com', N'$2a$10$mjZlGGD.K0.gqdz0JjYfFOK/yzBLmuRTpalq6E07eACNVfqvp7PAS')
GO

INSERT INTO [dbo].[usuario] ([id], [mail], [contrasenia]) VALUES (N'4', N'admin@correo.com', N'$2a$10$ABaMSJATECFh.8pf5WRb.eTQCOx1JCi2RLvfSKIEUktOD62a71C/S')
GO

SET IDENTITY_INSERT [dbo].[usuario] OFF
GO

-- ----------------------------
-- Records of rol
-- ----------------------------
SET IDENTITY_INSERT [dbo].[rol] ON
GO

INSERT INTO [dbo].[rol] ([id], [nombre]) VALUES (N'1', N'ADMIN')
GO

INSERT INTO [dbo].[rol] ([id], [nombre]) VALUES (N'2', N'GUESS')
GO

SET IDENTITY_INSERT [dbo].[rol] OFF
GO

-- ----------------------------
-- Records of usuario_rol
-- ----------------------------
INSERT INTO [dbo].[usuario_rol] ([usuario_id], [rol_id]) VALUES (N'2', N'1')
GO

INSERT INTO [dbo].[usuario_rol] ([usuario_id], [rol_id]) VALUES (N'3', N'2')
GO

INSERT INTO [dbo].[usuario_rol] ([usuario_id], [rol_id]) VALUES (N'4', N'1')
GO