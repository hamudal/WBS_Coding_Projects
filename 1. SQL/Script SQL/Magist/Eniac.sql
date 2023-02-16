SELECT product_id, product_category_name_english, price, seller_id, ROUND(AVG(price), 2) 
FROM magist.product_category_name_translation
JOIN products USING (product_category_name)
JOIN order_items USING (product_id)
JOIN sellers USING (seller_id)
WHERE (product_category_name_english LIKE '%computer%' OR 
		product_category_name_english LIKE '%games%' OR 
		product_category_name_english LIKE '%dvd%' OR 
        product_category_name_english LIKE '%audio%' OR 
        product_category_name_english LIKE '%electronic%' OR
        product_category_name_english LIKE '%phon%' OR
        product_category_name_english LIKE '%tablet%')
GROUP BY product_category_name_english
HAVING AVG(price) > 300
ORDER BY price DESC;



-- In relation to the products:
-- 1) 7 (11)
-- computers, audio, cds_dvds_musicals, consoles_games, computers_accessories, electronics, dvds_blu_ray


-- 2) Which table to find SOLD items quanitity?
-- --------------------------------------------
-- 2. Percentage of High Tech products : how much % of total products sold are from High_Tech categories
with tech_items_Sold_q as(
select count(order_item_id) as High_Tech_Items_Sold 
        ## TODO : add the order_status condition as != cancelled
        ,(select count(order_item_id) from order_items) as All_Items_Sold
from product_category_name_translation
join products         using (product_category_name)
join order_items     using (product_id)
where product_category_name_english in  ("computers")
    and price > 500

order by price desc
)
select * , ((High_Tech_Items_Sold/All_Items_Sold)*100) as percent_High_Tech_Items_Sold
from tech_items_Sold_q;
-- --------------------------------------------
SELECT seller_id, product_category_name_english, COUNT(product_category_name_english)
FROM product_category_name_translation
JOIN products USING (product_category_name)
JOIN order_items USING (product_id)
JOIN sellers USING (seller_id)
WHERE (product_category_name_english LIKE '%computer%' OR 
		product_category_name_english LIKE '%games%' OR 
		product_category_name_english LIKE '%dvd%' OR 
        product_category_name_english LIKE '%audio%' OR 
        product_category_name_english LIKE '%electronic%' OR
        product_category_name_english LIKE '%phon%' OR
        product_category_name_english LIKE '%tablet%')
        GROUP BY product_category_name_english;
        -- HAVING product_category_name_english LIKE '%computer%';

-- 2.1) 
 
 
SELECT seller_id, product_category_name_english, COUNT(product_category_name_english)
FROM product_category_name_translation
JOIN products USING (product_category_name)
JOIN order_items USING (product_id)
JOIN sellers USING (seller_id)
WHERE (product_category_name_english LIKE '%computer%' OR 
		product_category_name_english LIKE '%games%' OR 
		product_category_name_english LIKE '%dvd%' OR 
        product_category_name_english LIKE '%audio%' OR 
        product_category_name_english LIKE '%electronic%' OR
        product_category_name_english LIKE '%phon%' OR
        product_category_name_english LIKE '%tablet%')
        GROUP BY product_category_name_english;
        -- HAVING product_category_name_english LIKE '%computer%';
 
-- 2.2) How to use %?

-- 3) DONE

SELECT *
FROM magist.product_category_name_translation
JOIN products USING (product_category_name)
JOIN order_items USING (product_id)
GROUP BY product_category_name_english
ORDER BY price DESC;

-- 4) Where quantity of sold items?

-- In relation to the sellers:---------------------------------------------

-- 5) MIN 2016-09-04 23:15:19, MAX 2018-10-17 19:30:18 (Where to subtract?)

with Mo as (

SELECT
year(order_purchase_timestamp), 
month(order_purchase_timestamp)
FROM magist.orders
GROUP BY 1, 2
ORDER BY 1,2)
SELECT COUNT(*) 
FROM Mo
;

-- MAX(order_purchase_timestamp), 
MIN(order_purchase_timestamp)
-- 6) '3095' Are tech sellers meant?

SELECT DISTINCT seller_id, COUNT(seller_id)
FROM magist.sellers;

-- 6.1)

SELECT product_id, product_category_name_english, seller_id
FROM magist.product_category_name_translation
JOIN products USING (product_category_name)
JOIN order_items USING (product_id)
JOIN sellers USING (seller_id)
GROUP BY product_category_name_english;


-- 6.2) 7 (11)

SELECT product_id, product_category_name_english, price, seller_id, ROUND(AVG(price), 2) 
FROM magist.product_category_name_translation
JOIN products USING (product_category_name)
JOIN order_items USING (product_id)
JOIN sellers USING (seller_id)
WHERE (product_category_name_english LIKE '%computer%' OR 
		product_category_name_english LIKE '%games%' OR 
		product_category_name_english LIKE '%dvd%' OR 
        product_category_name_english LIKE '%audio%' OR 
        product_category_name_english LIKE '%electronic%' OR
        product_category_name_english LIKE '%telepon%')
GROUP BY product_category_name_english
ORDER BY price DESC;

-- 7)

SELECT ROUND(SUM(payment_value))
FROM magist.product_category_name_translation
JOIN products USING (product_category_name)
JOIN order_items USING (product_id)
JOIN sellers USING (seller_id)
JOIN order_payments USING (order_id);

-- 7.1) 

SELECT ROUND(SUM(payment_value))
FROM magist.product_category_name_translation
JOIN products USING (product_category_name)
JOIN order_items USING (product_id)
JOIN sellers USING (seller_id)
JOIN order_payments USING (order_id)
WHERE (product_category_name_english LIKE '%computer%' OR 
		product_category_name_english LIKE '%games%' OR 
		product_category_name_english LIKE '%dvd%' OR 
        product_category_name_english LIKE '%audio%' OR 
        product_category_name_english LIKE '%electronic%' OR
        product_category_name_english LIKE '%telepon%');

-- 8) 173 WHich table income monthly, how to? order payment, order items?

SELECT (ROUND(AVG(payment_value) /30))
FROM magist.product_category_name_translation
JOIN products USING (product_category_name)
JOIN order_items USING (product_id)
JOIN sellers USING (seller_id)
JOIN order_payments USING (order_id);

-- 8.1) 187

SELECT (ROUND(AVG(payment_value))/30)
FROM magist.product_category_name_translation
JOIN products USING (product_category_name)
JOIN order_items USING (product_id)
JOIN sellers USING (seller_id)
JOIN order_payments USING (order_id)
WHERE (product_category_name_english LIKE '%computer%' OR 
		product_category_name_english LIKE '%games%' OR 
		product_category_name_english LIKE '%dvd%' OR 
        product_category_name_english LIKE '%audio%' OR 
        product_category_name_english LIKE '%electronic%' OR
        product_category_name_english LIKE '%telepon%');
        
--         In relation to the delivery time:-----------------

-- 1) What’s the average time between the order being placed and the product being delivered?

SELECT order_purchase_timestamp, 
		order_approved_at, 
        order_delivered_customer_date, 
        order_estimated_delivery_date,
        DAY(order_delivered_customer_date - order_purchase_timestamp),
        MONTH(order_delivered_customer_date - order_purchase_timestamp)
FROM orders
WHERE order_delivered_customer_date IS NOT NULL
AND DAY(order_delivered_customer_date - order_purchase_timestamp) IS NOT NULL
GROUP BY 5,6
ORDER BY 5,6;


SELECT order_purchase_timestamp, 
		order_approved_at, 
        order_delivered_customer_date, 
        order_estimated_delivery_date,
        DAY(order_purchase_timestamp - order_delivered_customer_date),
        MONTH(order_purchase_timestamp - order_delivered_customer_date)
FROM orders
WHERE order_delivered_customer_date IS NOT NULL
AND DAY(order_delivered_customer_date - order_purchase_timestamp) IS NOT NULL
GROUP BY 5,6
ORDER BY 5,6;







-- 2) How many orders are delivered on time vs orders delivered with a delay?

SELECT 
        order_delivered_customer_date, 
        order_estimated_delivery_date
--         DAY(order_delivered_customer_date - order_purchase_timestamp),
--         MONTH(order_delivered_customer_date - order_purchase_timestamp)
FROM orders
WHERE order_delivered_customer_date IS NOT NULL
; 
 

-- 3) Is there any pattern for delayed orders, e.g. big products being delayed more often?

-- 
SELECT DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date)
FROM orders;