-- Create a new database
CREATE DATABASE Organization;
GO

-- Use the database
USE Organization;
GO

-- Create Department table
CREATE TABLE Depart (
    DptId INT IDENTITY(1,1) PRIMARY KEY,
    Dname NVARCHAR(50)
);
GO

-- Create Employee table
CREATE TABLE Emp (
    EID INT IDENTITY(1,1) PRIMARY KEY,
    Ename NVARCHAR(50),
    Address NVARCHAR(50),
    Salary DECIMAL(18,2),
    DptId INT FOREIGN KEY REFERENCES Depart(DptId)
);
GO

-- View Emp table (initially empty)
SELECT * FROM Emp;
GO

-- Insert into Department table
INSERT INTO Depart (Dname)
VALUES ('BTC');
GO

-- Insert into Employee table
-- Note: Use the correct DptId value that exists in Depart (e.g., 1)
INSERT INTO Emp (Ename, Address, Salary, DptId)
VALUES ('Ram', 'Kumarigal', 1000.00, 1);
GO

-- Select employees joined with department having salary > 1000 and Dname = 'BCA'
SELECT e.*, d.Dname
FROM Emp e
JOIN Depart d ON e.DptId = d.DptId
WHERE e.Salary > 1000 AND d.Dname = 'BCA';
GO

-- Update all employee salaries by 10%
UPDATE Emp
SET Salary = Salary * 1.1;
GO

-- Delete employees belonging to department with DptId = 2
DELETE FROM Emp
WHERE DptId = 2;
GO

-- Final join query to view all employees with their department
SELECT e.*, d.Dname
FROM Emp e
INNER JOIN Depart d ON e.DptId = d.DptId;
GO
