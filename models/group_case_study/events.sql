with orders as (
    
    select * from {{ ref('stg_gcs_orders') }}
),

charges as (

    select * from {{ ref('stg_gcs_charges') }}
),

refunds as (

    select * from {{ ref('stg_gcs_refunds') }}
),

completed_refunds_by_charge as (

    select 
        charge_id,
        count(distinct refund_id) as num_refunds
    
    from refunds 

    where refund_status = 'succeeded'

    group by 1
),

valid_charges_grouped as (

    select 
        charges.charge_id,
        sum(coalesce(completed_refunds_by_charge.num_refunds,0)) as num_refunds 
    
    from charges
    
    left outer join completed_refunds_by_charge
        using (charge_id)

    where charges.charge_status != 'failed'

    group by 1
),

events_by_order as (

    select 
        event_id,
        event_name,
        sum(num_tickets_purchased) as num_tickets_purchased,
        sum(num_refunds) as num_refunds 
    
    from orders
    
    left outer join valid_charges_grouped
        using (charge_id)

    group by 1, 2
)

select * from events_by_order