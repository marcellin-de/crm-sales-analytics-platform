
with source as (

    select * from {{ source('crm_raw', 'orders') }}

),

renamed as (

    select
        order_id::integer as order_id,
        customer_id::integer as customer_id,
        sales_rep_id::integer as sales_rep_id,
        order_date::date as order_date,
        trim(order_status) as order_status,
        trim(payment_status) as payment_status

    from source

)

select * from renamed