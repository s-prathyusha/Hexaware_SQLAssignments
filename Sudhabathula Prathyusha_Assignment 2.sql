--Assignment 2
--Task 1  Database Design:
--1. Create the database named "SISDB"
CREATE DATABASE SISDB;

USE SISDB;

--2.Define the schema for the Students, Courses, Enrollments, Teacher, and Payments tables based  on the provided schema. Write SQL scripts to create the mentioned tables with appropriate data types, constraints, and relationships. 
--4. Create appropriate Primary Key and Foreign Key constraints for referential integrity.
CREATE TABLE Students(
	student_id INT PRIMARY KEY,
	first_name VARCHAR(20),
	last_name VARCHAR(20),
	date_of_birth DATE,
	email VARCHAR(50),
	phone_number BIGINT
);

CREATE TABLE Teacher(
	teacher_id INT PRIMARY KEY,
	first_name VARCHAR(20),
	last_name VARCHAR(20),
	email VARCHAR(50)
);

CREATE TABLE Courses(
	course_id INT PRIMARY KEY,
	course_name VARCHAR(20),
	credits INT ,
	teacher_id INT FOREIGN KEY REFERENCES Teacher(teacher_id) ON DELETE CASCADE
);

CREATE TABLE Enrollments(
	enrollment_id INT PRIMARY KEY,
	student_id INT FOREIGN KEY REFERENCES Students(student_id) ON DELETE CASCADE,
	course_id INT FOREIGN KEY REFERENCES  Courses(course_id),
	enrollment_date DATE
);
--Other way of defining on delete cascade constraint

SELECT * FROM sys.foreign_keys
ALTER TABLE Enrollments DROP CONSTRAINT FK__Enrollmen__cours__59063A47;
ALTER TABLE Enrollments ADD CONSTRAINT "FK_course_id" FOREIGN KEY(course_id) REFERENCES Courses(course_id) ON DELETE CASCADE;

CREATE TABLE  Payments(
	payment_id INT PRIMARY KEY,
	student_id INT FOREIGN KEY REFERENCES Students(student_id) ON DELETE CASCADE,
	amount DECIMAL(10,2),
	payment_date DATE
);

--5. Insert at least 10 sample records into each of the following tables.

INSERT INTO Students VALUES
(1,'Prathyusha','Sudhabathula','2001-11-13','prathyusha@gmail.com',9603765677),
(2, 'Jayanth', 'Sudhabathula','2003-09-07', 'jayanth@gmail.com', 7036707055),
(3, 'Abubakar Siddiq', 'Shaik','2001-02-18', 'abubakarsiddiq@gmail.com', 9618595677),
(4, 'Rama Vaishnavi', 'Vedantham','2001-06-27', 'ramavaishnavi@gmail.com', 9635782416),
(5, 'Azeema', 'Shaik','2001-04-28', 'azeema@gmail.com', 8675924356),
(6, 'Akhila', 'Bodepudi', '2001-07-07','akhila@gmail.com', 8579254768),
(7, 'Leela Mahesh', 'Chittem','2001-07-15', 'leelamahesh@gmail.com', 9912704539),
(8, 'Nagarjuna', 'Devireddy', '2001-03-15','nagarjuna@gmail.com', 8567429346),
(9, 'Sai', 'Sagar', '2001-09-02','saisagar@gmail.com', 8574693254),
(10, 'Kowndinya', 'Ayithi', '2001-08-28','kowndinya@gmail.com', 9856742315);

SELECT * FROM Students;

INSERT INTO Teacher VALUES
(101,'Karthik','Kumar','karthik@gmail.com'),
(102,'Prameela Jyothi','Bombay','prameela@gmail.com'),
(103,'Farhana','Shaik','farhana@gmail.com'),
(104,'Aravinda','Kotha','aravinda@gmail.com'),
(105,'Dharani','Popuri','dharani@gmail.com'),
(106,'Niveditha','Chennupati','niveditha@gmail.com'),
(107,'Deepthi','Devara','deepthi@gmail.com'),
(108,'LakshmiKanth','Paleti','lakshmikanth@gmail.com'),
(109,'Srinivasa Rao','Manthri','srinivasarao@gmail.com'),
(110,'James','Bathula','james@gmail.com');

SELECT * FROM Teacher;

INSERT INTO Courses VALUES
(201,'Computer Networks',3,101),
(202,'C Programming',3,102),
(203,'Data Structures',4,103),
(204,'Automata Theory',3,104),
(205,'PEE',2,105),
(206,'Machine Learning',3,106),
(207,'Cloud Computing',2,107),
(208,'Web Applications',3,108),
(209,'NLP',2,109),
(210,'English',2,110);

SELECT * FROM Courses;

INSERT INTO Enrollments VALUES
(301,1,201,'2023-11-13'),
(302,2,205,'2023-09-07'),
(303,3,209,'2023-02-18'),
(304,4,204,'2023-06-27'),
(305,5,202,'2023-04-28'),
(306,6,203,'2023-07-07'),
(307,7,208,'2023-07-15'),
(308,8,207,'2023-03-13'),
(309,9,206,'2023-09-02'),
(310,10,210,'2023-04-06');

SELECT * FROM Enrollments;

INSERT INTO Payments VALUES
(401,1,2000,'2023-11-13'),
(402,2,2500,'2023-09-07'),
(403,3,2000,'2023-02-18'),
(404,4,1000,'2023-06-27'),
(405,5,3200,'2023-04-28'),
(406,6,1500,'2023-07-07'),
(407,7,2000,'2023-07-15'),
(408,8,1700,'2023-03-13'),
(409,9,2600,'2023-09-02'),
(410,10,2000,'2023-04-06');

SELECT * FROM Payments;

--Tasks 2: Select, Where, Between, AND, LIKE

--1. Write an SQL query to insert a new student into the "Students" table with the following details:
	--a. First Name: John
	--b. Last Name: Doe
	--c. Date of Birth: 1995-08-15
	--d. Email: john.doe@example.com
	--e. Phone Number: 1234567890

INSERT INTO Students VALUES (11,'John','Doe','1995-08-15','john.doe@example.com',1234567890);

--2. Write an SQL query to enroll a student in a course. Choose an existing student and course and insert a record into the "Enrollments" table with the enrollment date.
INSERT INTO Enrollments VALUES (311,1,208,'2023-02-18');

--3. Update the email address of a specific teacher in the "Teacher" table. Choose any teacher and modify their email address.
UPDATE Teacher SET email='prameelajyothi@gmail.com' WHERE last_name='Bombay';

--4. Write an SQL query to delete a specific enrollment record from the "Enrollments" table. Select an enrollment record based on the student and course.
DELETE FROM Enrollments WHERE student_id=5 AND course_id=202;

--5. Update the "Courses" table to assign a specific teacher to a course. Choose any course and teacher from the respective tables
UPDATE Courses SET teacher_id=102 WHERE course_name='English';

--6. Delete a specific student from the "Students" table and remove all their enrollment records from the "Enrollments" table. Be sure to maintain referential integrity
DELETE FROM Students WHERE student_id=2;
SELECT * FROM Enrollments;
SELECT * FROM Payments;

--7. Update the payment amount for a specific payment record in the "Payments" table. Choose any payment record and modify the payment amount
UPDATE Payments SET amount=3500 WHERE student_id=5;

--Task 3. Aggregate functions, Having, Order By, GroupBy and Joins:
--1. Write an SQL query to calculate the total payments made by a specific student. You will need to join the "Payments" table with the "Students" table based on the student's ID.
SELECT S.first_name+' '+S.last_name "Name",count(*) "Payments Made",SUM(P.amount) "Amount Paid" FROM Payments P 
JOIN Students S ON P.student_id=S.student_id
GROUP BY S.first_name,S.last_name;

SELECT S.first_name + ' ' + S.last_name AS "Name",
       COALESCE(COUNT(P.payment_id), 0) AS "Payments Made",   --coalesce() replaces null values 
       COALESCE(SUM(P.amount), 0) AS "Amount Paid"
FROM Students S
LEFT JOIN Payments P ON P.student_id = S.student_id
GROUP BY S.first_name, S.last_name;

--2. Write an SQL query to retrieve a list of courses along with the count of students enrolled in each course. Use a JOIN operation between the "Courses" table and the "Enrollments" table.
SELECT C.course_name,COUNT(*)"Students Enrolled" FROM  Courses C 
INNER JOIN Enrollments E
ON C.course_id=E.course_id
GROUP BY C.course_name;

--3. Write an SQL query to find the names of students who have not enrolled in any course. Use a LEFT JOIN between the "Students" table and the "Enrollments" table to identify students without enrollments.
SELECT * FROM  Students S
LEFT JOIN Enrollments E
ON S.student_id=E.student_id;

--4. Write an SQL query to retrieve the first name, last name of students, and the names of the courses they are enrolled in. Use JOIN operations between the "Students" table and the "Enrollments" and "Courses" tables.
SELECT CONCAT(S.first_name,' ',S.last_name) "Name",C.course_name  FROM Students S
JOIN Enrollments E ON S.student_id=E.student_id
JOIN Courses C ON E.course_id=C.course_id;

--5. Create a query to list the names of teachers and the courses they are assigned to. Join the "Teacher" table with the "Courses" table.
SELECT T.first_name+' '+T.last_name "Teacher Name",C.course_name FROM Teacher T
JOIN Courses C
ON C.teacher_id=T.teacher_id;

--6. Retrieve a list of students and their enrollment dates for a specific course. You'll need to join the "Students" table with the "Enrollments" and "Courses" tables.
SELECT CONCAT(S.first_name,' ',S.last_name) "Name",C.course_name,E.enrollment_date FROM Students S
JOIN Enrollments E
ON S.student_id=E.student_id
JOIN Courses C
ON C.course_id=E.course_id
WHERE C.course_name='NLP';

--7. Find the names of students who have not made any payments. Use a LEFT JOIN between the "Students" table and the "Payments" table and filter for students with NULL payment records.
SELECT CONCAT(S.first_name,' ',S.last_name) "Name" FROM Students S
LEFT JOIN Payments P ON S.student_id=P.student_id
WHERE P.payment_id IS NULL;

--8. Write a query to identify courses that have no enrollments. You'll need to use a LEFT JOIN  between the "Courses" table and the "Enrollments" table and filter for courses with NULL enrollment records.
SELECT C.course_name FROM Courses C
LEFT JOIN Enrollments E ON C.course_id=E.course_id
WHERE E.enrollment_id IS NULL;

--9. Identify students who are enrolled in more than one course. Use a self-join on the "Enrollments" table to find students with multiple enrollment records.
SELECT CONCAT(S.first_name,' ',S.last_name),COUNT(*) "Courses Enrolled" FROM Enrollments E
JOIN Students S ON S.student_id=E.student_id
GROUP BY S.first_name,S.last_name
HAVING COUNT(*)>1;

SELECT DISTINCT e1.student_id, s.first_name, s.last_name
FROM Enrollments e1
INNER JOIN Enrollments e2 ON e1.student_id = e2.student_id
INNER JOIN Students s ON e1.student_id = s.student_id
WHERE e1.course_id <> e2.course_id;

--10. Find teachers who are not assigned to any courses. Use a LEFT JOIN between the "Teacher" table and the "Courses" table and filter for teachers with NULL course assignments.
SELECT T.first_name+' '+T.last_name "Name" FROM Teacher T
LEFT JOIN  Courses C
ON C.teacher_id=T.teacher_id
WHERE C.course_id IS NULL;

--Task 4. Subquery and its types
--1. Write an SQL query to calculate the average number of students enrolled in each course. Use aggregate functions and subqueries to achieve this.
SELECT AVG(NoOfStudentsEnrolled) "AvgNoOfStudentsPerCourse"
FROM 
(SELECT E.course_id,COUNT(E.student_id) "NoOfStudentsEnrolled" FROM Enrollments E GROUP BY E.course_id) 
AS CourseEnrollments;

--2. Identify the student(s) who made the highest payment. Use a subquery to find the maximum payment amount and then retrieve the student(s) associated with that amount.
SELECT first_name+' '+last_name "Name" FROM Students WHERE student_id
 = (SELECT student_id FROM Payments WHERE amount = (SELECT MAX(amount) FROM Payments))

--3. Retrieve a list of courses with the highest number of enrollments. Use subqueries to find the course(s) with the maximum enrollment count
SELECT C.course_name FROM Courses C WHERE 
C.course_id = 
(SELECT E.course_id FROM Enrollments E
GROUP BY course_id
ORDER BY COUNT(*) DESC 
OFFSET 0 ROWS
FETCH NEXT 1 ROW ONLY);

SELECT C.course_name FROM Courses C WHERE 
C.course_id IN
(SELECT E.course_id FROM Enrollments E
GROUP BY course_id
HAVING COUNT(*) = 
(SELECT COUNT(*) FROM Enrollments E
GROUP BY course_id
ORDER BY COUNT(*) DESC 
OFFSET 0 ROWS
FETCH NEXT 1 ROW ONLY));

SELECT C.course_name FROM Courses C WHERE 
C.course_id IN (SELECT course_id 
FROM Enrollments
GROUP BY course_id
HAVING COUNT(*) = (
    SELECT MAX(EnrollmentCount)
    FROM (
        SELECT course_id, COUNT(*) AS EnrollmentCount
        FROM Enrollments
        GROUP BY course_id
    ) AS CourseEnrollments
));

--4. Calculate the total payments made to courses taught by each teacher. Use subqueries to sum payments for each teacher's courses.
SELECT C.teacher_id,T.first_name+' '+T.last_name "Teacher Name",SUM(amount) "Payment to teacher" 
FROM Payments P INNER JOIN Enrollments E ON E.student_id = P.student_id
INNER JOIN Courses C ON C.course_id = E.course_id
INNER JOIN Teacher T ON T.teacher_id = C.teacher_id
GROUP BY C.teacher_id,T.first_name+' '+T.last_name;

--5. Identify students who are enrolled in all available courses. Use subqueries to compare a student's enrollments with the total number of courses.
SELECT E.student_id,S.first_name+' '+S.last_name "Name" FROM Enrollments E
INNER JOIN Students S ON S.student_id = E.student_id
GROUP BY E.student_id,S.first_name+' '+S.last_name
HAVING COUNT(*) = (SELECT COUNT(DISTINCT course_id) FROM Courses);

--6. Retrieve the names of teachers who have not been assigned to any courses. Use subqueries to find teachers with no course assignments.
SELECT T.first_name+' '+T.last_name "Teacher Name" FROM Teacher T
WHERE T.teacher_id NOT IN 
(SELECT DISTINCT teacher_id FROM Courses);

--7. Calculate the average age of all students. Use subqueries to calculate the age of each student based on their date of birth.
SELECT AVG(Age) "AverageAgeOfStudents" FROM 
(SELECT DATEDIFF(YYYY,date_of_birth,GETDATE()) "Age" FROM Students) AS AgesTable;

--8. Identify courses with no enrollments. Use subqueries to find courses without enrollment records.
SELECT * FROM Courses
WHERE course_id NOT IN 
(SELECT DISTINCT course_id FROM Enrollments);

--9. Calculate the total payments made by each student for each course they are enrolled in. Use subqueries and aggregate functions to sum payments.
SELECT e.student_id, c.course_id, SUM(p.amount) AS total_payments
FROM Enrollments e
JOIN Payments p ON e.student_id = p.student_id
JOIN Courses c ON e.course_id = c.course_id
GROUP BY e.student_id, c.course_id;

--10. Identify students who have made more than one payment. Use subqueries and aggregate functions to count payments per student and filter for those with counts greater than one.
SELECT P.student_id,S.first_name+' '+S.last_name "Name" FROM Payments P
JOIN Students S ON S.student_id = P.student_id
GROUP BY P.student_id,S.first_name+' '+S.last_name
HAVING COUNT(*)>1;

--11. Write an SQL query to calculate the total payments made by each student. Join the "Students" table with the "Payments" table and use GROUP BY to calculate the sum of payments for each student.
SELECT P.student_id,S.first_name+' '+S.last_name "Name",SUM(P.amount)"Total Payment"FROM Payments P 
INNER JOIN Students S ON S.student_id = P.student_id
GROUP BY P.student_id,S.first_name+' '+S.last_name;

--12. Retrieve a list of course names along with the count of students enrolled in each course. Use JOIN operations between the "Courses" table and the "Enrollments" table and GROUP BY to count enrollments.
SELECT E.course_id,C.course_name,COUNT(*) FROM Courses C
JOIN Enrollments E ON C.course_id = E.course_id
GROUP BY E.course_id,C.course_name;

--13. Calculate the average payment amount made by students. Use JOIN operations between the "Students" table and the "Payments" table and GROUP BY to calculate the average.
SELECT P.student_id,S.first_name ,AVG(amount) "Average Payment" FROM Payments P
JOIN Students S ON S.student_id = P.student_id
GROUP BY P.student_id,S.first_name;


SELECT * FROM Courses;
SELECT * FROM Enrollments;
SELECT * FROM Students;
SELECT * FROM Teacher;
SELECT * FROM Payments;
