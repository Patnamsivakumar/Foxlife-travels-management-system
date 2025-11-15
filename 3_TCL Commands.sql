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