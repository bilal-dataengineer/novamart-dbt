
{{ config(materialized='view') }}

SELECT
    f.customer_id,
    c.customer_name,
    c.market_segment,

    COUNT(DISTINCT f.order_id) AS total_orders,

    SUM(f.revenue_before_tax) AS total_revenue_before_tax,
    SUM(f.revenue_with_tax) AS total_revenue_with_tax,

    SUM(f.quantity) AS total_quantity_purchased

FROM {{ ref('fct_revenue') }} AS f

INNER JOIN {{ ref('dim_customer') }} AS c
    ON f.customer_id = c.customer_id

GROUP BY
    f.customer_id,
    c.customer_name,
    c.market_segment

ORDER BY
    total_revenue_before_tax DESC

LIMIT 5
