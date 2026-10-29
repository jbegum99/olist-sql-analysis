-- Checking monthly revenue

WITH delivered AS (
  SELECT order_id, order_purchase_timestamp
  FROM `olist.orders`
  WHERE order_status = 'delivered'
    AND order_delivered_customer_date IS NOT NULL
)
SELECT
  FORMAT_DATE('%Y-%m', DATE(d.order_purchase_timestamp)) AS month,
  COUNT(DISTINCT d.order_id) AS orders,
  ROUND(SUM(i.price), 2) AS revenue,
  ROUND(SUM(i.price) / COUNT(DISTINCT d.order_id), 2) AS avg_order_value
FROM delivered AS d
JOIN `olist.order_items` AS i
  ON i.order_id = d.order_id
GROUP BY month
ORDER BY month;
