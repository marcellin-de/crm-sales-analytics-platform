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
- Project Status

In progress.

## Next Steps

- Generate synthetic CRM data
- Load raw data into Snowflake
- Build dbt staging models
- Build fact and dimension tables
- Add dbt tests and documentation
- Build Power BI dashboard