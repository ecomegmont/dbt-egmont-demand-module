

SELECT 
stock_date,
product_sku,
stock_qty,
case 
    when stock_qty=0 then 0
    when stock_qty>0 then 1
end as is_in_stock
FROM {{ref('transformed_erp_stockvaluebyday')}}