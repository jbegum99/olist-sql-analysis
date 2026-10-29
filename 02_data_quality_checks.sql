-- Data quality checks: table row counts, missing delivery dates by status, reviews per order

SELECT 'orders' AS tbl, COUNT(*) AS n FROM `olist.orders`
UNION ALL SELECT 'order_items', COUNT(*) FROM `olist.order_items`
UNION ALL SELECT 'order_reviews', COUNT(*) FROM `olist.order_reviews`
UNION ALL SELECT 'customers', COUNT(*) FROM `olist.customers`
UNION ALL SELECT 'products', COUNT(*) FROM `olist.products`
UNION ALL SELECT 'category_translation', COUNT(*) FROM `olist.category_translation`;

SELECT order_status,
       COUNT(*) AS orders,
       COUNTIF(order_delivered_customer_date IS NULL) AS missing_delivery_date
FROM `olist.orders`
GROUP BY order_status
ORDER BY orders DESC;

SELECT reviews_per_order, COUNT(*) AS orders
FROM (
  SELECT order_id, COUNT(*) AS reviews_per_order
  FROM `olist.order_reviews`
  GROUP BY order_id
)
GROUP BY reviews_per_order
ORDER BY reviews_per_order;
