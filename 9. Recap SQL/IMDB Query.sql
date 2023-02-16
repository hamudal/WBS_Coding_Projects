-- Answer the questions
-- 1. The big picture

-- How many actors are there in the actors table?
-- > 817718 Rows

Select count(Distinct id)
From actors
;

-- How many directors are there in the directors table?
-- > 86880

Select count(Distinct id)
From directors
;

-- How many movies are there in the movies table?
-- > 388269

Select count(id)
From movies
;


-- 2. Exploring the movies

-- From what year are the oldest and the newest movies? What are the names of those movies?
-- > 1888 ,2008

Select name, Min(year)
From movies
;

Select *, Max(year)
From movies
;

Select name, year
from movies
where
	year =(select max(year) from movies) or
    year =(select min(year) from movies)
;

-- What movies have the highest and the lowest ranks?
-- > Rank 1 & 9,9

Select *, Max(movies.rank)
From movies
Where movies.rank is not null
;

Select *, Min(movies.rank)
From movies
Where movies.rank is not null
;

SELECT id, name, movies.rank, Count(movies.rank)
FROM movies
Where movies.rank is not null
group by movies.rank
order by movies.rank desc
;

Select name, movies.rank
from movies
where
	movies.rank =(select max(movies.rank) from movies) or
    movies.rank =(select min(movies.rank) from movies)
;

-- What is the most common movie title?
-- > Eurovision Song Contest, The, 49

SELECT name, COUNT(name)
FROM movies
GROUP BY name
ORDER BY 2 DESC
;


-- 3. Understanding the database

-- Are there movies with multiple directors?
-- > There are many directors, who were involved in many movies.

SELECT director_id, COUNT(director_id)
FROM movies_directors
GROUP BY movie_id
HAVING COUNT(director_id) > 1
ORDER BY COUNT(director_id) DESC
;

-- What is the movie with the most directors? Why do you think it has so many?
-- > "Bill, The", 87, was running many years, more people involved overtime.

SELECT m.name, COUNT(md.director_id)
FROM movies_directors md
JOIN movies m
	ON md.movie_id = m.id
GROUP BY movie_id
HAVING COUNT(director_id) > 1
ORDER BY 2 DESC
;

-- On average, how many actors are listed by movie?
-- > 11.4303

WITH actors_per_movie AS (
	SELECT movie_id, COUNT(actor_id) AS no_actors
	FROM roles
	GROUP BY movie_id)
SELECT AVG(no_actors)
FROM actors_per_movie
;

-- Are there movies with more than one “genre”?
-- > Yes, List of movies

SELECT movie_id, COUNT(genre)
FROM movies_genres
GROUP BY movie_id
HAVING COUNT(genre) > 1
ORDER BY COUNT(genre) DESC
;


-- 4. Looking for specific movies

-- Can you find the movie called “Pulp Fiction”?
-- > 250101, 267038, Pulp Fiction, 1994, 8.7

SELECT *
FROM movies
WHERE name = 'Pulp Fiction'
;

-- Who directed it?
-- > Quentin, Tarantino

SELECT d.first_name, d.last_name
FROM directors d
JOIN movies_directors md
	ON d.id = md.director_id
JOIN movies m
	ON md.movie_id = m.id
WHERE m.name LIKE "pulp fiction"
;

-- Which actors where casted on it?
-- > List of actors

SELECT a.first_name, a.last_name
FROM actors a
JOIN roles r
	ON a.id = r.actor_id
JOIN movies m
	ON r.movie_id = m.id
WHERE m.name LIKE "pulp fiction"
;

-- Can you find the movie called “La Dolce Vita”?
-- > Query

SELECT *
FROM movies
WHERE name LIKE '%Dolce Vita%'
;


-- Who directed it?
-- > Federico, Fellini

SELECT d.first_name, d.last_name
FROM directors d
JOIN movies_directors md
	ON d.id = md.director_id
JOIN movies m
	ON md.movie_id = m.id
WHERE m.name LIKE "Dolce Vita, la"
;

-- Which actors where casted on it?
-- > List of Actors

SELECT a.first_name, a.last_name
FROM actors a
JOIN roles r
	ON a.id = r.actor_id
JOIN movies m
	ON r.movie_id = m.id
WHERE m.name LIKE "Dolce Vita, la"
;

-- When was the movie “Titanic” by James Cameron released?
-- Hint: there are many movies named “Titanic”. We want the one directed by James Cameron.
-- Hint 2: the name “James Cameron” is stored with a weird character on it.
-- > 1997

SELECT m.year
FROM movies m
JOIN movies_directors md
	ON m.id = md.movie_id
JOIN directors d
	ON md.director_id = d.id
WHERE m.name LIKE "titanic"
AND d.last_name LIKE "Cameron"
;


-- 5. Actors and directors

-- Who is the actor that acted most times as “Himself”?
-- > Check query..

SELECT a.first_name, a.last_name, COUNT(a.id)
FROM actors a
JOIN roles r
	ON a.id = r.actor_id
WHERE `role` LIKE "%himself%"
GROUP BY a.id, a.first_name, a.last_name
ORDER BY COUNT(a.id) DESC
;

-- What is the most common name for actors? And for directors?
-- > John (John, 4371) is the most common name .

SELECT first_name, COUNT(first_name)
FROM actors
GROUP BY 1
ORDER BY 2 DESC
;

SELECT last_name, COUNT(last_name)
FROM actors
GROUP BY 1
ORDER BY 2 DESC
;


-- 6. Analysing genders

-- How many actors are male and how many are female?
-- > M, 513306  ;  F, 304412

SELECT gender, count(gender)
FROM actors
GROUP BY gender
;

-- What percentage of actors are female, and what percentage are male?
-- '0.3723' 37% female, therefore 63% male

SELECT
(SELECT COUNT(id)
FROM actors
WHERE gender LIKE "f")
/
(SELECT COUNT(id)
FROM actors)
;


-- 7. Movies across time

-- How many of the movies were released after the year 2000?
-- > 46006

SELECT COUNT(year)
FROM movies
WHERE year > 2000
;

-- How many of the movies where released between the years 1990 and 2000?
-- > 91138

SELECT COUNT(id)
FROM movies
WHERE year BETWEEN 1990 AND 2000
;

-- Which are the 3 years with the most movies? How many movies were produced on those years?
-- > 1, 2002, 12056  ;  2, 2003, 11890  ;  3, 2001, 11690

SELECT DISTINCT COUNT(id), `year`
FROM movies
GROUP BY `year`
ORDER BY 1 DESC;

WITH cte AS (SELECT
	RANK() OVER (ORDER BY COUNT(id) DESC) ranking,
    year,
    count(id) total
FROM movies
GROUP BY year
ORDER BY 1)
SELECT ranking, year, total
FROM cte
WHERE ranking <= 3
;

-- What are the top 5 movie genres?
-- > 1, Short  81013 ; 2, Drama, 72877 ; 3, Comedy, 56425 ; 4, Documentary, 41356 ; 5, Animation, 17652 

SELECT DISTINCT COUNT(movie_id), genre
FROM movies_genres
GROUP BY `genre`
ORDER BY 1 DESC;

WITH cte AS (SELECT
	RANK() OVER (ORDER BY COUNT(movie_id) DESC) ranking,
    genre,
    COUNT(movie_id) total
FROM movies_genres
GROUP BY genre
ORDER BY 1)
SELECT ranking, genre, total
FROM cte
WHERE ranking <= 5
;

-- What are the top 5 movie genres before 1920?
-- > 1, Short, 81013 ; 2, Drama, 72877 ; 3, Comedy, 56425 ; 4, Documentary, 41356 ; 5, Animation, 17652

select count(distinct(movie_id)) as num_genre, genre
from movies_genres
join movies
on movies.id = movies_genres.movie_id
where movies.year < 1920
group by genre
order by num_genre desc
limit 5 
;

WITH cte AS (SELECT
	RANK() OVER (ORDER BY COUNT(movie_id) DESC) ranking,
    genre,
    COUNT(movie_id) total
FROM movies_genres
GROUP BY genre
ORDER BY 1)
SELECT ranking, genre, total
FROM cte
WHERE ranking <= 5
;

-- What is the evolution of the top movie genres across all the decades of the 20th century?
-- > 1, Short, 18559 ; 2, Comedy, 8676 ; 3, Drama, 7692 ; 4, Documentary, 3780 ; 5, Western, 1704

WITH cte AS (SELECT
	RANK() OVER (ORDER BY COUNT(movie_id) DESC) ranking,
    genre,
    COUNT(movie_id) total
FROM movies_genres
WHERE movie_id IN (SELECT id FROM movies WHERE year < 1920)
GROUP BY genre
ORDER BY 1)
SELECT ranking, genre, total
FROM cte
WHERE ranking <= 5
;


-- 8. Putting it all together: names, genders and time

-- Has the most common name for actors changed over time?
-- Get the most common actor name for each decade in the XX century.
-- Re-do the analysis on most common names, splitted for males and females.
-- How many movies had a majority of females among their cast?
-- What percentage of the total movies had a majority female cast?
