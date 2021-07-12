SELECT
order_date,
market,
country_iso_2_code,
order_discount_code,
order_number,
product_sku,
product_name,
product_quantity,
DiscountAmount as discount_amount,
price_standard,
price_standard_unit,
pricelist_name,
category_description,
brand_name
FROM {{ref('transformed_WP_sales')}}