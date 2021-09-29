


WITH BASE AS (

SELECT
    CAST(EXTRACT(date from order_date)as string) as order_dt,
    market,
    market_name,
    country_iso_2_code,
    order_discount_code,
    order_number,
    currency_iso_code,
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

),     currency_table AS (
        {# Extract join date in currency table #}
        SELECT  date,
                CAD_rate,
                CHF_rate,
                DKK_rate,
                JPY_rate,
                KRW_rate,
                NOK_rate,
                PLN_rate,
                AUD_rate,
                CNY_rate,
                EUR_rate,
                GBP_rate,
                USD_rate,
                CONCAT(EXTRACT(YEAR FROM date),'-',LPAD(CAST(EXTRACT(MONTH from date) as string),2,'0'),'-',LPAD(CAST(EXTRACT(DAY from date) as string),2,'0')) as cuDate
                FROM {{ref('stg__navision_currencies_to_sek')}}
        ),  final as (
                    SELECT
                        order_dt,
                        market,
                        market_name,
                        currency_iso_code,
                        country_iso_2_code,
                        order_discount_code,
                        order_number,
                        a.product_sku,
                        product_name,
                        product_quantity,
                        discount_amount, --add converted
                        {{ conversion_when('discount_amount')}} as discount_amount_lcy,
                        DiscountPercentage,
                        product_line_price_lcy,
                        product_line_price_ccy,
                        price_standard_current_pricelist,  --add converted
                        price_standard_unit_current_pricelist,  --add converted
                        top_level_price_standard,  --add converted
                        top_level_price_standard_unit,  --add converted
                        top_level_price_last_updated,
                        pricelist_name,
                        a.pricelist_id,
                        category_description,
                        brand_name,
                        line_number,
                        b.*
                        from BASE a
                            left join 
                                currency_table b
                                    on a.order_dt = b.cuDate
                )

        SELECT * FROM final
        -- add currency iso code to determine market. 