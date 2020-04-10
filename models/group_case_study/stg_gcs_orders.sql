select
    order_id,
    event_id,
    transaction_id as charge_id,

    event_name,
    event_start,
    event_end,
    order_items,
    tax_amount,
    tickets_checked_in,
    transaction_type,
    tickets_purchased as num_tickets_purchased,
    total_paid as amount_paid,
    order_cancelled as is_order_cancelled,
    order_date

from {{ source('ticket_tailor','orders')}}
