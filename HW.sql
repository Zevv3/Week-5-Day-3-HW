--1. List all customers who live in Texas (use JOINs)
SELECT customer.first_name, customer.last_name, address, district
FROM customer
FULL JOIN address
ON customer.address_id = address.address_id
WHERE district = 'Texas';
-- 5 customers

-- 2. Get all payments above $6.99 with the Customer's Full Name
SELECT customer.first_name, customer.last_name, payment, amount
FROM customer
FULL JOIN payment
ON customer.customer_id = payment.customer_id
WHERE amount > 6.98;
--2423 payments

-- 3. Show all customers names who have made payments over $175(use subqueries)
SELECT *
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
);
-- 6 customers

-- 4. List all customers that live in Nepal (use the city table)
-- Nepal country_id = 66
SELECT city_id, country_id
FROM city
GROUP BY city_id
ORDER BY country_id;
-- only city in Nepal city_id = 81
SELECT customer.first_name, customer.last_name, address, city_id
FROM customer
FULL JOIN address
ON customer.address_id = address.address_id
WHERE city_id = 81;
-- 1 guy named Kevin Schuler

-- 5. Which staff member had the most transactions?
SELECT staff.staff_id, staff.first_name, staff.last_name, COUNT(rental_id)
FROM staff
FULL JOIN rental
on staff.staff_id = rental.staff_id
GROUP BY staff.staff_id
ORDER BY COUNT(rental_id);
-- Mike Hillyer (staff_id 1)

-- 6. How many movies of each rating are there?
SELECT COUNT(film_id), rating
FROM film
GROUP BY rating
ORDER BY COUNT(film_id);
-- 178 G, 194 PG, 195 R, 210 NC-17, 223 PG-13

-- 7.Show all customers who have made a single payment above $6.99 (Use Subqueries)
-- SELECT customer_id, first_name, last_name
-- FROM customer
-- WHERE customer_id IN(
-- 	SELECT customer_id
-- 	FROM payment
-- 	WHERE amount > 6.99
-- 	ORDER BY customer_id
-- );
SELECT COUNT(customer_id), customer_id
FROM payment
WHERE amount > 6.99
GROUP BY customer_id
ORDER BY COUNT(customer_id);
-- 130 customers

-- 8. How many free rentals did our stores give away?
SELECT *
FROM payment
WHERE amount = 0;
-- 24 free rentals