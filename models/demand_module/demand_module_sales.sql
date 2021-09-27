SELECT
    EXTRACT(date from order_date) as order_dt,
    market,
    market_name,
    country_iso_2_code,
    order_discount_code,
    order_number,
    a.product_sku,
    product_name,
    product_quantity,
    DiscountAmount as discount_amount,
    DiscountPercentage,
    product_line_price_lcy,
    product_line_price_ccy,
    a.price_standard as price_standard_current_pricelist,
    price_standard_unit as price_standard_unit_current_pricelist,
    b.price_standard*product_quantity as top_level_price_standard,
    b.price_standard as top_level_price_standard_unit,
    b.last_updated as top_level_price_last_updated,
    pricelist_name,
    a.pricelist_id,
    category_description,
    brand_name,
    line_number
FROM {{ref('transformed_WP_sales')}} a 
    left join {{ref('standard_price')}} b
        on a.product_sku = b.product_sku
            and a.market_name = b.Pricelist
    WHERE NOT a.product_sku = '{{ var("removes") }}'