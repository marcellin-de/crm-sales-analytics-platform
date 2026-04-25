
with sales_reps as (

    select * from {{ ref('stg_sales_reps') }}

),

regions as (

    select * from {{ ref('stg_regions') }}

),

final as (

    select
        sales_reps.sales_rep_id,
        sales_reps.sales_rep_name,
        sales_reps.sales_rep_email,
        sales_reps.region_id,
        regions.region_name,
        regions.country as region_country,
        sales_reps.hire_date,

        datediff('month', sales_reps.hire_date, current_date) as tenure_months

    from sales_reps
    left join regions
        on sales_reps.region_id = regions.region_id

)

select * from final