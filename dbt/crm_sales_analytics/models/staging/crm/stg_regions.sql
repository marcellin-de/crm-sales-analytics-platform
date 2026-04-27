with source as (

    select * from {{ source('crm_raw', 'regions') }}

),

renamed as (

    select
        region_id::integer as region_id,
        trim(region_name) as region_name,
        trim(country) as country

    from source

)

select * from renamed
