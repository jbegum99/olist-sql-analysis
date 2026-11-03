WITH delivered AS (
  SELECT
    order_id,
    customer_id,
    DATE_DIFF(DATE(order_delivered_customer_date), DATE(order_purchase_timestamp), DAY) AS delivery_days,
    DATE_DIFF(DATE(order_delivered_customer_date), DATE(order_estimated_delivery_date), DAY) AS days_vs_estimate
  FROM `olist.orders`
  WHERE order_status = 'delivered'
    AND order_delivered_customer_date IS NOT NULL
)
SELECT
  COUNT(*) AS orders,
  COUNTIF(days_vs_estimate > 0) AS late_orders,
  ROUND(100 * COUNTIF(days_vs_estimate > 0) / COUNT(*), 1) AS pct_late,
  ROUND(AVG(delivery_days), 1) AS avg_delivery_days,
  ROUND(AVG(IF(days_vs_estimate > 0, days_vs_estimate, NULL)), 1) AS avg_days_late_when_late
FROM delivered;

WITH delivered AS (
  SELECT
    order_id,
    customer_id,
    DATE_DIFF(DATE(order_delivered_customer_date), DATE(order_purchase_timestamp), DAY) AS delivery_days,
    DATE_DIFF(DATE(order_delivered_customer_date), DATE(order_estimated_delivery_date), DAY) AS days_vs_estimate
  FROM `olist.orders`
  WHERE order_status = 'delivered'
    AND order_delivered_customer_date IS NOT NULL
)
SELECT
  c.customer_state AS state,
  COUNT(*) AS orders,
  ROUND(100 * COUNTIF(d.days_vs_estimate > 0) / COUNT(*), 1) AS pct_late,
  ROUND(AVG(d.delivery_days), 1) AS avg_delivery_days
FROM delivered AS d
JOIN `olist.customers` AS c
  ON c.customer_id = d.customer_id
GROUP BY state
HAVING orders >= 100
ORDER BY pct_late DESC;
