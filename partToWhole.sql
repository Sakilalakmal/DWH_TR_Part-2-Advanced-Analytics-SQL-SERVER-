-- which categories contribute the most to overall sales 
WITH CTE_category_sales AS (
SELECT
p.category,
SUM(f.sales_amount) total_sales
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_products AS p
ON f.product_key = p.product_key
GROUP BY p.category
)
select 
category,
total_sales,
SUM(total_sales) OVER() overall_sales,
CONCAT(ROUND(CAST(total_sales AS float) / SUM(total_sales) OVER() * 100,2),'%') perecentage_total
from CTE_category_sales
ORDER BY total_sales DESC