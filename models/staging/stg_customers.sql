with source as (
    select * from {{ ref('customers') }}
),

renamed as (
    select
        customer_id,
        customer_name,
        signup_date,
        country,
        '{{ var("environment") }}' as environment
    from source
)

select * from renamed
