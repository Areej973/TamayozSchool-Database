-- Create the database if it doesn't already exist
CREATE DATABASE IF NOT EXISTS TamayozSchool;
USE TamayozSchool;

-- Create Students table
CREATE TABLE IF NOT EXISTS Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(100) NOT NULL,
    birth_date DATE NOT NULL,
    gender CHAR(1) CHECK (gender IN ('M', 'F')),
    enrollment_date DATE NOT NULL,
    email VARCHAR(100) UNIQUE,
    student_level INT CHECK (student_level BETWEEN 1 AND 6),
    track VARCHAR(20) CHECK (track IN ('Computer', 'Science')),
    gpa DECIMAL(5,2) CHECK (gpa BETWEEN 0 AND 100)
);

-- Create Teachers table
CREATE TABLE IF NOT EXISTS Teachers (
    teacher_id INT PRIMARY KEY AUTO_INCREMENT,
    teacher_name VARCHAR(100) NOT NULL,
    birth_date DATE NOT NULL,
    gender CHAR(1) CHECK (gender IN ('M', 'F')),
    email VARCHAR(100) UNIQUE,
    office_number VARCHAR(10)
);

-- Create Subjects table
CREATE TABLE IF NOT EXISTS Subjects (
    subject_id INT PRIMARY KEY AUTO_INCREMENT,
    subject_name VARCHAR(100) NOT NULL
);

-- Insert sample students
INSERT IGNORE INTO Students (student_name, birth_date, gender, enrollment_date, email, student_level, track, gpa)
VALUES
('Areej Saad', '1999-07-03', 'F', '2018-07-09', 'areej.saad@gmail.com', 4, 'Computer', 98.9),
('Ahmed Nasser', '2008-04-22', 'M', '2020-09-01', 'ahmed.nasser@gmail.com', 6, 'Science', 100),
('Fatimah Ali', '2009-01-17', 'F', '2020-09-01', 'fatimah.ali@gmail.com', 5, 'Computer', 92.3),
('Sara Mohammed', '2010-05-30', 'F', '2021-09-05', 'sara.mohammed@gmail.com', 3, 'Science', 78.6),
('Omar Khaled', '2010-06-21', 'M', '2021-09-05', 'omar.khaled@gmail.com', 1, 'Computer', 55.4),
('Hassan Abdullah', '2009-12-19', 'M', '2020-09-01', 'hassan.abdullah@gmail.com', 2, 'Science', 61.2),
('Amina Noor', '2010-09-08', 'F', '2021-09-05', 'amina.noor@gmail.com', 1, 'Science', 59.8),
('Ali Salman', '2008-11-12', 'M', '2019-09-01', 'ali.salman@gmail.com', 6, 'Computer', 100);

-- Insert female teachers only
INSERT IGNORE INTO Teachers (teacher_name, birth_date, gender, email, office_number)
VALUES
('Mona Saleh', '1985-03-21', 'F', 'mona.saleh@gmail.com', '101'),
('Huda Alqahtani', '1988-07-14', 'F', 'huda.q@gmail.com', '102'),
('Noura Ahmed', '1990-02-10', 'F', 'noura.ahmed@gmail.com', '103'),
('Reem Ali', '1986-10-02', 'F', 'reem.ali@gmail.com', '104');

-- Insert subjects
INSERT IGNORE INTO Subjects (subject_name)
VALUES
('Mathematics'),
('Computer Science'),
('Physics'),
('Chemistry'),
('History'),
('Geography'),
('Biology');

-- Show all tables
SHOW TABLES;

-- Create table for high-achieving students (GPA > 90)
CREATE TABLE IF NOT EXISTS High_Achievers AS
SELECT * FROM Students WHERE gpa > 90;

-- Create table for failing students (GPA < 60)
CREATE TABLE IF NOT EXISTS Failing_Students AS
SELECT * FROM Students WHERE gpa < 60;

-- Display students whose names start with letter 'A'
SELECT student_name FROM Students
WHERE student_name LIKE 'A%';

-- Display students whose names contain exactly 4 parts (4 words)
SELECT student_name FROM Students
WHERE LENGTH(student_name) - LENGTH(REPLACE(student_name, ' ', '')) = 3;

-- Apply aggregate functions (AVG, MAX, MIN) on GPA
SELECT 
    AVG(gpa) AS Average_GPA,
    MAX(gpa) AS Highest_GPA,
    MIN(gpa) AS Lowest_GPA
FROM Students;

-- Show top students in level 6 with GPA = 100
SELECT student_name, gpa, student_level 
FROM Students
WHERE student_level = 6 AND gpa = 100;

-- Show students in level 1 whose age is between 15 and 16 years
SELECT student_name, birth_date, student_level,
TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) AS Age
FROM Students
WHERE student_level = 1 AND TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) BETWEEN 15 AND 16;

-- Count students in level 2
SELECT COUNT(*) AS Level2_Students
FROM Students
WHERE student_level = 2;

-- Show student tracks without duplicates
SELECT DISTINCT track FROM Students;

-- Display subject names in uppercase
SELECT UPPER(subject_name) AS Subject_Name_Uppercase
FROM Subjects;

-- Display average GPA rounded down (numeric function)
SELECT FLOOR(AVG(gpa)) AS Rounded_Avg_GPA
FROM Students;

-- Replace gender values (string function)
UPDATE Students
SET gender = CASE
    WHEN gender = 'F' THEN 'Female'
    WHEN gender = 'M' THEN 'Male'
END;

-- Increase GPA by 5 for students whose GPA < 60
UPDATE Students
SET gpa = gpa + 5
WHERE gpa < 60;

-- Verify updated student data
SELECT * FROM Students;
