with customers as (
    select * from {{ ref('stg_customers') }}
),
customer_order_summary as (
    select
        c.customer_id,
        c.customer_name,
        c.country
    from customers c
)

select * from customer_order_summary
