#DATA CLEANING 

select * from hotel_bookings;


SELECT hotel, is_canceled, lead_time, arrival_date_year, arrival_date_month,
       arrival_date_day_of_month, adults, children, babies, COUNT(*)
FROM hotel_bookings
GROUP BY hotel, is_canceled, lead_time, arrival_date_year, arrival_date_month,
         arrival_date_day_of_month, adults, children, babies
HAVING COUNT(*) > 1;


CREATE TABLE hotel_bookings_clean AS
SELECT DISTINCT * FROM hotel_bookings;

select* from hotel_bookings_clean;

select*from hotel_bookings_clean where hotel='City Hotel';


SELECT COUNT(*) FROM hotel_bookings_clean;


SELECT hotel, COUNT(*) AS total_bookings
FROM hotel_bookings_clean
GROUP BY hotel;


SELECT 
    SUM(CASE WHEN children IS NULL OR children = 'NA' THEN 1 ELSE 0 END) AS missing_children,
    SUM(CASE WHEN country IS NULL OR country = '' THEN 1 ELSE 0 END) AS missing_country,
    SUM(CASE WHEN agent IS NULL OR agent = 'NA' THEN 1 ELSE 0 END) AS missing_agent,
    SUM(CASE WHEN company IS NULL OR company = 'NA' THEN 1 ELSE 0 END) AS missing_company
FROM hotel_bookings_clean;

UPDATE hotel_bookings_clean SET children = 0 WHERE children IS NULL OR children = 'NA';
UPDATE hotel_bookings_clean SET country = 'Unknown' WHERE country IS NULL OR country = '';
UPDATE hotel_bookings_clean SET agent = 0 WHERE agent IS NULL OR agent = 'NA';
UPDATE hotel_bookings_clean SET company = 0 WHERE company IS NULL OR company = 'NA';


ALTER TABLE hotel_bookings_clean
MODIFY country VARCHAR(50);

ALTER TABLE hotel_bookings_clean
MODIFY children VARCHAR(10);

ALTER TABLE hotel_bookings_clean MODIFY children INT;
ALTER TABLE hotel_bookings_clean MODIFY babies INT;
ALTER TABLE hotel_bookings_clean MODIFY adults INT;

DELETE FROM hotel_bookings_clean
WHERE adr < 0 OR (adults = 0 AND children = 0 AND babies = 0);

UPDATE hotel_bookings_clean
SET meal = UPPER(meal),
    market_segment = UPPER(market_segment),
    distribution_channel = UPPER(distribution_channel),
    deposit_type = UPPER(deposit_type),
    customer_type = UPPER(customer_type);

DROP TABLE hotel_bookings;
ALTER TABLE hotel_bookings_clean RENAME TO hotel_bookings;

select * from hotel_bookings;





















