{{
    config(
        materialized='incremental',
        unique_key='opportunity_id',
        incremental_strategy='merge'
    )
}}


with opportunities_enriched as (

    select * from {{ ref('int_opportunities_enriched') }}

    {% if is_incremental() %}
        where opportunity_created_date >= (
            select coalesce(max(opportunity_created_date), '1900-01-01'::date)
            from {{ this }}
        )
    {% endif %}

),

final as (

    select
        opportunity_id,
        customer_id,
        sales_rep_id,
        region_id,

        opportunity_created_date,
        to_number(to_char(opportunity_created_date, 'YYYYMMDD')) as opportunity_created_date_key,

        opportunity_close_date,
        to_number(to_char(opportunity_close_date, 'YYYYMMDD')) as opportunity_close_date_key,

        opportunity_stage,
        expected_revenue,
        probability,
        weighted_pipeline_value,

        is_won,
        is_lost,
        is_closed

    from opportunities_enriched

)

select * from final