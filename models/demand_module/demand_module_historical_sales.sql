SELECT
transaction_date,
transaction_id,
product_sku,
product__line_price_lcy,
product__line_price_ccy
product_quantity
FROM {{ref('transformed_WP_sales')}}

