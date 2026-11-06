{{ config(materialized='view') }}

SELECT
    p.product_id,
    p.product_name,
    p.brand,
    p.manufacturer,
    p.product_type,

    SUM(f.quantity) AS total_quantity_sold,
    SUM(f.revenue_before_tax) AS total_revenue_before_tax,
    SUM(f.revenue_with_tax) AS total_revenue_with_tax,
    COUNT(DISTINCT f.order_id) AS total_orders

FROM {{ ref('fct_revenue') }} AS f

INNER JOIN {{ ref('dim_product') }} AS p
    ON f.product_id = p.product_id

GROUP BY
    p.product_id,
    p.product_name,
    p.brand,
    p.manufacturer,
    p.product_type