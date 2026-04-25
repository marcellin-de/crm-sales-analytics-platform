-- ============================================================
-- Create file format and internal stage
-- Project: CRM Sales Analytics Platform
-- ============================================================

USE WAREHOUSE CRM_ANALYTICS_WH;

USE DATABASE CRM_SALES_ANALYTICS;

USE SCHEMA RAW;

CREATE OR REPLACE FILE FORMAT CSV_FILE_FORMAT
    TYPE = CSV
    FIELD_DELIMITER = ','
    SKIP_HEADER = 1
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
    NULL_IF = ('', 'NULL', 'null')
    EMPTY_FIELD_AS_NULL = TRUE
    DATE_FORMAT = 'YYYY-MM-DD'
    TRIM_SPACE = TRUE;

CREATE
OR
REPLACE
    STAGE CRM_RAW_STAGE FILE_FORMAT = CSV_FILE_FORMAT;