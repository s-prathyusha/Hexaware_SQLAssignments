--Assignment 1
--Task:1. Database Design:
--1. Create the database named "TechShop"
CREATE DATABASE TechShop;

USE TechShop;

--2. Define the schema for the Customers, Products, Orders, OrderDetails and Inventory tables based on the provided schema.
--4. Create appropriate Primary Key and Foreign Key constraints for referential integrity.
CREATE TABLE Customers (
CustomerID INT PRIMARY KEY,
FirstName VARCHAR(20),
LastName VARCHAR(20),
Email VARCHAR(50),
Phone BIGINT,
Address VARCHAR(50)
);

CREATE TABLE Products(
ProductID INT PRIMARY KEY,
ProductName VARCHAR(50),
Description TEXT,
Price DECIMAL(10,2)
);


CREATE TABLE Orders(
OrderID INT PRIMARY KEY,
CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID),
OrderDate DATE,
TotalAmount DECIMAL(10,2)
);

CREATE TABLE OrderDetails(
OrderDetailID INT PRIMARY KEY,
OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
Quantity INT
);

CREATE TABLE Inventory(
InventoryID INT PRIMARY KEY,
ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
QuantityInStock INT,
LastStockUpdate DATETIME
);

--5. Insert at least 10 sample records into each of the following tables.
INSERT INTO Customers VALUES
(1, 'Prathyusha', 'Sudhabathula', 'prathyusha@gmail.com', '9603765677', 'Guntur'),
(2, 'Jayanth', 'Sudhabathula', 'jayanth@gmail.com', '7036707055', 'Vijayawada'),
(3, 'Abubakar Siddiq', 'Shaik', 'abubakarsiddiq@gmail.com', '9618595677', 'Texas'),
(4, 'Rama Vaishnavi', 'Vedantham', 'ramavaishnavi@gmail.com', '9635782416', 'Hyderabad'),
(5, 'Azeema', 'Shaik', 'azeema@gmail.com', '8675924356', 'Bangalore'),
(6, 'Akhila', 'Bodepudi', 'akhila@gmail.com', '8579254768', 'Maryland'),
(7, 'Leela Mahesh', 'Chittem', 'leelamahesh@gmail.com', '9912704539', 'Mumbai'),
(8, 'Nagarjuna', 'Devireddy', 'nagarjuna@gmail.com', '8567429346', 'Udupi'),
(9, 'Sai', 'Sagar', 'saisagar@gmail.com', '8574693254', 'Kerala'),
(10, 'Kowndinya', 'Ayithi', 'kowndinya@gmail.com', '9856742315', 'Tiruvananthapuram');

SELECT * FROM Customers;

INSERT INTO Products values
(101, 'Laptop', 'High-performance laptop with SSD storage', 60000),
(201, 'Smartphone', 'Latest smartphone with advanced camera features', 30000),
(301, 'Tablet', 'Lightweight tablet with long battery life', 28000),
(401, 'Desktop Computer', 'Powerful desktop computer for gaming and productivity', 20000),
(501, 'Wireless Headphones', 'High-quality wireless headphones with noise cancellation', 1500),
(601, 'Smart Watch', 'Fitness tracker and smartwatch with heart rate monitor', 5000),
(701, 'Bluetooth Speaker', 'Portable Bluetooth speaker with long battery life', 8000),
(801, 'Gaming Console', 'Next-generation gaming console with immersive graphics', 50000),
(901, 'Digital Camera', 'Professional-grade digital camera with interchangeable lenses', 60000),
(1001, 'Portable Charger', 'Compact portable charger for charging devices on the go', 1000);

SELECT * FROM Products;

INSERT INTO Orders VALUES
(102, 1, '2023-11-13', 60000),
(202, 2, '2023-09-07', 8000),
(302, 3, '2023-02-18', 60000),
(402, 4, '2023-06-27', 30000),
(502, 5, '2023-04-28', 28000),
(602, 6, '2023-07-07', 20000),
(702, 7, '2023-07-15', 1500),
(802, 8, '2023-03-13', 50000),
(902, 9, '2023-09-02', 1000),
(1002, 10, '2023-08-28', 5000);

SELECT * FROM Orders;

INSERT INTO OrderDetails VALUES
(103, 102, 101, 1),
(203, 202, 701, 1),
(303, 302, 901, 1),
(403, 402, 201, 1),
(503, 502, 301, 1),
(603, 602, 401, 1),
(703, 702, 501, 1),
(803, 802, 801, 1),
(903, 902, 1001, 1),
(1003, 1002, 601, 1);

SELECT * FROM OrderDetails;

INSERT INTO Inventory VALUES
(104, 101, 10, GETDATE()),
(204, 201, 15, GETDATE()),
(304, 301, 20, GETDATE()),
(404, 401, 10, GETDATE()),
(504, 501, 9, GETDATE()),
(604, 601, 30, GETDATE()),
(704, 701, 40, GETDATE()),
(804, 801, 20, GETDATE()),
(904, 901, 18, GETDATE()),
(1004, 1001, 36, GETDATE())

SELECT * FROM Inventory;

--Task 2: Select, Where, Between, AND, LIKE:

--1. Write an SQL query to retrieve the names and emails of all customers.
SELECT FirstName+' '+LastName as Name, Email FROM Customers;

--2. Write an SQL query to list all orders with their order dates and corresponding customer names.
SELECT o.orderID,o.OrderDate, c.FirstName+' '+c.LastName
FROM Orders o INNER JOIN  Customers c 
ON o.CustomerID=c.CustomerID;

SELECT o.orderID,o.OrderDate, c.FirstName+' '+c.LastName "Name",p.ProductName
FROM Orders o INNER JOIN Customers c ON o.CustomerID=c.CustomerID
INNER JOIN OrderDetails d ON d.OrderID=o.OrderID
INNER JOIN Products p ON p.ProductID=d.ProductID; 

--3. Write an SQL query to insert a new customer record into the "Customers" table. Include customer information such as name, email, and address.
INSERT INTO Customers (CustomerID,FirstName,LastName,Email,Address)
VALUES (11,'Ramanji','Mundlapati','ramanji@gmail.com','Connecticut');
 
UPDATE Customers SET Phone=9635278546 WHERE CustomerID=11;

--4. Write an SQL query to update the prices of all electronic gadgets in the "Products" table by increasing them by 10%.
UPDATE Products SET Price=1.1*Price;

--5. Write an SQL query to delete a specific order and its associated order details from the "Orders" and "OrderDetails" tables. Allow users to input the order ID as a parameter.
DECLARE @ORDERID INT;
SET @ORDERID = 1002

DELETE FROM OrderDetails WHERE OrderID=@ORDERID;
DELETE FROM Orders WHERE OrderID=@ORDERID;

--6. Write an SQL query to insert a new order into the "Orders" table. Include the customer ID,order date, and any other necessary information.
INSERT INTO Orders VALUES(1102,11,'2023-04-06',5500);

INSERT INTO OrderDetails VALUES(1103,1102,601,2);

--7.Write an SQL query to update the contact information (e.g., email and address) of a specific customer in the "Customers" table. Allow users to input the customer ID and new contact information.
DECLARE @CUSTOMERID INT;
DECLARE @EMAIL VARCHAR(50);
DECLARE @ADDRESS VARCHAR(50);

SET @CUSTOMERID=10;
SET @EMAIL='kowndinya.a@gmail.com';
SET @ADDRESS='Guntur';

UPDATE Customers SET Email=@EMAIL,Address=@ADDRESS WHERE CustomerID=@CUSTOMERID; 

--8. Write an SQL query to recalculate and update the total cost of each order in the "Orders" table based on the prices and quantities in the "OrderDetails" table.
UPDATE Orders SET TotalAmount =
(SELECT OD.Quantity*P.Price
FROM OrderDetails OD
INNER JOIN Products P
ON OD.ProductID=P.ProductID
WHERE Orders.OrderID = OD.OrderID);

--9. Write an SQL query to delete all orders and their associated order details for a specific customer from the "Orders" and "OrderDetails" tables. Allow users to input the customer ID as a parameter.
DECLARE @CUSTOMERID1 INT;
SET @CUSTOMERID1 = 6;

DELETE FROM OrderDetails WHERE OrderID IN (SELECT OrderID FROM Orders WHERE CustomerID=@CUSTOMERID1);
DELETE FROM Orders WHERE OrderID IN (SELECT OrderID FROM Orders WHERE CustomerID=@CUSTOMERID1);


--10. Write an SQL query to insert a new electronic gadget product into the "Products" table, including product name, category, price, and any other relevant details.
INSERT INTO Products VALUES(1101,'Smart Refrigerator', 'Smart refrigerator with touchscreen display and built-in camera', 75000);

--11. Write an SQL query to update the status of a specific order in the "Orders" table (e.g., from "Pending" to "Shipped"). Allow users to input the order ID and the new status.
ALTER TABLE Orders ADD Status VARCHAR(10) DEFAULT 'Pending';

DECLARE @ORDERID INT;
DECLARE @NEWSTATUS VARCHAR(10);

SET @ORDERID='102';
SET @NEWSTATUS='Shipped';

UPDATE Orders SET Status=@NEWSTATUS WHERE OrderID=@ORDERID;

--12. Write an SQL query to calculate and update the number of orders placed by each customer in the "Customers" table based on the data in the "Orders" table.
--Not updating just querying
SELECT O.CustomerID, COUNT(O.CustomerID) "Number of Orders Placed" FROM Customers C, Orders O
WHERE C.CustomerID=O.CustomerID
GROUP BY O.CustomerID;

--Task 3. Aggregate functions, Having, Order By, GroupBy and Joins

--1. Write an SQL query to retrieve a list of all orders along with customer information (e.g.,customer name) for each order.
SELECT o.orderID,o.OrderDate,O.TotalAmount, c.FirstName+' '+c.LastName "Name",c.Email,c.Phone
FROM Orders o INNER JOIN  Customers c 
ON o.CustomerID=c.CustomerID;

SELECT o.orderID, o.OrderDate,O.TotalAmount,c.FirstName+' '+c.LastName "Name",p.ProductName "Ordered Product",c.Email,c.Phone
FROM Orders o INNER JOIN Customers c ON o.CustomerID=c.CustomerID
INNER JOIN OrderDetails d ON d.OrderID=o.OrderID
INNER JOIN Products p ON p.ProductID=d.ProductID; 

--2. Write an SQL query to find the total revenue generated by each electronic gadget product.Include the product name and the total revenue.
SELECT P.ProductName,SUM(P.Price*OD.Quantity) "Revenue"
FROM Products P
INNER JOIN OrderDetails OD
ON P.ProductID=OD.ProductID
GROUP BY P.ProductName;

--3. Write an SQL query to list all customers who have made at least one purchase. Include their names and contact information.
SELECT C.FirstName+' '+C.LastName "Name" , C.Email,C.Phone,C.Address
FROM Customers C WHERE C.CustomerID IN 
(SELECT DISTINCT CustomerID FROM ORDERS);

--4. Write an SQL query to find the most popular electronic gadget, which is the one with the highest total quantity ordered. Include the product name and the total quantity ordered.
SELECT P.ProductName,SUM(OD.Quantity) "Total Quantity"
FROM Products P
INNER JOIN OrderDetails OD
ON P.ProductID=OD.ProductID
GROUP BY P.ProductName
HAVING SUM(OD.Quantity) IN
	(SELECT SUM(OD.Quantity) 
		FROM Products P
		INNER JOIN OrderDetails OD
		ON P.ProductID=OD.ProductID
		GROUP BY P.ProductName
		ORDER BY SUM(OD.Quantity) DESC
		OFFSET 0 ROWS
		FETCH NEXT 1 ROW ONLY);

Select P.ProductName,OD.Quantity from Products P
INNER JOIN OrderDetails OD  
ON P.ProductID=OD.ProductID 
where OD.Quantity=(Select max(Quantity) from orderdetails);

--5. Write an SQL query to retrieve a list of electronic gadgets along with their corresponding categories.
--Create a new table Categories containing Category ID and Category Name
CREATE TABLE Categories(
	CategoryID INT PRIMARY KEY,
	CategoryName VARCHAR(20)
);

INSERT INTO Categories VALUES
(105,'Computer'),
(205,'Mobile Device'),
(305,'Audio Device'),
(405,'Wearable Device'),
(505,'Gaming Device'),
(605,'Camera'),
(705,'Accessories'),
(805,'Home Appliances');

SELECT * FROM Categories;

--Adding CategoryID column in Products table and update the values in that column 
ALTER TABLE Products ADD CategoryID INT FOREIGN KEY REFERENCES Categories(CategoryID);

SELECT P.ProductName,C.CategoryName FROM Products P
INNER JOIN Categories C
ON C.CategoryID = P.CategoryID;

--6. Write an SQL query to calculate the average order value for each customer. Include the customer's name and their average order value.
SELECT C.FirstName+' '+C.LastName "Name", AVG(O.TotalAmount) "Avg Order" FROM Customers C
INNER JOIN Orders O
ON C.CustomerID=O.CustomerID
GROUP BY C.FirstName,C.LastName;

--7. Write an SQL query to find the order with the highest total revenue. Include the order ID, customer information, and the total revenue.
SELECT P.ProductName,SUM(P.Price*OD.Quantity) "Revenue"
FROM Products P
INNER JOIN OrderDetails OD
ON P.ProductID=OD.ProductID
GROUP BY P.ProductName
HAVING SUM(P.Price*OD.Quantity) IN 
	(SELECT SUM(P.Price*OD.Quantity) "Revenue"
		FROM Products P
		INNER JOIN OrderDetails OD
		ON P.ProductID=OD.ProductID
		GROUP BY P.ProductName
		ORDER BY Revenue DESC
		OFFSET 0 ROWS
		FETCH NEXT 1 ROW ONLY);

--8. Write an SQL query to list electronic gadgets and the number of times each product has been ordered.
SELECT P.ProductName,SUM(OD.Quantity) 
FROM Products P
INNER JOIN OrderDetails OD 
ON P.ProductID=OD.ProductID
GROUP BY P.ProductName;

--9. Write an SQL query to find customers who have purchased a specific electronic gadget product.Allow users to input the product name as a parameter.
DECLARE @PRODUCT VARCHAR(20);
SET @PRODUCT='Smart Watch';

SELECT FirstName+' '+LastName "Customer Name" FROM Customers WHERE CustomerID=(SELECT CustomerID FROM Orders WHERE OrderID = 
(SELECT OrderID FROM OrderDetails WHERE ProductID = (SELECT ProductID FROM Products WHERE ProductName=@PRODUCT)));

--10. Write an SQL query to calculate the total revenue generated by all orders placed within a specific time period. Allow users to input the start and end dates as parameters.
DECLARE @STARTDATE DATE;
DECLARE @ENDDATE DATE;

SET @STARTDATE='2023-03-01';
SET @ENDDATE='2023-11-01';

SELECT SUM(TotalAmount) "Total Revenue" FROM Orders
WHERE OrderDate between @STARTDATE AND @ENDDATE;

--Task 4. Subquery and its type:
--1. Write an SQL query to find out which customers have not placed any orders
SELECT  CustomerID, FirstName+' '+LastName "Customer Name" FROM Customers
WHERE CustomerID NOT IN 
(SELECT CustomerID FROM Orders);

--2. Write an SQL query to find the total number of products available for sale. 
SELECT COUNT(*) "Products Available" FROM Inventory 
WHERE QuantityInStock!=0;

--3. Write an SQL query to calculate the total revenue generated by TechShop. 
SELECT SUM(TotalAmount) "Total Revenue" FROM Orders;

SELECT SUM(OD.Quantity*P.Price) FROM OrderDetails OD
INNER JOIN Products P
ON P.ProductID=OD.ProductID;

--4. Write an SQL query to calculate the average quantity ordered for products in a specific category. Allow users to input the category name as a parameter.
DECLARE @CATEGORY VARCHAR(20);
SET @CATEGORY='Wearable Device';

SELECT AVG(Quantity) FROM OrderDetails
WHERE ProductID = 
(SELECT ProductID FROM Products WHERE CategoryID =
(SELECT CategoryID FROM Categories WHERE CategoryName=@CATEGORY));

SELECT AVG(OD.Quantity) FROM OrderDetails OD
INNER JOIN Products P ON OD.ProductID=P.ProductID
INNER JOIN Categories C ON C.CategoryID=P.CategoryID
GROUP BY CategoryName
HAVING CategoryName=@CATEGORY;

--5. Write an SQL query to calculate the total revenue generated by a specific customer. Allow users to input the customer ID as a parameter
DECLARE @CUSTOMERID INT;
SET @CUSTOMERID=1;

SELECT SUM(TotalAmount) "Total" FROM Orders
WHERE CustomerID = @CUSTOMERID;

--6. Write an SQL query to find the customers who have placed the most orders. List their names and the number of orders they've placed
SELECT FirstName+' '+LastName "Customer Name",COUNT(*) "Orders Placed" FROM Customers C
INNER JOIN Orders O ON C.CustomerID=O.CustomerID
GROUP BY C.FirstName,C.LastName;

--7. Write an SQL query to find the most popular product category, which is the one with the highest total quantity ordered across all orders.
SELECT C.CategoryName ,SUM(OD.Quantity) "Quantity Ordered" FROM  Categories C
INNER JOIN Products P ON P.CategoryID = C.CategoryID
INNER JOIN OrderDetails OD ON P.ProductID = OD.ProductID
GROUP BY C.CategoryName
HAVING SUM(OD.Quantity) IN 
(SELECT SUM(OD.Quantity)  FROM  Categories C
INNER JOIN Products P ON P.CategoryID = C.CategoryID
INNER JOIN OrderDetails OD ON P.ProductID = OD.ProductID
GROUP BY C.CategoryName
ORDER BY SUM(OD.Quantity) DESC
OFFSET 0 ROWS
FETCH NEXT 1 ROW ONLY);

SELECT C.CategoryName ,SUM(OD.Quantity) "Quantity Ordered" FROM  Categories C
INNER JOIN Products P ON P.CategoryID = C.CategoryID
INNER JOIN OrderDetails OD ON P.ProductID = OD.ProductID
GROUP BY C.CategoryName
ORDER BY SUM(OD.Quantity) DESC
OFFSET 0 ROWS
FETCH NEXT 1 ROW ONLY

--8. Write an SQL query to find the customer who has spent the most money (highest total revenue) on electronic gadgets. List their name and total spending.
SELECT FirstName+' '+LastName "Customer Name",SUM(O.TotalAmount) "Total Revenue" FROM Customers C
INNER JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.FirstName,C.LastName
HAVING SUM(O.TotalAmount) = 
(SELECT SUM(O.TotalAmount) "Total Revenue" FROM Customers C
INNER JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.FirstName,C.LastName
ORDER BY SUM(O.TotalAmount) DESC
OFFSET 0 ROWS
FETCH NEXT 1 ROW ONLY);

SELECT FirstName+' '+LastName "Customer Name",SUM(O.TotalAmount) "Total Revenue" FROM Customers C
INNER JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.FirstName,C.LastName
ORDER BY SUM(O.TotalAmount) DESC
OFFSET 0 ROWS
FETCH NEXT 1 ROW ONLY

--9. Write an SQL query to calculate the average order value (total revenue divided by the number of orders) for all customers
SELECT AVG(TotalAmount) FROM Orders; 
SELECT SUM(TotalAmount)/COUNT(TotalAmount) FROM Orders

--10. Write an SQL query to find the total number of orders placed by each customer and list their names along with the order count.
SELECT C.CustomerID, C.FirstName+' '+C.LastName "Name",COUNT(*) "Orders Placed" FROM Customers C
INNER JOIN Orders O
ON O.CustomerID = C.CustomerID
GROUP BY C.CustomerID, C.FirstName, C.LastName;

SELECT * FROM Customers
SELECT * FROM Orders
SELECT * FROM Products
SELECT * FROM OrderDetails
SELECT * FROM Categories
SELECT * FROM Inventory