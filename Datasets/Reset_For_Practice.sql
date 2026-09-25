-- IT2140 - reset helper, not part of any submission
--
-- Labs 3, 4, 6 and 7 create objects, so a second run fails with "There is
-- already an object named ...". This drops them so those labs can be redone.
-- IT2140_Labs is untouched - labs 1, 2 and 8 are read-only queries.


USE IT2140_Movies;
GO

DROP VIEW IF EXISTS FullyBookedShows;
DROP VIEW IF EXISTS StarMovieCount;
DROP VIEW IF EXISTS MovieTheaterCount;
DROP VIEW IF EXISTS TheaterMovieCount;
GO

DROP FUNCTION IF EXISTS dbo.GetTotalEarning;
DROP FUNCTION IF EXISTS dbo.GetRemainingSeats;
DROP FUNCTION IF EXISTS dbo.GetMovieCount;
DROP FUNCTION IF EXISTS dbo.GetTotalSpectators;
GO

DROP TRIGGER IF EXISTS trg_Show_CheckCapacity;
DROP TRIGGER IF EXISTS trg_StarsIn_UpdateRank;
GO

DROP PROCEDURE IF EXISTS AddBooking;
DROP PROCEDURE IF EXISTS UpdateMovieStarRanks;
GO

IF COL_LENGTH('MovieStar', 'rank') IS NOT NULL
    ALTER TABLE MovieStar DROP COLUMN [rank];
GO


USE IT2140_University;
GO

-- child tables first, or the foreign keys block the drop
DROP TABLE IF EXISTS Offers;
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Module;
DROP TABLE IF EXISTS Course;
GO


USE StudentInformation;
GO

DELETE FROM Student;
GO
