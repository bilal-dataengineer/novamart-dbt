
{{ config(materialized='view') }}

WITH order_fulfillment AS (

    SELECT
        o.order_id,
        o.order_priority,
        o.order_date,

        MAX(l.ship_date) AS final_ship_date,
        MAX(l.receipt_date) AS final_receipt_date

    FROM {{ ref('stg_orders') }} AS o

    INNER JOIN {{ ref('stg_lineitem') }} AS l
        ON o.order_id = l.order_id

    GROUP BY
        o.order_id,
        o.order_priority,
        o.order_date

)

SELECT
    order_priority,

    COUNT(*) AS total_orders,

    ROUND(
        AVG(DATEDIFF('day', order_date, final_ship_date)), 2
    ) AS avg_days_order_to_ship,

    ROUND(
        AVG(DATEDIFF('day', order_date, final_receipt_date)), 2
    ) AS avg_days_order_to_receipt

FROM order_fulfillment

GROUP BY order_priority
