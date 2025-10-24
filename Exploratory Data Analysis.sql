#Exploratory Data Analysis

SELECT COUNT(*) AS total_bookings FROM hotel_bookings;

#Bookings by hotel
SELECT hotel, COUNT(*) AS total_bookings
FROM hotel_bookings
GROUP BY hotel
ORDER BY total_bookings DESC;

#Bookings by year
SELECT arrival_date_year, COUNT(*) AS total_bookings
FROM hotel_bookings
GROUP BY arrival_date_year
ORDER BY arrival_date_year;

#Total cancellations
SELECT SUM(is_canceled) AS total_canceled,
       ROUND(SUM(is_canceled)/COUNT(*)*100, 2) AS cancel_rate_percentage
FROM hotel_bookings;

#Cancellations by hotel
SELECT hotel,
       SUM(is_canceled) AS total_canceled,
       COUNT(*) AS total_bookings,
       ROUND(SUM(is_canceled)/COUNT(*)*100, 2) AS cancel_rate
FROM hotel_bookings
GROUP BY hotel;

#Cancellations by market segment
SELECT market_segment,
       SUM(is_canceled) AS total_canceled,
       COUNT(*) AS total_bookings,
       ROUND(SUM(is_canceled)/COUNT(*)*100, 2) AS cancel_rate
FROM hotel_bookings
GROUP BY market_segment
ORDER BY cancel_rate DESC;

#Adults, children, babies summary
SELECT 
       SUM(adults) AS total_adults,
       SUM(children) AS total_children,
       SUM(babies) AS total_babies
FROM hotel_bookings;

#Bookings by customer type
SELECT customer_type, COUNT(*) AS total_bookings
FROM hotel_bookings
GROUP BY customer_type
ORDER BY total_bookings DESC;

#Bookings by country (top 10)
SELECT country, COUNT(*) AS total_bookings
FROM hotel_bookings
GROUP BY country
ORDER BY total_bookings DESC
LIMIT 10;

#Average lead time
SELECT hotel, ROUND(AVG(lead_time), 2) AS avg_lead_time
FROM hotel_bookings
GROUP BY hotel;

#Average stay length
SELECT hotel, 
       ROUND(AVG(stays_in_week_nights + stays_in_weekend_nights), 2) AS avg_stay_length
FROM hotel_bookings
GROUP BY hotel;

#Average daily rate (ADR)
SELECT hotel, ROUND(AVG(adr), 2) AS avg_adr
FROM hotel_bookings
GROUP BY hotel;

#ADR by customer type
SELECT customer_type, ROUND(AVG(adr), 2) AS avg_adr
FROM hotel_bookings
GROUP BY customer_type;

#Special requests vs cancellations
SELECT total_of_special_requests,
       COUNT(*) AS total_bookings,
       SUM(is_canceled) AS canceled_bookings,
       ROUND(SUM(is_canceled)/COUNT(*)*100, 2) AS cancel_rate
FROM hotel_bookings
GROUP BY total_of_special_requests
ORDER BY total_of_special_requests;

#Most reserved vs assigned room types
SELECT reserved_room_type, assigned_room_type, COUNT(*) AS total
FROM hotel_bookings
GROUP BY reserved_room_type, assigned_room_type
ORDER BY total DESC;