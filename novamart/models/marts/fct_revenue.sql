
{{ config(materialized='table') }}

SELECT
    -- Dimension keys
    o.order_id,
    l.line_number,
    o.customer_id,
    l.part_id AS product_id,

    TO_NUMBER(TO_CHAR(o.order_date, 'YYYYMMDD')) AS date_key,

    -- Order information
    o.order_status,
    o.order_date,

    -- Sales measures
    l.quantity,
    l.extended_price,
    l.discount,
    l.tax,

    l.revenue_before_tax,
    l.revenue_with_tax

FROM {{ ref('stg_orders') }} AS o

INNER JOIN {{ ref('stg_lineitem') }} AS l
    ON o.order_id = l.order_id
