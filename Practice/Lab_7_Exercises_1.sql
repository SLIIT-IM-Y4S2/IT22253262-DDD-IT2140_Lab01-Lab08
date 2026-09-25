-- IT2140 Lab 07, Exercises 1 - practice, not submitted
-- Needs: ../Datasets/MovieData_Set.sql. CREATE PROC/TRIGGER need their own batch.
GO

-- a. Procedure to insert a booking into the Booking table. Accepts show id,
--    customer name and number of tickets, and updates the number of
--    spectators on the Show table.
CREATE PROCEDURE AddBooking
    @showId     INT,
    @custName   VARCHAR(25),
    @numTickets INT
AS
BEGIN
    SET NOCOUNT ON;

    -- both writes belong together: if the spectator count cannot be updated
    -- the booking must not survive either, so they share one transaction.
    BEGIN TRY
        BEGIN TRANSACTION;

            INSERT INTO Booking (showId, custName, numTickets)
            VALUES (@showId, @custName, @numTickets);

            UPDATE [Show]
            SET spectators = spectators + @numTickets
            WHERE showId = @showId;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO

-- b. Trigger to ensure the number of spectators on the Show table does not
--    exceed the capacity of the theater it is shown in.
--
--    NOTE: the supplied dataset already breaks this rule - show 8 has 219
--    spectators at Nitehawk, whose capacity is 200. The trigger fires on
--    UPDATE as well as INSERT, so touching that row will be rejected until
--    its spectator count is brought within capacity.
CREATE TRIGGER trg_Show_CheckCapacity
ON [Show]
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1
               FROM inserted i
               INNER JOIN Theater t ON i.theaterName = t.theaterName
               WHERE i.spectators > t.capacity)
    BEGIN
        RAISERROR ('Spectators cannot exceed the capacity of the theater.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

-- Test: Electric seats 275 and show 1 is already at 275, so this must fail.
EXEC AddBooking 1, 'Test Customer', 5;
GO
