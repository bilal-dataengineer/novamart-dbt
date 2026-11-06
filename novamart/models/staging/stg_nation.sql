{{ config(materialized='view') }}

SELECT
    N_NATIONKEY AS nation_id,
    N_NAME      AS nation_name,
    N_REGIONKEY AS region_id,
    N_COMMENT   AS comment

FROM {{ source('tpch', 'nation') }}