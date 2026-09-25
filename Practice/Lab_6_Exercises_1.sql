-- IT2140 Lab 06, Exercises 1 - practice, not submitted
-- Needs: ../Datasets/MovieData_Set.sql. CREATE VIEW/FUNCTION need their own batch.
GO

-- a. View: title, theater name, country and city for fully booked shows.
CREATE VIEW FullyBookedShows AS
SELECT s.movieTitle, s.theaterName, t.country, t.city
FROM [Show] s
INNER JOIN Theater t ON s.theaterName = t.theaterName
WHERE s.spectators = t.capacity;
GO

SELECT * FROM FullyBookedShows;
GO

-- b. View: name, country, and number of movies each actor has starred in.
CREATE VIEW StarMovieCount AS
SELECT ms.name,
       ms.country,
       COUNT(DISTINCT si.movieTitle) AS Number_of_Movies
FROM MovieStar ms
INNER JOIN StarsIn si ON ms.name = si.starname
GROUP BY ms.name, ms.country;
GO

SELECT * FROM StarMovieCount;
GO

-- c. Function: total earning for a given movie title.
CREATE FUNCTION GetTotalEarning (@movieTitle VARCHAR(30))
RETURNS REAL
AS
BEGIN
    DECLARE @total REAL;

    SELECT @total = SUM(ticketPrice * spectators)
    FROM [Show]
    WHERE movieTitle = @movieTitle;

    RETURN ISNULL(@total, 0);
END;
GO

DECLARE @earning REAL;
EXEC @earning = dbo.GetTotalEarning 'Spider-man';
PRINT 'Total earning: ' + CAST(@earning AS VARCHAR(30));
GO

-- d. Function: remaining seats in a given show.
CREATE FUNCTION GetRemainingSeats (@showId INT)
RETURNS INT
AS
BEGIN
    DECLARE @remaining INT;

    SELECT @remaining = t.capacity - s.spectators
    FROM [Show] s
    INNER JOIN Theater t ON s.theaterName = t.theaterName
    WHERE s.showId = @showId;

    RETURN @remaining;
END;
GO

DECLARE @seats INT;
EXEC @seats = dbo.GetRemainingSeats 5;
PRINT 'Remaining seats: ' + CAST(@seats AS VARCHAR(20));
GO
