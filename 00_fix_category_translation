-- Fix: category_translation loaded with its header row as data.
-- Rename columns and drop the header row (71 categories remain).
-- Run once only. A second run errors because the columns are already renamed.

CREATE OR REPLACE TABLE `olist.category_translation` AS
SELECT
  string_field_0 AS product_category_name,
  string_field_1 AS product_category_name_english
FROM `olist.category_translation`
WHERE string_field_0 != 'product_category_name';

-- Check

SELECT COUNT(*) AS total_rows FROM `olist.category_translation`;
SELECT * FROM `olist.category_translation` LIMIT 5;
