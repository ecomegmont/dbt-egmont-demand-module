SELECT
transaction_date,
transaction_id,
product_sku,
product_unit_price_lcy,
product_quantity
FROM {{ref('transformed_storm_sales')}}

