USE sakila;

-- 1a.
SELECT first_name, last_name FROM actor;

-- 1b.
ALTER TABLE actor ADD COLUMN full_name VARCHAR(90);

SET SQL_SAFE_UPDATES = 0;

UPDATE actor SET full_name = CONCAT(first_name,' ', last_name);

SELECT * FROM actor;

-- 2a.
SELECT * 
FROM actor 
WHERE first_name = "Joe";

-- 2b.
SELECT last_name, first_name 
FROM actor 
WHERE last_name LIKE "%GEN%";

-- 2c.
SELECT last_name, first_name 
FROM actor 
WHERE last_name LIKE "%LI%"
ORDER BY last_name, first_name;

-- 2d.
SELECT country_id, country
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

-- 3a.
ALTER TABLE actor ADD COLUMN description BLOB(90);

-- 3b.
ALTER TABLE actor DROP COLUMN description;

-- 4a.
SELECT last_name, COUNT(*) as num
FROM actor
GROUP BY last_name;

-- 4b.
SELECT last_name, COUNT(*) as num
FROM actor
GROUP BY last_name
HAVING num > 2;

-- 4c.
UPDATE actor
SET first_name = "HARPO"
WHERE full_name = "GROUCHO WILLIAMS";

UPDATE actor
SET full_name = "HARPO WILLIAMS"
WHERE full_name = "GROUCHO WILLIAMS";

-- 4d.
UPDATE actor
SET first_name = "GROUCHO"
WHERE first_name = "HARPO";

-- 5a.

SHOW CREATE TABLE address

-- 6a.

SELECT staff.first_name, staff.last_name, address.address
FROM staff
INNER JOIN address ON
staff.address_id = address.address_id;

-- 6b.
SELECT * FROM payment;

SELECT first_name, last_name, SUM(payment.amount)
FROM staff
JOIN payment ON payment.staff_id = staff.staff_id WHERE payment_date LIKE "2005-08%"
GROUP BY first_name, last_name;
 
-- 6c.

SELECT title, COUNT(*) AS number_actors
FROM film
INNER JOIN film_actor USING (film_id)
GROUP BY film_id;

-- 6d.

-- 6e.

-- 7a.

SELECT title
FROM film
JOIN language
WHERE NAME = "English"
AND title IN
(
  SELECT title
  FROM film
  WHERE title LIKE "Q%" OR title LIKE "K%" "English"
  );

-- 7b. 

SELECT last_name, first_name
FROM actor
WHERE actor_id IN 
	(SELECT actor_id FROM film_actor
    WHERE film_id IN
		(SELECT film_id FROM film
        WHERE title = "Alone Trip"));
        
-- 7c.

SELECT country, last_name, first_name, email
FROM country
LEFT JOIN customer ON country.country_id = customer.customer_id 
WHERE country = 'Canada';  

-- 7d. 

SELECT title, category
FROM film_list
WHERE category = 'Family';   

-- 7f. 

SELECT store.store_id, SUM(amount) FROM store 
JOIN staff ON store.store_id = staff.store_id
JOIN payment ON payment.staff_id = staff.staff_id
GROUP BY store.store_id 
ORDER BY SUM(amount);

-- 7g.

SELECT store.store_id, city, country FROM store
JOIN customer ON store.store_id = customer.store_id
JOIN staff ON store.store_id = staff.store_id
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id;

-- 7h. 

SELECT name, SUM(payment.amount) FROM category
JOIN film_category ON category.category_id = film_category.film_id
JOIN inventory ON inventory.film_id = film_category.film_id
JOIN rental ON rental.inventory_id = inventory.inventory_id
JOIN payment GROUP BY name LIMIT 5;

-- 8a.

DROP VIEW if EXISTS top_five;
CREATE VIEW top_five (category, total_sales) AS
SELECT * FROM sales_by_film_category
ORDER BY total_sales DESC
LIMIT 5;
        
-- 8b.

SELECT * FROM top_five;
 
 -- 8c.
 
DROP VIEW top_five;
