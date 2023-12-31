USE [master]
GO
/****** Object:  Database [Excel]    Script Date: 25/09/2023 04:58:29 p. m. ******/
CREATE DATABASE [Excel]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Excel', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Excel.mdf' , SIZE = 5072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Excel_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Excel_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Excel] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Excel].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Excel] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Excel] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Excel] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Excel] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Excel] SET ARITHABORT OFF 
GO
ALTER DATABASE [Excel] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Excel] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Excel] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Excel] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Excel] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Excel] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Excel] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Excel] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Excel] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Excel] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Excel] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Excel] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Excel] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Excel] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Excel] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Excel] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Excel] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Excel] SET RECOVERY FULL 
GO
ALTER DATABASE [Excel] SET  MULTI_USER 
GO
ALTER DATABASE [Excel] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Excel] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Excel] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Excel] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Excel] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Excel', N'ON'
GO
USE [Excel]
GO
/****** Object:  UserDefinedTableType [dbo].[TablaPersona]    Script Date: 25/09/2023 04:58:29 p. m. ******/
CREATE TYPE [dbo].[TablaPersona] AS TABLE(
	[Id] [int] NULL,
	[Nombre] [nvarchar](255) NULL,
	[Telefono] [nvarchar](50) NULL
)
GO
/****** Object:  Table [dbo].[Personas]    Script Date: 25/09/2023 04:58:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Personas](
	[id] [int] NULL,
	[nombre] [nvarchar](255) NULL,
	[telefono] [nvarchar](50) NULL
) ON [PRIMARY]

GO
INSERT [dbo].[Personas] ([id], [nombre], [telefono]) VALUES (1, N'juan', N'8341000000')
INSERT [dbo].[Personas] ([id], [nombre], [telefono]) VALUES (2, N'pablo', N'8341000001')
INSERT [dbo].[Personas] ([id], [nombre], [telefono]) VALUES (3, N'pepe', N'8341000002')
INSERT [dbo].[Personas] ([id], [nombre], [telefono]) VALUES (1, N'juan', N'8341000000')
INSERT [dbo].[Personas] ([id], [nombre], [telefono]) VALUES (2, N'pablo', N'8341000001')
INSERT [dbo].[Personas] ([id], [nombre], [telefono]) VALUES (3, N'pepe', N'8341000002')
/****** Object:  StoredProcedure [dbo].[InsertarPersonas]    Script Date: 25/09/2023 04:58:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InsertarPersonas]
@Personas TablaPersona READONLY,

@res int = 0 Output
AS
BEGIN
    INSERT INTO Personas (Id, Nombre, Telefono)
    SELECT Id, Nombre, Telefono FROM @Personas;

	SET @res = 1
END

GO
USE [master]
GO
ALTER DATABASE [Excel] SET  READ_WRITE 
GO
