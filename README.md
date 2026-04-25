# CRM Sales Analytics Platform

## Overview

This project is an end-to-end analytics engineering project that transforms raw CRM sales data into clean, tested, and business-ready analytics models.

The goal is to help a sales organization monitor revenue, customers, products, regions, sales representatives, and opportunities through a reliable data pipeline and Power BI dashboard.

## Business Problem

The company needs a centralized analytics layer to answer key sales questions:

- How much revenue are we generating?
- Which customers and regions are the most profitable?
- Which products are driving sales?
- Which sales representatives are performing best?
- What is our opportunity conversion rate?
- How is revenue evolving over time?

## Tech Stack

- Snowflake
- dbt
- SQL
- Python
- Power BI
- GitHub

## Architecture

Raw CRM data is generated as CSV files, loaded into Snowflake, transformed using dbt, and visualized in Power BI.

```text
CSV files
   ↓
Snowflake RAW schema
   ↓
dbt staging models
   ↓
dbt intermediate models
   ↓
dbt marts
   ↓
Power BI dashboard
```

## Data Sources

The project uses synthetic CRM data:

- customers
- products
- sales representatives
- regions
- orders
- order items
- opportunities

## Data Generation

Synthetic CRM data is generated with a Python script located in:

```text
scripts/generate_crm_data.py
```

To generate the raw CSV files:

```bash
uv run scripts/generate_crm_data.py
```

The files are generated in:

```text
data/raw/
```

## Snowflake RAW Layer

The raw CSV files are loaded into Snowflake under the `RAW` schema.

```text
CRM_SALES_ANALYTICS.RAW.RAW_CUSTOMERS
CRM_SALES_ANALYTICS.RAW.RAW_PRODUCTS
CRM_SALES_ANALYTICS.RAW.RAW_REGIONS
CRM_SALES_ANALYTICS.RAW.RAW_SALES_REPS
CRM_SALES_ANALYTICS.RAW.RAW_ORDERS
CRM_SALES_ANALYTICS.RAW.RAW_ORDER_ITEMS
CRM_SALES_ANALYTICS.RAW.RAW_OPPORTUNITIES
```

## dbt Staging Layer

The project uses dbt to transform raw CRM data into clean staging models.

Staging models are located in:

```text
dbt/crm_sales_analytics/models/staging/crm/
```

The staging layer includes:

- source definitions
- cleaned column names
- type casting
- basic standardization
- dbt tests
- dbt documentation

To run the staging models:

```bash
cd dbt/crm_sales_analytics
dbt run --select staging
dbt test --select staging
```

## dbt Intermediate and Marts Layer

The project uses dbt to build analytics-ready models from the staging layer.

### Intermediate Models

Intermediate models apply reusable joins and business logic:

- `int_order_items_enriched`
- `int_opportunities_enriched`
- `int_customer_order_metrics`

### Core Marts

The core marts follow a star schema design:

- `dim_customers`
- `dim_products`
- `dim_regions`
- `dim_sales_reps`
- `dim_dates`
- `fct_order_items`
- `fct_opportunities`

### Business Marts

Business marts are designed for Power BI reporting:

- `mart_sales_performance`
- `mart_customer_revenue`
- `mart_product_performance`

### Main Business Rule

Recognized revenue is calculated only for completed and paid orders:

```text
recognized_revenue = quantity * unit_price * (1 - discount)
```

To build the models:

```bash
cd dbt/crm_sales_analytics
dbt build
```

## Key Metrics

- Total Revenue
- Monthly Revenue
- Average Order Value
- Revenue by Region
- Revenue by Product
- Revenue by Sales Representative
- Customer Lifetime Value
- Opportunity Conversion Rate
- Pipeline Value

## Project Status

In progress.

## Next Steps

- Generate synthetic CRM data
- Load raw data into Snowflake
- Build dbt staging models
- Build fact and dimension tables
- Add dbt tests and documentation
- Build Power BI dashboard