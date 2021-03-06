SELECT
SPLIT(product_id, ':')[OFFSET(2)] country,
brand,
calculation_date,
SPLIT(product_id, ':')[OFFSET(3)] product_sku,
product_price,
price_benchmark_value,
product_price/price_benchmark_value as index,
price_benchmark_currency
FROM {{ref('price_index')}}
WHERE
price_benchmark_currency = {{ var('company_currency') }}