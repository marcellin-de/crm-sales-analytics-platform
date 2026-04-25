
with source as (

    select * from {{ source('crm_raw', 'order_items') }}

),

renamed as (

    select
        order_item_id::integer as order_item_id,
        order_id::integer as order_id,
        product_id::integer as product_id,
        quantity::integer as quantity,
        unit_price::number(10, 2) as unit_price,
        discount::number(5, 2) as discount

    from source

)

select * from renamed