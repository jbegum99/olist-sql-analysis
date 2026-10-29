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
- (add more as you find them)

## Analysis
| File | Question |
| --- | --- |
| 01_explore.sql | Data checks and exploration |
| 02_... | (add as you go) |

## Key findings
1. (add after Step 2)
2.
3.

## Recommendations
1.
2.

## Limitations
Data covers 2016 to 2018 only and is from one marketplace.
