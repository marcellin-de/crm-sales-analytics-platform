
with customers as (

    select * from {{ ref('stg_customers') }}

),

regions as (

    select * from {{ ref('stg_regions') }}

),

customer_metrics as (

    select * from {{ ref('int_customer_order_metrics') }}

),

final as (

    select
        customers.customer_id,
        customers.customer_name,
        customers.industry,
        customers.company_size,
        customers.country,
        customers.region_id,
        regions.region_name,
        customers.customer_created_at,

        customer_metrics.first_order_date,
        customer_metrics.last_order_date,
        customer_metrics.total_orders,
        customer_metrics.completed_paid_orders,
        customer_metrics.gross_revenue,
        customer_metrics.total_discount_amount as discount_amount,
        customer_metrics.net_revenue,
        customer_metrics.recognized_revenue as customer_lifetime_value,
        customer_metrics.average_order_value,
        customer_metrics.days_since_last_order,
        coalesce(customer_metrics.is_inactive_customer, true) as is_inactive_customer

    from customers
    left join regions
        on customers.region_id = regions.region_id
    left join customer_metrics
        on customers.customer_id = customer_metrics.customer_id

)

select * from final
