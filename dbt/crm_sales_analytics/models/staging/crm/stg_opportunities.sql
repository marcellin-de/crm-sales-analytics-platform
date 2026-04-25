
with source as (

    select * from {{ source('crm_raw', 'opportunities') }}

),

renamed as (

    select
        opportunity_id::integer as opportunity_id,
        customer_id::integer as customer_id,
        sales_rep_id::integer as sales_rep_id,
        created_date::date as opportunity_created_date,
        close_date::date as opportunity_close_date,
        trim(stage) as opportunity_stage,
        expected_revenue::number(12, 2) as expected_revenue,
        probability::number(5, 2) as probability

    from source

)

select * from renamed