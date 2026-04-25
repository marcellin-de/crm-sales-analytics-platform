
with order_items_enriched as (

    select * from {{ ref('int_order_items_enriched') }}

),

final as (

    select
        order_item_id,
        order_id,
        customer_id,
        sales_rep_id,
        product_id,
        region_id,

        order_date,
        to_number(to_char(order_date, 'YYYYMMDD')) as order_date_key,

        order_status,
        payment_status,

        quantity,
        unit_price,
        discount,

        gross_revenue,
        discount_amount,
        net_revenue,
        recognized_revenue,
        is_revenue_recognized

    from order_items_enriched

)

select * from final