-- IT2140 Lab Sheet 05 - Exercises 2 (movie database joins)
-- Asan M A M | IT22253262
-- Needs: Datasets/MovieData_Set.sql
-- Show is a T-SQL keyword, so it is written as [Show].


-- a. Stars who have acted in movies directed by "Jon Watts".
SELECT DISTINCT ms.name
FROM MovieStar ms
INNER JOIN StarsIn si ON ms.name       = si.starname
INNER JOIN Movie   m  ON si.movieTitle = m.title
WHERE m.DirectorName = 'Jon Watts';


-- b. Movies shown in theaters in "LA", with total spectators.
SELECT s.movieTitle,
       SUM(s.spectators) AS Total_Spectators
FROM [Show] s
INNER JOIN Theater t ON s.theaterName = t.theaterName
WHERE t.city = 'LA'
GROUP BY s.movieTitle;


-- c. Customers who have booked tickets for more than one different movie.
--    No rows: Booking holds two rows, both on showId 1.
SELECT b.custName
FROM Booking b
INNER JOIN [Show] s ON b.showId = s.showId
GROUP BY b.custName
HAVING COUNT(DISTINCT s.movieTitle) > 1;


-- d. Theaters where total income from all shows exceeds 50,000.
SELECT s.theaterName,
       SUM(s.ticketPrice * s.spectators) AS Total_Income
FROM [Show] s
GROUP BY s.theaterName
HAVING SUM(s.ticketPrice * s.spectators) > 50000;


-- e. Customers who have booked tickets in more than one theater.
--    No rows, for the same reason as (c).
SELECT b.custName
FROM Booking b
INNER JOIN [Show] s ON b.showId = s.showId
GROUP BY b.custName
HAVING COUNT(DISTINCT s.theaterName) > 1;
