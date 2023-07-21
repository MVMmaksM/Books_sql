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
p.price AS 'Цена',
p.discount_price  AS 'Цена со скидкой'
FROM [dbo].[book] b INNER JOIN [dbo].[country] c ON b.country_id = c.id 
INNER JOIN [dbo].[book_publishing_house] bph ON bph.book_id = b.id
INNER JOIN [dbo].[publishing_house] ph ON ph.id = bph.publishing_house_id
INNER JOIN [dbo].[price] p ON b.id = p.book_id
INNER JOIN (SELECT author_book.book_id, STRING_AGG(CASE WHEN (a.surname IS NOT NULL) THEN (a.last_name + ' ' + SUBSTRING(a.first_name,1,1) + '. ' + SUBSTRING(a.surname,1,1) + '.') ELSE a.last_name + ' ' + SUBSTRING(a.first_name,1,1) + '.' END , ', ') as 'Автор'
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
p.price AS 'Цена',
p.discount_price  AS 'Цена со скидкой'
FROM [dbo].[book] b INNER JOIN [dbo].[country] c ON b.country_id = c.id 
INNER JOIN [dbo].[book_publishing_house] bph ON bph.book_id = b.id
INNER JOIN [dbo].[publishing_house] ph ON ph.id = bph.publishing_house_id
INNER JOIN [dbo].[price] p ON b.id = p.book_id
INNER JOIN (SELECT author_book.book_id, STRING_AGG(CASE WHEN (a.surname IS NOT NULL) THEN (a.last_name + ' ' + SUBSTRING(a.first_name,1,1) + '. ' + SUBSTRING(a.surname,1,1) + '.') ELSE a.last_name + ' ' + SUBSTRING(a.first_name,1,1) + '.' END , ', ') as 'Автор'
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
p.price AS 'Цена',
p.discount_price  AS 'Цена со скидкой'
FROM [dbo].[book] b INNER JOIN [dbo].[country] c ON b.country_id = c.id 
INNER JOIN [dbo].[book_publishing_house] bph ON bph.book_id = b.id
INNER JOIN [dbo].[publishing_house] ph ON ph.id = bph.publishing_house_id
INNER JOIN [dbo].[price] p ON b.id = p.book_id
INNER JOIN (SELECT author_book.book_id, STRING_AGG(CASE WHEN (a.surname IS NOT NULL) THEN (a.last_name + ' ' + SUBSTRING(a.first_name,1,1) + '. ' + SUBSTRING(a.surname,1,1) + '.') ELSE a.last_name + ' ' + SUBSTRING(a.first_name,1,1) + '.' END , ', ') as 'Автор'
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
p.price AS 'Цена',
p.discount_price  AS 'Цена со скидкой'
FROM [dbo].[book] b INNER JOIN [dbo].[country] c ON b.country_id = c.id 
INNER JOIN [dbo].[book_publishing_house] bph ON bph.book_id = b.id
INNER JOIN [dbo].[publishing_house] ph ON ph.id = bph.publishing_house_id
INNER JOIN [dbo].[price] p ON b.id = p.book_id
INNER JOIN (SELECT author_book.book_id, STRING_AGG(CASE WHEN (a.surname IS NOT NULL) THEN (a.last_name + ' ' + SUBSTRING(a.first_name,1,1) + '. ' + SUBSTRING(a.surname,1,1) + '.') ELSE a.last_name + ' ' + SUBSTRING(a.first_name,1,1) + '.' END , ', ') as 'Автор'
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
p.price AS 'Цена',
p.discount_price  AS 'Цена со скидкой'
FROM [dbo].[book] b INNER JOIN [dbo].[country] c ON b.country_id = c.id 
INNER JOIN [dbo].[book_publishing_house] bph ON bph.book_id = b.id
INNER JOIN [dbo].[publishing_house] ph ON ph.id = bph.publishing_house_id
INNER JOIN [dbo].[price] p ON b.id = p.book_id
INNER JOIN (SELECT author_book.book_id, STRING_AGG(CASE WHEN (a.surname IS NOT NULL) THEN (a.last_name + ' ' + SUBSTRING(a.first_name,1,1) + '. ' + SUBSTRING(a.surname,1,1) + '.') ELSE a.last_name + ' ' + SUBSTRING(a.first_name,1,1) + '.' END , ', ') as 'Автор'
FROM author a INNER JOIN author_book ON a.id = author_book.author_id
GROUP BY author_book.book_id) query_author ON b.id = query_author.book_id
INNER JOIN (SELECT gb.book_id, STRING_AGG(g.name, ', ') AS 'Жанр'
FROM genre g INNER JOIN genre_book gb ON g.id = gb.genre_id
GROUP BY gb.book_id) query_genre ON b.id = query_genre.book_id
WHERE b.title_eng LIKE '%'+ @title_eng + '%'
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
p.price AS 'Цена',
p.discount_price  AS 'Цена со скидкой'
FROM [dbo].[book] b INNER JOIN [dbo].[country] c ON b.country_id = c.id 
INNER JOIN [dbo].[book_publishing_house] bph ON bph.book_id = b.id
INNER JOIN [dbo].[publishing_house] ph ON ph.id = bph.publishing_house_id
INNER JOIN [dbo].[price] p ON b.id = p.book_id
INNER JOIN (SELECT author_book.book_id, STRING_AGG(CASE WHEN (a.surname IS NOT NULL) THEN (a.last_name + ' ' + SUBSTRING(a.first_name,1,1) + '. ' + SUBSTRING(a.surname,1,1) + '.') ELSE a.last_name + ' ' + SUBSTRING(a.first_name,1,1) + '.' END , ', ') as 'Автор'
FROM author a INNER JOIN author_book ON a.id = author_book.author_id
GROUP BY author_book.book_id) query_author ON b.id = query_author.book_id
INNER JOIN (SELECT gb.book_id, STRING_AGG(g.name, ', ') AS 'Жанр'
FROM genre g INNER JOIN genre_book gb ON g.id = gb.genre_id
GROUP BY gb.book_id) query_genre ON b.id = query_genre.book_id
WHERE ph.name LIKE '%' + @publishing_name + '%'
ORDER BY b.title_ru
GO
IF OBJECT_ID('sp_get_book_by_author', 'P') IS NOT NULL
	DROP PROCEDURE sp_get_book_by_author
GO
CREATE PROCEDURE sp_get_book_by_author
@author_first_name NVARCHAR(255),
@author_last_name NVARCHAR(255)

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
p.price AS 'Цена',
p.discount_price  AS 'Цена со скидкой'
FROM [dbo].[book] b INNER JOIN [dbo].[country] c ON b.country_id = c.id 
INNER JOIN [dbo].[book_publishing_house] bph ON bph.book_id = b.id
INNER JOIN [dbo].[publishing_house] ph ON ph.id = bph.publishing_house_id
INNER JOIN [dbo].[price] p ON b.id = p.book_id
INNER JOIN (SELECT author_book.book_id, STRING_AGG(CASE WHEN (a.surname IS NOT NULL) THEN (a.last_name + ' ' + SUBSTRING(a.first_name,1,1) + '. ' + SUBSTRING(a.surname,1,1) + '.') ELSE a.last_name + ' ' + SUBSTRING(a.first_name,1,1) + '.' END , ', ') as 'Автор'
FROM author a INNER JOIN author_book ON a.id = author_book.author_id
WHERE a.first_name LIKE '%' + @author_first_name + '%' AND a.last_name LIKE '%' + @author_last_name + '%'
GROUP BY author_book.book_id) query_author ON b.id = query_author.book_id
INNER JOIN (SELECT gb.book_id, STRING_AGG(g.name, ', ') AS 'Жанр'
FROM genre g INNER JOIN genre_book gb ON g.id = gb.genre_id
GROUP BY gb.book_id) query_genre ON b.id = query_genre.book_id
ORDER BY b.title_ru
GO
IF OBJECT_ID('sp_get_book_by_genre', 'P') IS NOT NULL
	DROP PROCEDURE sp_get_book_by_genre
GO
CREATE PROCEDURE sp_get_book_by_genre
@genre_name NVARCHAR(255)


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
p.price AS 'Цена',
p.discount_price  AS 'Цена со скидкой'
FROM [dbo].[book] b INNER JOIN [dbo].[country] c ON b.country_id = c.id 
INNER JOIN [dbo].[book_publishing_house] bph ON bph.book_id = b.id
INNER JOIN [dbo].[publishing_house] ph ON ph.id = bph.publishing_house_id
INNER JOIN [dbo].[price] p ON b.id = p.book_id
INNER JOIN (SELECT author_book.book_id, STRING_AGG(CASE WHEN (a.surname IS NOT NULL) THEN (a.last_name + ' ' + SUBSTRING(a.first_name,1,1) + '. ' + SUBSTRING(a.surname,1,1) + '.') ELSE a.last_name + ' ' + SUBSTRING(a.first_name,1,1) + '.' END , ', ') as 'Автор'
FROM author a INNER JOIN author_book ON a.id = author_book.author_id
GROUP BY author_book.book_id) query_author ON b.id = query_author.book_id
INNER JOIN (SELECT gb.book_id, STRING_AGG(g.name, ', ') AS 'Жанр'
FROM genre g INNER JOIN genre_book gb ON g.id = gb.genre_id
WHERE g.name LIKE '%' + @genre_name + '%'
GROUP BY gb.book_id) query_genre ON b.id = query_genre.book_id
ORDER BY b.title_ru
GO
IF OBJECT_ID('sp_get_book_by_country', 'P') IS NOT NULL
	DROP PROCEDURE sp_get_book_by_country
GO
CREATE PROCEDURE sp_get_book_by_country
@country_name NVARCHAR(255)


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
p.price AS 'Цена',
p.discount_price  AS 'Цена со скидкой'
FROM [dbo].[book] b INNER JOIN [dbo].[country] c ON b.country_id = c.id 
INNER JOIN [dbo].[book_publishing_house] bph ON bph.book_id = b.id
INNER JOIN [dbo].[publishing_house] ph ON ph.id = bph.publishing_house_id
INNER JOIN [dbo].[price] p ON b.id = p.book_id
INNER JOIN (SELECT author_book.book_id, STRING_AGG(CASE WHEN (a.surname IS NOT NULL) THEN (a.last_name + ' ' + SUBSTRING(a.first_name,1,1) + '. ' + SUBSTRING(a.surname,1,1) + '.') ELSE a.last_name + ' ' + SUBSTRING(a.first_name,1,1) + '.' END , ', ') as 'Автор'
FROM author a INNER JOIN author_book ON a.id = author_book.author_id
GROUP BY author_book.book_id) query_author ON b.id = query_author.book_id
INNER JOIN (SELECT gb.book_id, STRING_AGG(g.name, ', ') AS 'Жанр'
FROM genre g INNER JOIN genre_book gb ON g.id = gb.genre_id
GROUP BY gb.book_id) query_genre ON b.id = query_genre.book_id
WHERE c.name LIKE '%' + @country_name + '%'
ORDER BY b.title_ru
GO
