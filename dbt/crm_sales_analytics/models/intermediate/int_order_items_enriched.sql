
with order_items as (

    select * from {{ ref('stg_order_items') }}

),

orders as (

    select * from {{ ref('stg_orders') }}

),

products as (

    select * from {{ ref('stg_products') }}

),

customers as (

    select * from {{ ref('stg_customers') }}

),

sales_reps as (

    select * from {{ ref('stg_sales_reps') }}

),

regions as (

    select * from {{ ref('stg_regions') }}

),

enriched as (

    select
        order_items.order_item_id,
        order_items.order_id,
        orders.customer_id,
        orders.sales_rep_id,
        order_items.product_id,
        customers.region_id,

        orders.order_date,
        orders.order_status,
        orders.payment_status,

        customers.customer_name,
        customers.industry,
        customers.company_size,

        products.product_name,
        products.product_category,

        sales_reps.sales_rep_name,
        sales_reps.sales_rep_email,

        regions.region_name,
        regions.country as region_country,

        order_items.quantity,
        order_items.unit_price,
        order_items.discount,

        round(order_items.quantity * order_items.unit_price, 2) as gross_revenue,
        round(order_items.quantity * order_items.unit_price * order_items.discount, 2) as discount_amount,
        round(order_items.quantity * order_items.unit_price * (1 - order_items.discount), 2) as net_revenue,

        case
            when orders.order_status = 'Completed'
             and orders.payment_status = 'Paid'
            then true
            else false
        end as is_revenue_recognized,

        case
            when orders.order_status = 'Completed'
             and orders.payment_status = 'Paid'
            then round(order_items.quantity * order_items.unit_price * (1 - order_items.discount), 2)
            else 0
        end as recognized_revenue

    from order_items
    left join orders
        on order_items.order_id = orders.order_id
    left join products
        on order_items.product_id = products.product_id
    left join customers
        on orders.customer_id = customers.customer_id
    left join sales_reps
        on orders.sales_rep_id = sales_reps.sales_rep_id
    left join regions
        on customers.region_id = regions.region_id

)

select * from enriched