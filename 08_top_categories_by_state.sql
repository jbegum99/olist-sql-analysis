WITH delivered AS (
  SELECT order_id, customer_id
  FROM `olist.orders`
  WHERE order_status = 'delivered'
    AND order_delivered_customer_date IS NOT NULL
),
cat_state AS (
  SELECT
    c.customer_state AS state,
    COALESCE(t.product_category_name_english, p.product_category_name, 'unknown') AS category,
    ROUND(SUM(i.price), 2) AS revenue
  FROM delivered AS d
  JOIN `olist.customers` AS c ON c.customer_id = d.customer_id
  JOIN `olist.order_items` AS i ON i.order_id = d.order_id
  JOIN `olist.products` AS p ON p.product_id = i.product_id
  LEFT JOIN `olist.category_translation` AS t
    ON t.product_category_name = p.product_category_name
  GROUP BY state, category
),
ranked AS (
  SELECT *,
    RANK() OVER (PARTITION BY state ORDER BY revenue DESC) AS rank_in_state
  FROM cat_state
)
SELECT state, rank_in_state, category, revenue
FROM ranked
WHERE state IN ('SP', 'RJ', 'MG', 'RS', 'PR')
  AND rank_in_state <= 3
ORDER BY state, rank_in_state;
