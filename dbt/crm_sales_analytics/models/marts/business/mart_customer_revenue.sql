
with order_items as (

    select * from {{ ref('fct_order_items') }}

),

customers as (

    select * from {{ ref('dim_customers') }}

),

customer_revenue as (

    select
        customer_id,

        count(distinct order_id) as total_orders,
        count(distinct case when is_revenue_recognized then order_id end) as completed_paid_orders,

        min(order_date) as first_order_date,
        max(order_date) as last_order_date,

        round(sum(gross_revenue), 2) as gross_revenue,
        round(sum(discount_amount), 2) as discount_amount,
        round(sum(net_revenue), 2) as net_revenue,
        round(sum(recognized_revenue), 2) as recognized_revenue,

        round(
            sum(recognized_revenue) / nullif(count(distinct case when is_revenue_recognized then order_id end), 0),
            2
        ) as average_order_value

    from order_items
    group by customer_id

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

        coalesce(customer_revenue.total_orders, 0) as total_orders,
        coalesce(customer_revenue.completed_paid_orders, 0) as completed_paid_orders,
        customer_revenue.first_order_date,
        customer_revenue.last_order_date,

        coalesce(customer_revenue.gross_revenue, 0) as gross_revenue,
        coalesce(customer_revenue.discount_amount, 0) as discount_amount,
        coalesce(customer_revenue.net_revenue, 0) as net_revenue,
        coalesce(customer_revenue.recognized_revenue, 0) as recognized_revenue,
        customer_revenue.average_order_value,

        customers.is_inactive_customer

    from customers
    left join customer_revenue
        on customers.customer_id = customer_revenue.customer_id

)

select * from final