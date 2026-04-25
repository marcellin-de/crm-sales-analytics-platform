-- ============================================================
-- Validate RAW data load
-- Project: CRM Sales Analytics Platform
-- ============================================================

USE WAREHOUSE CRM_ANALYTICS_WH;

USE DATABASE CRM_SALES_ANALYTICS;

USE SCHEMA RAW;

-- Row counts
SELECT 'RAW_REGIONS' AS table_name, COUNT(*) AS row_count
FROM RAW_REGIONS
UNION ALL
SELECT 'RAW_CUSTOMERS', COUNT(*)
FROM RAW_CUSTOMERS
UNION ALL
SELECT 'RAW_PRODUCTS', COUNT(*)
FROM RAW_PRODUCTS
UNION ALL
SELECT 'RAW_SALES_REPS', COUNT(*)
FROM RAW_SALES_REPS
UNION ALL
SELECT 'RAW_ORDERS', COUNT(*)
FROM RAW_ORDERS
UNION ALL
SELECT 'RAW_ORDER_ITEMS', COUNT(*)
FROM RAW_ORDER_ITEMS
UNION ALL
SELECT 'RAW_OPPORTUNITIES', COUNT(*)
FROM RAW_OPPORTUNITIES;

-- Preview orders
SELECT * FROM RAW_ORDERS LIMIT 10;

-- Preview order items
SELECT * FROM RAW_ORDER_ITEMS LIMIT 10;

-- Check order revenue calculation
SELECT oi.order_item_id, oi.order_id, oi.product_id, oi.quantity, oi.unit_price, oi.discount, ROUND(
        oi.quantity * oi.unit_price * (1 - oi.discount), 2
    ) AS net_revenue
FROM RAW_ORDER_ITEMS oi
LIMIT 20;

-- Check date range
SELECT
    MIN(order_date) AS min_order_date,
    MAX(order_date) AS max_order_date
FROM RAW_ORDERS;

-- Check order statuses
SELECT
    order_status,
    COUNT(*) AS number_of_orders
FROM RAW_ORDERS
GROUP BY
    order_status
ORDER BY number_of_orders DESC;

-- Check opportunity stages
SELECT
    stage,
    COUNT(*) AS number_of_opportunities,
    ROUND(SUM(expected_revenue), 2) AS total_expected_revenue
FROM RAW_OPPORTUNITIES
GROUP BY
    stage
ORDER BY total_expected_revenue DESC;