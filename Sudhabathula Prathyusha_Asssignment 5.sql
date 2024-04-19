--Assignment 5
--Tasks 1: Database Design: 
--1. Create the database named "TicketBookingSystem"
CREATE DATABASE TicketBookingSystem;

USE TicketBookingSystem;

--2. Write SQL scripts to create the mentioned tables with appropriate data types, constraints, and relationships. 
--4. Create appropriate Primary Key and Foreign Key constraints for referential integrity.
CREATE TABLE Venu (
	venue_id INT PRIMARY KEY IDENTITY(1,1),
	venue_name VARCHAR(20),
	address TEXT
);

CREATE TABLE Event (
	event_id INT PRIMARY KEY IDENTITY(101,1),
	event_name VARCHAR(50),
	event_date DATE,
	event_time TIME,
	venue_id INT FOREIGN KEY REFERENCES Venu (venue_id) ON DELETE CASCADE ,
	total_seats INT,
	available_seats INT,
	ticket_price DECIMAL,
	event_type VARCHAR(20),
	booking_id INT 
);

CREATE TABLE  Customer(
	customer_id INT PRIMARY KEY IDENTITY(205,1),
	customer_name VARCHAR(20), 
	email VARCHAR(50), 
	phone_number BIGINT,
	booking_id INT
);

CREATE TABLE  Booking(
	booking_id INT PRIMARY KEY IDENTITY(302,1),
	customer_id INT FOREIGN KEY REFERENCES Customer(customer_id) ON DELETE CASCADE,
	event_id INT FOREIGN KEY REFERENCES  Event(event_id) ON DELETE CASCADE,
	num_tickets INT,
	total_cost DECIMAL,
	booking_date DATE
);

ALTER TABLE Event ADD FOREIGN KEY (booking_id) REFERENCES Booking(booking_id);
ALTER TABLE Customer ADD FOREIGN KEY (booking_id) REFERENCES Booking(booking_id) ON DELETE NO ACTION;
--ON DELETE CASCADE should not be used here when there is cyclicity 

--Tasks 2: Select, Where, Between, AND, LIKE:
--1. Write a SQL query to insert at least 10 sample records into each table.
INSERT INTO Venu (venue_name, address) VALUES
('Stadium', '123 Main St, New York'),
('CinemaPlex', '456 Broadway, Los Angeles'),
('Concert Hall', '789 High St, Chicago'),
('Convention Center', '101 Convention Ave, Washington D.C.'),
('Sports Arena', '222 Victory Lane, Dallas'),
('Outdoor Amphitheater', '333 Nature Trail, Denver'),
('Community Center', '444 Unity Square, Seattle'),
('Music Club', '555 Melody Ave, San Francisco'),
('Event Hall', '666 Celebration Blvd, Miami'),
('Theater', '777 Drama St, Boston');

INSERT INTO Event (event_name, event_date, event_time, venue_id, total_seats, available_seats, ticket_price, event_type, booking_id) VALUES
('Football Match', '2024-05-01', '18:00:00', 1, 5000, 5000, 500.00, 'Sports', NULL),
('Movie Premiere', '2024-05-05', '20:00:00', 2, 200, 200, 150.00, 'Movie', NULL),
('Concert', '2024-05-10', '19:30:00', 3, 1000, 800, 750.00, 'Concert', NULL),
('Tech Conference', '2024-05-15', '09:00:00', 4, 500, 500, 100.00, 'Conference', NULL),
('Basketball Game', '2024-05-20', '17:00:00', 5, 8000, 7500, 400.00, 'Sports', NULL),
('Outdoor Music Festival', '2024-05-25', '16:00:00', 6, 10000, 9500, 600.00, 'Concert', NULL),
('Community Workshop', '2024-05-30', '10:30:00', 7, 100, 90, 0.00, 'Conference', NULL),
('Live Band Performance', '2024-06-05', '21:00:00', 8, 300, 250, 200.00, 'Concert', NULL),
('Dance Show', '2024-06-10', '19:00:00', 9, 500, 450, 300.00, 'Concert', NULL),
('Play', '2024-06-15', '19:30:00', 10, 150, 120, 250.00, 'Movie', NULL);

INSERT INTO Customer (customer_name, email, phone_number, booking_id) VALUES
('John Doe', 'john@gmail.com', '1234567890', NULL),
('Jane Smith', 'jane@gmail.com', '9876543210', NULL),
('Alice Johnson', 'alice@gmail.com', '4567890123', NULL),
('Bob Brown', 'bob@gmail.com', '7890123456', NULL),
('Emma Davis', 'emma@gmail.com', '3216549870', NULL),
('Michael Wilson', 'michael@gmail.com', '6543210987', NULL),
('Sophia Martinez', 'sophia@gmail.com', '0123456789', NULL),
('William Anderson', 'william@gmail.com', '6549870123', NULL),
('Olivia Taylor', 'olivia@gmail.com', '7890123456', NULL),
('James Lee', 'james@gmail.com', '9876543210', NULL);

INSERT INTO Booking (customer_id, event_id, num_tickets, total_cost, booking_date) VALUES
(205, 101, 2, 1000.00, '2024-04-15'),
(206, 102, 3, 450.00, '2024-04-16'),
(207, 103, 1, 750.00, '2024-04-17'),
(208, 104, 5, 500.00, '2024-04-18'),
(209, 105, 2, 800.00, '2024-04-19'),
(210, 106, 4, 2400.00, '2024-04-20'),
(211, 107, 1, 0.00, '2024-04-21'),
(212, 108, 2, 400.00, '2024-04-22'),
(213, 109, 3, 900.00, '2024-04-23'),
(214, 110, 2, 500.00, '2024-04-24');

--Now BookingIDs  can be updated in Customer and Events tables
--2. Write a SQL query to list all Events.
SELECT * FROM Event;

--3. Write a SQL query to select events with available tickets.
SELECT * FROM Event WHERE available_seats!=0;

--4. Write a SQL query to select events name partial match with ‘cup’.
SELECT * FROM Event WHERE event_name LIKE '%cup%';

--5. Write a SQL query to select events with ticket price range is between 1000 to 2500.
SELECT * FROM Event WHERE ticket_price BETWEEN 1000 AND 2500

--6. Write a SQL query to retrieve events with dates falling within a specific range.
SELECT * FROM Event WHERE event_date BETWEEN '2024-04-01' AND '2024-05-15';

--7. Write a SQL query to retrieve events with available tickets that also have "Concert" in their name.
SELECT * FROM Event WHERE available_seats!=0 AND event_name LIKE '%Concert%';

--8. Write a SQL query to retrieve users in batches of 5, starting from the 6th user.
SELECT * FROM Customer 
ORDER BY customer_id
OFFSET 5 ROWS
FETCH NEXT 5 ROWS ONLY;

SELECT * FROM 
(SELECT *, ROW_NUMBER() OVER(ORDER BY customer_id) "RowNumber" FROM Customer) AS SubQuery
WHERE SubQuery.RowNumber>=6
ORDER BY SubQuery.RowNumber
OFFSET 0 ROWS 
FETCH NEXT 5 ROWS ONLY;

--9. Write a SQL query to retrieve bookings details contains booked no of ticket more than 4.
SELECT * FROM Booking WHERE num_tickets > 4;

--10. Write a SQL query to retrieve customer information whose phone number end with ‘000’
SELECT * FROM Customer WHERE CONVERT(VARCHAR,phone_number) LIKE '%000';

--11. Write a SQL query to retrieve the events in order whose seat capacity more than 15000.
SELECT * FROM Event WHERE total_seats > 15000
ORDER BY total_seats;

--12. Write a SQL query to select events name not start with ‘x’, ‘y’, ‘z’
SELECT * FROM Event WHERE event_name NOT LIKE '[xyz]%';
SELECT * FROM Event WHERE event_name NOT LIKE '[x-z]%';
SELECT * FROM Event WHERE event_name NOT LIKE 'x%' AND event_name NOT LIKE 'y%' AND event_name NOT LIKE 'z%';

--Tasks 3: Aggregate functions, Having, Order By, GroupBy and Joins:
--1. Write a SQL query to List Events and Their Average Ticket Prices.
SELECT event_type,event_name,AVG(ticket_price) "Average Ticket Price" FROM Event
GROUP BY event_type, event_name;

--2. Write a SQL query to Calculate the Total Revenue Generated by Events.
SELECT SUM(total_cost) "Total Revenue" FROM Booking;

--3. Write a SQL query to find the event with the highest ticket sales.
SELECT * FROM Event WHERE event_id = 
(SELECT event_id FROM Booking WHERE num_tickets = ((SELECT MAX(num_tickets) FROM Booking))) ;

SELECT event_id, SUM(num_tickets) AS total_tickets_sold
FROM Booking
GROUP BY event_id
ORDER BY total_tickets_sold DESC
OFFSET 0 ROWS
FETCH NEXT 1 ROW ONLY;

--4. Write a SQL query to Calculate the Total Number of Tickets Sold for Each Event.
SELECT B.event_id,E.event_name ,SUM(num_tickets) "NumberOfTicketsSold" FROM Booking B
JOIN Event E ON E.event_id = B.event_id
GROUP BY B.event_id,E.event_name;

--5. Write a SQL query to Find Events with No Ticket Sales.
SELECT * FROM Event WHERE event_id NOT IN (SELECT event_id FROM Booking);

--6. Write a SQL query to Find the User Who Has Booked the Most Tickets.
SELECT * FROM Customer WHERE customer_id IN
(SELECT customer_id  FROM Booking 
GROUP BY customer_id
HAVING SUM(num_tickets) >= ALL (SELECT SUM(num_tickets) FROM Booking GROUP BY customer_id));

SELECT B.customer_id, customer_name, SUM(num_tickets) AS total_tickets_booked
FROM Booking B JOIN Customer C ON C.customer_id = B.customer_id
GROUP BY B.customer_id, customer_name
ORDER BY total_tickets_booked DESC
OFFSET 0 ROWS
FETCH NEXT 1 ROW ONLY;

--7. Write a SQL query to List Events and the total number of tickets sold for each month.
SELECT MONTH(booking_date)"Month",COUNT(*)"NoOfticketsSold" FROM Booking
GROUP BY MONTH(booking_date);

--8. Write a SQL query to calculate the average Ticket Price for Events in Each Venue.
SELECT E.venue_id,V.venue_name,AVG(ticket_price) "Average Ticket Price" FROM Venu V
JOIN Event E ON E.venue_id = V.venue_id
GROUP BY E.venue_id,V.venue_name;

--9. Write a SQL query to calculate the total Number of Tickets Sold for Each Event Type.
SELECT E.event_type,SUM(num_tickets) "Number of Tickets Sold" FROM Event E
JOIN Booking B ON B.event_id = E.event_id
GROUP BY E.event_type;

--10. Write a SQL query to calculate the total Revenue Generated by Events in Each Year
SELECT YEAR(booking_date) "Year",SUM(total_cost) "Total Revenue" FROM Booking
GROUP BY YEAR(booking_date);

--11. Write a SQL query to list users who have booked tickets for multiple events.
SELECT * FROM Customer WHERE customer_id IN 
(SELECT customer_id FROM Booking
GROUP BY customer_id
HAVING COUNT(*) > 1);

SELECT B.customer_id, C.customer_name, COUNT(DISTINCT event_id) AS num_events_booked
FROM Booking B JOIN Customer C on C.customer_id = B.customer_id
GROUP BY B.customer_id, C.customer_name
HAVING COUNT(DISTINCT event_id) > 1;

--12. Write a SQL query to calculate the Total Revenue Generated by Events for Each User.
SELECT B.customer_id,C.customer_name,SUM(total_cost) "Total Revenue" FROM Booking B
JOIN Customer C ON B.customer_id = C.customer_id
GROUP BY B.customer_id,C.customer_name;

--13. Write a SQL query to calculate the Average Ticket Price for Events in Each Category and Venue.
SELECT E.venue_id,E.event_type,V.venue_name,AVG(ticket_price) FROM Event E
JOIN Venu V ON V.venue_id = E.venue_id
GROUP BY E.venue_id,E.event_type,V.venue_name;

--14. Write a SQL query to list Users and the Total Number of Tickets They've Purchased in the Last 30 Days.
SELECT B.customer_id,C.customer_name,SUM(num_tickets)  "Total Number of Tickets" FROM Booking B
JOIN Customer C ON B.customer_id = C.customer_id
WHERE DATEDIFF(DAY,booking_date,GETDATE())<=30
GROUP BY B.customer_id,C.customer_name;

--Tasks 4: Subquery and its types
--1. Calculate the Average Ticket Price for Events in Each Venue Using a Subquery.
SELECT V.venue_id,V.venue_name,
(SELECT AVG(ticket_price)  FROM Event WHERE venue_id = V.venue_id ) "Average Ticket Price"
FROM Venu V ;

--2. Find Events with More Than 50% of Tickets Sold using subquery.
SELECT * FROM Event 
WHERE available_seats < (total_seats/2);

SELECT * FROM Event E
WHERE (SELECT SUM(num_tickets) FROM Booking B WHERE B.event_id = E.event_id) > (0.5 * total_seats);

--3. Calculate the Total Number of Tickets Sold for Each Event.
SELECT *, (total_seats - available_seats) "Total Number of Tickets Sold" FROM Event;

SELECT event_id,SUM(num_tickets) "Total Number of Tickets Sold" FROM Booking 
GROUP BY event_id;

SELECT event_id,event_name,
(SELECT SUM(num_tickets) FROM Booking WHERE Booking.event_id = E.event_id)  "Total Number of Tickets Sold"
FROM Event E;

--4. Find Users Who Have Not Booked Any Tickets Using a NOT EXISTS Subquery.
SELECT * FROM Customer C
WHERE NOT EXISTS 
(SELECT * FROM Booking WHERE customer_id = C.customer_id);

--5. List Events with No Ticket Sales Using a NOT IN Subquery.
SELECT * FROM Event
WHERE event_id NOT IN 
(SELECT DISTINCT event_id FROM Booking);

--6. Calculate the Total Number of Tickets Sold for Each Event Type Using a Subquery in the FROM Clause.
SELECT event_type,SUM(total_seats - available_seats) "Total Number of Tickets Sold" FROM Event
GROUP BY event_type;

SELECT event_type,SUM([Tickets Sold]) "Total Number of Tickets Sold" FROM 
(SELECT event_id,SUM(num_tickets) "Tickets Sold" FROM Booking B GROUP BY event_id) AS S
JOIN Event E ON S.event_id = E.event_id
GROUP BY event_type;

--7. Find Events with Ticket Prices Higher Than the Average Ticket Price Using a Subquery in the WHERE Clause.
SELECT * FROM Event WHERE ticket_price > 
(SELECT AVG(ticket_price) FROM Event);

--8. Calculate the Total Revenue Generated by Events for Each User Using a Correlated Subquery.
SELECT B.customer_id,C.customer_name,SUM(total_cost) "Total Revenue Generated" 
FROM Booking B JOIN Customer C ON B.customer_id = C.customer_id
GROUP BY B.customer_id,C.customer_name;

SELECT C.customer_id,C.customer_name,
(SELECT SUM(total_cost) FROM Booking B WHERE B.customer_id = C.customer_id)  "Total Revenue Generated"  FROM Customer C

--9. List Users Who Have Booked Tickets for Events in a Given Venue Using a Subquery in the WHERE Clause.
DECLARE @VENUE VARCHAR(20);
SET @VENUE = 'CinemaPlex';

SELECT * FROM Customer C
WHERE customer_id IN (SELECT customer_id FROM Booking B WHERE B.event_id  IN
(SELECT event_id FROM Event WHERE venue_id = (SELECT venue_id FROM Venu WHERE venue_name = @VENUE)));

SELECT customer_id, customer_name
FROM Customer
WHERE EXISTS 
(SELECT * FROM Booking WHERE customer_id = Customer.customer_id AND event_id IN 
(SELECT event_id FROM Event WHERE venue_id =  (SELECT venue_id FROM Venu WHERE venue_name = @VENUE)));

--10. Calculate the Total Number of Tickets Sold for Each Event Category Using a Subquery with GROUP BY.
SELECT event_type,SUM([Tickets Sold]) "Total Number of Tickets Sold" FROM 
(SELECT event_id,SUM(num_tickets) "Tickets Sold" FROM Booking B GROUP BY event_id) AS S
JOIN Event E ON S.event_id = E.event_id
GROUP BY event_type;

--11. Find Users Who Have Booked Tickets for Events in each Month Using a Subquery with DATE_FORMAT.
SELECT MONTH(booking_date)"Month",SUM(num_tickets)"Tickets Booked",B.customer_id,C.customer_name
FROM BOOKING B JOIN Customer C ON C.customer_id = B.customer_id
GROUP BY MONTH(booking_date),B.customer_id,C.customer_name;

--12. Calculate the Average Ticket Price for Events in Each Venue Using a SubquerySELECT *,(SELECT AVG(ticket_price) FROM EVENT E WHERE E.venue_id = Venu.venue_id) "Average Ticket Price"FROM Venu

SELECT * FROM Venu;
SELECT * FROM Event;
SELECT * FROM Customer;
SELECT * FROM Booking;