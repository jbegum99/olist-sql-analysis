WITH monthly AS (
  SELECT
    FORMAT_DATE('%Y-%m', DATE(o.order_purchase_timestamp)) AS month,
    ROUND(SUM(i.price), 2) AS revenue
  FROM `olist.orders` AS o
  JOIN `olist.order_items` AS i ON i.order_id = o.order_id
  WHERE o.order_status = 'delivered'
    AND o.order_delivered_customer_date IS NOT NULL
    AND DATE(o.order_purchase_timestamp) >= '2017-01-01'
  GROUP BY month
)
SELECT
  month,
  revenue,
  LAG(revenue) OVER (ORDER BY month) AS prev_month_revenue,
  ROUND(100 * (revenue - LAG(revenue) OVER (ORDER BY month))
        / LAG(revenue) OVER (ORDER BY month), 1) AS mom_growth_pct
FROM monthly
ORDER BY month;
