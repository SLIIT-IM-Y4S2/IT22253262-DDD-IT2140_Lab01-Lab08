-- IT2140 Lab 04 - database for the JavaFX application
-- Asan M A M | IT22253262
--
-- Separate from the university database in Lab_3_CreateDB.sql: this is the
-- small form-backed table the app drives, one column per field on the form.

IF DB_ID(N'StudentInformation') IS NULL
    CREATE DATABASE StudentInformation;
GO

USE StudentInformation;
GO

DROP TABLE IF EXISTS Student;
GO

CREATE TABLE Student
(
    ID      INT PRIMARY KEY,
    Name    VARCHAR(50),
    Age     INT,
    GPA     FLOAT,
    Address VARCHAR(100)
);
GO

SELECT * FROM Student;
GO
