-- Revenue, orders and average order value by customer state 

WITH delivered AS (
  SELECT order_id, customer_id
  FROM `olist.orders`
  WHERE order_status = 'delivered'
    AND order_delivered_customer_date IS NOT NULL
)
SELECT
  c.customer_state AS state,
  COUNT(DISTINCT d.order_id) AS orders,
  ROUND(SUM(i.price), 2) AS revenue,
  ROUND(100 * SUM(i.price) / SUM(SUM(i.price)) OVER (), 1) AS pct_of_revenue,
  ROUND(SUM(i.price) / COUNT(DISTINCT d.order_id), 2) AS avg_order_value
FROM delivered AS d
JOIN `olist.customers` AS c
  ON c.customer_id = d.customer_id
JOIN `olist.order_items` AS i
  ON i.order_id = d.order_id
GROUP BY state
ORDER BY revenue DESC;
