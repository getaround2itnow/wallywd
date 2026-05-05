{{ config({
    "materialized": 'view',
    "alias": 'fact_VIEW',
    "schema": 'GOLD'
}) }}

WITH base AS (

    SELECT
        Store,
        DBT_VALID_FROM AS VRSN_STRT_DTS,
        COALESCE(DBT_VALID_TO, TO_TIMESTAMP('9999-12-31 00:00:00')) AS VRSN_END_DTS,

        CASE 
            WHEN DBT_VALID_TO IS NULL THEN TRUE
            ELSE FALSE
        END AS IS_CURRENT,

        Date,
        SOURCE_FILE_ROW_NUMBER,
        Temperature,
        Fuel_Price,
        MarkDown1,
        MarkDown2,
        MarkDown3,
        MarkDown4,
        MarkDown5,
        CPI,
        Unemployment,
        IsHoliday,
        INSERT_DTS,
        UPDATE_DTS

    FROM {{ ref('wally_snapshot') }}
),

ranked AS (

    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY Store, Date
            ORDER BY VRSN_STRT_DTS DESC, SOURCE_FILE_ROW_NUMBER DESC
        ) AS rn
    FROM base
    WHERE IS_CURRENT = TRUE

)

SELECT *
FROM ranked
WHERE rn = 1