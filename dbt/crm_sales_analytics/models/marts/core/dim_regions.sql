with regions as ( select * from {{ ref('stg_regions') }} )

select region_id, region_name, country from regions