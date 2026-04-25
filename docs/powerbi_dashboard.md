# Power BI Sales Analytics Dashboard

## Overview

This dashboard provides an executive and operational view of CRM sales performance.

It connects to the Snowflake MARTS layer and uses a star schema model to analyze revenue, customers, products, sales representatives, regions, and opportunities.

## Data Source

The dashboard uses the following Snowflake schema:

```text
CRM_SALES_ANALYTICS.MARTS
```

### Imported Tables

- `DIM_CUSTOMERS`
- `DIM_PRODUCTS`
- `DIM_REGIONS`
- `DIM_SALES_REPS`
- `DIM_DATES`
- `FCT_ORDER_ITEMS`
- `FCT_OPPORTUNITIES`
- `MART_SALES_PERFORMANCE`
- `MART_CUSTOMER_REVENUE`
- `MART_PRODUCT_PERFORMANCE`

## Dashboard Pages

1. **Executive Overview**

	Provides a high-level view of revenue, orders, customers, regions, and pipeline.

2. **Sales Performance**

	Analyzes sales representative performance, revenue contribution, opportunity conversion, and pipeline value.

3. **Customer Analysis**

	Identifies top customers, inactive customers, customer lifetime value, revenue by industry, and revenue by company size.

4. **Product Performance**

	Analyzes revenue by product, product category, discount impact, and product sales trends.

## Main Measures

- Total Recognized Revenue
- Total Gross Revenue
- Total Net Revenue
- Average Order Value
- Total Orders
- Total Customers
- Active Customers
- Inactive Customers
- Total Opportunities
- Won Opportunities
- Lost Opportunities
- Opportunity Win Rate
- Weighted Pipeline Value

## Business Rule

Recognized revenue is counted only when:

```text
order_status = Completed
payment_status = Paid
```

## Model Design

The dashboard uses a star schema with two main fact tables:

| Fact Table | Grain |
|---|---|
| FCT_ORDER_ITEMS | One row per order item |
| FCT_OPPORTUNITIES | One row per commercial opportunity |

The main dimensions are:

- `DIM_CUSTOMERS`
- `DIM_PRODUCTS`
- `DIM_SALES_REPS`
- `DIM_REGIONS`
- `DIM_DATES`

