WITH BASE AS (
SELECT stock_date,
product_sku,
sales_product_description,
stock_qty,
SUM(stock_qty) OVER w AS weighted_stock_30_active_flag
FROM {{ref('demand_module_stock_value')}}
WINDOW w AS (PARTITION BY product_sku ORDER BY UNIX_DATE(stock_date)  asc 
    RANGE BETWEEN 30 PRECEDING AND 0 FOLLOWING)
order by stock_date desc 
)
SELECT stock_date,
product_sku,
sales_product_description,
stock_qty,
weighted_stock_30_active_flag
 FROM BASE
where stock_date = CURRENT_DATE() 
AND weighted_stock_30_active_flag > 0



