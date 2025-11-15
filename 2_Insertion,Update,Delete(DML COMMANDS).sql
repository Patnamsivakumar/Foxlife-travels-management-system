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