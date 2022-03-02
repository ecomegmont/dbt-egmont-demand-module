select * EXCEPT (product_sku, revenue_ccy),
product_sku as shipped_product_sku,
revenue_ccy as revenue_lcy,
    case when sold_product_sku != product_sku then true else false END as virtual_product
 from {{ ref('storm_sales_sku_level') }}
