-- Explore the Magist tables

-- 1) How many orders are there in the dataset? The orders table contains a row for each order, so this should be easy to find out!



-- 2) Are orders actually delivered? Look at columns in the orders table: one of them is called order_status. Most orders seem to be delivered, but some aren’t. Find out how many orders are delivered and how many are canceled, unavailable, or in any other status by grouping and aggregating this column.



-- 3) Is Magist having user growth? A platform losing users left and right isn’t going to be very useful to us. It would be a good idea to check for the number of orders grouped by year and month. Tip: you can use the functions YEAR() and MONTH() to separate the year and the month of the order_purchase_timestamp.



-- 4) How many products are there on the products table? (Make sure that there are no duplicate products.)



-- 5) Which are the categories with the most products? Since this is an external database and has been partially anonymized, we do not have the names of the products. But we do know which categories products belong to. This is the closest we can get to know what sellers are offering in the Magist marketplace. By counting the rows in the products table and grouping them by categories, we will know how many products are offered in each category. This is not the same as how many products are actually sold by category. To acquire this insight we will have to combine multiple tables together: we’ll do this in the next lesson.



-- 6) How many of those products were present in actual transactions? The products table is a “reference” of all the available products. Have all these products been involved in orders? Check out the order_items table to find out!



-- 7) What’s the price for the most expensive and cheapest products? Sometimes, having a basing range of prices is informative. Looking for the maximum and minimum values is also a good way to detect extreme outliers.



-- 8) What are the highest and lowest payment values? Some orders contain multiple products. What’s the highest someone has paid for an order? Look at the order_payments table and try to find it out.

-- ______________________________________________________________________________________

-- Business questions 
-- Is Magist a good fit for high-end tech products? 
-- Are orders delivered on time?

-- In relation to the products:

-- 1) What categories of tech products does Magist have?



-- 2) How many products of these tech categories have been sold (within the time window of the database snapshot)? 



-- 2.1 What percentage does that represent from the overall number of products sold?



-- 3) What’s the average price of the products being sold?



-- 4) Are expensive tech products popular? *

-- _______________________________________________________________

-- In relation to the sellers:

-- 5) How many months of data are included in the magist database?



-- 6) How many sellers are there? How many Tech sellers are there? 



-- 6.1) What percentage of overall sellers are Tech sellers?



-- 7) What is the total amount earned by all sellers? 



-- 7.1What is the total amount earned by all Tech sellers?



-- 8) Can you work out the average monthly income of all sellers? 



-- 8.1) Can you work out the average monthly income of Tech sellers?

-- _________________________________________________________________

-- In relation to the delivery time:

-- 9) What’s the average time between the order being placed and the product being delivered?



-- 10) How many orders are delivered on time vs orders delivered with a delay?



-- 11) Is there any pattern for delayed orders, e.g. big products being delayed more often?

