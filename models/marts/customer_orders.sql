with customers as (
    select * from {{ ref('stg_customers') }}
),

orders as (
    select * from {{ ref('stg_orders') }}
),

customer_order_summary as (
    select
        c.customer_id,
        c.customer_name,
        c.country,
        count(o.order_id) as total_orders,
        sum(o.amount) as total_amount,
        min(o.order_date) as first_order_date,
        max(o.order_date) as last_order_date
    from customers c
    left join orders o on c.customer_id = o.customer_id
    group by c.customer_id, c.customer_name, c.country
)

select * from customer_order_summary
