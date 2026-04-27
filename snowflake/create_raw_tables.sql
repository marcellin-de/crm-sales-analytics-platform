-- ============================================================
-- Create RAW tables
-- Project: CRM Sales Analytics Platform
-- ============================================================

USE WAREHOUSE CRM_ANALYTICS_WH;

USE DATABASE CRM_SALES_ANALYTICS;

USE SCHEMA RAW;

CREATE TABLE IF NOT EXISTS RAW_REGIONS (
    region_id INTEGER,
    region_name VARCHAR,
    country VARCHAR
);

CREATE TABLE IF NOT EXISTS RAW_CUSTOMERS (
    customer_id INTEGER,
    customer_name VARCHAR,
    industry VARCHAR,
    company_size VARCHAR,
    country VARCHAR,
    region_id INTEGER,
    created_at DATE
);

CREATE TABLE IF NOT EXISTS RAW_PRODUCTS (
    product_id INTEGER,
    product_name VARCHAR,
    category VARCHAR,
    unit_price NUMBER (10, 2),
    created_at DATE
);

CREATE TABLE IF NOT EXISTS RAW_SALES_REPS (
    sales_rep_id INTEGER,
    sales_rep_name VARCHAR,
    email VARCHAR,
    region_id INTEGER,
    hire_date DATE
);

CREATE TABLE IF NOT EXISTS RAW_ORDERS (
    order_id INTEGER,
    customer_id INTEGER,
    sales_rep_id INTEGER,
    order_date DATE,
    order_status VARCHAR,
    payment_status VARCHAR
);

CREATE TABLE IF NOT EXISTS RAW_ORDER_ITEMS (
    order_item_id INTEGER,
    order_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    unit_price NUMBER (10, 2),
    discount NUMBER (5, 2)
);

CREATE TABLE IF NOT EXISTS RAW_OPPORTUNITIES (
    opportunity_id INTEGER,
    customer_id INTEGER,
    sales_rep_id INTEGER,
    created_date DATE,
    close_date DATE,
    stage VARCHAR,
    expected_revenue NUMBER (12, 2),
    probability NUMBER (5, 2)
);
