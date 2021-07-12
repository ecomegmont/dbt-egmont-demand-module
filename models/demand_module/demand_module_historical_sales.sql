SELECT
order_date,
order_number,
product_sku,
product_line_price_lcy,
product_line_price_ccy,
product_quantity,
category_description
FROM {{ref('transformed_WP_sales')}}
