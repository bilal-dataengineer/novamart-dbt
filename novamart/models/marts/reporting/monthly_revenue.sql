
{{ config(materialized='view') }}

SELECT
    d.year,
    d.month,
    d.month_name,
    c.region_name,
    c.nation_name,

    SUM(f.revenue_before_tax) AS total_revenue_before_tax,
    SUM(f.revenue_with_tax) AS total_revenue_with_tax,

    SUM(f.quantity) AS total_quantity_sold,
    COUNT(DISTINCT f.order_id) AS total_orders

FROM {{ ref('fct_revenue') }} AS f

INNER JOIN {{ ref('dim_date') }} AS d
    ON f.date_key = d.date_key

INNER JOIN {{ ref('dim_customer') }} AS c
    ON f.customer_id = c.customer_id

GROUP BY
    d.year,
    d.month,
    d.month_name,
    c.region_name,
    c.nation_name
