with source as (
    select * from {{ source('easy_shop', 'products') }}
)

select
    product_id,
    name,
    category,
    price_cents,
    {{easy_shop.cents_to_dollars('price_cents')}} as price_dollars,
    sku
from source