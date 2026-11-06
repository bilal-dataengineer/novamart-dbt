{{ config(materialized='table') }}

WITH lineitem_revenue AS (

    SELECT
        order_id,
        SUM(revenue_before_tax) AS revenue_before_tax,
        SUM(revenue_with_tax) AS revenue_with_tax

    FROM {{ ref('stg_lineitem') }}

    GROUP BY order_id

)

SELECT
    o.order_id,
    o.customer_id,
    o.order_status,
    o.order_date,
    o.total_price,
    l.revenue_before_tax,
    l.revenue_with_tax

FROM {{ ref('stg_orders') }} AS o

INNER JOIN lineitem_revenue AS l
    ON o.order_id = l.order_id