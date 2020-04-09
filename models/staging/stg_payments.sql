select
    ID as payment_id,
    "orderID" as order_id,
    "paymentMethod" as payment_method,
    round(AMOUNT/100, 2) as amount,
    CREATED as payment_creation_date

from raw.stripe.payment