SELECT stock_date,
    product_sku,
    sales_product_description,
    stock_qty,
    case 
     when stock_qty=0 then 0
     When stock_qty< then 0
	 when stock_qty>0 then 1
    end as is_in_stock
FROM {{ref('all_products_stock_value_by_day')}}




