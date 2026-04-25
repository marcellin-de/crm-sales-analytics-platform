# dbt Staging Layer

## Overview

The staging layer transforms raw CRM data from Snowflake into clean, standardized, and documented dbt models.

The goal of the staging layer is not to apply complex business logic, but to prepare source data for analytics modeling.

## Source Schema

The source data comes from:

```text
CRM_SALES_ANALYTICS.RAW
```
## Target Schema

The staging models are created in:

CRM_SALES_ANALYTICS.STAGING
## Staging Models

|Model|Description|
|---|---|
|stg_regions|	Cleaned sales regions|
|stg_customers|	Cleaned customer companies|
|stg_products|	Cleaned product catalog|
|stg_sales_reps|	Cleaned sales representatives|
|stg_orders|	Cleaned customer orders|
|stg_order_items|	Cleaned order line items|
|stg_opportunities|	Cleaned commercial opportunities|

## Transformations Applied

The staging models apply light transformations:

- Rename columns
- Cast data types
- Trim text fields
- Standardize email fields
- Prepare clean column names for downstream models
- Tests

The staging layer includes dbt tests for:

- Primary key uniqueness
- Non-null identifiers
- Valid order statuses
- Valid payment statuses
- Valid opportunity stages
- Relationships between orders and customers
- Relationships between orders and sales representatives
- Relationships between order items and products

## Next Step

The next step is to build intermediate models and marts for business analysis.