-- Row counts, order statuses, date range

SELECT COUNT(*) AS total_rows, COUNT(DISTINCT review_id) AS reviews
FROM `olist.order_reviews`;

SELECT order_status, COUNT(*) AS n
FROM `olist.orders`
GROUP BY order_status
ORDER BY n DESC;

SELECT MIN(order_purchase_timestamp) AS first_order,
       MAX(order_purchase_timestamp) AS last_order
FROM `olist.orders`;
