USE mavenmovies;

-- Question 1: Retrieve the total number of rentals made in the Sakila database.
SELECT COUNT(*) AS Total_Rentals 
FROM rental;

-- Question 2: Find the average rental duration (in days) of movies rented from the Sakila database.
SELECT AVG(DATEDIFF(return_date, rental_date)) AS Avg_Rental_Duration
FROM rental;

-- Question 3: Display the first name and last name of customers in uppercase.
SELECT UPPER(first_name), UPPER(last_name)
FROM customer;

-- Question 4: Extract the month from the rental date and display it alongside the rental ID.
SELECT rental_id, MONTH(rental_date) AS Rental_Month
FROM rental;

-- Question 5: Retrieve the count of rentals for each customer (display customer ID and the count of rentals).
SELECT customer_id, COUNT(*) AS Rental_Count
FROM rental
GROUP BY customer_id;

-- Question 6: Find the total revenue generated by each store.
SELECT store_id, SUM(payment.amount) AS Total_Revenue
FROM payment
JOIN rental ON payment.rental_id = rental.rental_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN store ON inventory.store_id = store.store_id
GROUP BY store_id;

-- Question 7: Display the title of the movie, customer's first name, and last name who rented it.
SELECT film.title, customer.first_name, customer.last_name
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN customer ON rental.customer_id = customer.customer_id;

-- Question 8: Retrieve the names of all actors who have appeared in the film "Gone with the Wind."
SELECT actor.first_name, actor.last_name
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film_actor.film_id = film.film_id
WHERE film.title = 'Gone with the Wind'; 

-- Question 1: Determine the total number of rentals for each category of movies.
SELECT category.name, COUNT(rental.rental_id) AS Total_Rentals
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film_category.film_id = film.film_id
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY category.name;

-- Question 2: Find the average rental rate of movies in each language.
SELECT language.name, AVG(film.rental_rate) AS Avg_Rental_Rate
FROM language
JOIN film ON language.language_id = film.language_id
GROUP BY language.name;

-- Question 3: Retrieve the customer names along with the total amount they've spent on rentals.
SELECT CONCAT(customer.first_name, ' ', customer.last_name) AS Customer_Name, SUM(payment.amount) AS Total_Spent
FROM customer
JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id, Customer_Name;

-- Question 4: List the titles of movies rented by each customer in a particular city (e.g., 'London').
SELECT film.title
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN customer ON rental.customer_id = customer.customer_id
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
WHERE city.city = 'London'
GROUP BY film.title;

-- Question 5: Display the top 5 rented movies along with the number of times they've been rented.
SELECT film.title, COUNT(rental.rental_id) AS Rental_Count
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY film.title
ORDER BY Rental_Count DESC
LIMIT 5;

-- Question 6: Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).
SELECT customer.customer_id, CONCAT(customer.first_name, ' ', customer.last_name) AS Customer_Name
FROM customer
JOIN rental ON customer.customer_id = rental.customer_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
WHERE inventory.store_id IN (1, 2)
GROUP BY customer.customer_id
HAVING COUNT(DISTINCT inventory.store_id) = 2;
