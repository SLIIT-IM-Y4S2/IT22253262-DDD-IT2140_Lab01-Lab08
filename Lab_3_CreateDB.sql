-- IT2140 Lab Sheet 03 - Create table script
-- Asan M A M | IT22253262
--
-- 1. Keys:  Course(CID)  Module(Mcode)  Student(SID, FK CID)
--           Offers(CID+Mcode composite, FK to Course and Module)
-- 2. Order: a table must exist before another can reference it, so the two
--           without foreign keys come first.


-- Step 1: Course - referenced by Student and Offers
CREATE TABLE Course
(
    CID           VARCHAR(10)  PRIMARY KEY,
    Cname         VARCHAR(50)  NOT NULL,
    C_Description VARCHAR(200),
    C_fee         FLOAT
);
GO

-- Step 2: Module - referenced by Offers
CREATE TABLE Module
(
    Mcode         VARCHAR(10)  PRIMARY KEY,
    Mname         VARCHAR(50)  NOT NULL,
    M_Description VARCHAR(200),
    NoOfCredits   INT
);
GO

-- Step 3: Student - references Course
CREATE TABLE Student
(
    SID     VARCHAR(10) PRIMARY KEY,
    Sname   VARCHAR(50) NOT NULL,
    Address VARCHAR(100),
    dob     DATE,
    NIC     VARCHAR(10),
    CID     VARCHAR(10),
    CONSTRAINT fk_Student_Course FOREIGN KEY (CID) REFERENCES Course(CID)
);
GO

-- Step 4: Offers - references Course and Module
CREATE TABLE Offers
(
    CID            VARCHAR(10),
    Mcode          VARCHAR(10),
    Accadamic_year VARCHAR(9),
    Semester       VARCHAR(20),
    CONSTRAINT pk_Offers        PRIMARY KEY (CID, Mcode),
    CONSTRAINT fk_Offers_Course FOREIGN KEY (CID)   REFERENCES Course(CID),
    CONSTRAINT fk_Offers_Module FOREIGN KEY (Mcode) REFERENCES Module(Mcode)
);
GO


-- 3. CHECK constraints

-- NIC must be exactly 9 digits followed by 'V' or 'v'.
ALTER TABLE Student
ADD CONSTRAINT chk_Student_NIC
CHECK (NIC LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][Vv]');
GO

-- Credits must be 1, 2, 3 or 4.
ALTER TABLE Module
ADD CONSTRAINT chk_Module_Credits
CHECK (NoOfCredits IN (1, 2, 3, 4));
GO
