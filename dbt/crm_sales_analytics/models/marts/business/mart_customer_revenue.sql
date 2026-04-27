
customers as (

    select * from {{ ref('dim_customers') }}

),

final as (

    select
        customers.customer_id,
        customers.customer_name,
        customers.industry,
        customers.company_size,
        customers.country,
        customers.region_id,
        customers.region_name,

        coalesce(customers.total_orders, 0) as total_orders,
        coalesce(customers.completed_paid_orders, 0) as completed_paid_orders,
        customers.first_order_date,
        customers.last_order_date,

        coalesce(customers.gross_revenue, 0) as gross_revenue,
        coalesce(customers.discount_amount, 0) as discount_amount,
        coalesce(customers.net_revenue, 0) as net_revenue,
        coalesce(customers.customer_lifetime_value, 0) as recognized_revenue,
        coalesce(customers.average_order_value, 0) as average_order_value,

        customers.is_inactive_customer

    from customers

)

select * from final
