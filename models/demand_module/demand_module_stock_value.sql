

SELECT 
a.stock_date,
a.product_sku,
a.stock_qty,
case 
    when stock_qty=0 then 0
    when stock_qty>0 then 1
end as is_in_stock,
b.product_brand 
FROM {{ref('transformed_erp_stockvaluebyday')}} as a
left join {{ref('transformed_product_sku_to_brand')}} as b
on a.product_sku=b.product_sku


