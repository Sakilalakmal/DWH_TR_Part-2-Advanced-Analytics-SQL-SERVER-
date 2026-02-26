-- CUMULATIVE ANALYTICS

-- calculate the total sales per month 
-- and the running total of sales over time

SELECT 
order_date,
total_sales,
SUM(total_sales) OVER(PARTITION BY order_date ORDER BY order_date ASC) AS running_total
FROM (
SELECT
DATETRUNC(MONTH,order_date) AS order_date,
SUM(sales_amount) AS total_sales
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(MONTH,order_date)
) t

-- year

SELECT 
order_date,
total_sales,
SUM(total_sales) OVER(ORDER BY order_date ASC) AS running_total,
AVG(avg_price) OVER(ORDER BY order_date ASC) AS running_average
FROM (
SELECT
DATETRUNC(YEAR,order_date) AS order_date,
SUM(sales_amount) AS total_sales,
AVG(price) AS avg_price
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(YEAR,order_date)
) t
