-- IT2140 Lab Sheet 06 - Exercises 2 (views and functions)
-- Asan M A M | IT22253262
-- Needs: Datasets/MovieData_Set.sql
-- CREATE VIEW and CREATE FUNCTION must be alone in their batch, hence the GOs.
GO


-- a. View: movie title, year, director, and number of theaters shown in.
CREATE VIEW MovieTheaterCount AS
SELECT m.title,
       m.year,
       m.DirectorName,
       COUNT(DISTINCT s.theaterName) AS Number_of_Theaters
FROM Movie m
INNER JOIN [Show] s ON m.title = s.movieTitle
GROUP BY m.title, m.year, m.DirectorName;
GO

SELECT * FROM MovieTheaterCount;
GO


-- b. View: theater, city, and total number of movies shown there.
CREATE VIEW TheaterMovieCount AS
SELECT t.theaterName,
       t.city,
       COUNT(DISTINCT s.movieTitle) AS Total_Movies
FROM Theater t
INNER JOIN [Show] s ON t.theaterName = s.theaterName
GROUP BY t.theaterName, t.city;
GO

SELECT * FROM TheaterMovieCount;
GO


-- c. Function: number of movies a star has acted in.
CREATE FUNCTION GetMovieCount (@starName VARCHAR(25))
RETURNS INT
AS
BEGIN
    DECLARE @count INT;

    SELECT @count = COUNT(DISTINCT movieTitle)
    FROM StarsIn
    WHERE starname = @starName;

    RETURN ISNULL(@count, 0);
END;
GO

-- EXEC on a scalar function needs the two-part name.
DECLARE @movieCount INT;
EXEC @movieCount = dbo.GetMovieCount 'Robert Downey';
PRINT 'Movies acted in: ' + CAST(@movieCount AS VARCHAR(20));
GO


-- d. Function: total spectators for a given theater.
CREATE FUNCTION GetTotalSpectators (@theaterName VARCHAR(20))
RETURNS INT
AS
BEGIN
    DECLARE @total INT;

    SELECT @total = SUM(spectators)
    FROM [Show]
    WHERE theaterName = @theaterName;

    RETURN ISNULL(@total, 0);
END;
GO

DECLARE @spectators INT;
EXEC @spectators = dbo.GetTotalSpectators 'Grand Rex';
PRINT 'Total spectators: ' + CAST(@spectators AS VARCHAR(20));
GO
