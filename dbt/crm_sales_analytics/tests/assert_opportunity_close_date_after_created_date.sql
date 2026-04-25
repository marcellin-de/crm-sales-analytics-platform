select
    opportunity_id,
    opportunity_created_date,
    opportunity_close_date
from {{ ref('fct_opportunities') }}
where opportunity_close_date < opportunity_created_date