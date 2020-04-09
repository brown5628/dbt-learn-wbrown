select
    id as order_id,
    user_id as customer_id,
    order_date,
    status,
    amount

from raw.jaffle_shop.orders

left outer join {{ ref('stg_payments')}}
    on orders.id = stg_payments.order_id