USE master

IF DB_ID('Books') IS NOT NULL 
	DROP DATABASE Books
GO
CREATE DATABASE Books
GO
USE Books
GO
CREATE TABLE [dbo].[country]
(
	[id] INT IDENTITY(1,1) NOT NULL,
	[name] NVARCHAR(64) NOT NULL,

	CONSTRAINT PK__country PRIMARY KEY CLUSTERED(id)
)
GO
CREATE TABLE [dbo].[book]
(	
	[id] INT IDENTITY(1,1) NOT NULL,
	[title_ru] NVARCHAR(255) NOT NULL,
	[title_eng] NVARCHAR(255) NOT NULL,
	[country_id] INT NOT NULL,
	[description] NVARCHAR(MAX) NOT NULL,
	[published_year] DATE,
	[isbn] NVARCHAR(24) NOT NULL,
	[udk] NVARCHAR(24) NOT NULL,
	[bbk] NVARCHAR(24) NOT NULL,
	[price] MONEY NOT NULL,
	[pages] INT NOT NULL,

	CONSTRAINT PK__book PRIMARY KEY CLUSTERED (id),
	CONSTRAINT FK__book_country_id FOREIGN KEY (country_id) REFERENCES [dbo].[country] (id)
)
GO
CREATE TABLE [dbo].[region]
(	
	[kod] INT NOT NULL,
	[name] NVARCHAR(64) NOT NULL,

	CONSTRAINT PK__region PRIMARY KEY CLUSTERED(kod)
)
GO
CREATE TABLE [dbo].[city]
(
	[id] INT IDENTITY(1,1) NOT NULL,
	[name] NVARCHAR(255) NOT NULL,
	[days_delivery] INT NOT NULL,
	[region_kod] INT NOT NULL,

	CONSTRAINT PK__city PRIMARY KEY CLUSTERED(id),
	CONSTRAINT FK__city_region_id FOREIGN KEY (region_kod) REFERENCES [dbo].[region](kod)
)
GO
CREATE TABLE [dbo].[client]
(
	[id] INT IDENTITY(1,1) NOT NULL,
	[first_name] NVARCHAR(64) NOT NULL,
	[last_name] NVARCHAR(64) NOT NULL,
	[city_id] INT NOT NULL,
	[telephone] NVARCHAR(24) NOT NULL,
	[email] NVARCHAR(255) NOT NULL,

	CONSTRAINT PK__client PRIMARY KEY CLUSTERED (id),
	CONSTRAINT FK__client_city_id FOREIGN KEY (city_id) REFERENCES [dbo].[city] (id),
	CONSTRAINT UQ__client_telephone UNIQUE(telephone),
	CONSTRAINT UQ__client_email UNIQUE(email)
)
GO
CREATE TABLE [dbo].[publishing_house]
(
	[id] INT IDENTITY(1,1) NOT NULL,
	[name] NVARCHAR(255) NOT NULL,
	[index] INT NOT NULL,
	[city_id] INT NOT NULL,
	[country_id] INT NOT NULL,
	[address] NVARCHAR(255) NOT NULL,
	[telephone] NVARCHAR(64) NOT NULL,
	[email] NVARCHAR(255) NOT NULL,
	
	CONSTRAINT PK__publishing_house PRIMARY KEY CLUSTERED(id),
	CONSTRAINT FK__publishing_house_city_id FOREIGN KEY (city_id) REFERENCES [dbo].[city](id),
	CONSTRAINT FK__publishing_house_country_id FOREIGN KEY (country_id) REFERENCES [dbo].[country](id),
	CONSTRAINT UQ__publishing_house_telephone UNIQUE(telephone),
	CONSTRAINT UQ__publishing_house_email UNIQUE(email)
)
GO
CREATE TABLE [dbo].[book_publishing_house]
(
	[id] INT IDENTITY(1,1) NOT NULL,
	[book_id] INT NOT NULL,
	[publishing_house_id] INT NOT NULL,

	CONSTRAINT PK__book_publishing_house PRIMARY KEY CLUSTERED(id),
	CONSTRAINT FK__book_publishing_house_book_id FOREIGN KEY (book_id) REFERENCES [dbo].[book](id),
	CONSTRAINT FK__publishing_house_id FOREIGN KEY (publishing_house_id) REFERENCES [dbo].[publishing_house](id)
)
GO
CREATE TABLE [dbo].[genre]
(
	[id] INT IDENTITY(1,1) NOT NULL,
	[name] NVARCHAR(255) NOT NULL,

	CONSTRAINT PK__genre PRIMARY KEY CLUSTERED(id)
)
GO
CREATE TABLE [dbo].[author]
(
	[id] INT IDENTITY(1,1) NOT NULL,
	[first_name] NVARCHAR(255) NOT NULL,
	[last_name] NVARCHAR(255) NOT NULL,
	[surname] NVARCHAR(255) NULL,

	CONSTRAINT PK__author PRIMARY KEY CLUSTERED(id)
)
GO
CREATE TABLE [dbo].[genre_book]
(
	[id] INT IDENTITY(1,1) NOT NULL,
	[genre_id] INT NOT NULL,
	[book_id] INT NOT NULL,

	CONSTRAINT PK__genre_book PRIMARY KEY CLUSTERED(id),
	CONSTRAINT FK__genre_book_genre_id FOREIGN KEY(genre_id) REFERENCES [dbo].[genre](id),
	CONSTRAINT FK__genre_book_book_id FOREIGN KEY(book_id) REFERENCES [dbo].[book](id)
)
GO
CREATE TABLE [dbo].[author_book]
(
	[id] INT IDENTITY(1,1) NOT NULL,
	[author_id] INT NOT NULL,
	[book_id] INT NOT NULL,

	CONSTRAINT PK__author_book PRIMARY KEY CLUSTERED(id),
	CONSTRAINT FK__author_book_author_id FOREIGN KEY (author_id) REFERENCES [dbo].[author](id),
	CONSTRAINT FK__author_book_book_id FOREIGN KEY (book_id) REFERENCES [dbo].[book](id)
)
GO
CREATE TABLE [dbo].[delivery]
(
	[id] INT IDENTITY(1,1) NOT NULL,
	[name] NVARCHAR(64) NOT NULL,

	CONSTRAINT PK__delivery PRIMARY KEY CLUSTERED(id)
)
GO
CREATE TABLE [dbo].[buy]
(
	[id] INT IDENTITY(1,1) NOT NULL,
	[client_id] INT NOT NULL,
	[delivery_id] INT NOT NULL,
	[description] NVARCHAR(255) NULL,

	CONSTRAINT PK__buy_id PRIMARY KEY CLUSTERED(id),
	CONSTRAINT FK__buy_delivery_id FOREIGN KEY(delivery_id) REFERENCES [dbo].[delivery](id),
	CONSTRAINT FK__buy_client_id FOREIGN KEY(client_id) REFERENCES [dbo].[client](id)
)
GO
CREATE TABLE [dbo].[buy_book]
(
	[id] INT IDENTITY(1,1) NOT NULL,
	[book_id] INT NOT NULL,
	[buy_id] INT NOT NULL,
	[amount] INT DEFAULT 0,

	CONSTRAINT PK__buy_book PRIMARY KEY CLUSTERED(id),
	CONSTRAINT FK__buy_book_buy_id FOREIGN KEY (buy_id) REFERENCES [dbo].[buy] (id),
	CONSTRAINT FK__buy_book_book_id FOREIGN KEY (book_id) REFERENCES [dbo].[book](id)
)
GO
CREATE TABLE [dbo].[stage]
(
	[id] INT IDENTITY(1,1) NOT NULL,
	[name] NVARCHAR(20) NOT NULL,

	CONSTRAINT PK__stage PRIMARY KEY CLUSTERED(id)
)
GO
CREATE TABLE [dbo].[buy_stage]
(
	[id] INT IDENTITY(1,1) NOT NULL,
	[buy_id] INT NOT NULL,
	[stage_id] INT NOT NULL,
	[date_start_stage] DATETIME NULL,
	[date_end_stage] DATETIME NULL,

	CONSTRAINT PK__buy_stage PRIMARY KEY CLUSTERED(id),
	CONSTRAINT FK__buy_stage_buy_id FOREIGN KEY (buy_id)  REFERENCES [dbo].[buy](id),
	CONSTRAINT FK__buy_stage_stage_id FOREIGN KEY(stage_id) REFERENCES [dbo].[stage](id)
)
GO
CREATE TABLE [dbo].[storage]
(
	[id] INT IDENTITY NOT NULL,
	[book_id] INT NOT NULL,
	[amount] INT DEFAULT 0,

	CONSTRAINT PK__storage PRIMARY KEY CLUSTERED(id),
	CONSTRAINT FK__storage_book_id FOREIGN KEY(book_id) REFERENCES [dbo].[book](id)
)
GO
CREATE TABLE [dbo].[client_book_like]
(
	[id] INT IDENTITY(1,1) NOT NULL,
	[client_id] INT NOT NULL,
	[book_id] INT NOT NULL,

	CONSTRAINT PK__client_book_like PRIMARY KEY CLUSTERED (id),
	CONSTRAINT FK__client_book_like_client_id FOREIGN KEY(client_id) REFERENCES [dbo].[client](id),
	CONSTRAINT FK__client_book_like_book_id FOREIGN KEY(book_id) REFERENCES [dbo].[book](id)
)
GO




