# Data Quality Strategy

## Overview

This project includes multiple layers of data quality checks using dbt.

The goal is to ensure that the analytics models are reliable, consistent, and aligned with business rules.

## Test Types

The project uses:

- Built-in dbt tests
- Custom generic tests
- Singular business tests
- Source freshness checks

## Built-in Tests

Built-in tests validate:

- primary key uniqueness
- non-null identifiers
- accepted values
- referential integrity

## Custom Generic Tests

Custom tests were added for reusable business rules:

- non_negative
- positive_value
- between_zero_and_one

## Singular Business Tests

Singular tests validate project-specific business assumptions:

- recognized revenue logic
- no future order dates
- opportunity close date after created date

## Freshness

A raw load audit table tracks when source data was loaded.

The freshness check validates whether the raw load audit table is recent enough.

## Incremental Models

Fact tables are configured as incremental models to simulate scalable transformation patterns.

## Snapshots

The customer snapshot tracks historical changes in customer attributes using dbt snapshots.

## Why This Matters

These checks help ensure that downstream dashboards are based on trusted data.
