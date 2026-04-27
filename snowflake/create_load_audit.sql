-- ============================================================
-- Create RAW load audit table
-- Project: CRM Sales Analytics Platform
-- ============================================================

USE WAREHOUSE CRM_ANALYTICS_WH;

USE DATABASE CRM_SALES_ANALYTICS;

USE SCHEMA RAW;

CREATE TABLE IF NOT EXISTS RAW_LOAD_AUDIT (
    table_name VARCHAR,
    loaded_at TIMESTAMP_NTZ
);

MERGE INTO RAW_LOAD_AUDIT AS target
USING (
    SELECT 'RAW_REGIONS' AS table_name, CURRENT_TIMESTAMP() AS loaded_at
    UNION ALL
    SELECT 'RAW_CUSTOMERS', CURRENT_TIMESTAMP()
    UNION ALL
    SELECT 'RAW_PRODUCTS', CURRENT_TIMESTAMP()
    UNION ALL
    SELECT 'RAW_SALES_REPS', CURRENT_TIMESTAMP()
    UNION ALL
    SELECT 'RAW_ORDERS', CURRENT_TIMESTAMP()
    UNION ALL
    SELECT 'RAW_ORDER_ITEMS', CURRENT_TIMESTAMP()
    UNION ALL
    SELECT 'RAW_OPPORTUNITIES', CURRENT_TIMESTAMP()
) AS source
ON target.table_name = source.table_name
WHEN MATCHED THEN
    UPDATE SET loaded_at = source.loaded_at
WHEN NOT MATCHED THEN
    INSERT (table_name, loaded_at)
    VALUES (source.table_name, source.loaded_at);
