select * from {{ ref('input_purchase_orders') }}
where expected_arrival_date is not null

--excluding values that not have a expected date. 
--Dates get filled in when the order gets registered in ERP.
