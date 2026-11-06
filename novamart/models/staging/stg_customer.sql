{{ config(materialized='view') }}

SELECT
    C_CUSTKEY      AS customer_id,
    C_NAME         AS customer_name,
    C_ADDRESS      AS address,
    C_NATIONKEY    AS nation_id,
    C_PHONE        AS phone,
    C_ACCTBAL      AS account_balance,
    C_MKTSEGMENT   AS market_segment,
    C_COMMENT      AS comment

FROM {{ source('tpch', 'customer') }}