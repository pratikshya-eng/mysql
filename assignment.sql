------------------------------------------------------------
-- 1️⃣ RESET DATABASE (CLEAN START)
------------------------------------------------------------
-- Drop database if it exists
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'CollegeDB')
BEGIN
    ALTER DATABASE CollegeDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE CollegeDB;
END
GO

-- Create database
CREATE DATABASE CollegeDB;
GO

-- Use the database
USE CollegeDB;
GO


------------------------------------------------------------
-- 2️⃣ DROP TABLES IF THEY EXIST (PREVENT OBJECT ERRORS)
------------------------------------------------------------
IF OBJECT_ID('Enrollments', 'U') IS NOT NULL DROP TABLE Enrollments;
IF OBJECT_ID('Students', 'U') IS NOT NULL DROP TABLE Students;
IF OBJECT_ID('Courses', 'U') IS NOT NULL DROP TABLE Courses;
GO


------------------------------------------------------------
-- 3️⃣ TABLE CREATION
------------------------------------------------------------
-- Students Table
CREATE TABLE Students (
    StudentID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,  -- Prevent duplicates
    DateOfBirth DATE
);
GO

-- Courses Table
CREATE TABLE Courses (
    CourseID INT IDENTITY(1,1) PRIMARY KEY,
    CourseName NVARCHAR(100) NOT NULL,
    CreditHours INT CHECK (CreditHours > 0),
    Department NVARCHAR(50)
);
GO

-- Enrollments Table
CREATE TABLE Enrollments (
    EnrollmentID INT IDENTITY(1,1) PRIMARY KEY,
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    EnrollmentDate DATE DEFAULT GETDATE(),
    Grade NVARCHAR(5),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);
GO


------------------------------------------------------------
-- 4️⃣ INSERT SAMPLE DATA (NO DUPLICATES)
------------------------------------------------------------
-- Students
INSERT INTO Students (FirstName, LastName, Email, DateOfBirth)
VALUES 
('Ram', 'Thapa', 'ram.thapa@example.com', '2002-03-15'),
('Sita', 'Shrestha', 'sita.shrestha@example.com', '2001-11-20'),
('Hari', 'Koirala', 'hari.koirala@example.com', '2003-06-10');
GO

-- Courses
INSERT INTO Courses (CourseName, CreditHours, Department)
VALUES
('Database Systems', 3, 'Computer Science'),
('Web Development', 4, 'Information Technology'),
('Networking', 3, 'Computer Science');
GO

-- Enrollments
INSERT INTO Enrollments (StudentID, CourseID, EnrollmentDate, Grade)
VALUES
(1, 1, '2024-01-10', 'A'),
(2, 2, '2024-02-05', 'B+'),
(3, 3, '2024-03-12', 'A-');
GO


------------------------------------------------------------
-- 5️⃣ RETRIEVE DATA (JOINS)
------------------------------------------------------------
SELECT 
    s.StudentID,
    s.FirstName + ' ' + s.LastName AS StudentName,
    c.CourseName,
    e.EnrollmentDate,
    e.Grade
FROM Enrollments AS e
INNER JOIN Students AS s ON e.StudentID = s.StudentID
INNER JOIN Courses AS c ON e.CourseID = c.CourseID;
GO


------------------------------------------------------------
-- 6️⃣ UPDATE AND DELETE OPERATIONS
------------------------------------------------------------
-- Update grade
UPDATE Enrollments
SET Grade = 'A+'
WHERE EnrollmentID = 2;
GO

-- Delete enrollment
DELETE FROM Enrollments
WHERE EnrollmentID = 3;
GO


------------------------------------------------------------
-- 7️⃣ FINAL VIEW AFTER CHANGES
------------------------------------------------------------
SELECT 
    s.StudentID,
    s.FirstName,
    s.LastName,
    c.CourseName,
    e.Grade
FROM Enrollments AS e
INNER JOIN Students AS s ON e.StudentID = s.StudentID
INNER JOIN Courses AS c ON e.CourseID = c.CourseID;
GO
