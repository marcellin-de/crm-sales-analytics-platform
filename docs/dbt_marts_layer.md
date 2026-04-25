# dbt Marts Layer

## Overview

The marts layer transforms cleaned staging models into analytics-ready fact tables, dimension tables, and business marts.

This layer is designed for BI consumption, especially Power BI.

## Modeling Approach

The project uses a star schema approach.

Fact tables store business events such as order items and opportunities.

Dimension tables store descriptive entities such as customers, products, sales representatives, regions, and dates.

## Core Dimensions

| Model | Description |
|---|---|
| dim_customers | Customer dimension enriched with customer order metrics |
| dim_products | Product dimension |
| dim_sales_reps | Sales representative dimension |
| dim_regions | Region dimension |
| dim_dates | Date dimension |

## Fact Tables

| Model | Grain |
|---|---|
| fct_order_items | One row per order item |
| fct_opportunities | One row per opportunity |

## Business Marts

| Model | Description |
|---|---|
| mart_sales_performance | Monthly sales and opportunity performance by sales representative |
| mart_customer_revenue | Customer-level revenue analysis |
| mart_product_performance | Product-level sales analysis |

## Business Logic

Recognized revenue is calculated only when:

```text
order_status = Completed
payment_status = Paid
```

The formula is:

```text
recognized_revenue = quantity * unit_price * (1 - discount)
```

For non-completed or unpaid orders, recognized revenue is set to 0.

## Key Metrics

The marts layer supports the following metrics:

- Total revenue
- Recognized revenue
- Gross revenue
- Discount amount
- Average order value
- Customer lifetime value
- Sales representative performance
- Product performance
- Pipeline value
- Weighted pipeline value
- Opportunity win rate

## Next Step

Connect Power BI to the marts layer and build an executive sales dashboard.