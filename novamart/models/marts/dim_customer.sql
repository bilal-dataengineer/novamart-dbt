{{ config(materialized='table') }}

SELECT
    c.customer_id,
    c.customer_name,
    c.address,
    c.phone,
    c.account_balance,
    c.market_segment,

    n.nation_id,
    n.nation_name,

    r.region_id,
    r.region_name

FROM {{ ref('stg_customer') }} AS c

INNER JOIN {{ ref('stg_nation') }} AS n
    ON c.nation_id = n.nation_id

INNER JOIN {{ ref('stg_region') }} AS r
    ON n.region_id = r.region_id