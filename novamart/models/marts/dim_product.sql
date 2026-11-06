{{ config(materialized='table') }}

SELECT
    product_id,
    product_name,
    manufacturer,
    brand,
    product_type,
    product_size,
    container,
    retail_price
FROM {{ ref('stg_part') }}