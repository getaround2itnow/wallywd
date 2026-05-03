{{ config(
    materialized='table',
    transient=true,
    alias='fact_TRANSFORM',
    pre_hook=macros_copy_csv('fact_COPY'),
    schema='SILVER'
) }}

WITH transform AS (

    SELECT 
        Store,
        Date,
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
        UPDATE_DTS,
        SOURCE_FILE_NAME,
        SOURCE_FILE_ROW_NUMBER
    FROM {{ source('source','fact_COPY') }}

)

SELECT *
FROM transform