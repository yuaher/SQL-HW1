USE sakila;

-- 1a. Display the first and last names of all actors from the table actor.
SELECT first_name, last_name FROM actor;

-- 1b. Display the first and last name of each actor in a single column in upper case letters. 
-- Name the column Actor Name.
USE sakila;

SELECT 
	CONCAT(first_name, " ", last_name) as Actor_Name
FROM actor
;
-- 2a. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." 
-- What is one query would you use to obtain this information?
USE sakila;

SELECT
	actor_id
    , first_name
    , last_name
    
FROM actor

WHERE first_name = "Joe"
;    

-- 2b. Find all actors whose last name contain the letters GEN: 
USE sakila;

Select * last_name from actor;
SELECT
	actor_id
    , first_name
    , last_name
    
FROM actor

WHERE last_name like "%GEN%"
;

-- 2c. Find all actors whose last names contain the letters LI. 
-- This time, order the rows by last name and first name, in that order:
USE sakila;

Select * last_name from actor;
SELECT
    last_name
    ,first_name

FROM actor

WHERE last_name like "%LI%"
;
-- 2d. Using IN, display the country_id and country columns of the following countries: Afghanistan, Bangladesh, and China:	
USE sakila;

Select *  from country;
Select
	country_id
	,country

From country

WHERE country in ("Afghanistan", "Bangladesh", "China")
;

-- 3a. You want to keep a description of each actor. 
-- You don't think you will be performing queries on a description, 
-- so create a column in the table actor named description and use the data type BLOB (
-- Make sure to research the type BLOB, as the difference between it and VARCHAR are significant).
-- use sakila;

-- INSERT INTO actor (
-- 	description BLOB 
--     )
-- ;
-- 4a. List the last names of actors, as well as how many actors have that last name. 
USE sakila;

SELECT last_name, COUNT(*) FROM actor GROUP BY last_name;

-- 4b. List last names of actors and the number of actors who have that last name, 
-- but only for names that are shared by at least two actors
-- USE sakila;

-- SELECT last_name, COUNT(*) FROM actor GROUP BY last_name
-- 	WHERE last_name
--     IN (
--     SELECT last_name, COUNT(*) FROM actor GROUP BY last_name >= ">2")
-- 	GROUP BY last_name;

-- 4c. The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS. Write a query to fix the record.-- 
USE sakila;

SELECT * FROM actor
	Where first_name = "GROUCHO";

SELECT * FROM actor;
UPDATE actor
	SET first_name = "HARPO"
    WHERE actor_id = "172";
    
SELECT * FROM actor
	  WHERE actor_id = "172";
      
-- 4d. Perhaps we were too hasty in changing GROUCHO to HARPO. It turns out that GROUCHO was the correct name after all! In a single query, if the first name of the actor is currently HARPO, change it to GROUCHO.

USE sakila;

SELECT * FROM actor;
UPDATE actor
	SET first_name = "GROUCHO"
    WHERE actor_id = "172";
    
SELECT * FROM actor
	  WHERE actor_id = "172";

-- 5a. You cannot locate the schema of the address table. Which query would you use to re-create it?

SHOW CREATE TABLE address;

-- 6a. Use JOIN to display the first and last names, as well as the address, of each staff member. Use the tables staff and address:

USE sakila;

SELECT * FROM staff;
SELECT * FROM address;


SELECT
	s.first_name
    ,s.last_name
    ,a.address
    
FROM staff s
INNER JOIN address a on s.address_id = a.address_id
;

-- 6b. Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment.

USE sakila;

SELECT * FROM staff;
SELECT * FROM payment;


SELECT
	s.first_name
    ,s.last_name
    ,SUM(p.amount) AS "Total"

FROM staff s
	LEFT JOIN payment p ON s.staff_id = p.staff_id and payment_date like '%2005-08%'
	GROUP BY s.first_name, s.last_name;


-- 6c. List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join.

USE sakila;

SELECT * FROM film_actor;
SELECT * FROM film;


SELECT
		f.title AS "Movie"
		,COUNT(fa.actor_id) AS "Number of Actors"

    FROM film_actor fa
	INNER JOIN film f on fa.film_id = f.film_id
	GROUP BY f.title
        ;

-- 6d. How many copies of the film Hunchback Impossible exist in the inventory system? 
USE sakila;


SELECT * FROM film;
SELECT * FROM inventory;

SELECT title,
	(SELECT COUNT(*) FROM inventory
		WHERE film.film_id = inventory.inventory_id) as "Number of copies"
        FROM film
        WHERE title ="Hunchback Impossible";

-- 6e. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabeticalSELEly by last name:
USE sakila;

SELECT * FROM customer;
SELECT * FROM payment;


SELECT 
    c.first_name
    , c.last_name
    ,SUM(p.amount) AS "Total Paid"
    
    FROM customer c 
    INNER JOIN payment p 
    ON c.customer_id = p.customer_id 
    GROUP BY p.customer_id
    ORDER BY last_name ASC;

-- 7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. 
-- As an unintended consequence, films starting with the letters K and Q have also soared in popularity. 
-- Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.

USE sakila;

SELECT * FROM film;
SELECT * FROM `language`;

SELECT film.title, `language`.`name` AS "Language"

FROM film
	INNER JOIN `language`
    ON film.language_id = `language`.language_id
	WHERE film.title like "K%" OR "Q%"
    AND (SELECT `language`.language_id from `language` WHERE name = "English");
    

-- 7b. Use subqueries to display all actors who appear in the film Alone Trip.

USE sakila;

SELECT * FROM actor;
SELECT * FROM film_actor;
SELECT * FROM film
	WHERE title = "Alone Trip";

-- Alone Trip film_id in film_actor table is 17


SELECT 
	actor.first_name
    ,actor.last_name
    ,film_actor.actor_id
    
    FROM actor
    INNER JOIN film_actor on actor.actor_id = film_actor.actor_id
		WHERE film_actor.film_id = "17";


-- 7c. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. 
-- Use joins to retrieve this information.
USE sakila;

-- SELECT * FROM country
-- 	WHERE country = "Canada";
--     -- Canada country_id is 20
--     
-- SELECT * FROM city
-- 	WHERE country_id = "20";
-- -- has country_id

-- SELECT * FROM address
-- -- seven addresses have the city_id  with Canadian country_code of 20
-- 	WHERE city_id IN ("179", "196", "300", "313", "383", "430", "565");
--     
-- SELECT * FROM customer
-- -- match city_id in customer table to identify seven Canadian customers
-- 	WHERE address_id IN ("481", "468", "1", "3", "193", "415", "441");


SELECT * FROM country;
SELECT * FROM customer;
SELECT * FROM address;
SELECT * FROM city;

SELECT customer.first_name, customer.last_name, customer.email
	FROM customer
		JOIN address
			ON customer.address_id = address.address_id

		JOIN city
			ON city.city_id = address.city_id

		JOIN country
			ON country.country_id = city.country_id
			WHERE country = 'Canada';

    

-- 7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.
SELECT * FROM category;
-- join on category_id to film_category table

SELECT * FROM film_category;
-- join on film_id to film table

SELECT * FROM film;
-- title, description

SELECT 
	film.title
    , film.description
    FROM film
    JOIN film_category
		ON film.film_id = film_category.film_id
        
    JOIN category
		ON film_category.category_id = category.category_id
        WHERE name = "Family";
    

-- 7e. Display the most frequently rented movies in descending order.
USE sakila;

SELECT 
	i.film_id
    , f.title
    , COUNT(r.inventory_id)
	
    FROM inventory i
		INNER JOIN rental r
		ON i.inventory_id = r.inventory_id

		INNER JOIN film_text f 
		ON i.film_id = f.film_id
		GROUP BY r.inventory_id
		ORDER BY COUNT(r.inventory_id) DESC;
        
-- 7f. Write a query to display how much business, in dollars, each store brought in.
USE sakila;

SELECT 
	store.store_id
    , SUM(amount) AS revenue 
    
    FROM store 
		INNER JOIN staff 
			ON store.store_id = staff.store_id 
        
        INNER JOIN payment 
			ON payment.staff_id = staff.staff_id 
			GROUP BY store.store_id;
        
-- 7g. Write a query to display for each store its store ID, city, and country.
USE Sakila;

SELECT * FROM store;
-- join on address_id to address table
SELECT * FROM address;
-- join on city_id to city table
SELECT * FROM city;
-- join on country_id to country table
SELECT * FROM country;

SELECT 
	store.store_id
    , city.city
    , country.country 
    FROM store 
    INNER JOIN address 
    ON store.address_id = address.address_id 
    
    INNER JOIN city 
		ON address.city_id = city.city_id 
    
    INNER JOIN country 
		ON city.country_id = country.country_id;

-- 7h. List the top five genres in gross revenue in descending order. (Hint: you may need to use the following 
-- tables: category, film_category, inventory, payment, and rental.)

USE Sakila;

SELECT 
	name
	, SUM(p.amount) AS gross_revenue 
    FROM category c 
    INNER JOIN film_category fc 
		ON fc.category_id = c.category_id 
    
    INNER JOIN inventory i 
		ON i.film_id = fc.film_id 
        
	INNER JOIN rental r 
		ON r.inventory_id = i.inventory_id 
        
	RIGHT JOIN payment p 
		ON p.rental_id = r.rental_id 
        GROUP BY name 
        ORDER BY gross_revenue 
        DESC LIMIT 5;

-- 8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. 
-- Use the solution from the problem above to create a view. If you haven't solved 7h, you can substitute another query to create a view.
USE sakila;

DROP VIEW IF EXISTS top_five_grossing_genres; 
CREATE VIEW top_five_grossing_genres AS

SELECT 
	name
    , SUM(p.amount) AS gross_revenue 
    FROM category c 
    INNER JOIN film_category fc 
		ON fc.category_id = c.category_id 
        
	INNER JOIN inventory i 
		ON i.film_id = fc.film_id 
        
	INNER JOIN rental r 
		ON r.inventory_id = i.inventory_id 
        
	RIGHT JOIN payment p 
		ON p.rental_id = r.rental_id 
		GROUP BY name 
        ORDER BY gross_revenue 
        DESC LIMIT 5;
            


-- 8b. How would you display the view that you created in 8a?
SELECT * FROM top_five_grossing_genres;

-- 8c. You find that you no longer need the view top_five_genres. Write a query to delete it.
DROP VIEW top_five_grossing_genres;