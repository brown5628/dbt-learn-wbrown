select
    id as charge_id,
    
    status as charge_status,
    description,
    currency as currency_type,
    failure_code,
    failure_message,
    fraud_details,
    object as stripe_object,
    livemode as is_livemode,
    paid as is_paid,
    refunded as is_refunded,
    
    captured as is_captured,
    created as date_created 

from {{ source('learn_stripe','charges') }}