/*

More advanced SQL

------------------------------------------------------------------------------------------------

HOW TO GET THE SCHEMA OF A DATABASE: 
* Windows/Linux: Ctrl + r
* MacOS: Cmd + r

*/

/**************************
***************************
CHALLENGES
***************************
**************************/

-- In SQL we can have many databases, they will show up in the schemas list
-- We must first define which database we will be working with
USE publications; 
 
/**************************
ALIAS
**************************/
-- https://www.w3schools.com/sql/sql_alias.asp

-- 1. From the sales table, change the column name qty to Quantity

SELECT *, qty AS 'Quantity'
FROM sales;


-- 2. Assign a new name into the table sales. Select the column order number using the table alias

SELECT ord_num AS Ordernumber
FROM sales;

/**************************
JOINS
**************************/
-- https://www.w3schools.com/sql/sql_join.asp

/* We will only use LEFT, RIGHT, and INNER joins this week
You do not need to worry about the other types for now */

-- LEFT JOIN example
-- https://www.w3schools.com/sql/sql_join_left.asp
SELECT *
FROM stores s
LEFT JOIN discounts d 
ON d.stor_id = s.stor_id;

-- RIGHT JOIN example
-- https://www.w3schools.com/sql/sql_join_right.asp
SELECT *
FROM stores s
RIGHT JOIN discounts d
ON d.stor_id = s.stor_id;

-- INNER JOIN example
-- https://www.w3schools.com/sql/sql_join_inner.asp
SELECT *
FROM stores s
INNER JOIN discounts d 
ON d.stor_id = s.stor_id;

-- 3. Using LEFT JOIN: in which cities has "Is Anger the Enemy?" been sold?
-- HINT: you can add WHERE function after the joins

SELECT title_id, city
from sales
left join stores
USING (stor_id)
WHERE title_id = 'PS2091'
AND qty > 0;

-- 4. Using RIGHT JOIN: select all the books (and show their titles) that have a link to the employee Howard Snyder.

SELECT title, emp_id
FROM titles
Right JOIN employee
USING (pub_id)
WHERE emp_id = 'HAS54740M';

-- 5. Using INNER JOIN: select all the authors that have a link (directly or indirectly) with the employee Howard Snyder

SELECT *
FROM authors
JOIN titleauthor USING (au_id)
JOIN titles USING (title_id)
JOIN publishers USING (pub_id)
JOIN employee USING(pub_id)
-- JOIN stores USING (stor_id)
WHERE emp_id = 'HAS54740M';

-- 6. Using the JOIN of your choice: Select the book title with higher number of sales (qty)

SELECT title, qty, SUM(qty)
FROM titles
JOIN sales 
USING (title_id)
GROUP BY title_id, title
ORDER BY SUM(qty) DESC;


/**************************
CASE
**************************/
-- https://www.w3schools.com/sql/sql_case.asp

-- 7. Select everything from the sales table and create a new column called "sales_category" with case conditions to categorise qty
--  * qty >= 50 high sales
--  * 20 <= qty < 50 medium sales
--  * qty < 20 low sales

SELECT *,
CASE
	WHEN qty >= 50 THEN 'high sales'
	WHEN 20 <= qty < 50 THEN 'medium sales'
    ELSE 'low sales'
    END AS sales_category
FROM sales
GROUP BY sales_category;


-- _____________________________________________________________________ Understand!
-- 8. Adding to your answer from question 7. Find out the total amount of books sold (qty) in each sales category
-- i.e. How many books had high sales, how many had medium sales, and how many had low sales

SELECT *, SUM(qty),
CASE
	WHEN qty >= 50 THEN 'high sales'
	WHEN 20 <= qty < 50 THEN 'medium sales'
    ELSE 'low sales'
    END AS sales_category
FROM sales
JOIN titles
USING (title_id)
GROUP BY sales_category, type
ORDER BY SUM(qty) DESC;
-- ____________________________________________________________________ To finish & understand
-- 9. Adding to your answer from question 8. Output only those sales categories that have a SUM(qty) greater than 100, and order them in descending order

SELECT *, SUM(qty),
CASE
	WHEN qty >= 50 THEN 'high sales'
	WHEN 20 <= qty < 50 THEN 'medium sales'
    ELSE 'low sales'
    END AS sales_category
FROM sales
JOIN titles
USING (title_id)
GROUP BY sales_category
HAVING SUM(qty) > 100
ORDER BY SUM(qty) DESC;
-- _________________________________________ To finish & understand!

-- 10. Find out the average book price, per publisher, for the following book types and price categories:     
-- book types: business, traditional cook and psychology
-- price categories: <= 5 super low, <= 10 low, <= 15 medium, > 15 high

SELECT *, SUM(qty),
CASE
	WHEN qty >= 5 THEN 'high sales'
	WHEN 20 <= qty < 50 THEN 'medium sales'
    ELSE 'low sales'
    END AS sales_category
FROM sales
JOIN titles
USING (title_id)
GROUP BY sales_category
HAVING SUM(qty) > 100
ORDER BY SUM(qty) DESC;