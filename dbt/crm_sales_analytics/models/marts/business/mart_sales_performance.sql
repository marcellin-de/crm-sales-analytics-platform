
with order_items as (

    select * from {{ ref('fct_order_items') }}

),

opportunities as (

    select * from {{ ref('fct_opportunities') }}

),

sales_reps as (

    select * from {{ ref('dim_sales_reps') }}

),

monthly_sales as (

    select
        sales_rep_id,
        date_trunc('month', order_date) as performance_month,

        count(distinct order_id) as total_orders,
        count(distinct case when is_revenue_recognized then order_id end) as completed_paid_orders,

        round(sum(gross_revenue), 2) as gross_revenue,
        round(sum(discount_amount), 2) as discount_amount,
        round(sum(net_revenue), 2) as net_revenue,
        round(sum(recognized_revenue), 2) as recognized_revenue

    from order_items
    group by sales_rep_id, date_trunc('month', order_date)

),

monthly_opportunities as (

    select
        sales_rep_id,
        date_trunc('month', opportunity_created_date) as performance_month,

        count(distinct opportunity_id) as total_opportunities,
        count(distinct case when is_won then opportunity_id end) as won_opportunities,
        count(distinct case when is_lost then opportunity_id end) as lost_opportunities,

        round(sum(expected_revenue), 2) as total_pipeline_value,
        round(sum(weighted_pipeline_value), 2) as weighted_pipeline_value

    from opportunities
    group by sales_rep_id, date_trunc('month', opportunity_created_date)

),

combined as (

    select
        coalesce(monthly_sales.sales_rep_id, monthly_opportunities.sales_rep_id) as sales_rep_id,
        coalesce(monthly_sales.performance_month, monthly_opportunities.performance_month) as performance_month,

        coalesce(monthly_sales.total_orders, 0) as total_orders,
        coalesce(monthly_sales.completed_paid_orders, 0) as completed_paid_orders,
        coalesce(monthly_sales.gross_revenue, 0) as gross_revenue,
        coalesce(monthly_sales.discount_amount, 0) as discount_amount,
        coalesce(monthly_sales.net_revenue, 0) as net_revenue,
        coalesce(monthly_sales.recognized_revenue, 0) as recognized_revenue,

        coalesce(monthly_opportunities.total_opportunities, 0) as total_opportunities,
        coalesce(monthly_opportunities.won_opportunities, 0) as won_opportunities,
        coalesce(monthly_opportunities.lost_opportunities, 0) as lost_opportunities,
        coalesce(monthly_opportunities.total_pipeline_value, 0) as total_pipeline_value,
        coalesce(monthly_opportunities.weighted_pipeline_value, 0) as weighted_pipeline_value

    from monthly_sales
    full outer join monthly_opportunities
        on monthly_sales.sales_rep_id = monthly_opportunities.sales_rep_id
       and monthly_sales.performance_month = monthly_opportunities.performance_month

),

final as (

    select
        combined.sales_rep_id,
        sales_reps.sales_rep_name,
        sales_reps.sales_rep_email,
        sales_reps.region_id,
        sales_reps.region_name,
        sales_reps.region_country,
        combined.performance_month,

        combined.total_orders,
        combined.completed_paid_orders,
        combined.gross_revenue,
        combined.discount_amount,
        combined.net_revenue,
        combined.recognized_revenue,

        combined.total_opportunities,
        combined.won_opportunities,
        combined.lost_opportunities,
        combined.total_pipeline_value,
        combined.weighted_pipeline_value,

        coalesce(round(
            combined.won_opportunities / nullif(combined.won_opportunities + combined.lost_opportunities, 0),
            4
        ), 0) as opportunity_win_rate,

        round(
            combined.recognized_revenue / nullif(combined.completed_paid_orders, 0),
            2
        ) as average_order_value

    from combined
    left join sales_reps
        on combined.sales_rep_id = sales_reps.sales_rep_id

)

select * from final
