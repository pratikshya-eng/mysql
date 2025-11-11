-- Create the database
CREATE DATABASE CollegeDB;
GO

-- Use the database
USE CollegeDB;
GO

-- Create Students table
CREATE TABLE Students (
    StudentID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Email NVARCHAR(100),
    DateOfBirth DATE
);
GO

-- Create Courses table
CREATE TABLE Courses (
    CourseID INT IDENTITY(1,1) PRIMARY KEY,
    CourseName NVARCHAR(100),
    CreditHours INT,
    Department NVARCHAR(50)
);
GO

-- Create Enrollments table
CREATE TABLE Enrollments (
    EnrollmentID INT IDENTITY(1,1) PRIMARY KEY,
    StudentID INT FOREIGN KEY REFERENCES Students(StudentID),
    CourseID INT FOREIGN KEY REFERENCES Courses(CourseID),
    EnrollmentDate DATE,
    Grade NVARCHAR(5)
);
GO

-- Insert sample data into Students
INSERT INTO Students (FirstName, LastName, Email, DateOfBirth)
VALUES 
('Ram', 'Thapa', 'ram.thapa@example.com', '2002-03-15'),
('Sita', 'Shrestha', 'sita.shrestha@example.com', '2001-11-20'),
('Hari', 'Koirala', 'hari.koirala@example.com', '2003-06-10');
GO

-- Insert sample data into Courses
INSERT INTO Courses (CourseName, CreditHours, Department)
VALUES
('Database Systems', 3, 'Computer Science'),
('Web Development', 4, 'Information Technology'),
('Networking', 3, 'Computer Science');
GO

-- Insert sample data into Enrollments
INSERT INTO Enrollments (StudentID, CourseID, EnrollmentDate, Grade)
VALUES
(1, 1, '2024-01-10', 'A'),
(2, 2, '2024-02-05', 'B+'),
(3, 3, '2024-03-12', 'A-');
GO

-- Select all students with their courses and grades
SELECT 
    s.FirstName + ' ' + s.LastName AS StudentName,
    c.CourseName,
    e.EnrollmentDate,
    e.Grade
FROM Enrollments e
JOIN Students s ON e.StudentID = s.StudentID
JOIN Courses c ON e.CourseID = c.CourseID;
GO

-- Update example: change a student's grade
UPDATE Enrollments
SET Grade = 'A+'
WHERE EnrollmentID = 2;
GO

-- Delete example: remove an enrollment
DELETE FROM Enrollments
WHERE EnrollmentID = 3;
GO

-- Final joined view
SELECT 
    s.StudentID, s.FirstName, s.LastName,
    c.CourseName, e.Grade
FROM Enrollments e
JOIN Students s ON e.StudentID = s.StudentID
JOIN Courses c ON e.CourseID = c.CourseID;
GO
