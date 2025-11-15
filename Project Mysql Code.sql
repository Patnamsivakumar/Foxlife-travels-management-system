-- =====================================================
-- Fox Life Travel Experience Management System
-- =====================================================

-- DDL (Create + Alter + Truncate + Drop + Rename)
-- Topics: CREATE, ALTER ADD, ALTER DROP, ALTER MODIFY, ALTER RENAME, TRUNCATE, DROP


DROP DATABASE IF EXISTS foxlife_travel;
CREATE DATABASE foxlife_travel ;
USE foxlife_travel;

-- 1) CREATE TABLE Country
CREATE TABLE Country (
  country_id INT PRIMARY KEY AUTO_INCREMENT,
  country_name VARCHAR(100) NOT NULL UNIQUE,
  region VARCHAR(50) NOT NULL,
  currency VARCHAR(30) NOT NULL,
  language VARCHAR(50),
  population_millions DECIMAL(7,2) DEFAULT NULL,
  CHECK (population_millions >= 0)
);

-- 2) CREATE TABLE Destination
CREATE TABLE Destination (
  destination_id INT PRIMARY KEY AUTO_INCREMENT,
  destination_name VARCHAR(120) NOT NULL,
  country_id INT NOT NULL,
  city VARCHAR(80),
  best_season VARCHAR(30),
  attraction_type VARCHAR(50),
  avg_cost_per_day DECIMAL(9,2) NOT NULL CHECK (avg_cost_per_day > 0),
  CONSTRAINT fk_dest_country FOREIGN KEY (country_id) REFERENCES Country(country_id) ON DELETE CASCADE
);

-- 3) CREATE TABLE Traveler
CREATE TABLE Traveler (
  traveler_id INT PRIMARY KEY AUTO_INCREMENT,
  full_name VARCHAR(100) NOT NULL,
  email VARCHAR(120) NOT NULL UNIQUE,
  phone VARCHAR(20),
  dob DATE,
  passport_no VARCHAR(30) UNIQUE,
  nationality VARCHAR(50)
);

-- 4) CREATE TABLE Guide
CREATE TABLE Guide (
  guide_id INT PRIMARY KEY AUTO_INCREMENT,
  full_name VARCHAR(100) NOT NULL,
  language_spoken VARCHAR(100),
  rating DECIMAL(2,1) DEFAULT 4.5 CHECK (rating BETWEEN 1 AND 5),
  destination_id INT,
  available_from DATE,
  CONSTRAINT fk_guide_destination FOREIGN KEY (destination_id) REFERENCES Destination(destination_id) ON DELETE SET NULL
);

-- 5) CREATE TABLE Trip
CREATE TABLE Trip (
  trip_id INT PRIMARY KEY AUTO_INCREMENT,
  trip_name VARCHAR(150) NOT NULL,
  destination_id INT NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  base_price DECIMAL(10,2) NOT NULL CHECK (base_price >= 0),
  seats_total INT NOT NULL CHECK (seats_total >= 0),
  CONSTRAINT fk_trip_destination FOREIGN KEY (destination_id) REFERENCES Destination(destination_id) ON DELETE CASCADE
);

-- 6) CREATE TABLE Booking
CREATE TABLE Booking (
  booking_id INT PRIMARY KEY AUTO_INCREMENT,
  traveler_id INT NOT NULL,
  trip_id INT NOT NULL,
  booking_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  seats_booked INT NOT NULL CHECK (seats_booked > 0),
  status ENUM('BOOKED','CONFIRMED','CANCELLED') DEFAULT 'BOOKED',
  CONSTRAINT fk_booking_traveler FOREIGN KEY (traveler_id) REFERENCES Traveler(traveler_id) ON DELETE CASCADE,
  CONSTRAINT fk_booking_trip FOREIGN KEY (trip_id) REFERENCES Trip(trip_id) ON DELETE CASCADE
);

-- 7) CREATE TABLE Payment
CREATE TABLE Payment (
  payment_id INT PRIMARY KEY AUTO_INCREMENT,
  booking_id INT NOT NULL,
  amount_paid DECIMAL(10,2) NOT NULL CHECK (amount_paid >= 0),
  payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  payment_method ENUM('CARD','BANK_TRANSFER','CASH','WALLET') DEFAULT 'CARD',
  status ENUM('PENDING','SUCCESS','FAILED') DEFAULT 'PENDING',
  CONSTRAINT fk_payment_booking FOREIGN KEY (booking_id) REFERENCES Booking(booking_id) ON DELETE CASCADE
);

-- 8) CREATE TABLE Review
CREATE TABLE Review (
  review_id INT PRIMARY KEY AUTO_INCREMENT,
  traveler_id INT NOT NULL,
  trip_id INT NOT NULL,
  rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
  comment VARCHAR(500),
  review_date DATE DEFAULT "(CUR_DATE)",
  CONSTRAINT fk_review_traveler FOREIGN KEY (traveler_id) REFERENCES Traveler(traveler_id) ON DELETE CASCADE,
  CONSTRAINT fk_review_trip FOREIGN KEY (trip_id) REFERENCES Trip(trip_id) ON DELETE CASCADE
);
-- 9) CREATE TABLE Transport
CREATE TABLE TRANSPORT (
  transport_id INT ,
  trip_id INT,
  mode VARCHAR(30),
  provider_name VARCHAR(100),
  departure_city VARCHAR(100),
  arrival_city VARCHAR(100),
  ticket_price int ,
  travel_date DATE
);

-- 10) CREATE TABLE Accommodation
CREATE TABLE ACCOMMODATION (
  accommodation_id int ,
  destination_id INT,
  hotel_name VARCHAR(150),
  type varchar(30),
  price_per_night DECIMAL(10,2),
  rating DECIMAL(2,1),
  contact_number VARCHAR(20)
);

-- ADDING CONSTRAINTS FOR TABLE TRANSPORT

ALTER TABLE TRANSPORT ADD PRIMARY KEY(TRANSPORT_ID);
ALTER TABLE TRANSPORT MODIFY TRIP_ID INT NOT NULL;
ALTER TABLE TRANSPORT ADD CONSTRAINT FK_TRANSPORT_TRIP FOREIGN KEY(TRIP_ID) REFERENCES TRIP(TRIP_ID) ON DELETE CASCADE;

-- ADDING CONSTRAINTS FOR TABLE ACCOMMODATION

ALTER TABLE ACCOMMODATION ADD PRIMARY KEY(accommodation_id);
ALTER TABLE ACCOMMODATION MODIFY destination_id INT NOT NULL;
ALTER TABLE ACCOMMODATION ADD CONSTRAINT FK_ACCOMODATION_DESTINATION FOREIGN KEY(destination_id) REFERENCES Destination(destination_id) ON DELETE CASCADE;

-- ALTER examples

-- ALTER ADD a column
ALTER TABLE Traveler ADD emergency_contact VARCHAR(20);
ALTER TABLE ACCOMMODATION ADD CITY VARCHAR(20);
ALTER TABLE TRANSPORT ADD NO_OF_PEOPLE INT;

-- ALTER RENAME table AND COLUMN
ALTER TABLE Review RENAME TO Trip_Review;

-- ALTER MODIFY a column
ALTER TABLE Trip MODIFY base_price DECIMAL(12,2) NOT NULL;
ALTER TABLE ACCOMMODATION MODIFY ACCOMODATION_CITY VARCHAR(50);
ALTER TABLE TRANSPORT MODIFY NO_OF_PERSONS BIGINT;
-- ALTER DROP a column
ALTER TABLE Guide DROP COLUMN available_from;
ALTER TABLE ACCOMMODATION DROP ACCOMODATION_CITY;
ALTER TABLE TRANSPORT DROP NO_OF_PERSONS;

-- RENAME
RENAME TABLE ACCOMMODATION TO TRIP_ACCOMMODATION;

-- TRUNCATE 
TRUNCATE TABLE TRIP_ACCOMMODATION; 

-- DROP
 DROP TABLE TRIP_ACCOMMODATION; 


-- DML (Insert + Update + Delete)
-- Topics: INSERT, UPDATE, DELETE


-- INSERT COMMAND
INSERT INTO Country (country_name, region, currency, language, population_millions)
VALUES
('Japan','Asia','JPY','Japanese',125.8),
('Italy','Europe','EUR','Italian',60.3),
('Brazil','South America','BRL','Portuguese',213.2),
('New Zealand','Oceania','NZD','English',5.1),
('Kenya','Africa','KES','Swahili/English',53.5),
('Canada','North America','CAD','English/French',38.0),
('Iceland','Europe','ISK','Icelandic',0.37),
('Thailand','Asia','THB','Thai',69.6),
('Peru','South America','PEN','Spanish',33.0),
('Australia','Oceania','AUD','English',25.6);


INSERT INTO Destination (destination_name, country_id, city, best_season, attraction_type, avg_cost_per_day)
VALUES
('Kyoto Temples',1,'Kyoto','Spring','Cultural',120.00),
('Tokyo Highlights',1,'Tokyo','Autumn','City',150.00),
('Amalfi Coast',2,'Amalfi','Summer','Scenic',180.00),
('Rome Historic',2,'Rome','Spring','Historical',140.00),
('Amazon Adventure',3,'Manaus','Winter','Nature',100.00),
('Rio Carnival',3,'Rio de Janeiro','Summer','Festival',160.00),
('Milford Sound',4,'Te Anau','Summer','Nature',200.00),
('Maasai Mara Safari',5,'Nairobi','Dry Season','Safari',220.00),
('Banff Peaks',6,'Banff','Winter','Mountain',170.00),
('Blue Lagoon',7,'Grindavik','Summer','Spa',250.00);


INSERT INTO Traveler (full_name,email,phone,dob,passport_no,nationality,emergency_contact)
VALUES
('Aisha Khan','aisha.khan@example.com','+91-9876500011','1992-06-18','P1234567','India','+91-9876500012'),
('Liam Smith','liam.smith@example.co.uk','+44-7700900011','1988-11-05','GB987654','UK','+44-7700900012'),
('Sofia Rossi','sofia.rossi@example.it','+39-3330001111','1995-02-14','IT445566','Italy','+39-3330001112'),
('Carlos Silva','carlos.silva@example.com','+55-2190001111','1990-07-08','BR778899','Brazil','+55-2190001112'),
('Mia Chen','mia.chen@example.hk','+852-60001111','1998-03-22','HK112233','Hong Kong','+852-60001112'),
('Noah Brown','noah.brown@example.ca','+1-6040001111','1985-09-30','CA556677','Canada','+1-6040001112'),
('Emma Wilson','emma.wilson@example.au','+61-40001111','1993-12-09','AU998877','Australia','+61-40001112'),
('Kenji Tanaka','kenji.tanaka@example.jp','+81-7012345678','1991-05-17','JP445500','Japan','+81-7012345679'),
('Zoe Anders','zoe.anders@example.is','+354-6000111','1994-08-02','IS223344','Iceland','+354-6000112'),
('Fatima Hassan','fatima.hassan@example.ke','+254-700011111','1990-10-10','KE667788','Kenya','+254-700011112');

INSERT INTO Guide (full_name, language_spoken, rating, destination_id)
VALUES
('Arjun Mehta', 'Hindi, English', 4.8, 1),
('Claire Dubois', 'French, English', 4.7, 2),
('Kenji Sato', 'Japanese, English', 4.6, 3),
('Ethan Wilson', 'English', 4.5, 4),
('Sarah Johnson', 'English', 4.9, 5),
('Pedro Lima', 'Portuguese, English', 4.4, 6),
('Omar Ali', 'Arabic, English', 4.3, 7),
('Samantha Lee', 'English, French', 4.6, 8),
('Giulia Bianchi', 'Italian, English', 4.8, 9),
('Somchai Prasert', 'Thai, English', 4.7, 10);

INSERT INTO Trip (trip_name, destination_id, start_date, end_date, base_price, seats_total)
VALUES
('Majestic India Tour', 1, '2025-12-01', '2025-12-07', 1000.00, 20),
('Paris City Lights', 2, '2025-11-10', '2025-11-15', 1500.00, 15),
('Tokyo Adventure', 3, '2025-10-20', '2025-10-27', 1300.00, 25),
('Aussie Reef Explorer', 4, '2025-12-05', '2025-12-10', 1800.00, 10),
('Canyon Hike Experience', 5, '2025-11-20', '2025-11-25', 1200.00, 18),
('Rio Carnival Blast', 6, '2025-02-10', '2025-02-15', 1600.00, 22),
('Mystery of the Pyramids', 7, '2025-12-15', '2025-12-20', 1400.00, 16),
('Falls and Fun', 8, '2025-09-05', '2025-09-10', 900.00, 20),
('Rome Heritage Walk', 9, '2025-10-15', '2025-10-20', 1100.00, 25),
('Phuket Beach Escape', 10, '2025-12-25', '2025-12-30', 800.00, 30);

INSERT INTO Booking (traveler_id, trip_id, seats_booked, status)
VALUES
(1, 1, 2, 'CONFIRMED'),
(2, 2, 1, 'BOOKED'),
(3, 3, 3, 'CONFIRMED'),
(4, 4, 1, 'BOOKED'),
(5, 5, 2, 'CONFIRMED'),
(6, 6, 1, 'BOOKED'),
(7, 7, 2, 'CANCELLED'),
(8, 8, 1, 'CONFIRMED'),
(9, 9, 1, 'BOOKED'),
(10, 10, 2, 'CONFIRMED');

INSERT INTO Payment (booking_id, amount_paid, payment_method, status)
VALUES
(1, 2000.00, 'CARD', 'SUCCESS'),
(2, 1500.00, 'BANK_TRANSFER', 'SUCCESS'),
(3, 3900.00, 'CASH', 'SUCCESS'),
(4, 1800.00, 'CARD', 'PENDING'),
(5, 2400.00, 'CARD', 'SUCCESS'),
(6, 1600.00, 'WALLET', 'SUCCESS'),
(7, 0.00, 'CARD', 'FAILED'),
(8, 900.00, 'CARD', 'SUCCESS'),
(9, 1100.00, 'BANK_TRANSFER', 'PENDING'),
(10, 1600.00, 'CASH', 'SUCCESS');

INSERT INTO Trip_Review (traveler_id, trip_id, rating, comment)
VALUES
(1, 1, 5, 'Amazing cultural experience!'),
(2, 2, 4, 'Loved the Eiffel Tower visit!'),
(3, 3, 5, 'Fun rides and great food.'),
(4, 4, 4, 'Loved the reef and the guides.'),
(5, 5, 5, 'Unforgettable adventure!'),
(6, 6, 4, 'Vibrant and colorful event.'),
(7, 7, 5, 'Incredible history and sights.'),
(8, 8, 4, 'Beautiful views of the falls.'),
(9, 9, 5, 'Rome was breathtaking.'),
(10, 10, 4, 'Relaxing and sunny holiday!');

INSERT INTO TRANSPORT (transport_id, trip_id, mode, provider_name, departure_city, arrival_city, ticket_price, travel_date)
VALUES
(1, 1, 'Train', 'Indian Railways', 'Delhi', 'Agra', 1200, '2025-12-01'),
(2, 2, 'Flight', 'Air France', 'London', 'Paris', 9000, '2025-11-10'),
(3, 3, 'Flight', 'Japan Airlines', 'Osaka', 'Tokyo', 7500, '2025-10-20'),
(4, 4, 'Flight', 'Qantas Airways', 'Sydney', 'Cairns', 8500, '2025-12-05'),
(5, 5, 'Bus', 'Greyhound Lines', 'Las Vegas', 'Grand Canyon', 2500, '2025-11-20'),
(6, 6, 'Flight', 'LATAM Airlines', 'São Paulo', 'Rio de Janeiro', 4000, '2025-02-10'),
(7, 7, 'Bus', 'GoBus Egypt', 'Cairo', 'Giza', 1500, '2025-12-15'),
(8, 8, 'Train', 'VIA Rail', 'Toronto', 'Niagara Falls', 1800, '2025-09-05'),
(9, 9, 'Train', 'Trenitalia', 'Florence', 'Rome', 2000, '2025-10-15'),
(10, 10, 'Flight', 'Thai Airways', 'Bangkok', 'Phuket', 5000, '2025-12-25');

-- UPDATE COMMAND
UPDATE TRANSPORT SET DEPARTURE_CITY="PARIS" WHERE TRANSPORT_ID=5; 
UPDATE TRANSPORT SET TRAVEL_DATE="2025-04-16", PROVIDER_NAME="INDIAN AIRLINES" WHERE TRIP_ID=8;
UPDATE TRANSPORT SET ARRIVAL_CITY=CASE TRANSPORT_ID
WHEN 1 THEN 'TOKYO'
WHEN 2 THEN 'Cairns'
WHEN 3 THEN 'Rio de Janeiro'
WHEN 4 THEN 'Niagara Falls'
WHEN 5 THEN 'Paris'
WHEN 6 THEN 'Agra'
WHEN 7 THEN 'Phuket'
WHEN 8 THEN 'São Paulo'
WHEN 9 THEN 'Rome'
WHEN 10 THEN 'Las Vegas'
ELSE ARRIVAL_CITY
END;

-- DELETE COMMAND
DELETE FROM TRANSPORT WHERE TRANSPORT_ID=5;
DELETE FROM TRANSPORT WHERE ARRIVAL_CITY='PARIS' AND TRIP_ID=5;
DELETE FROM TRANSPORT WHERE TRAVEL_DATE BETWEEN '2025-1-16' AND '2025-05-08';
DELETE FROM TRANSPORT;

-- TCL (Transactions)
-- Topics: COMMIT, ROLLBACK, SAVEPOINT

-- Start a new transaction
START TRANSACTION;
SET FOREIGN_KEY_CHECKS=0;
-- Insert a few records into Transport
INSERT INTO Transport
VALUES
(11,101, 'Flight', 'Air India', 'Delhi', 'Tokyo', 55000, '2025-11-01'),
(12,102, 'Train', 'Amtrak', 'New York', 'Boston', 4500, '2025-11-05'),
(13,103, 'Bus', 'RedBus', 'Bangalore', 'Chennai', 1200, '2025-11-10');

-- Create a SAVEPOINT after inserting into Transport
SAVEPOINT after_transport_inserts;


-- update a record 
UPDATE Transport SET PROVIDER_NAME = case TRIP_ID
when 1 then "flight"
when 2 then "bus"
when 3 then "train"
when 4 then "flight"
when 5 then "ship"
else PROVIDER_NAME
end;

-- Rollback to previous savepoint
ROLLBACK TO after_transport_inserts;

-- Insert another record after rollback
INSERT INTO Transport (TRANSPORT_ID,trip_id, mode, provider_name, departure_city, arrival_city, ticket_price, travel_date)
VALUES (14,104, 'Ship', 'Carnival', 'Miami', 'Bahamas', 30000, '2025-12-01');

-- Finally, save all successful changes
COMMIT;

-- Operators
-- Topics: Arithmetic, Logical, Comparison, LIKE

-- Arthematic operators 

SELECT transport_id, mode, ticket_price + 500 AS adjusted_fare FROM Transport; #(-,*,/,%)

-- comparison operator

SELECT trip_name, base_price FROM Trip WHERE base_price > 1200; #(<,<=,>=,=,!=)

-- logical operator --

SELECT trip_name, base_price FROM Trip WHERE base_price BETWEEN 1000 AND 1500;

SELECT * FROM Payment WHERE payment_method='CARD' OR status='FAILED';

SELECT d.destination_name, c.region 
FROM Destination d JOIN Country c ON d.country_id=c.country_id 
WHERE NOT (c.region='Asia');

-- null operators --

SELECT destination_id, destination_name, best_season
FROM Destination
WHERE city IS NULL;

SELECT payment_id, booking_id, amount_paid
FROM Payment
WHERE payment_date IS NOT NULL;

-- special operators --

SELECT trip_id, trip_name, base_price
FROM Trip
WHERE base_price BETWEEN 1000 AND 1500;

SELECT traveler_id, full_name, email
FROM Traveler
WHERE full_name LIKE 'A%';

SELECT t.full_name, t.nationality
FROM Traveler t
WHERE nationality IN (SELECT country_name FROM Country WHERE region='Asia')
AND t.full_name LIKE '%a%';

-- Pre-Defined Functions 
-- Topics : Numerical,String and Date&Time

#Aggregate Function
SELECT 
  COUNT(*) AS total_trips,
  AVG(ticket_price) AS avg_price,
  MAX(ticket_price) AS highest_price,
  MIN(ticket_price) AS lowest_price,
  SUM(ticket_price) AS total_revenue
FROM Transport;

#Normal Function
SELECT 
  transport_id,
  ticket_price,
  BIN(ticket_price) AS binary_ticket,       -- Binary representation
  POW(ticket_price, 2) AS price_squared,   -- Square
  ABS(ticket_price - 500) AS abs_diff,     -- Absolute difference
  SQRT(ticket_price) AS sqrt_price,        -- Square root
  ROUND(ticket_price, -1) AS rounded_price,-- Rounded to nearest 10
  MOD(ticket_price, 100) AS remainder      -- Modulo 100
FROM Transport;

#String Functions
SELECT 
  provider_name,
  LENGTH(provider_name) AS name_length,          -- Length of string
  UCASE(provider_name) AS upper_name,           -- Uppercase
  LCASE(provider_name) AS lower_name,           -- Lowercase
  LEFT(provider_name, 5) AS left_5_chars,       -- Leftmost 5 characters
  RIGHT(provider_name, 5) AS right_5_chars,     -- Rightmost 5 characters
  LPAD(provider_name, 20, '*') AS lpad_name,    -- Pad left to 20 chars
  RPAD(provider_name, 20, '-') AS rpad_name,    -- Pad right to 20 chars
  TRIM(provider_name) AS trim_name,             -- Remove spaces both sides
  LTRIM(provider_name) AS ltrim_name,           -- Remove left spaces
  RTRIM(provider_name) AS rtrim_name,           -- Remove right spaces
  CONCAT(departure_city, ' to ', arrival_city) AS route, -- Concatenate
  CONCAT_WS(' | ', departure_city, arrival_city, mode) AS route_ws, -- Concatenate with separator
  REPEAT(mode, 3) AS repeat_mode,               -- Repeat string
  REPLACE(mode, 'Bus', 'Coach') AS replaced_mode, -- Replace substring
  SUBSTRING(provider_name, 2, 5) AS substring_name -- Substring from 2nd char, length 5
FROM Transport;

SELECT trip_id, GROUP_CONCAT(provider_name SEPARATOR ', ') AS providers
FROM Transport
GROUP BY trip_id;

-- Date & Time
SELECT
  transport_id,
  travel_date,
  NOW() AS current_datetime,             /* Current date and time */
  CURTIME() AS current__time,             /* Current time */
  CURDATE() AS current__date,             /* Current date */
  CURRENT_TIMESTAMP AS current_ts,       /* Current timestamp */
  YEAR(travel_date) AS travel_year,      /* Year of travel */
  MONTH(travel_date) AS travel_month,    /* Month of travel */
  DAY(travel_date) AS travel_day,        /* Day of travel */
  DAYNAME(travel_date) AS travel_dayname,/* Name of the day */
  MONTHNAME(travel_date) AS travel_monthname, /* Name of the month */
  DATE_ADD(travel_date, INTERVAL 5 DAY) AS travel_plus_5_days, /* Add 5 days */
  DATE_ADD(travel_date, INTERVAL 2 MONTH) AS travel_plus_2_months /* Add 2 months */
FROM Transport;

-- Srikanth : User-Defined Functions 
-- Topics : Function & Stored Procedure

DELIMITER $$

CREATE FUNCTION IsEven(n INT)
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
    IF n % 2 = 0 THEN
        RETURN 'Even';
    ELSE
        RETURN 'Odd';
    END IF;
END$$

DELIMITER ;
-- Stored procedure(even)
DELIMITER $$

CREATE PROCEDURE ShowEvenTickets()
BEGIN
    SELECT transport_id, ticket_price
    FROM Transport
    WHERE ticket_price % 2 = 0;
END$$

DELIMITER ;
SELECT 
    transport_id, 
    ticket_price, 
    IsEven(ticket_price) AS price_type
FROM Transport;

CALL ShowEvenTickets() ;


-- Clauses
-- Topics: WHERE, GROUP BY, HAVING, ORDER BY, LIMIT,OFFSET

#Aggregate + WHERE
SELECT 
    COUNT(*) AS total_trips,
    AVG(ticket_price) AS avg_price,
    MAX(ticket_price) AS highest_price,
    MIN(ticket_price) AS lowest_price,
    SUM(ticket_price) AS total_revenue
FROM Transport
WHERE ticket_price > 500;

#Normal Function + WHERE
SELECT 
    transport_id,
    ticket_price,
    BIN(ticket_price) AS binary_ticket,
    POW(ticket_price, 2) AS price_squared,
    ABS(ticket_price - 500) AS abs_diff,
    SQRT(ticket_price) AS sqrt_price,
    ROUND(ticket_price, -1) AS rounded_price,
    MOD(ticket_price, 2) AS is_even
FROM Transport
WHERE MOD(ticket_price, 2) = 0;

#String Function + ORDER BY
SELECT 
    CONCAT(departure_city, ' to ', arrival_city) AS route,
    UCASE(provider_name) AS provider_upper
FROM Transport
ORDER BY provider_upper;

#Group By
SELECT 
    mode,
    COUNT(*) AS total_trips,
    AVG(ticket_price) AS avg_price,
    MAX(ticket_price) AS highest_price,
    MIN(ticket_price) AS lowest_price
FROM Transport
GROUP BY mode;
#Aggregate + WHERE
SELECT 
    COUNT(*) AS total_trips,
    AVG(ticket_price) AS avg_price,
    MAX(ticket_price) AS highest_price,
    MIN(ticket_price) AS lowest_price,
    SUM(ticket_price) AS total_revenue
FROM Transport
WHERE ticket_price > 500;

#Normal Function + WHERE
SELECT 
    transport_id,
    ticket_price,
    BIN(ticket_price) AS binary_ticket,
    POW(ticket_price, 2) AS price_squared,
    ABS(ticket_price - 500) AS abs_diff,
    SQRT(ticket_price) AS sqrt_price,
    ROUND(ticket_price, -1) AS rounded_price,
    MOD(ticket_price, 2) AS is_even
FROM Transport
WHERE MOD(ticket_price, 2) = 0;

#String Function + ORDER BY
SELECT 
    CONCAT(departure_city, ' to ', arrival_city) AS route,
    UCASE(provider_name) AS provider_upper
FROM Transport
ORDER BY provider_upper;

#Group By
SELECT 
    mode,
    COUNT(*) AS total_trips,
    AVG(ticket_price) AS avg_price,
    MAX(ticket_price) AS highest_price,
    MIN(ticket_price) AS lowest_price
FROM Transport
GROUP BY mode;

#Limit with Offset
SELECT 
    CONCAT(departure_city, ' to ', arrival_city) AS route,
    UCASE(provider_name) AS provider_upper
FROM Transport
ORDER BY provider_upper limit 3 offset 1;

-- Constraints, Joins & Views
-- Topics: PK, FK, UNIQUE, NOT NULL, CHECK, INNER/LEFT/RIGHT JOIN

-- INNER JOIN
SELECT d.destination_name, c.country_name, c.region 
FROM Destination d INNER JOIN Country c 
ON d.country_id = c.country_id;

SELECT t.trip_name, d.destination_name, c.country_name FROM Trip t JOIN Destination d 
ON t.destination_id = d.destination_id JOIN Country c ON d.country_id = c.country_id;

-- LEFT JOIN

SELECT d.destination_name, g.full_name AS guide_name
FROM Destination d
LEFT JOIN Guide g ON d.destination_id = g.destination_id;

SELECT tr.full_name, b.booking_id, b.status
FROM Traveler tr
LEFT JOIN Booking b ON tr.traveler_id = b.traveler_id;

-- RIGHT JOIN
SELECT c.country_name, d.destination_name
FROM Country c
RIGHT JOIN Destination d ON c.country_id = d.country_id;

SELECT t.trip_name, b.booking_id, b.status
FROM Booking b
RIGHT JOIN Trip t ON b.trip_id = t.trip_id;

-- full join
SELECT d.destination_name, g.full_name AS guide_name
FROM Destination d
LEFT JOIN Guide g ON d.destination_id = g.destination_id
UNION
SELECT d.destination_name, g.full_name AS guide_name
FROM Guide g
RIGHT JOIN Destination d ON d.destination_id = g.destination_id;

SELECT t.trip_name, r.rating, r.comment
FROM Trip t
LEFT JOIN TRIP_Review r ON t.trip_id = r.trip_id
UNION ALL
SELECT t.trip_name, r.rating, r.comment
FROM Trip t
RIGHT JOIN TRIP_Review r ON t.trip_id = r.trip_id;

-- CROSS JOIN

SELECT d.destination_name, c.country_name, c.region 
FROM Destination d INNER JOIN Country c ;

SELECT C.COUNTRY_ID,country_name,CURRENCY 
FROM COUNTRY AS C INNER JOIN DESTINATION AS D;


-- SELF JOIN
SELECT * FROM COUNTRY C1 INNER JOIN COUNTRY C2 ON C1.COUNTRY_ID=C2.COUNTRY_ID;

SELECT * FROM Destination D1 INNER JOIN Destination D2 ON D1.destination_id=D2.destination_id;

-- VIEWS
CREATE VIEW CNT AS SELECT COUNTRY_NAME,REGION FROM COUNTRY WHERE population_millions>50;
SELECT * FROM CNT;

CREATE VIEW DES AS SELECT destination_name,CITY,best_season FROM DESTINATION ORDER BY CITY;
SELECT * FROM DES;

CREATE VIEW BOOK AS SELECT booking_date,seats_booked FROM BOOKING ;
SELECT * FROM BOOK;


-- Index & Subquery
-- Topics: CREATE INDEX, DROP INDEX, Subqueries

#indexes 
#--1) Clustered
CREATE INDEX idx_travel_date
ON Transport(travel_date);

#2)non - Clustered --Not Available

#--3)Unique
CREATE UNIQUE INDEX idx_unique_route
ON Transport(departure_city, arrival_city);


#--4)Composite
CREATE INDEX idx_mode_provider
ON Transport(mode, provider_name);

#SUBQUERIES
-- NON CO-RELATED
SELECT transport_id, ticket_price
FROM Transport
WHERE ticket_price > (
    SELECT AVG(ticket_price) FROM Transport
);
-- CO-REALTED
SELECT t1.transport_id, t1.mode, t1.ticket_price
FROM Transport t1
WHERE t1.ticket_price > (
    SELECT AVG(t2.ticket_price)
    FROM Transport t2
    WHERE t2.mode = t1.mode
);