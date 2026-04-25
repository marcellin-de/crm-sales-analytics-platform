# Project Summary

## Project Name

CRM Sales Analytics Platform

## Role Simulated

Analytics Engineer / Data Analyst

## Objective

The objective of this project is to build an end-to-end analytics platform that transforms raw CRM sales data into reliable, tested, and business-ready datasets for reporting and decision-making.

## Business Context

A B2B company wants to improve visibility into sales performance, customer revenue, product performance, regional performance, and sales pipeline conversion.

The company needs a centralized analytics layer to answer questions such as:

- How much revenue are we generating?
- Which products and regions drive the most revenue?
- Which sales representatives perform best?
- Which customers generate the most value?
- What is our opportunity win rate?
- What is the value of our sales pipeline?

## Technical Solution

The solution follows a modern analytics engineering workflow:

1. Generate synthetic CRM data with Python.
2. Load raw CSV files into Snowflake.
3. Create a RAW schema to preserve source data.
4. Use dbt to clean and standardize source tables.
5. Build intermediate models for reusable business logic.
6. Build dimension and fact tables using a star schema.
7. Create business marts for sales, customer, and product analysis.
8. Connect Power BI to the Snowflake MARTS layer.
9. Build an interactive sales analytics dashboard.

## Tech Stack

- Python
- Snowflake
- SQL
- dbt
- Power BI
- GitHub

## Main Deliverables

- Synthetic CRM dataset
- Snowflake RAW layer
- dbt staging models
- dbt intermediate models
- dbt marts layer
- Star schema
- Power BI dashboard
- Project documentation
- Data quality tests

## Key Business Metrics

- Total recognized revenue
- Gross revenue
- Net revenue
- Average order value
- Total orders
- Customer lifetime value
- Opportunity win rate
- Weighted pipeline value
- Revenue by product
- Revenue by region
- Revenue by sales representative

## Main Business Rule

Recognized revenue is counted only when an order is completed and paid.

```text
recognized_revenue = quantity * unit_price * (1 - discount)
```

If the order is not completed or the payment is not paid, recognized revenue is set to 0.

## Outcome

The final dashboard allows business users to monitor revenue, customer performance, product performance, regional performance, sales representative performance, and opportunity conversion.

