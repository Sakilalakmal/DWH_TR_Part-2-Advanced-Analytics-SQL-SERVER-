USE DB_WAREHOUSE

-- segment products into cost ranges and count how many products fall into each segment

WITH prodcut_segment AS (
    SELECT
        product_key,
        product_name,
        cost,
        CASE WHEN COST < 100 THEN 'Below 100'
             WHEN COST BETWEEN 100 AND 500 THEN '100-500'
             WHEN COST BETWEEN 500 AND 100 THEN '500-1000'
             ELSE 'Above 1000'
        END cost_range
    FROM gold.dim_products
) 
select 
    cost_range,
    COUNT(*) product_count
from prodcut_segment
GROUP BY cost_range
ORDER BY COUNT(*) DESC

-- group customers into three segments based on their spending behavior:
/* VIP: customer with at leat 12 months of history and spending more than 5,000.
   Regular: customer with at least 12 months of history but spending 5,000 or less
   New: Customers with a lifespan less than 12 months.
And fins the total number of customers by each group
*/
WITH CTE_intermediate_result AS(
     SELECT
         c.customer_key,
         SUM(f.sales_amount) AS total_spending,
         MIN(order_date) AS frist_date,
         MAX(order_date) AS last_date,
         DATEDIFF(MONTH,MIN(order_date),MAX(order_date)) AS lifespan 
     FROM gold.fact_sales f
     LEFT JOIN gold.dim_customers AS c
     ON f.customer_key = c.customer_key
     GROUP BY c.customer_key
),

    segment AS (
    SELECT 
        customer_key,
        total_spending,
        lifespan,
        CASE WHEN lifespan >= 12 AND total_spending > 5000 THEN 'VIP'
             WHEN lifespan > 12 AND total_spending <= 5000 THEN 'Regular'
             ELSE 'New'
        END customer_segment
    FROM CTE_intermediate_result
)
SELECT
customer_segment,
COUNT(*) customer_count
FROM segment
GROUP BY customer_segment
ORDER BY COUNT(*) DESC