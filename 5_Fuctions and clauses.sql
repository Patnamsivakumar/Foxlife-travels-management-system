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