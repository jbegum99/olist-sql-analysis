# Olist E-Commerce Analysis (SQL)

## Business question
Which product categories and states drive revenue, and do late deliveries lower customer review scores?

## Data
Olist Brazilian E-Commerce Public Dataset (Kaggle), about 99K orders from Sept 2016 to Oct 2018.
Tables used: orders, order_items, order_reviews, customers, products, category_translation.

## Tools
BigQuery (SQL), Google Sheets for charts.

## Data cleaning notes
- Kept only orders with status `delivered` and a delivery date (about 97% of orders).
- order_reviews has about 800 duplicate review_ids; kept one review per order.
- Excluded 8 delivered orders with no delivery date.
- 547 orders have 2 to 3 reviews; kept the most recent review per order.
- Excluded orders that were never delivered (shipped, canceled, unavailable, invoiced, processing).
- Category_translation loaded with its header as a data row; rebuilt the table with correct column names (71 categories).

## Analysis
| File | Question |
| --- | --- |
| 01_explore_orders.sql | Row counts, order statuses, date range |
| 02_data_quality_checks.sql | Table counts, missing delivery dates, duplicate reviews |

## Key findings
1. (add after Step 2)
2.
3.

## Recommendations
1.
2.

## Limitations
Data covers 2016 to 2018 only and is from one marketplace.
