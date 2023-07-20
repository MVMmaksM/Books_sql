GO
IF OBJECT_ID('sp_all_select_book', 'P') IS NOT NULL
	DROP PROCEDURE sp_all_select_book

GO
CREATE PROCEDURE sp_all_select_book

AS

SELECT b.id, 
b.title_ru AS 'Наименование на русском', 
b.title_eng AS 'Наименование на английском', 
query_author.Автор,
query_genre.Жанр,
c.name AS 'Страна публикации', 
b.description AS 'Описание книги', 
YEAR(b.published_year) AS 'Год публикации', 
ph.name AS 'Издательство',
b.isbn AS ISBN, 
b.bbk AS BBK,
b.udk AS UDK,
b.pages AS 'Количество страниц',
b.price AS 'Цена'
FROM [dbo].[book] b INNER JOIN [dbo].[country] c ON b.country_id = c.id 
INNER JOIN [dbo].[book_publishing_house] bph ON bph.book_id = b.id
INNER JOIN [dbo].[publishing_house] ph ON ph.id = bph.publishing_house_id
INNER JOIN (SELECT author_book.book_id, STRING_AGG(a.last_name + ' ' + a.first_name, ', ') as 'Автор'
FROM author a INNER JOIN author_book ON a.id = author_book.author_id
GROUP BY author_book.book_id) query_author ON b.id = query_author.book_id
INNER JOIN (SELECT gb.book_id, STRING_AGG(g.name, ', ') AS 'Жанр'
FROM genre g INNER JOIN genre_book gb ON g.id = gb.genre_id
GROUP BY gb.book_id) query_genre ON b.id = query_genre.book_id
GO
IF OBJECT_ID('sp_get_book_by_published_year', 'P') IS NOT NULL
	DROP PROCEDURE sp_get_book_by_published_year
GO
CREATE PROCEDURE sp_get_book_by_published_year
@year DATE

AS

SELECT b.id, 
b.title_ru AS 'Наименование на русском', 
b.title_eng AS 'Наименование на английском', 
query_author.Автор,
query_genre.Жанр,
c.name AS 'Страна публикации', 
b.description AS 'Описание книги', 
YEAR(b.published_year) AS 'Год публикации', 
ph.name AS 'Издательство',
b.isbn AS ISBN, 
b.bbk AS BBK,
b.udk AS UDK,
b.pages AS 'Количество страниц',
b.price AS 'Цена'
FROM [dbo].[book] b INNER JOIN [dbo].[country] c ON b.country_id = c.id 
INNER JOIN [dbo].[book_publishing_house] bph ON bph.book_id = b.id
INNER JOIN [dbo].[publishing_house] ph ON ph.id = bph.publishing_house_id
INNER JOIN (SELECT author_book.book_id, STRING_AGG(a.last_name + ' ' + a.first_name, ', ') as 'Автор'
FROM author a INNER JOIN author_book ON a.id = author_book.author_id
GROUP BY author_book.book_id) query_author ON b.id = query_author.book_id
INNER JOIN (SELECT gb.book_id, STRING_AGG(g.name, ', ') AS 'Жанр'
FROM genre g INNER JOIN genre_book gb ON g.id = gb.genre_id
GROUP BY gb.book_id) query_genre ON b.id = query_genre.book_id
WHERE b.published_year = @year
ORDER BY b.title_ru
GO
IF OBJECT_ID('sp_get_book_by_isbn', 'P') IS NOT NULL
	DROP PROCEDURE sp_get_book_by_isbn
GO
CREATE PROCEDURE sp_get_book_by_isbn
@isbn NVARCHAR(24)

AS

SELECT b.id, 
b.title_ru AS 'Наименование на русском', 
b.title_eng AS 'Наименование на английском', 
query_author.Автор,
query_genre.Жанр,
c.name AS 'Страна публикации', 
b.description AS 'Описание книги', 
YEAR(b.published_year) AS 'Год публикации', 
ph.name AS 'Издательство',
b.isbn AS ISBN, 
b.bbk AS BBK,
b.udk AS UDK,
b.pages AS 'Количество страниц',
b.price AS 'Цена'
FROM [dbo].[book] b INNER JOIN [dbo].[country] c ON b.country_id = c.id 
INNER JOIN [dbo].[book_publishing_house] bph ON bph.book_id = b.id
INNER JOIN [dbo].[publishing_house] ph ON ph.id = bph.publishing_house_id
INNER JOIN (SELECT author_book.book_id, STRING_AGG(a.last_name + ' ' + a.first_name, ', ') as 'Автор'
FROM author a INNER JOIN author_book ON a.id = author_book.author_id
GROUP BY author_book.book_id) query_author ON b.id = query_author.book_id
INNER JOIN (SELECT gb.book_id, STRING_AGG(g.name, ', ') AS 'Жанр'
FROM genre g INNER JOIN genre_book gb ON g.id = gb.genre_id
GROUP BY gb.book_id) query_genre ON b.id = query_genre.book_id
WHERE b.isbn = @isbn
ORDER BY b.title_ru
GO
IF OBJECT_ID('sp_get_book_by_title_ru', 'P') IS NOT NULL
	DROP PROCEDURE sp_get_book_by_title_ru
GO
CREATE PROCEDURE sp_get_book_by_title_ru
@title_ru NVARCHAR(255)

AS

SELECT b.id, 
b.title_ru AS 'Наименование на русском', 
b.title_eng AS 'Наименование на английском', 
query_author.Автор,
query_genre.Жанр,
c.name AS 'Страна публикации', 
b.description AS 'Описание книги', 
YEAR(b.published_year) AS 'Год публикации', 
ph.name AS 'Издательство',
b.isbn AS ISBN, 
b.bbk AS BBK,
b.udk AS UDK,
b.pages AS 'Количество страниц',
b.price AS 'Цена'
FROM [dbo].[book] b INNER JOIN [dbo].[country] c ON b.country_id = c.id 
INNER JOIN [dbo].[book_publishing_house] bph ON bph.book_id = b.id
INNER JOIN [dbo].[publishing_house] ph ON ph.id = bph.publishing_house_id
INNER JOIN (SELECT author_book.book_id, STRING_AGG(a.last_name + ' ' + a.first_name, ', ') as 'Автор'
FROM author a INNER JOIN author_book ON a.id = author_book.author_id
GROUP BY author_book.book_id) query_author ON b.id = query_author.book_id
INNER JOIN (SELECT gb.book_id, STRING_AGG(g.name, ', ') AS 'Жанр'
FROM genre g INNER JOIN genre_book gb ON g.id = gb.genre_id
GROUP BY gb.book_id) query_genre ON b.id = query_genre.book_id
WHERE b.title_ru LIKE '%'+ @title_ru + '%'
ORDER BY b.title_ru
GO
IF OBJECT_ID('sp_get_book_by_title_eng', 'P') IS NOT NULL
	DROP PROCEDURE sp_get_book_by_title_eng
GO
CREATE PROCEDURE sp_get_book_by_title_eng
@title_eng NVARCHAR(255)

AS

SELECT b.id, 
b.title_ru AS 'Наименование на русском', 
b.title_eng AS 'Наименование на английском', 
query_author.Автор,
query_genre.Жанр,
c.name AS 'Страна публикации', 
b.description AS 'Описание книги', 
YEAR(b.published_year) AS 'Год публикации', 
ph.name AS 'Издательство',
b.isbn AS ISBN, 
b.bbk AS BBK,
b.udk AS UDK,
b.pages AS 'Количество страниц',
b.price AS 'Цена'
FROM [dbo].[book] b INNER JOIN [dbo].[country] c ON b.country_id = c.id 
INNER JOIN [dbo].[book_publishing_house] bph ON bph.book_id = b.id
INNER JOIN [dbo].[publishing_house] ph ON ph.id = bph.publishing_house_id
INNER JOIN (SELECT author_book.book_id, STRING_AGG(a.last_name + ' ' + a.first_name, ', ') as 'Автор'
FROM author a INNER JOIN author_book ON a.id = author_book.author_id
GROUP BY author_book.book_id) query_author ON b.id = query_author.book_id
INNER JOIN (SELECT gb.book_id, STRING_AGG(g.name, ', ') AS 'Жанр'
FROM genre g INNER JOIN genre_book gb ON g.id = gb.genre_id
GROUP BY gb.book_id) query_genre ON b.id = query_genre.book_id
WHERE b.title_ru LIKE '%'+ @title_eng + '%'
ORDER BY b.title_eng
GO
IF OBJECT_ID('sp_get_book_by_publishing_house', 'P') IS NOT NULL
	DROP PROCEDURE sp_get_book_by_publishing_house
GO
CREATE PROCEDURE sp_get_book_by_publishing_house
@publishing_name NVARCHAR(255)

AS

SELECT b.id, 
b.title_ru AS 'Наименование на русском', 
b.title_eng AS 'Наименование на английском', 
query_author.Автор,
query_genre.Жанр,
c.name AS 'Страна публикации', 
b.description AS 'Описание книги', 
YEAR(b.published_year) AS 'Год публикации', 
ph.name AS 'Издательство',
b.isbn AS ISBN, 
b.bbk AS BBK,
b.udk AS UDK,
b.pages AS 'Количество страниц',
b.price AS 'Цена'
FROM [dbo].[book] b INNER JOIN [dbo].[country] c ON b.country_id = c.id 
INNER JOIN [dbo].[book_publishing_house] bph ON bph.book_id = b.id
INNER JOIN [dbo].[publishing_house] ph ON ph.id = bph.publishing_house_id
INNER JOIN (SELECT author_book.book_id, STRING_AGG(a.last_name + ' ' + a.first_name, ', ') as 'Автор'
FROM author a INNER JOIN author_book ON a.id = author_book.author_id
GROUP BY author_book.book_id) query_author ON b.id = query_author.book_id
INNER JOIN (SELECT gb.book_id, STRING_AGG(g.name, ', ') AS 'Жанр'
FROM genre g INNER JOIN genre_book gb ON g.id = gb.genre_id
GROUP BY gb.book_id) query_genre ON b.id = query_genre.book_id
WHERE ph.name LIKE '%' + @publishing_name + '%'
ORDER BY b.title_ru
GO







