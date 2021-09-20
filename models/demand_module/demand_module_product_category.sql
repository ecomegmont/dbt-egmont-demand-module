SELECT
  product_sku,
  category_id,
  category_name,
  category_full_name
FROM {{ ref('transformed_product_category') }}
 WHERE NOT product_sku = '{{ var("removes") }}'