-- 1 How many films are there for each of the categories in the category table. Use appropriate join to write this query.-right join
USE sakila;

SELECT * FROM sakila.category;
SELECT * FROM sakila.film_category;

select c.name, count(film_id)
from category as c
join film_category as f
on c.category_id=f.category_id
group by c.name;

-- 2 - get info about money and stuff, get only data in august and do the aggregation
-- Display the total amount rung up by each staff member in August of 2005.
-- keep the rental date as column
-- filter the date needed 
SELECT * FROM sakila.staff;
SELECT * FROM sakila.rental;

select r.staff_id, rental_date, count(rental_id)
from staff as s
join rental as r
on s.staff_id=r.staff_id
group by r.staff_id, rental_date
having rental_date BETWEEN "2005-08-01" and '2005-08-31';


-- 4 - Which actor has appeared in the most films? 
SELECT * FROM sakila.film_actor;
SELECT * FROM sakila.film;
SELECT * FROM sakila.actor;
-- common film_id and actor_id

select a.actor_id, a.first_name, a.last_name, count(f.film_id) as Number_of_film
from film_actor as f_a
join film as f
on f.film_id=f_a.film_id
join actor as a
on f_a.actor_id=a.actor_id
group by a.actor_id, a.first_name, a.last_name;

-- 5 -Most active customer (the customer that has rented the most number of films)- first and last name + addres of each stuff member 
SELECT * FROM sakila.staff;
SELECT * FROM sakila.rental;
SELECT * FROM sakila.customer;

select c.address_id, c.first_name, c.last_name, s.staff_id, count(r.rental_id) as Number_of_film_rented
from rental as r
join customer as c
on r.customer_id=c.customer_id
join staff as s
on r.staff_id=s.staff_id
group by c.address_id, c.first_name, c.last_name, s.staff_id;

-- 6 List each film and the number of actors who are listed for that film. - for each film the number of actors in every film
SELECT * FROM sakila.film;
SELECT * FROM sakila.film_actor;
SELECT * FROM sakila.actor;

select f.film_id, f.title, count(a.actor_id) as Num_of_actors_for_films
from film_actor as fa
join film as f
on fa.film_id=f.film_id
join actor as a
on a.actor_id=fa.actor_id
group by f.film_id, f.title
ORDER BY Num_of_actors_for_films;

-- to check
select *
from film_actor as fa
join film as f
on fa.film_id=f.film_id
join actor as a
on a.actor_id=fa.actor_id
where (f.title = "betrayed rear");


-- 7 - Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name.
SELECT * FROM sakila.payment;
SELECT * FROM sakila.customer;

select c.customer_id, c.first_name, c.last_name, SUM(amount) as total_paid
from payment as p
join customer as c
on p.customer_id=c.customer_id
group by c.customer_id, c.first_name, c.last_name
ORDER BY c.last_name ASC;


-- fist determine in which table are the info, then common column , determine left or right table, think about the aggregation you need to do. 