USE restaurant_db;
#menu table exploration
-- 1. View the menu items table.
SELECT *
FROM menu_items; 

-- 2. Find the number of items on the menu.
SELECT COUNT(distinct(price))
FROM menu_items; 

-- 3. What are the least and most expensive items on the menu?
(SELECT item_name, price
FROM menu_items
WHERE price = (
	SELECT MAX(price)
    FROM menu_items))
UNION ALL
(SELECT item_name, price
FROM menu_items
WHERE price = (
	SELECT MIN(price)
    FROM menu_items)
)
; 

-- 4. How many Italian dishes are on the menu?
SELECT COUNT(*)
FROM menu_items
WHERE category="Italian"
;

-- 5. What are the least and most expensive Italian dishes on the menu?
(SELECT item_name, price
FROM menu_items
WHERE category = 'Italian' 
	AND price = (SELECT MAX(price) FROM menu_items WHERE category = 'Italian'))

UNION ALL

(SELECT item_name, price
FROM menu_items
WHERE category = 'Italian' 
	AND price = (SELECT MIN(price) FROM menu_items WHERE category = 'Italian'))
    ;

-- 6. How many dishes are in each category?
SELECT category, COUNT(item_name) AS num_dishes
FROM menu_items
GROUP BY category 
ORDER BY num_dishes DESC
;
-- 7. What is the average dish price within each category?
SELECT category, AVG(price) AS avg_price
FROM menu_items 
GROUP BY category;

#orders table exploration

-- 1. View the order details table.
SELECT * 
FROM order_details 
;

-- 2. What is the date range of the table?
SELECT MIN(order_date) earliest, MAX(order_date) recent
FROM order_details 
;
-- 3. How many orders were made within this date range?
SELECT COUNT(DISTINCT(order_id))
FROM order_details;

-- 4. How many items were ordered within this date range?
SELECT COUNT(*)
FROM order_details
;
-- 5. Which orders had the most number of items?
SELECT order_id, COUNT(item_id) AS num_item 
FROM order_details
GROUP BY order_id
ORDER BY num_item DESC
;

-- 6. How many orders had more than 12 items?
SELECT COUNT(*)
FROM (
SELECT order_id, COUNT(item_id) AS num_item 
FROM order_details
GROUP BY order_id
HAVING num_item > 12) AS num_orders;

#combined table exploration

-- 1. Combine the menu_items and order_details tables into a single table.
SELECT *
FROM order_details AS od LEFT JOIN menu_items AS mi
	ON od.item_id = mi.menu_item_id
;

-- 2. What were the least and most ordered items? What categories were they in?
(SELECT item_name, COUNT(order_details_id) num_purchase, category
FROM order_details AS od LEFT JOIN menu_items AS mi
	ON od.item_id = mi.menu_item_id
GROUP BY item_name, category	
ORDER BY num_purchase DESC
LIMIT 1)

UNION ALL

(SELECT item_name, COUNT(order_details_id) num_purchase, category
FROM order_details AS od LEFT JOIN menu_items AS mi
	ON od.item_id = mi.menu_item_id
GROUP BY item_name, category
ORDER BY num_purchase ASC
LIMIT 1)
;
-- 3. What were the top 5 orders that spent the most money?
SELECT order_id, SUM(price) AS amt_spent
FROM order_details AS od LEFT JOIN menu_items AS mi
	ON od.item_id = mi.menu_item_id
GROUP BY order_id
ORDER BY amt_spent DESC
LIMIT 5
;

-- 4. View the details of the highest spend order.
SELECT category, SUM(price) AS amt_spent, COUNT(item_id) AS num_item
FROM order_details AS od LEFT JOIN menu_items AS mi
	ON od.item_id = mi.menu_item_id
WHERE order_id = 440
GROUP BY category
;

-- 5. View the details of the top 5 highest spend orders.
SELECT order_id, category, SUM(price) AS amt_spent, COUNT(item_id) AS num_item
FROM order_details AS od LEFT JOIN menu_items AS mi
	ON od.item_id = mi.menu_item_id
WHERE order_id IN (440, 2075, 1957, 330, 2675)
GROUP BY order_id, category
ORDER BY num_item DESC
;



