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