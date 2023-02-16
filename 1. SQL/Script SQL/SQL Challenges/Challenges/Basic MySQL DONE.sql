/*1*/
SELECT * 
FROM authors;

/*2*/
SELECT au_fname, au_lname
FROM authors;

/*3*/
SELECT concat(au_fname, '  ', au_lname)
FROM authors;

/*4*/
SELECT DISTINCT au_fname
FROM authors;

/*5*/
SELECT au_fname, au_lname
FROM authors
WHERE au_fname = 'Ringer' OR au_lname = 'Ringer';

/*6*/
SELECT au_fname, au_lname
FROM authors
WHERE au_fname = 'Anne' AND au_lname = 'Ringer';

/*7*/
SELECT au_fname, au_lname, city
FROM authors
WHERE (city = 'Oakland' OR city = 'Berkeley')
AND au_fname = 'Dean';

/*8*/
SELECT au_fname, au_lname, city
FROM authors
WHERE (city = 'Oakland' OR city = 'Berkeley')
AND au_fname != 'Straight';


/*9*/
SELECT title, ytd_sales
FROM titles
ORDER BY pubdate DESC;

/*10*/
SELECT title, ytd_sales
FROM titles
ORDER BY ytd_sales DESC
LIMIT 5;

/*11*/
SELECT MAX(qty)
FROM sales;

/*11*/
SELECT MIN(qty)
FROM sales;

/*12*/
SELECT COUNT(qty)
FROM sales;

/*12*/
SELECT AVG(qty)
FROM sales;

/*12*/
SELECT SUM(qty)
FROM sales;

/*Rework*/
SELECT 
    COUNT(qty),avg(qty),sum(qty)
FROM
    sales;

/*13*/
SELECT *
FROM titles
WHERE title LIKE '%cooking%';

/*14*/
SELECT *
FROM titles
WHERE title LIKE '%____ing%';

/*15*/
SELECT *
FROM authors
WHERE city != 'Salt Lake City'
AND city != 'Ann Arbor'
AND city != 'Oakland';

/*16*/
SELECT *
FROM sales
WHERE qty BETWEEN 25 AND 45;

/*17*/
SELECT *
FROM sales
WHERE ord_date BETWEEN '1993-03-11' AND '1994-09-13';

/*18*/
SELECT COUNT(state)
FROM authors
GROUP BY state;

/*18 Rework */

SELECT
    state, COUNT(*)
FROM
    authors
GROUP BY 
    state; 

/*19*/
SELECT COUNT(state)
FROM authors
GROUP BY state
ORDER BY state DESC;

/*19 Rework */ 
SELECT state, COUNT(*)
FROM authors
GROUP BY state
ORDER BY COUNT(*) DESC;


/*20*/
SELECT MAX(price)
FROM titles
GROUP BY pub_id;

/*21*/
SELECT *
FROM sales
GROUP BY pub_id DESC
LIMIT 3;

/*21 Rework */
SELECT stor_id, SUM(qty)
FROM sales
GROUP BY stor_id
ORDER BY SUM(qty) DESC
LIMIT 3;

/*22 Do it */
select pub_id, type, count(*)
from titles
group by pub_id, type
having avg(price) > 12;

/*23 Do it */
SELECT
    pub_id, type, COUNT(*),AVG(price)
FROM
    titles
GROUP BY 
    pub_id, type
HAVING 
    AVG(price) > 12
ORDER BY 
    AVG(price); 


/*24 Do it */
SELECT 
    state, city, SUM(contract)
FROM
    authors
GROUP BY state , city
HAVING SUM(contract) > 1
ORDER BY city;


/*25 Do it */
SELECT ord_num, qty
FROM sales
WHERE ord_date BETWEEN '1993-03-11' AND '1994-09-13'
ORDER BY qty DESC
LIMIT 5;

/*26 Do it */
SELECT *, COUNT(*)
FROM authors
WHERE au_fname LIKE '%i%'
	AND state in ('UT', 'MD', 'KS');

/*27 Do it */
select city, count(*)
from authors
where city like '%o%' and state = 'CA'
group by city
having count(*) >1
order by city asc;



















