{{ config(store_failures = true) }} 

SELECT order_number, line_number, count(*) as count
 FROM {{ref('demand_module_sales')}}
 group by order_number, line_number
 having count >1