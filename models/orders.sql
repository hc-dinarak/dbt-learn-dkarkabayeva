with order_payments as (
    select 
        order_id, 
        sum(amount) as amount

from {{ ref('stg_payments') }}
group by 1 
)

select 
    orders.order_id,
    orders.customer_id,
    orders.order_date,
    orders.status,
    order_payments.amount 

from {{ ref('stg_orders') }} as orders
left join order_payments  
on orders.order_id = order_payments.order_id
