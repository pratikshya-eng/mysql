------------------------------------------------------------
-- DATABASE CREATION
------------------------------------------------------------
CREATE DATABASE CollegeDB;
GO

-- Use the created database
USE CollegeDB;
GO


------------------------------------------------------------
-- TABLE CREATION
------------------------------------------------------------

-- 1. Students Table
CREATE TABLE Students (
    StudentID INT IDENTITY(1,1) PRIMARY KEY,  -- Auto-increment ID
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) UNIQUE,
    DateOfBirth DATE
);
GO

-- 2. Courses Table
CREATE TABLE Courses (
    CourseID INT IDENTITY(1,1) PRIMARY KEY,   -- Auto-increment ID
    CourseName NVARCHAR(100) NOT NULL,
    CreditHours INT CHECK (CreditHours > 0),
    Department NVARCHAR(50)
);
GO

-- 3. Enrollments Table (links Students & Courses)
CREATE TABLE Enrollments (
    EnrollmentID INT IDENTITY(1,1) PRIMARY KEY,
    StudentID INT NOT NULL FOREIGN KEY REFERENCES Students(StudentID),
    CourseID INT NOT NULL FOREIGN KEY REFERENCES Courses(CourseID),
    EnrollmentDate DATE DEFAULT GETDATE(),
    Grade NVARCHAR(5)
);
GO


------------------------------------------------------------
-- INSERT SAMPLE DATA
------------------------------------------------------------

-- Insert data into Students
INSERT INTO Students (FirstName, LastName, Email, DateOfBirth)
VALUES 
('Ram', 'Thapa', 'ram.thapa@example.com', '2002-03-15'),
('Sita', 'Shrestha', 'sita.shrestha@example.com', '2001-11-20'),
('Hari', 'Koirala', 'hari.koirala@example.com', '2003-06-10');
GO

-- View Students with their auto-generated IDs
SELECT * FROM Students;
GO


-- Insert data into Courses
INSERT INTO Courses (CourseName, CreditHours, Department)
VALUES
('Database Systems', 3, 'Computer Science'),
('Web Development', 4, 'Information Technology'),
('Networking', 3, 'Computer Science');
GO

-- View Courses with their IDs
SELECT * FROM Courses;
GO


-- Insert data into Enrollments
-- (Uses StudentID and CourseID values from the tables above)
INSERT INTO Enrollments (StudentID, CourseID, EnrollmentDate, Grade)
VALUES
(1, 1, '2024-01-10', 'A'),
(2, 2, '2024-02-05', 'B+'),
(3, 3, '2024-03-12', 'A-');
GO


------------------------------------------------------------
-- RETRIEVE DATA (JOINS)
------------------------------------------------------------

-- Show students with their enrolled courses and grades
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
-- UPDATE AND DELETE OPERATIONS
------------------------------------------------------------

-- Update: change a student’s grade
UPDATE Enrollments
SET Grade = 'A+'
WHERE EnrollmentID = 2;
GO

-- Delete: remove a specific enrollment record
DELETE FROM Enrollments
WHERE EnrollmentID = 3;
GO


------------------------------------------------------------
-- FINAL VIEW AFTER CHANGES
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

