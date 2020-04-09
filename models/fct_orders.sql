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