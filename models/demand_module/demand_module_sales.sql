SELECT
EXTRACT(date from order_date) as order_dt,
market,
country_iso_2_code,
order_discount_code,
order_number,
product_sku,
product_name,
product_quantity,
DiscountAmount as discount_amount,
product_line_price_lcy,
product_line_price_ccy,
price_standard,
price_standard_unit,
pricelist_name,
pricelist_id,
category_description,
brand_name
FROM {{ref('transformed_WP_sales')}}
 WHERE NOT product_sku = '{{ var(removes) }}'