with source as (
    select * from {{ ref('orders') }}
),

renamed as (
    select
        order_id,
        customer_id,
        order_date,
        amount,
        '{{ var("environment") }}' as environment
    from source
)

select * from renamed
