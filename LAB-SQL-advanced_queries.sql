USE sakila;

## 1. List each pair of actors that have worked together.

SELECT DISTINCT fa.actor_id, fb.actor_id
FROM film_actor AS fa, film_actor AS fb
WHERE fa.film_id = fb.film_id
  AND fa.actor_id < fb.actor_id;

SELECT DISTINCT fa.actor_id, fb.actor_id
FROM film_actor AS fa
JOIN film_actor AS fb ON fa.film_id = fb.film_id 
AND fa.actor_id < fb.actor_id;

## 2. For each film, list actor that has acted in more films.


SELECT f.film_id, a.actor_id, a.first_name, a.last_name
FROM film_actor AS fa
JOIN actor AS a ON fa.actor_id = a.actor_id
JOIN (
    SELECT film_id, COUNT(*) AS film_count
    FROM film_actor
    GROUP BY film_id
) AS film_counts ON fa.film_id = film_counts.film_id
JOIN (
    SELECT film_id, MAX(film_count) AS max_count
    FROM (
        SELECT film_id, COUNT(*) AS film_count
        FROM film_actor
        GROUP BY film_id
    ) AS counts
    GROUP BY film_id
) AS max_counts ON film_counts.film_id = max_counts.film_id AND film_counts.film_count = max_counts.max_count
JOIN film AS f ON fa.film_id = f.film_id;



