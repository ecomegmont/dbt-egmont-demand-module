select * from {{ ref('input_purchase_order') }}
where expected_arrival_date is not null