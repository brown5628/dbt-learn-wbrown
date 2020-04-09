with orders as (
    
    select * from {{ ref('stg_orders') }}
),

payments as (
    
    select * from {{ ref('stg_payments') }}
),

payments_grouped_by_order as (

    select 
        order_id,
        sum(amount) as amount 
    
    from payments

    group by 1
),

orders_with_amount as (

    select
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        orders.status,
        payments_grouped_by_order.amount as amount
    
    from orders 
    
    left outer join payments_grouped_by_order
        using (order_id)

)

select * from orders_with_amount

/*
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

*/