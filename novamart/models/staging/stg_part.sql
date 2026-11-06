{{ config(materialized='view') }}

SELECT
    P_PARTKEY     AS product_id,
    P_NAME        AS product_name,
    P_MFGR        AS manufacturer,
    P_BRAND       AS brand,
    P_TYPE        AS product_type,
    P_SIZE        AS product_size,
    P_CONTAINER   AS container,
    P_RETAILPRICE AS retail_price,
    P_COMMENT     AS comment

FROM {{ source('tpch', 'part') }}