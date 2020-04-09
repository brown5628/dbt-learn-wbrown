select
    orders.id as order_id,
    orders.user_id as customer_id,
    orders.order_date,
    orders.status,
    sum(stg_payments.amount) as amount

from raw.jaffle_shop.orders

left outer join {{ ref('stg_payments')}}
    on orders.id = stg_payments.order_id

group by 1,2,3,4