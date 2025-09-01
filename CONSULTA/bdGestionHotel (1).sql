-- Crear base de datos
CREATE DATABASE dbGestionHotel;
GO

USE dbGestionHotel;
GO

-- Tabla de configuración del hotel
CREATE TABLE tblConfigHotel (
    RUC             VARCHAR(20)    NOT NULL PRIMARY KEY,
    NombreHotel     VARCHAR(100)   NOT NULL,
    LogoHotel       VARBINARY(MAX) NULL,
    Direccion       VARCHAR(200)   NOT NULL
);

-- Tabla de empleados
CREATE TABLE tblEmpleados (
    ID INT IDENTITY(1,1) PRIMARY KEY ,
    Cedula VARCHAR(20) UNIQUE NOT NULL,
    CorreoElectronico VARCHAR(150) UNIQUE NOT NULL,
    Usuario VARCHAR(50) UNIQUE NULL,
    Contrasena VARCHAR(255) NULL,
    Nombres VARCHAR(100) NOT NULL,
    Apellidos VARCHAR(100) NOT NULL,
    Telefono VARCHAR(20) NOT NULL,
    DireccionHotel VARCHAR(200) NOT NULL,
    Cargo VARCHAR(100) NOT NULL,
    TurnoInicio TIME NOT NULL,
    TurnoFin TIME NOT NULL,
    FotoPerfil VARBINARY(MAX) NULL
    );

-- Tabla de clientes
CREATE TABLE tblClientes (
    Identificacion      VARCHAR(20)  NOT NULL PRIMARY KEY,
    TipoIdentificacion  VARCHAR(20)  NOT NULL,
    Nombres             VARCHAR(50)  NOT NULL,
    Apellidos           VARCHAR(50)  NOT NULL,
    CorreoElectronico   VARCHAR(100) NOT NULL,
    Telefono            VARCHAR(20)  NOT NULL,
    Direccion           VARCHAR(200) NULL
);

-- Tabla de habitaciones
CREATE TABLE tblHabitaciones (
    CodigoHabitacion VARCHAR(10)PRIMARY KEY NOT NULL,
    TipoHabitacion   VARCHAR(50)         NOT NULL,
    Capacidad        INT                 NOT NULL,
    Estado           VARCHAR(20)         NOT NULL,
    Descripcion      VARCHAR(200)        NULL,
    Precio           DECIMAL(10,2)       NOT NULL
);

--Tabla de servicios
CREATE TABLE tblServicios (
    IdServicio         INT IDENTITY(1,1) PRIMARY KEY    NOT NULL,
    NombreServicio     VARCHAR(50)  NOT NULL,
    Descripcion        VARCHAR(200) NOT NULL,
    Precio             DECIMAL(10,2) NOT NULL,
    UnidadCobro        VARCHAR(50)  NOT NULL
    );

-- Tabla de reservas
CREATE TABLE tblReservas (
    IdReserva           INT IDENTITY(1,1) PRIMARY KEY   NOT NULL,
    Identificacion      VARCHAR(20)   NOT NULL,
    TipoIdentificacion  VARCHAR(20)   NOT NULL,
    NombreCliente       VARCHAR(100)  NOT NULL,
    FechaCreacion       DATETIME      NOT NULL DEFAULT GETDATE(),
    CodigoHabitacion    VARCHAR(10)   NOT NULL,
    Capacidad           INT           NOT NULL,
    Precio              DECIMAL(10,2) NOT NULL,
    Descripcion         VARCHAR(200)  NULL,
    NumeroPersonas      INT           NOT NULL,
    FechaIngreso        DATE          NOT NULL,
    FechaSalida         DATE          NOT NULL,
    MetodoPago          VARCHAR(50)   NOT NULL,
    MontoAbonado        DECIMAL(10,2) NOT NULL DEFAULT 0,

    FOREIGN KEY (Identificacion) REFERENCES tblClientes(Identificacion),
    FOREIGN KEY (CodigoHabitacion) REFERENCES tblHabitaciones(CodigoHabitacion)
);
GO


-- Crear login a nivel de servidor
CREATE LOGIN Pookemones WITH PASSWORD = 'Pookemones3',
    CHECK_POLICY = OFF;

-- Crear usuario dentro de la base de datos
USE dbGestionHotel;
GO
CREATE USER Pookemones FOR LOGIN Pookemones;

-- Asignar rol de propietario de la base de datos (acceso total)
ALTER ROLE db_owner ADD MEMBER Pookemones;
GO
