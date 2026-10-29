# Olist E-Commerce Analysis (SQL)

## Business question
Which product categories and states drive revenue, and do late deliveries lower customer review scores?

## Data
Olist Brazilian E-Commerce Public Dataset (Kaggle), about 99K orders from Sept 2016 to Oct 2018.
Tables used: orders, order_items, order_reviews, customers, products, category_translation.
Revenue is defined as the sum of item price, excluding shipping (freight).

## Tools
BigQuery (SQL), Google Sheets for charts.

## Data cleaning notes
- Kept only orders with status `delivered` and a delivery date (about 97% of orders). This excludes 8 delivered orders with no delivery date and all orders never delivered (shipped, canceled, unavailable, invoiced, processing).
- order_reviews has about 800 duplicate review_ids, and 547 orders have 2 to 3 reviews. Keep the most recent review per order.
- category_translation loaded with its header as a data row; rebuilt the table with correct column names (71 categories).

## Analysis
| File | Question |
| --- | --- |
| 00_fix_category_translation.sql | Fixes header row loaded as data in the category table |
| 01_explore_orders.sql | Row counts, order statuses, date range |
| 02_data_quality_checks.sql | Table counts, missing delivery dates, duplicate reviews |
| 03_monthly_revenue.sql | Monthly revenue, orders and average order value |
| 04_top_categories.sql | Top 10 product categories by revenue |

## Key findings
1. Strong growth: monthly revenue went from about $112K (Jan 2017) to about $988K (Nov 2017), roughly 9x in 10 months.
2. Peak in Nov 2017: 7,288 orders and $988K, likely a Black Friday spike. December dropped to $726K.
3. Plateau in 2018: revenue stayed between about $830K and $980K a month.
4. Volume drives revenue, not order size: average order value stayed in a narrow $125 to $152 range, so growth came from more orders.
5. Top 10 categories make up about 62% of revenue. Health and beauty leads at about $1.23M (9.3%).
6. Watches and gifts ranks #2 in revenue despite fewer orders than bed/bath/table, because it earns about $212 per order versus about $110.
7. Some categories win on volume (bed/bath/table) and others on price (watches and gifts), which matters for marketing and inventory decisions.

## Recommendations
1.
2.

## Limitations
- Data covers 2016 to 2018 only and is from one marketplace.
- Sept to Dec 2016 has almost no orders (1 order each in Sept and Dec, none in Nov), so 2016 is excluded from trend charts.
- Analysis uses delivered orders only, and the last delivered orders are from Aug 2018.
- Revenue excludes shipping costs.
