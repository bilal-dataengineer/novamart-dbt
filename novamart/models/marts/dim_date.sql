
{{ config(materialized='table') }}

WITH RECURSIVE date_spine (full_date, end_date) AS (

    -- Determine the date range from orders
    SELECT
        MIN(order_date),
        DATEADD(YEAR, 10, MAX(order_date))
    FROM {{ ref('stg_orders') }}

    UNION ALL

    -- Generate the next calendar day
    SELECT
        DATEADD(DAY, 1, full_date),
        end_date
    FROM date_spine
    WHERE full_date < end_date

)

SELECT
    TO_NUMBER(TO_CHAR(full_date, 'YYYYMMDD')) AS date_key,
    full_date,
    DAY(full_date) AS day,
    DAYNAME(full_date) AS day_name,
    MONTH(full_date) AS month,
    MONTHNAME(full_date) AS month_name,
    'Q' || QUARTER(full_date) AS quarter,
    YEAR(full_date) AS year,
    TO_CHAR(full_date, 'YYYY-MM') AS year_month

FROM date_spine
