{{ config(materialized='table') }}

SELECT
    order_id,
    revenue_before_tax,
    revenue_with_tax

FROM {{ ref('int_order_revenue') }}