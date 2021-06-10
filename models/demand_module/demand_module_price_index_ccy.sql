SELECT 
*
FROM {{ref('price_index')}}
WHERE
price_benchmark_currency = {{ var('company_currency') }}