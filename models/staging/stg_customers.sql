with source as (
    select * from {{ source('easy_shop', 'customers') }}
)

select
    customer_id,
    first_name,
    last_name,
    first_name || ' ' || last_name as full_name,
    email,
    {{ get_email_provider('email') }} as email_provider,
    city,
    created_at as created_date
from source