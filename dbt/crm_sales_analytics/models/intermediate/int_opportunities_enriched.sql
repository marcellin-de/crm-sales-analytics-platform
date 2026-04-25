
with opportunities as (

    select * from {{ ref('stg_opportunities') }}

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
        opportunities.opportunity_id,
        opportunities.customer_id,
        opportunities.sales_rep_id,
        customers.region_id,

        opportunities.opportunity_created_date,
        opportunities.opportunity_close_date,
        opportunities.opportunity_stage,
        opportunities.expected_revenue,
        opportunities.probability,

        round(opportunities.expected_revenue * opportunities.probability, 2) as weighted_pipeline_value,

        case
            when opportunities.opportunity_stage = 'Closed Won' then true
            else false
        end as is_won,

        case
            when opportunities.opportunity_stage = 'Closed Lost' then true
            else false
        end as is_lost,

        case
            when opportunities.opportunity_stage in ('Closed Won', 'Closed Lost') then true
            else false
        end as is_closed,

        customers.customer_name,
        customers.industry,
        customers.company_size,

        sales_reps.sales_rep_name,
        sales_reps.sales_rep_email,

        regions.region_name,
        regions.country as region_country

    from opportunities
    left join customers
        on opportunities.customer_id = customers.customer_id
    left join sales_reps
        on opportunities.sales_rep_id = sales_reps.sales_rep_id
    left join regions
        on customers.region_id = regions.region_id

)

select * from enriched