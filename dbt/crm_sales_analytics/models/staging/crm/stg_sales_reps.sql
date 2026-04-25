
with source as (

    select * from {{ source('crm_raw', 'sales_reps') }}

),

renamed as (

    select
        sales_rep_id::integer as sales_rep_id,
        trim(sales_rep_name) as sales_rep_name,
        lower(trim(email)) as sales_rep_email,
        region_id::integer as region_id,
        hire_date::date as hire_date

    from source

)

select * from renamed