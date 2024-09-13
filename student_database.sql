-- select the student_database schema to use --
USE student_database;

-- creating the students table --
-- contains basic student information --
CREATE TABLE Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    dob DATE,
    email VARCHAR(100),
    phone_number VARCHAR(20)
);

-- creating the courses table --
-- contains course information --
CREATE TABLE Courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100),
    instructor VARCHAR(100)
);

-- creating the enrollments table --
-- links students to the courses they are enrolled in --
CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    FOREIGN KEY (student_id)
        REFERENCES Students (student_id),
    FOREIGN KEY (course_id)
        REFERENCES Courses (course_id)
);

-- creating the grades table --
-- records the grades that students receive in courses --
CREATE TABLE Grades (
    grade_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    grade VARCHAR(2),
    FOREIGN KEY (student_id)
        REFERENCES Students (student_id),
    FOREIGN KEY (course_id)
        REFERENCES Courses (course_id)
);

-- insert some data into the tables --
-- inserting data into the students table --
INSERT INTO Students (first_name, last_name, dob, email, phone_number) VALUES
	('John', 'Doe', '2000-05-10', 'john.doe@example.com', '123-456-7890'),
	('Jane', 'Smith', '1999-08-20', 'jane.smith@example.com', '098-765-4321'),
	('Mike', 'Johnson', '2001-11-15', 'mike.johnson@example.com', '234-567-8901')
;

-- inserting data into the courses table --
INSERT INTO Courses (course_name, instructor) VALUES
	('Database Systems', 'Prof. Martin'),
	('Data Structures', 'Prof. Anderson'),
	('Web Development', 'Prof. Lee')
;

-- inserting data into the enrollments table --
INSERT INTO Enrollments (student_id, course_id, enrollment_date) VALUES
	(1, 1, '2023-09-01'),
    (1, 2, '2023-09-02'),
    (2, 1, '2023-09-01'),
    (2, 3, '2023-09-03'),
    (3, 2, '2023-09-02')
;

-- inserting data into grades table --
INSERT INTO Grades (student_id, course_id, grade) VALUES
	(1, 1, 'A'),
    (1, 2, 'B'),
    (2, 1, 'B'),
    (2, 3, 'A'),
    (3, 2, 'C')
;

-- queries to retrieve data from the database --
-- retrieve all students and their details --
SELECT 
    *
FROM
    Students;
    
-- get the courses a student is enrolled in (by student_id) --
SELECT 
    S.first_name, S.last_name, C.course_name, E.enrollment_date
FROM
    Students S
        JOIN
    Enrollments E ON S.student_id = E.student_id
        JOIN
    Courses C ON E.course_id = C.course_id
WHERE
    S.student_id = 1;
    
-- get the grades of a student (by student_id) --
SELECT 
    S.first_name, S.last_name, C.course_name, G.grade
FROM
    Students S
        JOIN
    Grades G ON S.student_id = G.student_id
        JOIN
    Courses C ON G.course_id = C.course_id
WHERE
    S.student_id = 1;
    
-- get the average grade for a course --
SELECT 
    course_name,
    AVG(CASE
        WHEN grade = 'A' THEN 4.0
        WHEN grade = 'B' THEN 3.0
        WHEN grade = 'C' THEN 2.0
        ELSE 0
    END) AS avg_grade
FROM
    Grades G
        JOIN
    Courses C ON G.course_id = C.course_id
GROUP BY C.course_name;

-- get the total number of students enrolled in each course --
SELECT 
    C.course_name, COUNT(E.student_id) AS total_students
FROM
    Enrollments E
        JOIN
    Courses C ON E.course_id = C.course_id
GROUP BY C.course_name;

-- retrieve all students enrolled in a particular course (by course_id) --
SELECT 
    S.first_name, S.last_name
FROM
    Students S
        JOIN
    Enrollments E ON S.student_id = E.student_id
WHERE
    E.course_id = 1;
    
-- use queries to update a student's information (e.g., phone number) -- 
UPDATE Students 
SET 
    phone_number = '321-654-0987'
WHERE
    student_id = 1;
    
-- delete a student's enrollment -- 
DELETE FROM Enrollments 
WHERE
    enrollment_id = 2;