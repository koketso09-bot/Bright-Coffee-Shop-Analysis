--- Data Validation and screening
USE coffee.shop;

SELECT * 
from sales
limit 50;

-- How many stores operating stores do we have?
SELECT DISTINCT store_location
FROM sales;

-- what is the period of this data?
SELECT min(transaction_date) AS start_date,
       MAX(transaction_date) AS last_date
FROM sales;

-- What are the operational hours of the stores?
SELECT MIN(transaction_time) AS opening_time,
       MAX(transaction_time) AS closing_time
FROM sales;

--- Products sold per store?
SELECT store_location,
        COUNT(DISTINCT product_id) AS number_of_products
FROM sales
GROUP BY store_location;

--- Would like to see how many transactions were processed daily
SELECT
  transaction_date,
  count(*) as total_transactions
FROM sales
GROUP BY transaction_date
ORDER BY transaction_date;

--- Visualizing different products under 'Coffee' category we have
SELECT DISTINCT product_category,
               product_type,
               product_detail
FROM sales
WHERE product_category IN ('Coffee')
ORDER BY product_type;
