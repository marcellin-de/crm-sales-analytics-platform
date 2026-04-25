# Metrics Validation

## Overview

This document explains how key dashboard metrics were validated against the Snowflake MARTS layer.

The goal is to ensure that Power BI metrics match the source-of-truth tables created by dbt.

## Revenue Validation

Power BI measure:

```DAX
Total Recognized Revenue =
SUM('FCT_ORDER_ITEMS'[RECOGNIZED_REVENUE])
```

Snowflake validation query:

```sql
SELECT
	ROUND(SUM(RECOGNIZED_REVENUE), 2) AS total_recognized_revenue
FROM CRM_SALES_ANALYTICS.MARTS.FCT_ORDER_ITEMS;
```

## Orders Validation

Power BI measure:

```DAX
Total Orders =
DISTINCTCOUNT('FCT_ORDER_ITEMS'[ORDER_ID])
```

Snowflake validation query:

```sql
SELECT
	COUNT(DISTINCT ORDER_ID) AS total_orders
FROM CRM_SALES_ANALYTICS.MARTS.FCT_ORDER_ITEMS;
```

## Customers Validation

Power BI measure:

```DAX
Total Customers =
DISTINCTCOUNT('DIM_CUSTOMERS'[CUSTOMER_ID])
```

Snowflake validation query:

```sql
SELECT
	COUNT(DISTINCT CUSTOMER_ID) AS total_customers
FROM CRM_SALES_ANALYTICS.MARTS.DIM_CUSTOMERS;
```

## Opportunities Validation

Power BI measure:

```DAX
Won Opportunities =
CALCULATE(
	DISTINCTCOUNT('FCT_OPPORTUNITIES'[OPPORTUNITY_ID]),
	'FCT_OPPORTUNITIES'[IS_WON] = TRUE()
)
```

Snowflake validation query:

```sql
SELECT
	COUNT(DISTINCT OPPORTUNITY_ID) AS won_opportunities
FROM CRM_SALES_ANALYTICS.MARTS.FCT_OPPORTUNITIES
WHERE IS_WON = TRUE;
```

## Opportunity Win Rate

Power BI measure:

```DAX
Opportunity Win Rate =
DIVIDE(
	[Won Opportunities],
	[Won Opportunities] + [Lost Opportunities]
)
```

Snowflake validation query:

```sql
SELECT
	COUNT(DISTINCT CASE WHEN IS_WON THEN OPPORTUNITY_ID END) AS won_opportunities,
	COUNT(DISTINCT CASE WHEN IS_LOST THEN OPPORTUNITY_ID END) AS lost_opportunities,
	COUNT(DISTINCT CASE WHEN IS_WON THEN OPPORTUNITY_ID END)
		/ NULLIF(
			COUNT(DISTINCT CASE WHEN IS_WON THEN OPPORTUNITY_ID END)
			+ COUNT(DISTINCT CASE WHEN IS_LOST THEN OPPORTUNITY_ID END),
			0
		) AS opportunity_win_rate
FROM CRM_SALES_ANALYTICS.MARTS.FCT_OPPORTUNITIES;
```

## Validation Principle

Power BI is used for visualization, but Snowflake MARTS tables remain the source of truth for metric validation.

