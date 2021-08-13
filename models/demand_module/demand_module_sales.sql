{% docs demand_module_sales %}
# This Model takes all the sales that is happening in raw format. Later taking away the frieght rows.
# This is mainly used to feed the Demand Module forcasting algo.
# The specification has been ordered by Egmont IT Data science team.
# Removes are defined in the main project in the dbt_project. The variable {removes} are only available in the demand_module package and resources. 
{% enddocs %}

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
 WHERE NOT product_sku = {{ var("removes") }} 