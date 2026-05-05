{{ config(
    materialized='table',
    transient=true,
    alias='fact_TRANSFORM',
    pre_hook=macros_copy_csv('fact_COPY'),
    schema='SILVER'
) }}

WITH source_data AS (

    SELECT 
        Store,
        Date,
        CAST(Temperature AS NUMBER(10,2)) AS Temperature,
        CAST(Fuel_Price AS NUMBER(10,3)) AS Fuel_Price,
        CAST(MarkDown1 AS NUMBER(10,2)) AS MarkDown1,
        CAST(MarkDown2 AS NUMBER(10,2)) AS MarkDown2,
        CAST(MarkDown3 AS NUMBER(10,2)) AS MarkDown3,
        CAST(MarkDown4 AS NUMBER(10,2)) AS MarkDown4,
        CAST(MarkDown5 AS NUMBER(10,2)) AS MarkDown5,
        CAST(CPI AS NUMBER(18,7)) AS CPI,
        CAST(Unemployment AS NUMBER(10,3)) AS Unemployment,
        IsHoliday,
        INSERT_DTS,
        UPDATE_DTS,
        SOURCE_FILE_NAME,
        SOURCE_FILE_ROW_NUMBER
    FROM {{ source('source','fact_COPY') }}

),

deduped AS (



    SELECT *,
        ROW_NUMBER() OVER (
        PARTITION BY Store, Date
        ORDER BY INSERT_DTS DESC,
        SOURCE_FILE_ROW_NUMBER DESC,
        SOURCE_FILE_NAME DESC
    ) AS rn
    FROM source_data

)

SELECT *
FROM deduped
WHERE rn = 1

