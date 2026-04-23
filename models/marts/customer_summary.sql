with orders as (
    select * from {{ ref('stg_orders') }}
),

customers as (
    select * from {{ ref('stg_customers') }}
)

select
    c.customer_id,
    c.full_name,
    c.city,
    count(distinct o.order_id) as total_orders,
    sum(case when o.status = 'delivered' then 1 else 0 end) as delivered_orders,
    sum(case when o.status = 'delivered' then o.total_order_item_price_dollars else 0 end) as total_spent
from orders o
left join customers c
on o.customer_id = c.customer_id
group by all