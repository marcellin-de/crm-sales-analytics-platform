
with order_items_enriched as (

    select * from {{ ref('int_order_items_enriched') }}

),

customer_metrics as (

    select
        customer_id,

        min(order_date) as first_order_date,
        max(order_date) as last_order_date,

        count(distinct order_id) as total_orders,
        count(distinct case when is_revenue_recognized then order_id end) as completed_paid_orders,

        round(sum(gross_revenue), 2) as gross_revenue,
        round(sum(discount_amount), 2) as total_discount_amount,
        round(sum(net_revenue), 2) as net_revenue,
        round(sum(recognized_revenue), 2) as recognized_revenue,

        round(
            sum(recognized_revenue) / nullif(count(distinct case when is_revenue_recognized then order_id end), 0),
            2
        ) as average_order_value,

        datediff('day', max(order_date), current_date) as days_since_last_order,

        case
            when datediff('day', max(order_date), current_date) > 180 then true
            else false
        end as is_inactive_customer

    from order_items_enriched
    group by customer_id

)

select * from customer_metrics