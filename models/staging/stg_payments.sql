    select 
        id as payment_id,
        orderid as order_id,
        paymentmethod as payment_method,
        round(amount /100, 2) as amount,
        created as created_date
    from {{ source('stripe', 'payment') }}
    where status = 'success'