


WITH BASE AS ( -- Take all from WP sales

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
    CAST(EXTRACT(date from b.last_updated)as string) as top_level_price_last_updated,
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

),     currency_table AS ( -- take conversion table
        {# Extract join date in currency table #}
        SELECT  currency_date,
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
                CONCAT(EXTRACT(YEAR FROM currency_date),'-',LPAD(CAST(EXTRACT(MONTH from currency_date) as string),2,'0'),'-',LPAD(CAST(EXTRACT(DAY from currency_date) as string),2,'0')) as cuDate
                FROM {{ref('stg__navision_currencies_to_sek')}}
        ),  final as ( -- join all conversions. creating dependencies on the line. Use Macro conversion_when to shorten code. all existing measures in market money, converted to Lcy/sek aswell.
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
                        discount_amount, 
                        {{ conversion_when('discount_amount')}} as discount_amount_lcy,
                        DiscountPercentage,
                        product_line_price_lcy,
                        product_line_price_ccy,
                        price_standard_current_pricelist, 
                        {{ conversion_when('price_standard_current_pricelist')}} as price_standard_current_pricelist_lcy,
                        price_standard_unit_current_pricelist, 
                         {{ conversion_when('price_standard_unit_current_pricelist')}} as price_standard_unit_current_pricelist_lcy,
                        top_level_price_standard,  
                        {{ conversion_when('top_level_price_standard')}} as top_level_price_standard_lcy,
                        top_level_price_standard_unit, 
                        c.*,
                        {{ conversion_when('top_level_price_standard_unit')}} as top_level_price_standard_unit_lcy,
                        top_level_price_last_updated,
                        pricelist_name,
                        a.pricelist_id,
                        category_description,
                        brand_name,
                        line_number
                        from BASE a
                            left join 
                                currency_table b
                                    on a.order_dt = b.cuDate
                            left join currency_table c on a.top_level_price_last_updated = c.cuDate
                )

        SELECT * FROM final