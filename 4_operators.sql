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