with source as (
    select * from {{ source('easy_shop', 'orders') }}
),

converted as (
    select
        *,
        {{easy_shop.cents_to_dollars('unit_price_cents')}} as unit_price_dollars,
    from source
)

select
    {{ dbt_utils.star(
        from=source('easy_shop', 'orders'),
        except=['unit_price_cents', 'ordered_at']
    ) }},
    unit_price_dollars * quantity as total_order_item_price_dollars,
    extract(date from ordered_at) as ordered_at
from converted
