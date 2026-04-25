
with source as (

    select * from {{ source('crm_raw', 'customers') }}

),

renamed as (

    select
        customer_id::integer as customer_id,
        trim(customer_name) as customer_name,
        trim(industry) as industry,
        trim(company_size) as company_size,
        trim(country) as country,
        region_id::integer as region_id,
        created_at::date as customer_created_at

    from source

)

select * from renamed