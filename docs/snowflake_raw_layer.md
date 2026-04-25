# Snowflake RAW Layer

## Overview

This document describes the RAW layer of the CRM Sales Analytics Platform.

The RAW layer stores source data with minimal transformation. Its purpose is to preserve the original structure of the source files before applying analytics transformations with dbt.

## Database Structure

```text
CRM_SALES_ANALYTICS
├── RAW
├── STAGING
└── MARTS
```

# RAW Tables
|Table	|Source File|Description
|-------|-------------|------------
|RAW_REGIONS|regions.csv|Sales regions
|RAW_CUSTOMERS|customers.csv|Customer companies
|RAW_PRODUCTS|products.csv|Product catalog
|RAW_SALES_REPS|sales_reps.csv|Sales representatives
|RAW_ORDERS|orders.csv|Customer orders
|RAW_ORDER_ITEMS|order_items.csv|Order line items
|RAW_OPPORTUNITIES|opportunities.csv|Commercial opportunities

## Design Principle

**The RAW layer should stay close to the original source data.**

Business logic should not be applied directly in the RAW layer. Transformations, joins, calculations, and business rules will be handled later in dbt.

## Validation Checks

After loading the data, the following checks are performed:

- Row count by table
- Sample record preview
- Date range validation
- Order status distribution
- Opportunity stage distribution
- Revenue calculation preview

## Next Step

The next step is to configure dbt and create staging models that clean and standardize the RAW data.