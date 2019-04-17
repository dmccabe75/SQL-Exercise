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
WHERE last_name = "%GEN%";

-- 2c.
SELECT last_name, first_name 
FROM actor 
WHERE last_name = "%LI%";

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


