select 
    id as refund_id,
    charge_id,
    currency as currency_type,
    status as refund_status,
    created as date_created

from {{ source('learn_stripe', 'refunds')}}