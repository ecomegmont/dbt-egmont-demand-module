

SELECT 
stock_date,
product_sku,
stock_qty
FROM {{ref('transformed_erp_stockvaluebyday')}}