USE [master]
GO
/****** Object:  Database [SSIS-Demo]    Script Date: 01/14/2018 16:04:39 ******/
CREATE DATABASE [SSIS-Demo] ON  PRIMARY 
( NAME = N'SSIS-Demo', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQL\DATA\SSIS-Demo.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'SSIS-Demo_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQL\DATA\SSIS-Demo_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [SSIS-Demo] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SSIS-Demo].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SSIS-Demo] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [SSIS-Demo] SET ANSI_NULLS OFF
GO
ALTER DATABASE [SSIS-Demo] SET ANSI_PADDING OFF
GO
ALTER DATABASE [SSIS-Demo] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [SSIS-Demo] SET ARITHABORT OFF
GO
ALTER DATABASE [SSIS-Demo] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [SSIS-Demo] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [SSIS-Demo] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [SSIS-Demo] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [SSIS-Demo] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [SSIS-Demo] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [SSIS-Demo] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [SSIS-Demo] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [SSIS-Demo] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [SSIS-Demo] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [SSIS-Demo] SET  DISABLE_BROKER
GO
ALTER DATABASE [SSIS-Demo] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [SSIS-Demo] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [SSIS-Demo] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [SSIS-Demo] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [SSIS-Demo] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [SSIS-Demo] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [SSIS-Demo] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [SSIS-Demo] SET  READ_WRITE
GO
ALTER DATABASE [SSIS-Demo] SET RECOVERY SIMPLE
GO
ALTER DATABASE [SSIS-Demo] SET  MULTI_USER
GO
ALTER DATABASE [SSIS-Demo] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [SSIS-Demo] SET DB_CHAINING OFF
GO
USE [SSIS-Demo]
GO
/****** Object:  Table [dbo].[Importacoes]    Script Date: 01/14/2018 16:04:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Importacoes](
	[IdImportacao] [varchar](40) NOT NULL,
	[Arquivo] [varchar](255) NOT NULL,
	[Usuario] [varchar](20) NOT NULL,
	[DtCadastro] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Importacao] PRIMARY KEY CLUSTERED 
(
	[IdImportacao] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Autores]    Script Date: 01/14/2018 16:04:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Autores](
	[IdAutor] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [varchar](60) NOT NULL,
	[DtCadastro] [datetime2](7) NOT NULL,
	[DtAlteracao] [datetime2](7) NULL,
 CONSTRAINT [PK_Autores] PRIMARY KEY CLUSTERED 
(
	[IdAutor] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_Autores] UNIQUE NONCLUSTERED 
(
	[Nome] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tipos]    Script Date: 01/14/2018 16:04:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tipos](
	[IdTipo] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [varchar](60) NOT NULL,
	[DtCadastro] [datetime2](7) NOT NULL,
	[DtAlteracao] [datetime2](7) NULL,
 CONSTRAINT [PK_TipoLivro] PRIMARY KEY CLUSTERED 
(
	[IdTipo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_Tipos] UNIQUE NONCLUSTERED 
(
	[Nome] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LivrosStg]    Script Date: 01/14/2018 16:04:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LivrosStg](
	[Id] [uniqueidentifier] NOT NULL,
	[IdImportacao] [varchar](40) NOT NULL,
	[IdLivro] [varchar](20) NULL,
	[Nome] [varchar](255) NULL,
	[ISBN] [varchar](40) NULL,
	[Tipo] [varchar](20) NULL,
	[Preco] [numeric](15, 2) NULL,
	[Autor] [varchar](60) NULL,
	[DtCadastro] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_ProdutosStg] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Livros]    Script Date: 01/14/2018 16:04:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Livros](
	[IdLivro] [int] NOT NULL,
	[ISBN] [varchar](40) NOT NULL,
	[Nome] [varchar](255) NOT NULL,
	[IdTipo] [int] NOT NULL,
	[IdAutor] [int] NOT NULL,
	[Preco] [numeric](15, 2) NOT NULL,
	[DtCadastro] [datetime2](7) NOT NULL,
	[DtAlteracao] [datetime2](7) NULL,
 CONSTRAINT [PK_Livros] PRIMARY KEY CLUSTERED 
(
	[IdLivro] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[usp_limpa_base]    Script Date: 01/14/2018 16:04:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_limpa_base]
as
begin
  delete from importacoes
  delete from livrosstg
  delete from livros
  delete from autores
  delete from tipos
end
GO
/****** Object:  StoredProcedure [dbo].[usp_copia_livros]    Script Date: 01/14/2018 16:04:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_copia_livros]
(
	@IdImportacao varchar(40)
)
as
begin
	-- cadastra os novos tipos
	insert into Tipos (nome)
	select distinct stg.Tipo 
	  from LivrosStg stg
	 where stg.IdImportacao = @IdImportacao
	   and not Exists (select 1
	  				     from Tipos tp
						where tp.Nome = stg.Tipo)
						
	-- cadastra os novos autores
	insert into Autores (nome)
	select distinct stg.Autor
	  from LivrosStg stg
	 where stg.IdImportacao = @IdImportacao
	   and not Exists (select 1
	  				     from Autores aut
						where aut.Nome = stg.Autor)
						
	-- copia os dados associados para a tabela temporária
	declare @tmp as table
	(
		IdLivro	int,
		ISBN	varchar(40),
		Nome	varchar(255),
		IdTipo	int,	
		IdAutor	int,	
		Preco	numeric(15, 2)
	)	

	-- cadastra os novos livros
	insert into @tmp
	(
		IdLivro,	
		Nome,
		ISBN,
		Preco,
		IdTipo,
		IdAutor
	) 
	select stg.IdLivro,	
		   stg.Nome,
		   stg.ISBN,
		   (stg.Preco/100.00) as Preco,
		   tip.IdTipo,
		   aut.IdAutor
	  from LivrosStg stg
	 inner join Autores aut
	    on aut.Nome = stg.Autor
	 inner join Tipos tip
	    on tip.Nome = stg.Tipo
	 where stg.IdImportacao = @IdImportacao
						
	-- altera os produtos já cadastrados
	update p
	   set Nome = src.Nome,
	       ISBN = src.ISBN,
	       Preco = src.PReco,
	       IdTipo = src.IdTipo,
	       IdAutor = src.IdAutor,
	       DtAlteracao = GETDATE()
      from Livros p
     inner join @tmp src
        on src.IdLivro = p.IdLivro	 
        
	-- insere os novos produtos
	insert into Livros
	(
		IdLivro,	
		Nome,
		ISBN,
		Preco,
		IdTipo,
		IdAutor
	) 
	select IdLivro,	
		   Nome,
		   ISBN,
		   Preco,
		   IdTipo,
		   IdAutor
	  from @tmp tmp
	 where not exists (select 1
						 from Livros liv
						where liv.IdLivro = tmp.IdLivro)              

end
GO
/****** Object:  Default [DF_Importacao_DtCadastro]    Script Date: 01/14/2018 16:04:41 ******/
ALTER TABLE [dbo].[Importacoes] ADD  CONSTRAINT [DF_Importacao_DtCadastro]  DEFAULT (getdate()) FOR [DtCadastro]
GO
/****** Object:  Default [DF_Autores_DtCadastro]    Script Date: 01/14/2018 16:04:41 ******/
ALTER TABLE [dbo].[Autores] ADD  CONSTRAINT [DF_Autores_DtCadastro]  DEFAULT (getdate()) FOR [DtCadastro]
GO
/****** Object:  Default [DF_Tipos_DtCadastro]    Script Date: 01/14/2018 16:04:41 ******/
ALTER TABLE [dbo].[Tipos] ADD  CONSTRAINT [DF_Tipos_DtCadastro]  DEFAULT (getdate()) FOR [DtCadastro]
GO
/****** Object:  Default [DF_ProdutosStg_Id]    Script Date: 01/14/2018 16:04:41 ******/
ALTER TABLE [dbo].[LivrosStg] ADD  CONSTRAINT [DF_ProdutosStg_Id]  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  Default [DF_LivrosStg_DtCadastro]    Script Date: 01/14/2018 16:04:41 ******/
ALTER TABLE [dbo].[LivrosStg] ADD  CONSTRAINT [DF_LivrosStg_DtCadastro]  DEFAULT (getdate()) FOR [DtCadastro]
GO
/****** Object:  Default [DF_Livros_DtCadastro]    Script Date: 01/14/2018 16:04:41 ******/
ALTER TABLE [dbo].[Livros] ADD  CONSTRAINT [DF_Livros_DtCadastro]  DEFAULT (getdate()) FOR [DtCadastro]
GO
/****** Object:  ForeignKey [FK_Livros_Autores]    Script Date: 01/14/2018 16:04:41 ******/
ALTER TABLE [dbo].[Livros]  WITH CHECK ADD  CONSTRAINT [FK_Livros_Autores] FOREIGN KEY([IdAutor])
REFERENCES [dbo].[Autores] ([IdAutor])
GO
ALTER TABLE [dbo].[Livros] CHECK CONSTRAINT [FK_Livros_Autores]
GO
/****** Object:  ForeignKey [FK_Livros_Tipos]    Script Date: 01/14/2018 16:04:41 ******/
ALTER TABLE [dbo].[Livros]  WITH CHECK ADD  CONSTRAINT [FK_Livros_Tipos] FOREIGN KEY([IdTipo])
REFERENCES [dbo].[Tipos] ([IdTipo])
GO
ALTER TABLE [dbo].[Livros] CHECK CONSTRAINT [FK_Livros_Tipos]
GO
