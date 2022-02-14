select distinct 
    product_on_site_date,
    product_sku,
   -- product_site_description,
    availability,
    channel,
    country_web_site
from {{ ref('available_products_on_site_by_day') }}