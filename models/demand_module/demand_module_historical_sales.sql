SELECT
transaction_date,
transaction_id,
product_sku,
product_line_price_lcy,
product_line_price_ccy
product_quantity
FROM {{ref('transformed_WP_sales')}}
