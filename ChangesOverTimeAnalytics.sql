USE DB_WAREHOUSE

-- YEAR performance 

SELECT 
YEAR(order_date) AS order_year,
SUM(sales_amount) AS total_sales,
COUNT(DISTINCT customer_key) AS total_customer,
SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date)
ORDER BY YEAR(order_date)


-- YEAR & MONTH performance 

SELECT 
YEAR(order_date) AS order_year,
MONTH(order_date) AS order_year,
SUM(sales_amount) AS total_sales,
COUNT(DISTINCT customer_key) AS total_customer,
SUM(quantity) AS total_quantity
FROM gold.fact_sales  
WHERE order_date IS NOT NULL
GROUP BY MONTH(order_date),YEAR(order_date)
ORDER BY MONTH(order_date),YEAR(order_date)

-- Datetrunc performance

SELECT 
DATETRUNC(month , order_date) AS order_year,
SUM(sales_amount) AS total_sales,
COUNT(DISTINCT customer_key) AS total_customer,
SUM(quantity) AS total_quantity
FROM gold.fact_sales  
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(month , order_date)
ORDER BY DATETRUNC(month , order_date)

-- using format function 

SELECT 
FORMAT(order_date,'yyyy-MMM') AS order_year,
SUM(sales_amount) AS total_sales,
COUNT(DISTINCT customer_key) AS total_customer,
SUM(quantity) AS total_quantity
FROM gold.fact_sales  
WHERE order_date IS NOT NULL
GROUP BY FORMAT(order_date,'yyyy-MMM')
ORDER BY FORMAT(order_date,'yyyy-MMM')