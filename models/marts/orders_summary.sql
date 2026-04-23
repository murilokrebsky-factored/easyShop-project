with orders as (
    select * from {{ ref('stg_orders') }}
),

customers as (
    select * from {{ ref('stg_customers') }}
)

select
    o.order_id,
    o.customer_id,
    c.full_name,
    c.city,
    o.status,
    sum(o.quantity) as quantity,
    sum(o.total_order_item_price_dollars) as order_price_dollars,
    c.created_date
from orders o
inner join customers c
on o.customer_id = c.customer_id
group by all
