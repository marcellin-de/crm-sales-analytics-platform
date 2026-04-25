
with order_items as (

    select * from {{ ref('fct_order_items') }}

),

products as (

    select * from {{ ref('dim_products') }}

),

product_performance as (

    select
        product_id,

        count(distinct order_id) as total_orders,
        sum(quantity) as total_quantity_sold,

        round(sum(gross_revenue), 2) as gross_revenue,
        round(sum(discount_amount), 2) as discount_amount,
        round(sum(net_revenue), 2) as net_revenue,
        round(sum(recognized_revenue), 2) as recognized_revenue,

        round(avg(unit_price), 2) as average_selling_price,
        round(avg(discount), 4) as average_discount

    from order_items
    group by product_id

),

final as (

    select
        products.product_id,
        products.product_name,
        products.product_category,
        products.standard_unit_price,

        coalesce(product_performance.total_orders, 0) as total_orders,
        coalesce(product_performance.total_quantity_sold, 0) as total_quantity_sold,

        coalesce(product_performance.gross_revenue, 0) as gross_revenue,
        coalesce(product_performance.discount_amount, 0) as discount_amount,
        coalesce(product_performance.net_revenue, 0) as net_revenue,
        coalesce(product_performance.recognized_revenue, 0) as recognized_revenue,

        product_performance.average_selling_price,
        product_performance.average_discount

    from products
    left join product_performance
        on products.product_id = product_performance.product_id

)

select * from final