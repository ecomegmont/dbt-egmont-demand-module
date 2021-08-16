SELECT stock_date,
product_sku,
sales_product_description,
stock_qty,
FROM {{ref('all_products_stock_value_by_day')}}




