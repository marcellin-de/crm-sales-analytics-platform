# Data Generation

## Overview

The CRM dataset is synthetic and generated with Python.

The goal is to simulate a realistic B2B sales environment with customers, products, sales representatives, regions, orders, order items, and opportunities.

## Generated Tables

| File | Description |
|---|---|
| regions.csv | Geographic sales regions |
| customers.csv | Customer companies |
| products.csv | Product catalog |
| sales_reps.csv | Sales representatives |
| orders.csv | Customer orders |
| order_items.csv | Order line items |
| opportunities.csv | Commercial opportunities |

## Data Volumes

| File | Approximate Rows |
|---|---:|
| regions.csv | 8 |
| customers.csv | 500 |
| products.csv | 30 |
| sales_reps.csv | 20 |
| orders.csv | 3,000 |
| order_items.csv | ~9,000 |
| opportunities.csv | 1,200 |

## Validation Rules

The generation script validates:

- Primary key uniqueness
- Referential integrity between orders and customers
- Referential integrity between orders and sales representatives
- Referential integrity between order items and products
- Referential integrity between opportunities and customers
- Positive quantities
- Positive unit prices
- Non-negative discounts

## Date Range

The generated data covers the period from 2023-01-01 to 2025-12-31.