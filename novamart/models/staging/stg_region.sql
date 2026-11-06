{{ config(materialized='view') }}

SELECT
    R_REGIONKEY AS region_id,
    R_NAME      AS region_name,
    R_COMMENT   AS comment

FROM {{ source('tpch', 'region') }}