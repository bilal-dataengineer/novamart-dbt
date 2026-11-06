
{{ config(materialized='view') }}

SELECT
    order_id,

    COUNT(*) AS late_line_items,

    MAX(
        DATEDIFF('day', commit_date, ship_date)
    ) AS days_late,

    SUM(revenue_with_tax) AS affected_revenue

FROM {{ ref('stg_lineitem') }}

WHERE ship_date > commit_date

GROUP BY order_id
