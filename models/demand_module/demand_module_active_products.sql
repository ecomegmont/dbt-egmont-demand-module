WITH BASE AS (
    SELECT stock_date,
    product_sku,
    sales_product_description,
    stock_qty,
    SUM(stock_qty) OVER w AS weighted_stock_30_active_flag
    FROM {{ref('demand_module_stock_value')}}
    WINDOW w AS (PARTITION BY product_sku ORDER BY UNIX_DATE(stock_date) ASC 
    RANGE BETWEEN 30 PRECEDING AND 0 FOLLOWING)
    ORDER BY stock_date DESC 
)

SELECT stock_date,
product_sku,
sales_product_description,
stock_qty,
weighted_stock_30_active_flag,
CASE 
    WHEN weighted_stock_30_active_flag > 0 then 1
    ELSE 0
    END as active_product
 FROM BASE


