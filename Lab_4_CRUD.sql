-- IT2140 Lab Sheet 04 - Parts 1-3, data manipulation
-- Asan M A M | IT22253262
-- Needs: Lab_3_CreateDB.sql
--
-- Insert order is forced by the foreign keys:
--   Course -> Student -> Module -> Offers


-- PART 1: Insert

INSERT INTO Course (CID, Cname, C_Description, C_fee) VALUES
    ('IT',   'Information Technology',
     'The programme is designed for technically focused students who capabilities in programming',
     175000),
    ('SE',   'Software Engineering',
     'Software engineering is the discipline of designing, creating and maintaining',
     185000),
    ('CSNE', 'Computer Systems And Network Engineering',
     'The programme aims to provide students with the knowledge, skills, planning, and designing',
     155000),
    ('DS',   'Data Scinece',
     'The meticulous curriculum focuses on the fundamentals of computer science, statistics, and applied mathematics',
     170000);

INSERT INTO Student (SID, Sname, Address, dob, NIC, CID) VALUES
    ('CN18384756', 'Kamal',  'No122, Rose street, matale',        '1994-05-02', '946785467v', 'CSNE'),
    ('DS18234876', 'Pubudu', 'No678 , 3rd new lane, Maharahgama', '1994-11-08', '948763759v', 'DS'),
    ('IT18234568', 'Ann',    'No12, Kings street, colombo',       '1996-11-11', '961234587v', 'IT'),
    ('SE19238567', 'Malith', 'No08, st.thomas street, Kandy',     '1992-12-20', '922356785v', 'SE');

INSERT INTO Module (Mcode, Mname, M_Description, NoOfCredits) VALUES
    ('SE3050', 'User Experience Engineering', 'subject under SE', 3),
    ('IT1010', 'Introduction to Programming', 'subject under IT', 4),
    ('IT2050', 'Computer Networks',           'subject under IT', 4),
    ('IT3051', 'Fundamentals of Data Mining', 'subject under DS', 4);

INSERT INTO Offers (CID, Mcode, Accadamic_year, Semester) VALUES
    ('SE', 'SE3050', 'Y3', '2'),
    ('IT', 'IT1010', 'Y1', '2'),
    ('IT', 'IT2050', 'Y2', '1'),
    ('DS', 'IT3051', 'Y3', '2');
GO

SELECT * FROM Course;
SELECT * FROM Student;
SELECT * FROM Module;
SELECT * FROM Offers;
GO


-- PART 2: Update the address of the student named Ann.

UPDATE Student
SET Address = 'No45, Galle Road, Colombo 03'
WHERE Sname = 'Ann';
GO

SELECT SID, Sname, Address FROM Student WHERE Sname = 'Ann';
GO


-- PART 3: Remove the module 'User Experience Engineering'.
-- Offers references Module, so the child row goes first or the delete fails
-- on a REFERENCE constraint.

DELETE FROM Offers
WHERE Mcode IN (SELECT Mcode FROM Module WHERE Mname = 'User Experience Engineering');

DELETE FROM Module
WHERE Mname = 'User Experience Engineering';
GO

SELECT * FROM Module;
SELECT * FROM Offers;
GO
