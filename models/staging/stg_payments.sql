select
    ID as payment_id,
    "orderID" as order_id,
    "paymentMethod" as payment_method,
    AMOUNT as amount,
    CREATED as payment_creation_date

from raw.stripe.payment
