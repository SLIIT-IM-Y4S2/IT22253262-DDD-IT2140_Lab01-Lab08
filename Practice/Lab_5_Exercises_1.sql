-- IT2140 Lab 05, Exercises 1 - practice, not submitted
-- Needs: ../Datasets/MovieData_Set.sql

-- a. Names of the directors who had worked with American stars.
SELECT DISTINCT m.DirectorName
FROM Movie m
INNER JOIN StarsIn   si ON m.title     = si.movieTitle
INNER JOIN MovieStar ms ON si.starname = ms.name
WHERE ms.country = 'America';

-- b. Movies in English for which all seats are booked in a theater.
--    (fully booked = spectators equals the theater's capacity)
SELECT DISTINCT m.title
FROM Movie m
INNER JOIN [Show]  s ON m.title       = s.movieTitle
INNER JOIN Theater t ON s.theaterName = t.theaterName
WHERE m.language = 'English'
  AND s.spectators = t.capacity;

-- c. Stars who have acted in 3 or more movies in any year between 2017-2018.
SELECT si.starname, si.movieYear, COUNT(*) AS Movie_Count
FROM StarsIn si
WHERE si.movieYear BETWEEN 2017 AND 2018
GROUP BY si.starname, si.movieYear
HAVING COUNT(*) >= 3;

-- d. Feature movies viewed by at least 1 million spectators in total.
--    ('F' = feature film. On the supplied dataset the largest show is 300
--     spectators, so this correctly returns no rows.)
SELECT m.title, SUM(s.spectators) AS Total_Spectators
FROM Movie m
INNER JOIN [Show] s ON m.title = s.movieTitle
WHERE m.filmtype = 'F'
GROUP BY m.title
HAVING SUM(s.spectators) >= 1000000;

-- e. Total income of each movie shown in theaters in America.
--    (income of a show = ticketPrice x spectators; Theater must be joined
--     to filter on country)
SELECT s.movieTitle,
       SUM(s.ticketPrice * s.spectators) AS Total_Income
FROM [Show] s
INNER JOIN Theater t ON s.theaterName = t.theaterName
WHERE t.country = 'America'
GROUP BY s.movieTitle;
