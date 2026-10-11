USE coffee.shop; ---to set the current context for our catalog and schema

SELECT* --- to verify that our main dataset has been successfully loaded
  FROM sales;

SELECT
---starting with columns that are pulled from our main dataset and have to be part of our new table
  transaction_date,
  store_location,
  product_category,
  product_type,
  product_detail,

    DAYNAME(transaction_date) AS Day_name, ---Adding day names, New column
    MONTHNAME(transaction_date) AS Month_name, ---Adding month names, New column
     COUNT(transaction_id) AS number_of_sales, ---Counting the number of transactions, New column
     SUM(transaction_qty) AS units_sold, ---Counting the number of units sold, New column
     COUNT(DISTINCT product_id) AS unique_products, ----Counting the number of diff products available, New column
     COUNT(store_id) AS number_of_stores, ---Counting the number of stores, New column
     SUM(transaction_qty * double(replace(unit_price, ',', '.'))) AS revenue, ---Summing the total revenue with 'R' currency
     
 
 CASE ---Classifying what period of the day it is
        WHEN (transaction_time) BETWEEN '06:00:00' AND '08:59:59' THEN 'Morning'
        WHEN (transaction_time) BETWEEN '09:00:00' AND '11:59:59' THEN 'Peak_Morning'
        WHEN (transaction_time) BETWEEN '12:00:00' AND '13:59:59' THEN 'Afternoon'
        WHEN (transaction_time) BETWEEN '14:00:00' AND '17:59:59' THEN 'Peak_Afternoon'
        WHEN (transaction_time) BETWEEN '18:00:00' AND '20:59:59' THEN 'Evening'
    END AS temporal_classification,

    CASE ---Classifying days as weekday or weekend
        WHEN DAYNAME(transaction_date) IN ('Mon','Tues','Wed','Thur','Fri') THEN 'Weekday'
        WHEN DAYNAME(transaction_date) IN ('Sat','Sun') THEN 'Weekend'
    END AS daypart_classification

    FROM sales

GROUP BY 
    transaction_date,
    transaction_time,
    month_name,
    store_location,
    product_category,
    product_type,
    product_detail;
