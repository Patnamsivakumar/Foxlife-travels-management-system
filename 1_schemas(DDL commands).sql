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