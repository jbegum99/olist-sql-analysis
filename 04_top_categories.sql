-- Top categories by revenue

WITH delivered AS (
  SELECT order_id
  FROM `olist.orders`
  WHERE order_status = 'delivered'
    AND order_delivered_customer_date IS NOT NULL
)
SELECT
  COALESCE(t.product_category_name_english, p.product_category_name, 'unknown') AS category,
  COUNT(DISTINCT i.order_id) AS orders,
  ROUND(SUM(i.price), 2) AS revenue,
  ROUND(100 * SUM(i.price) / SUM(SUM(i.price)) OVER (), 1) AS pct_of_revenue
FROM `olist.order_items` AS i
JOIN delivered AS d
  ON d.order_id = i.order_id
JOIN `olist.products` AS p
  ON p.product_id = i.product_id
LEFT JOIN `olist.category_translation` AS t
  ON t.product_category_name = p.product_category_name
GROUP BY category
ORDER BY revenue DESC
LIMIT 10;
