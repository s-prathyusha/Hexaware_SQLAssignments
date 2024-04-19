--Assignment 4
--Define the Database Schema
CREATE DATABASE "Courier Management System";

USE [Courier Management System];

--Create SQL tables for entities such as User, Courier, Employee, Location,Payment 
--Define relationships between these tables (one-to-many, many-to-many, etc.). 

CREATE TABLE Users(
	UserID INT PRIMARY KEY IDENTITY(1,1), 
	Name VARCHAR(255), 
	Email VARCHAR(255) UNIQUE, 
	Password VARCHAR(255), 
	ContactNumber VARCHAR(20), 
	Address TEXT 
);

CREATE TABLE Courier(
	CourierID INT PRIMARY KEY IDENTITY(101,1), 
	SenderName VARCHAR(255), 
	SenderAddress TEXT, 
	ReceiverName VARCHAR(255), 
	ReceiverAddress TEXT, 
	Weight DECIMAL(5, 2), 
	Status VARCHAR(50), 
	TrackingNumber VARCHAR(20) UNIQUE, 
	DeliveryDate DATE
);

CREATE TABLE CourierServices (
	ServiceID INT PRIMARY KEY IDENTITY(201,1), 
	ServiceName VARCHAR(100), 
	Cost DECIMAL(8, 2)
); 

CREATE TABLE Employee(
	EmployeeID INT PRIMARY KEY IDENTITY(301,1), 
	Name VARCHAR(255), 
	Email VARCHAR(255) UNIQUE, 
	ContactNumber VARCHAR(20), 
	Role VARCHAR(50), 
	Salary DECIMAL(10, 2)
);

CREATE TABLE Location(
	LocationID INT PRIMARY KEY IDENTITY(401,1), 
	LocationName VARCHAR(100), 
	Address TEXT
); 

CREATE TABLE Payment(
	PaymentID INT PRIMARY KEY IDENTITY(501,1), 
	CourierID INT, 
	LocationId INT, 
	Amount DECIMAL(10, 2), 
	PaymentDate DATE, 
	FOREIGN KEY (CourierID) REFERENCES Courier(CourierID) ON DELETE CASCADE, 
	FOREIGN KEY (LocationID) REFERENCES Location(LocationID) ON DELETE CASCADE
);

--• Populate Sample Data • Insert sample data into the tables to simulate real-world scenarios. 
INSERT INTO Users ( Name, Email, Password, ContactNumber, Address)
VALUES
( 'John Doe', 'john.doe@gmail.com', 'password123', '1234567890', '123 Main St, Guntur, India'),
( 'Jane Smith', 'jane.smith@gmail.com', 'securepassword', '9876543210', '456 Elm St, Texas, USA'),
( 'Michael Johnson', 'michael.j@gmail.com', 'michaelpass', '5556667777', '789 Oak St, Vijayawada, India'),
( 'Emily Brown', 'emily.b@gmail.com', 'emilypass', '1112223333', '101 Pine St, Connecticut, USA'),
( 'Sophia Garcia', 'sophia.g@gmail.com', 'sophiapass', '4445556666', '202 Maple St, Mumbai, India'),
( 'William Martinez', 'william.m@gmail.com', 'williampass', '8889990000', '303 Cedar St, Chennai, India'),
( 'Olivia Lee', 'olivia.l@gmail.com', 'oliviapass', '3334445555', '404 Pine St, Bangalore, India'),
( 'James Wilson', 'james.w@gmail.com', 'jamespass', '6667778888', '505 Elm St, Maryland, USA'),
( 'Emma Anderson', 'emma.a@gmail.com', 'emmapass', '9990001111', '606 Oak St, Hyderabad, India'),
( 'Daniel Taylor', 'daniel.t@gmail.com', 'danielpass', '2223334444', '707 Maple St, Kolkata, India');

INSERT INTO Courier (SenderName, SenderAddress, ReceiverName, ReceiverAddress, Weight, Status, TrackingNumber, DeliveryDate)
VALUES
('Alice', '123 Sender St', 'Bob', '456 Receiver St', 2.5, 'In Transit', 'ABC123', '2024-04-15'),
('Eve', '789 Sender St', 'Mallory', '012 Receiver St', 1.8, 'Delivered', 'XYZ789', '2024-04-14'),
('Charlie', '456 Sender St', 'David', '789 Receiver St', 3.0, 'Pending', 'DEF456', NULL),
('Fiona', '012 Sender St', 'Grace', '123 Receiver St', 1.2, 'In Transit', 'GHI789', '2024-04-16'),
('George', '789 Sender St', 'Hannah', '456 Receiver St', 2.8, 'Delivered', 'JKL012', '2024-04-13'),
('Ivy', '456 Sender St', 'Jack', '012 Receiver St', 1.5, 'Pending', 'MNO345', NULL),
('Kevin', '123 Sender St', 'Lily', '789 Receiver St', 2.0, 'In Transit', 'PQR678', '2024-04-17'),
('Megan', '012 Sender St', 'Nathan', '456 Receiver St', 3.2, 'Delivered', 'STU901', '2024-04-12'),
('Oliver', '789 Sender St', 'Sophie', '123 Receiver St', 2.3, 'Pending', 'VWX234', NULL),
( 'Peter', '456 Sender St', 'Rachel', '789 Receiver St', 1.7, 'In Transit', 'YZA567', '2024-04-18');

INSERT INTO CourierServices (ServiceName, Cost)
VALUES
('Standard Delivery', 10.00),
('Express Delivery', 20.00),
('Same Day Delivery', 30.00),
('International Delivery', 50.00),
('Next Day Delivery', 15.00),
('Priority Delivery', 25.00),
('Overnight Delivery', 18.00),
('Economy Delivery', 8.00),
('Two-Day Delivery', 12.00),
('Scheduled Delivery', 22.00);

INSERT INTO Employee (Name, Email, ContactNumber, Role, Salary)
VALUES
('David Johnson', 'david.johnson@gmail.com', '1112223333', 'Manager', 50000.00),
('Emily Brown', 'emily.brown@gmail.com', '4445556666', 'Courier', 30000.00),
('Michael Smith', 'michael.smith@gmail.com', '7778889999', 'Customer Service Representative', 35000.00),
('Jessica Davis', 'jessica.davis@gmail.com', '1113335555', 'Warehouse Manager', 45000.00),
('Christopher Wilson', 'christopher.wilson@gmail.com', '2224446666', 'Dispatcher', 40000.00),
('Amanda Taylor', 'amanda.taylor@gmail.com', '3335557777', 'Driver', 32000.00),
('Daniel Martinez', 'daniel.martinez@gmail.com', '4446668888', 'Logistics Coordinator', 38000.00),
('Sarah Anderson', 'sarah.anderson@gmail.com', '5557779999', 'Supervisor', 42000.00),
('Ryan Thompson', 'ryan.thompson@gmail.com', '6668881111', 'Package Handler', 28000.00),
('Melissa Hernandez', 'melissa.hernandez@gmail.com', '7779991111', 'Security Guard', 30000.00);

INSERT INTO Location (LocationName, Address)
VALUES
('Head Office', '789 HQ St, New York City, USA'),
('Branch Office 1', '456 Branch St, Los Angeles, USA'),
('Branch Office 2', '123 Main St, London, UK'),
('Warehouse', '101 Warehouse Ave, Tokyo, Japan'),
('Distribution Center', '555 Distribution Blvd, Sydney, Australia'),
('Shipping Hub', '999 Shipping Ln, Paris, France'),
('Customer Service Center', '777 Service Rd, Berlin, Germany'),
('Dispatch Center', '333 Dispatch Blvd, Toronto, Canada'),
('Logistics Center', '888 Logistics Rd, Mumbai, India'),
('Security Office', '222 Security Ave, Rio de Janeiro, Brazil');

INSERT INTO Payment (CourierID, LocationID, Amount, PaymentDate)
VALUES
(101, 402, 10.00, '2024-04-16'),
(102, 401, 15.00, '2024-04-15'),
(103, 403, 12.50, '2024-04-17'),
(104, 405, 8.00, '2024-04-18'),
(105, 404, 20.00, '2024-04-19'),
(106, 406, 10.00, '2024-04-20'),
(107, 407, 15.00, '2024-04-21'),
(108, 408, 18.00, '2024-04-22'),
(109, 409, 25.00, '2024-04-23'),
(110, 410, 30.00, '2024-04-24');

--Task 2: Select,Where
--1. List all customers: 
SELECT Name "Customer Name" FROM Users;

--**2. List all orders for a specific customer: 
SELECT * FROM Courier WHERE SenderName = 'George';
SELECT * FROM Courier WHERE ReceiverName = 'Hannah';
SELECT * FROM Courier WHERE UserID=5;

--3. List all couriers:
SELECT * FROM Courier;

--**4. List all packages for a specific order: 
SELECT * FROM Courier WHERE CourierID = 108 ;

--**5. List all deliveries for a specific courier: 
SELECT * FROM Courier WHERE CourierID = 106;

--6. List all undelivered packages:
SELECT * FROM Courier WHERE Status <> 'Delivered';

--7. List all packages that are scheduled for delivery today:
SELECT * FROM Courier WHERE DeliveryDate = CONVERT(DATE,GETDATE());

--8. List all packages with a specific status:
SELECT * FROM Courier WHERE Status = 'Pending';

--**9. Calculate the total number of packages for each courier. 
SELECT CourierID, COUNT(*) AS TotalPackages
FROM Courier
GROUP BY CourierID;

--**10. Find the average delivery time for each courier 
--Adding a column called OrderedDate and data Inserted
ALTER TABLE Courier ADD OrderedDate DATE;

SELECT CourierID,AVG(DATEDIFF(DAY,OrderedDate,DeliveryDate)) AS "AvgDeliveryTime(Days)"
FROM Courier
GROUP BY CourierID;

--Otherwise we can consider Payment Date
SELECT C.CourierID, AVG(DATEDIFF(DAY,C.DeliveryDate, P.PaymentDate)) AS "AvgDeliveryTime(Days)"
FROM Courier c, Payment P
GROUP BY c.CourierID;

--11. List all packages with a specific weight range: 
SELECT * FROM Courier WHERE Weight BETWEEN 1.00 AND 2.00;

--12. Retrieve employees whose names contain 'John'
SELECT * FROM Employee WHERE Name LIKE '%John%';

--13. Retrieve all courier records with payments greater than $50. 
SELECT * FROM Courier
WHERE CourierID IN (SELECT CourierID FROM Payment WHERE Amount>50);

--Task 3: GroupBy, Aggregate Functions, Having, Order By, where 
--14.** Find the total number of couriers handled by each employee. 
--SELECT (SELECT Name FROM EMPLOYEE WHERE Role='Courier Manager')"Courier Manager",(SELECT COUNT(*) FROM Courier) "Number of Couriers handled";
--Add a column EmpID in Courier Table Refering Employees table and Insert data thrn link the tables
ALTER TABLE Courier ADD EmployeeID INT FOREIGN KEY REFERENCES Employee(EmployeeID);

SELECT C.EmployeeID,E.Name,COUNT(*)  "Number of Couriers handled" FROM Courier C
JOIN Employee E ON E.EmployeeID = C.EmployeeID
GROUP BY C.EmployeeID,E.Name;

--15. Calculate the total revenue generated by each location 
SELECT P.LocationId, L.LocationName,SUM(Amount) "Total Revenue" FROM Payment P
JOIN Location L ON L.LocationID = P.LocationId
GROUP BY P.LocationId,L.LocationName;

--16. Find the total number of couriers delivered to each location.
SELECT P.LocationId, L.LocationName,COUNT(CourierID) "NoOfCouriers" FROM Payment P
JOIN Location L ON L.LocationID = P.LocationId
GROUP BY P.LocationId,L.LocationName;

--17. **Find the courier with the highest average delivery time: 
SELECT C.CourierID, AVG(DATEDIFF(DAY,OrderedDate,DeliveryDate)) AS AvgDeliveryTime
FROM Courier C
GROUP BY C.CourierID
ORDER BY AvgDeliveryTime DESC
OFFSET 0 ROWS
FETCH NEXT 1 ROW ONLY;

SELECT C.CourierID, AVG(DATEDIFF(DAY,C.DeliveryDate, P.PaymentDate)) AS "AvgDeliveryTime(Days)"
FROM Courier c, Payment P
GROUP BY C.CourierID
ORDER BY [AvgDeliveryTime(Days)] DESC
OFFSET 0 ROWS
FETCH NEXT 1 ROW ONLY;

SELECT TOP 1 C.CourierID, AVG(DATEDIFF(DAY,C.DeliveryDate, P.PaymentDate)) AS "AvgDeliveryTime(Days)"
FROM Courier c, Payment P
GROUP BY C.CourierID
ORDER BY [AvgDeliveryTime(Days)] DESC;

--18. Find Locations with Total Payments Less Than a Certain Amount
SELECT P.LocationId, L.LocationName,SUM(Amount) "Total Payment" FROM Payment P
JOIN Location L ON L.LocationID = P.LocationId
GROUP BY P.LocationId,L.LocationName
HAVING SUM(Amount)<15;

--19. Calculate Total Payments per Location 
SELECT L.LocationName, SUM(P.Amount) AS TotalPayments
FROM Location L
LEFT JOIN Payment P ON L.LocationID = P.LocationID
GROUP BY L.LocationID,L.LocationName;

--20. Retrieve couriers who have received payments totaling more than $1000 in a specific location (LocationID = X): 
SELECT * FROM Courier WHERE CourierID IN
(SELECT CourierID  FROM Payment
WHERE LocationId = 410
GROUP BY CourierID
HAVING SUM(Amount)>1000);

--21. Retrieve couriers who have received payments totaling more than $1000 after a certain date (PaymentDate > 'YYYY-MM-DD'): 
SELECT * FROM Courier WHERE CourierID IN
(SELECT CourierID  FROM Payment
WHERE PaymentDate > '2024-03-01'
GROUP BY LocationId,CourierID
HAVING SUM(Amount)>1000);

--22. Retrieve locations where the total amount received is more than $5000 before a certain date (PaymentDate > 'YYYY-MM-DD') 
SELECT * FROM Location WHERE LocationID IN
(SELECT LocationId  FROM Payment
WHERE PaymentDate > '2024-03-01'
GROUP BY LocationId
HAVING SUM(Amount)>5000);

--Task 4: Inner Join,Full Outer Join, Cross Join, Left Outer Join,Right Outer Join 
--23. Retrieve Payments with Courier Information 
SELECT * FROM Payment P
JOIN Courier C  ON C.CourierID = P.CourierID;

--24. Retrieve Payments with Location Information 
SELECT P.*,L.LocationName,L.Address FROM Payment P 
INNER JOIN Location L ON L.LocationID = P.LocationId;

--25. Retrieve Payments with Courier and Location Information 
SELECT P.*,L.LocationName,L.Address,C.* FROM Payment P
INNER JOIN Location L ON L.LocationID = P.LocationId
INNER JOIN Courier C ON C.CourierID = P.CourierID;

--26. List all payments with courier details 
SELECT * FROM Payment P
JOIN Courier C  ON C.CourierID = P.CourierID;

--27. Total payments received for each courier
SELECT P.CourierID,SUM(P.Amount)"Total Payment" FROM Payment P
GROUP BY P.CourierID;

--28. List payments made on a specific date
SELECT * FROM Payment
WHERE PaymentDate = '2024-04-15';

--29. Get Courier Information for Each Payment 
SELECT * FROM Payment P
JOIN Courier C  ON C.CourierID = P.CourierID;

--30. Get Payment Details with Location 
SELECT P.*,L.LocationName,L.Address FROM Payment P 
INNER JOIN Location L ON L.LocationID = P.LocationId;

--31. Calculating Total Payments for Each Courier
SELECT P.CourierID,SUM(P.Amount)"Total Payment" FROM Payment P
GROUP BY P.CourierID;

--32. List Payments Within a Date Range 
SELECT * FROM Payment WHERE PaymentDate BETWEEN '2024-04-01' AND '2024-04-15';

--**33. Retrieve a list of all users and their corresponding courier records, including cases where there are no matches on either side 
--FULL OUTER JOIN
--As there is no relation between Users and Courier tables add UserId in Couriers table
ALTER TABLE Courier ADD UserID INT FOREIGN KEY REFERENCES Users(userID);

SELECT U.UserID ,U.Name,C.* FROM Users U FULL OUTER JOIN Courier C ON C.UserID = U.UserID;

--34. Retrieve a list of all couriers and their corresponding services, including cases where there are no matches on either side
--Joining based on their costs
SELECT C.*,CS.* FROM Courier C
JOIN Payment P ON P.CourierID = C.CourierID
FULL OUTER JOIN CourierServices CS ON P.Amount = CS.Cost;

--Adding a column CourierService ID in Couriers table and linking them
ALTER TABLE Courier ADD ServiceID INT FOREIGN KEY REFERENCES CourierServices(ServiceID);

SELECT * FROM Courier C JOIN CourierServices CS 
ON C.ServiceID = CS.ServiceID;

--**35.Retrieve a list of all employees and their corresponding payments, including cases where there are no matches on either side 
--Adding Employee Id in Payments table
ALTER TABLE Payment ADD EmployeeID INT FOREIGN KEY REFERENCES Employee(EmployeeID) ;

SELECT * FROM Payment P FULL OUTER JOIN Employee E ON E.EmployeeID = P.EmployeeID; 

--36. List all users and all courier services, showing all possible combinations. 
SELECT * FROM Users
CROSS JOIN CourierServices;

SELECT * FROM Users,CourierServices;

--37. List all employees and all locations, showing all possible combinations: 
SELECT * FROM Employee CROSS JOIN Location;

--**38. Retrieve a list of couriers and their corresponding sender information (if available) 
SELECT c.*, u.*
FROM Courier c
LEFT JOIN Users u ON c.SenderName = u.Name;

SELECT C.*, U.*
FROM Courier C
LEFT JOIN Users u ON C.UserID = U.UserID;

--**39. Retrieve a list of couriers and their corresponding receiver information (if available):
SELECT c.*, u.*
FROM Courier c
LEFT JOIN Users u ON c.ReceiverName = u.Name;

SELECT C.*, U.*
FROM Courier C
LEFT JOIN Users u ON C.UserID = U.UserID;

--**40. Retrieve a list of couriers along with the courier service details (if available): 
--Joining based on Cost
SELECT C.*,CS.* FROM Courier C
JOIN Payment P ON P.CourierID = C.CourierID
FULL OUTER JOIN CourierServices CS ON P.Amount = CS.Cost;

SELECT * FROM Courier C JOIN CourierServices CS 
ON C.ServiceID = CS.ServiceID;

--**41. Retrieve a list of employees and the number of couriers assigned to each employee: 
--SELECT (SELECT Name FROM EMPLOYEE WHERE Role='Courier Manager')"Courier Manager",(SELECT COUNT(*) FROM Courier) "Number of Couriers assigned";
--As we added an Employee ID we can link them now
SELECT C.EmployeeID,E.Name,COUNT(*)  "Number of Couriers assigned" FROM Courier C
JOIN Employee E ON E.EmployeeID = C.EmployeeID
GROUP BY C.EmployeeID,E.Name;

--42. Retrieve a list of locations and the total payment amount received at each location: 
SELECT P.LocationId,L.LocationName,SUM(Amount) "Total Payment" FROM Location L 
INNER JOIN Payment P ON P.LocationId = L.LocationID
GROUP BY P.LocationId,L.LocationName;

--43. Retrieve all couriers sent by the same sender (based on SenderName). 
SELECT * FROM Courier WHERE SenderName = 'Alice';

SELECT *FROM Courier c1
JOIN Courier c2 ON c1.SenderName = c2.SenderName 
AND c1.CourierID != c2.CourierID;

--44. List all employees who share the same role. 
SELECT e1.*, e2.*FROM Employee e1
JOIN Employee e2 ON e1.Role = e2.Role AND e1.EmployeeID != e2.EmployeeID;

SELECT * FROM Employee WHERE Role = 'Warehouse Manager';

--45. Retrieve all payments made for couriers sent from the same location. 
SELECT P.* FROM Payment P
JOIN Courier C ON P.CourierID = C.CourierID
WHERE P.LocationId = 408; 

SELECT *
FROM Payment p1
JOIN Payment p2 ON p1.LocationID = p2.LocationID 
AND p1.CourierID != p2.CourierID;

--46. Retrieve all couriers sent from the same location (based on SenderAddress).
SELECT *
FROM Courier c1
JOIN Courier c2 ON c1.SenderAddress = c2.SenderAddress 
AND c1.CourierID != c2.CourierID;

SELECT * FROM Courier WHERE SenderAddress = '123 Sender St';

--**47. List employees and the number of couriers they have delivered: 
--SELECT (SELECT Name FROM EMPLOYEE WHERE Role='Courier Manager')"Courier Manager",(SELECT COUNT(*) FROM Courier WHERE Status = 'Delivered') "Number of Couriers Delivered";
SELECT C.EmployeeID,E.Name,COUNT(*)  "Number of Couriers Delivered" FROM Courier C
JOIN Employee E ON E.EmployeeID = C.EmployeeID
WHERE Status = 'Delivered'
GROUP BY C.EmployeeID,E.Name;

--**48. Find couriers that were paid an amount greater than the cost of their respective courier services 
--SELECT * FROM Courier C JOIN Payment P ON C.CourierID = P.CourierID WHERE P.Amount > ALL (SELECT DISTINCT Cost FROM CourierServices);
SELECT C.*,cs.Cost,P.Amount FROM Courier C 
JOIN Payment P ON C.CourierID = P.CourierID 
JOIN CourierServices CS ON CS.ServiceID = C.ServiceID
Where CS.Cost < P.Amount;

--Scope: Inner Queries, Non Equi Joins, Equi joins,Exist,Any,All
--49. Find couriers that have a weight greater than the average weight of all couriers 
SELECT * FROM Courier WHERE Weight >
(SELECT AVG(Weight) FROM Courier);

--50. Find the names of all employees who have a salary greater than the average salary: 
SELECT Name FROM Employee WHERE Salary > (SELECT AVG(Salary) FROM Employee);

--51. Find the total cost of all courier services where the cost is less than the maximum cost 
SELECT SUM(Cost) "Total Cost" FROM CourierServices WHERE Cost<
(SELECT MAX(Cost) FROM CourierServices);

--52. Find all couriers that have been paid for 
SELECT * FROM Courier WHERE CourierID IN (SELECT DISTINCT CourierID FROM Payment);

--53. Find the locations where the maximum payment amount was made 
SELECT * FROM Location WHERE LocationID =
(SELECT LocationId FROM Payment WHERE Amount = (SELECT MAX(Amount) FROM Payment));

--54. Find all couriers whose weight is greater than the weight of all couriers sent by a specific sender (e.g., 'SenderName'): 
SELECT * FROM Courier WHERE Weight > ALL
(SELECT  Weight FROM Courier
WHERE SenderName = 'Charlie');

SELECT * FROM Users;
SELECT * FROM Courier;
SELECT * FROM CourierServices;
SELECT * FROM Employee;
SELECT * FROM Location;
SELECT * FROM Payment;
