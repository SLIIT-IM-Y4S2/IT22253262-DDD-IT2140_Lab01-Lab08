-- IT2140 Lab Sheet 07 - Exercises 2 (procedures and triggers)
-- Asan M A M | IT22253262
-- Needs: Datasets/MovieData_Set.sql
-- rank is a reserved word, so the column is written as [rank].
GO


-- a. Rank each movie star by the number of lead roles played.

IF COL_LENGTH('MovieStar', 'rank') IS NULL
    ALTER TABLE MovieStar ADD [rank] INT;
GO

CREATE PROCEDURE UpdateMovieStarRanks
AS
BEGIN
    SET NOCOUNT ON;

    -- LEFT JOIN so stars with no lead role are set to 0, not skipped.
    UPDATE ms
    SET ms.[rank] = ISNULL(leads.LeadCount, 0)
    FROM MovieStar ms
    LEFT JOIN (
        SELECT starname,
               COUNT(*) AS LeadCount
        FROM StarsIn
        WHERE role = 'lead'
        GROUP BY starname
    ) AS leads ON ms.name = leads.starname;
END;
GO

EXEC UpdateMovieStarRanks;
SELECT name, country, [rank] FROM MovieStar ORDER BY [rank] DESC;
GO


-- b. Trigger to update the rank when a star appears in a new movie.

CREATE TRIGGER trg_StarsIn_UpdateRank
ON StarsIn
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- inserted holds every row of the statement, so a multi-row insert is
    -- handled in one pass.
    UPDATE ms
    SET ms.[rank] = (
            SELECT COUNT(*)
            FROM StarsIn si
            WHERE si.starname = ms.name
              AND si.role     = 'lead'
        )
    FROM MovieStar ms
    WHERE ms.name IN (SELECT starname FROM inserted);
END;
GO

-- Test: Tom Holland has 1 lead role; a second should move his rank to 2.
SELECT name, [rank] AS Rank_Before FROM MovieStar WHERE name = 'Tom Holland';

INSERT INTO StarsIn VALUES ('Avengers', 2018, 'Tom Holland', 'lead');

SELECT name, [rank] AS Rank_After  FROM MovieStar WHERE name = 'Tom Holland';
GO

-- Undo the test insert
DELETE FROM StarsIn
WHERE movieTitle = 'Avengers' AND movieYear = 2018 AND starname = 'Tom Holland';
EXEC UpdateMovieStarRanks;
GO
