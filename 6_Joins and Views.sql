-- Joins & Views

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
