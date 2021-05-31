{% docs ml_input_historical_sales %}

Main Table is Historical Sales

This Model merges historical_sales with item_meta
by collecting data from ;
    Historical_sales
        /transaction_date	
        /transaction_id	
        /product_sku	
        /product_unit_price_lcy	Local website currency
        /product_unit_price_ccy	Company reporting currency
        /product_quantity	

     &

    item_meta
        /product_sku	
        /product_brand	
        /product_category	

{% enddocs %}