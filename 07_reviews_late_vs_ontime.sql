WITH delivered AS (
  SELECT
    order_id,
    DATE_DIFF(DATE(order_delivered_customer_date), DATE(order_estimated_delivery_date), DAY) AS days_vs_estimate
  FROM `olist.orders`
  WHERE order_status = 'delivered'
    AND order_delivered_customer_date IS NOT NULL
),
latest_review AS (
  SELECT
    order_id,
    review_score,
    ROW_NUMBER() OVER (
      PARTITION BY order_id
      ORDER BY review_answer_timestamp DESC
    ) AS rn
  FROM `olist.order_reviews`
)
SELECT
  IF(d.days_vs_estimate > 0, 'late', 'on_time') AS delivery_status,
  COUNT(*) AS orders,
  ROUND(AVG(r.review_score), 2) AS avg_review_score,
  ROUND(100 * COUNTIF(r.review_score <= 2) / COUNT(*), 1) AS pct_low_reviews
FROM delivered AS d
JOIN latest_review AS r
  ON r.order_id = d.order_id
 AND r.rn = 1
GROUP BY delivery_status;

WITH delivered AS (
  SELECT
    order_id,
    DATE_DIFF(DATE(order_delivered_customer_date), DATE(order_estimated_delivery_date), DAY) AS days_vs_estimate
  FROM `olist.orders`
  WHERE order_status = 'delivered'
    AND order_delivered_customer_date IS NOT NULL
),
latest_review AS (
  SELECT
    order_id,
    review_score,
    ROW_NUMBER() OVER (
      PARTITION BY order_id
      ORDER BY review_answer_timestamp DESC
    ) AS rn
  FROM `olist.order_reviews`
)
SELECT
  CASE
    WHEN d.days_vs_estimate <= 0 THEN '1_on_time_or_early'
    WHEN d.days_vs_estimate <= 3 THEN '2_1_to_3_days_late'
    WHEN d.days_vs_estimate <= 7 THEN '3_4_to_7_days_late'
    ELSE '4_8_plus_days_late'
  END AS delay_bucket,
  COUNT(*) AS orders,
  ROUND(AVG(r.review_score), 2) AS avg_review_score
FROM delivered AS d
JOIN latest_review AS r
  ON r.order_id = d.order_id
 AND r.rn = 1
GROUP BY delay_bucket
ORDER BY delay_bucket;
