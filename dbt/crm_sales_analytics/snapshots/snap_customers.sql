
{% snapshot snap_customers %}

{{
    config(
        target_schema='SNAPSHOTS',
        unique_key='customer_id',
        strategy='check',
        check_cols=[
            'customer_name',
            'industry',
            'company_size',
            'country',
            'region_id'
        ]
    )
}}


select
    customer_id,
    customer_name,
    industry,
    company_size,
    country,
    region_id,
    customer_created_at
from {{ ref('stg_customers') }}

{% endsnapshot %}