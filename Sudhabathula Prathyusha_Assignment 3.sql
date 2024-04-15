--Assignment 3
--Tasks 1: Database Design: 
--1. Create the database named "HMBank"
CREATE DATABASE HMBank;

USE HMBank;

--AUTO_INCREMENT IN MYSQL  --- IDENTITY(INITIAL SEED VALUE,INCREMENT VALUE)
--2. Define the schema for the Customers, Accounts, and Transactions tables based on the provided schema.
--5. Create appropriate Primary Key and Foreign Key constraints for referential integrity.
--6. Write SQL scripts to create the mentioned tables with appropriate data types, constraints, and relationships. 

CREATE TABLE Customers(
	customer_id INT PRIMARY KEY IDENTITY(101,1),
	first_name VARCHAR(20),
	last_name VARCHAR(20),
	DOB DATE,
	email VARCHAR(50),
	phone_number BIGINT,
	address VARCHAR(20)
);

CREATE TABLE Accounts(
	account_id INT PRIMARY KEY IDENTITY(201,1),
	customer_id INT FOREIGN KEY REFERENCES Customers(customer_id) ON DELETE CASCADE,
	account_type VARCHAR(15),
	balance DECIMAL(15,2)
);

CREATE TABLE Transactions(
	transaction_id INT PRIMARY KEY IDENTITY(301,1),
	account_id INT FOREIGN KEY REFERENCES Accounts(account_id),
	transaction_type VARCHAR(15),
	amount DECIMAL(15,2),
	transaction_date DATE
);

--Tasks 2: Select, Where, Between, AND, LIKE:
--1. Insert at least 10 sample records into each of the following tables. 
				--Customers
				--Accounts
				--Transactions

INSERT INTO Customers (first_name, last_name, DOB, email, phone_number, address) VALUES
('Prathyusha','Sudhabathula','2001-11-13','prathyusha@gmail.com',9603765677,'Guntur'),
('Jayanth', 'Sudhabathula','2003-09-07', 'jayanth@gmail.com', 7036707055,'Vijayawada'),
('Abubakar Siddiq', 'Shaik','2001-02-18', 'abubakarsiddiq@gmail.com', 9618595677, 'Texas'),
('Rama Vaishnavi', 'Vedantham','2001-06-27', 'ramavaishnavi@gmail.com', 9635782416, 'Hyderabad'),
('Azeema', 'Shaik','2001-04-28', 'azeema@gmail.com', 8675924356, 'Bangalore'),
('Akhila', 'Bodepudi', '2001-07-07','akhila@gmail.com', 8579254768, 'Maryland'),
('Leela Mahesh', 'Chittem','2001-07-15', 'leelamahesh@gmail.com', 9912704539, 'Mumbai'),
('Nagarjuna', 'Devireddy', '2001-03-15','nagarjuna@gmail.com', 8567429346, 'Udupi'),
('Sai', 'Sagar', '2001-09-02','saisagar@gmail.com', 8574693254, 'Kerala'),
('Kowndinya', 'Ayithi', '2001-08-28','kowndinya@gmail.com', 9856742315, 'Tiruvananthapuram');


INSERT INTO Accounts (customer_id, account_type, balance) VALUES
(101, 'savings', 5000.00),
(102, 'current', 10000.00),
(103, 'zero_balance', 7500.00),
(104, 'current', 3000.00),
(105, 'zero_balance', 2000.00),
(106, 'current', 15000.00),
(107, 'savings', 10000.00),
(108, 'zero_balance', 5000.00),
(109, 'savings', 8000.00),
(110, 'current', 12000.00);


INSERT INTO Transactions (account_id, transaction_type, amount, transaction_date) VALUES
(201, 'deposit', 1000.00, '2023-11-13'),
(201, 'withdrawal', 500.00, '2023-09-07'),
(202, 'transfer', 2000.00, '2023-02-18'),
(202, 'withdrawal', 1500.00,'2023-06-27'),
(203, 'deposit', 1500.00,'2023-04-28'),
(203, 'transfer', 1000.00,'2023-07-07'),
(204, 'deposit', 1000.00,'2023-07-15'),
(204, 'withdrawal', 500.00, '2023-03-13'),
(205, 'deposit', 500.00, '2023-09-02'),
(205, 'transfer', 300.00, '2023-08-28');

--1. Write a SQL query to retrieve the name, account type and email of all customers.
SELECT C.first_name+' '+C.last_name "Name",A.account_type ,C.email FROM Customers C
INNER JOIN Accounts A ON C.customer_id = A.customer_id;

--2. Write a SQL query to list all transaction corresponding customer.
SELECT  C.customer_id,C.first_name,C.last_name,A.account_id,T.transaction_id,T.transaction_type,T.amount,T.transaction_date 
FROM Customers C
JOIN Accounts A ON C.customer_id=A.customer_id
JOIN Transactions T ON T.account_id=A.account_id

--3. Write a SQL query to increase the balance of a specific account by a certain amount.
DECLARE @AMOUNT INT;
DECLARE @ACCOUNTID INT;
SET @AMOUNT=1000;
SET @ACCOUNTID=201;

UPDATE  Accounts SET balance=balance+@AMOUNT
WHERE account_id = @ACCOUNTID ;

--4. Write a SQL query to Combine first and last names of customers as a full_name.
SELECT CONCAT(first_name,' ',last_name) "full_name" FROM Customers 

--5. Write a SQL query to remove accounts with a balance of zero where the account type is savings.
DELETE FROM Accounts
WHERE account_type = 'savings' AND balance = 0;

--6. Write a SQL query to Find customers living in a specific city.
DECLARE @CITY VARCHAR(20);
SET @CITY='Guntur';
SELECT * FROM Customers WHERE address=@CITY;

SELECT * FROM Customers WHERE address LIKE '%'+@CITY+'%';

--7. Write a SQL query to Get the account balance for a specific account.
DECLARE @ACCOUNTID INT;
SET @ACCOUNTID=201;
SELECT balance FROM Accounts WHERE account_id = @ACCOUNTID;

--8. Write a SQL query to List all current accounts with a balance greater than $1,000.
SELECT * FROM Accounts
WHERE account_type='current' AND balance>1000;

--9. Write a SQL query to Retrieve all transactions for a specific account.
SELECT * FROM Transactions
WHERE account_id=205;

--10. Write a SQL query to Calculate the interest accrued on savings accounts based on a given interest rate.
DECLARE @InterestRate INT;
SET @InterestRate = 0.12;
SELECT account_id,balance,(@InterestRate * balance)  "Interest" FROM ACCOUNTS
WHERE account_type = 'savings';

--11. Write a SQL query to Identify accounts where the balance is less than a specified overdraft limit.
DECLARE @OverdraftLimit DECIMAL(15,2);
SET @OverdraftLimit=1000;
SELECT * FROM Accounts WHERE balance < @OverdraftLimit;

--12. Write a SQL query to Find customers not living in a specific city.
DECLARE @CITY VARCHAR(20);
SET @CITY='Guntur';

SELECT * FROM Customers WHERE address <> @CITY;

SELECT * FROM Customers WHERE address NOT LIKE '%'+@CITY+'%';

--Tasks 3: Aggregate functions, Having, Order By, GroupBy and Joins:
--1. Write a SQL query to Find the average account balance for all customers. 
SELECT AVG(balance) "Average Account Balance"  FROM Accounts;

--2. Write a SQL query to Retrieve the top 10 highest account balances.
SELECT balance FROM Accounts
ORDER BY balance DESC
OFFSET 0 ROWS 
FETCH NEXT 10 ROWS ONLY;

SELECT TOP 10 *
FROM Accounts
ORDER BY balance DESC;

--3. Write a SQL query to Calculate Total Deposits for All Customers in specific date.
SELECT SUM(amount) "Total Deposits" FROM Transactions
WHERE transaction_type = 'deposit'  AND  transaction_date = '2023-11-13';

--4. Write a SQL query to Find the Oldest and Newest Customers.
SELECT TOP 1 *
FROM Customers
ORDER BY DOB ASC;

SELECT TOP 1 *
FROM Customers
ORDER BY DOB DESC;

--5. Write a SQL query to Retrieve transaction details along with the account type.
SELECT A.account_id,A.account_type,T.transaction_id ,T.transaction_date,T.transaction_type,T.amount FROM Accounts A
INNER JOIN Transactions T ON T.account_id = A.account_id;

SELECT T.*,A.account_type FROM Accounts A
INNER JOIN Transactions T ON T.account_id = A.account_id;

--6. Write a SQL query to Get a list of customers along with their account details.
SELECT C.customer_id ,C.first_name+' '+C.last_name "Name" ,A.account_id, A.account_type, A.balance
FROM Customers C
JOIN Accounts A ON A.customer_id = C.customer_id;

--7. Write a SQL query to Retrieve transaction details along with customer information for a specific account.
SELECT A.account_id,C.customer_id,C.first_name+' '+C.last_name "Name",T.transaction_id ,T.transaction_date,T.transaction_type,T.amount
FROM Accounts A
JOIN Transactions T ON A.account_id = T.account_id
JOIN Customers C ON C.customer_id = A.customer_id
WHERE A.account_id = 204;

--8. Write a SQL query to Identify customers who have more than one account.
INSERT INTO  Accounts (customer_id, account_type, balance) VALUES
(101, 'current', 2000.00)

SELECT C.customer_id,C.first_name+' '+C.last_name "Name",COUNT(A.account_id) FROM Customers C
JOIN Accounts A ON A.customer_id = C.customer_id
GROUP BY C.customer_id,C.first_name+' '+C.last_name
HAVING COUNT(A.account_id) > 1;

--9. Write a SQL query to Calculate the difference in transaction amounts between deposits and withdrawals.
SELECT (SELECT SUM(amount) FROM Transactions WHERE transaction_type = 'deposit' )  - 
(SELECT SUM(amount) FROM Transactions WHERE transaction_type = 'withdrawal')  AS "Deposits - Withdrawals";

SELECT account_id,
SUM(CASE WHEN transaction_type = 'deposit' THEN amount WHEN transaction_type = 'withdrawal' THEN -amount END) "Deposits - Withdrawals"
FROM Transactions
GROUP BY account_id;

--10. Write a SQL query to Calculate the average daily balance for each account over a specified period.
SELECT account_id ,AVG(balance) "Average Daily Balance" FROM Accounts
GROUP BY account_id;

--11. Calculate the total balance for each account type.
SELECT account_type,SUM(balance) FROM Accounts
GROUP BY account_type;

SELECT (SELECT SUM(balance) FROM Accounts WHERE account_type = 'savings') AS "Savings Amount",
(SELECT SUM(balance) FROM Accounts WHERE account_type = 'current') AS "Current Account",
(SELECT SUM(balance) FROM Accounts WHERE account_type = 'zero_balance') AS "Zero Balance Amount";

--12.Identify accounts with the highest number of transactions order by descending order
INSERT INTO Transactions (account_id, transaction_type, amount, transaction_date) VALUES
(201, 'deposit', 2000.00, GETDATE())

SELECT account_id,COUNT(*) "No of Transactions" FROM Transactions
GROUP BY account_id
ORDER BY COUNT(*) DESC;

--13. List customers with high aggregate account balances, along with their account types.
SELECT C.customer_id, C.first_name, C.last_name, SUM(A.balance) AS total_balance, A.account_id, A.account_type
FROM Customers C
JOIN Accounts A ON C.customer_id = A.customer_id
GROUP BY C.customer_id, C.first_name, C.last_name,A.account_id, A.account_type
ORDER BY total_balance DESC;

--14. Identify and list duplicate transactions based on transaction amount, date, and account.
--Adding a duplicate row to test
INSERT INTO Transactions (account_id, transaction_type, amount, transaction_date) VALUES
(201, 'withdrawal', 500.00, '2023-09-07');

SELECT * FROM Transactions WHERE account_id =
(SELECT account_id FROM Transactions
GROUP BY amount,transaction_date,account_id
HAVING COUNT(*)>1) AND
amount = 
(SELECT amount FROM Transactions
GROUP BY amount,transaction_date,account_id
HAVING COUNT(*)>1) AND 
transaction_date = 
(SELECT transaction_date FROM Transactions
GROUP BY amount,transaction_date,account_id
HAVING COUNT(*)>1);

--Tasks 4: Subquery and its type:
--1. Retrieve the customer(s) with the highest account balance.
SELECT * ,(SELECT MAX(balance) "Amount" FROM Accounts) FROM Customers WHERE customer_id = 
(SELECT customer_id FROM Accounts WHERE balance =
(SELECT MAX(balance) FROM Accounts));

--2. Calculate the average account balance for customers who have more than one account.
SELECT customer_id ,avg(balance) "Average Balance" FROM Accounts
GROUP BY customer_id
HAVING COUNT(*) > 1;

--3. Retrieve accounts with transactions whose amounts exceed the average transaction amount.
SELECT * FROM Accounts WHERE account_id IN
(SELECT account_id FROM Transactions WHERE amount >
(SELECT AVG(amount) FROM Transactions));

--4. Identify customers who have no recorded transactions.
SELECT * FROM Customers WHERE customer_id NOT IN
(SELECT A.customer_id FROM Transactions T JOIN Accounts A ON T.account_id = A.account_id);

--5. Calculate the total balance of accounts with no recorded transactions.
SELECT SUM(balance) "Total Balance" FROM Accounts WHERE customer_id  IN
(SELECT A.customer_id FROM Transactions T JOIN Accounts A ON T.account_id = A.account_id);

--6. Retrieve transactions for accounts with the lowest balance.
SELECT * FROM Transactions WHERE account_id IN 
(SELECT account_id FROM Accounts WHERE balance = 
(SELECT  MIN(balance) FROM Accounts));

--7. Identify customers who have accounts of multiple types.
SELECT customer_id FROM Accounts
GROUP BY customer_id
HAVING COUNT(DISTINCT account_type)>1

--8. Calculate the percentage of each account type out of the total number of accounts.
SELECT account_type,CONVERT(VARCHAR,(count(*) * 100) / (SELECT COUNT(*) FROM Accounts))+'%'  "Percentage" 
FROM Accounts
GROUP BY account_type;

--9. Retrieve all transactions for a customer with a given customer_id.
SELECT * FROM Transactions WHERE account_id IN
(SELECT account_id FROM Accounts WHERE customer_id = 105);

--10. Calculate the total balance for each account type, including a subquery within the SELECT clause.
SELECT (SELECT SUM(balance) FROM Accounts WHERE account_type = 'savings') "Savings A/C Balance",
(SELECT SUM(balance) FROM Accounts WHERE account_type = 'current') "Current A/C Balance",
(SELECT SUM(balance) FROM Accounts WHERE account_type = 'zero_balance') "Zero Balance A/C Balance";

SELECT account_type, 
(SELECT SUM(balance) FROM Accounts WHERE account_type =A.account_type) AS total_balance
FROM Accounts A
GROUP BY account_type;



SELECT * FROM Customers;
SELECT * FROM Accounts;
SELECT * FROM Transactions;