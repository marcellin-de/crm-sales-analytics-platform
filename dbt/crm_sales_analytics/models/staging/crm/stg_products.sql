
with source as (

    select * from {{ source('crm_raw', 'products') }}

),

renamed as (

    select
        product_id::integer as product_id,
        trim(product_name) as product_name,
        trim(category) as product_category,
        unit_price::number(10, 2) as standard_unit_price,
        created_at::date as product_created_at

    from source

)

select * from renamed