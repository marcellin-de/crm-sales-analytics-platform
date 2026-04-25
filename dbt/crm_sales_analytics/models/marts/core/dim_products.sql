with products as ( select * from {{ ref('stg_products') }} )

select
    product_id,
    product_name,
    product_category,
    standard_unit_price,
    product_created_at
from products