{{ config({ "materialized":'table',

 "transient":true,

 "alias":'fact_TRANSFORM',

 "pre_hook": macros_copy_csv('fact_COPY'),

 "schema": 'SILVER'

})}}

 

WITH transform AS(

SELECT 

    Store AS Store

    ,Date AS Date

    ,Temperature AS Temperature

    ,Fuel_Price AS Fuel_Price

    ,MarkDown1 AS MarkDown1

    ,MarkDown2 AS MarkDown2

    ,MarkDown3 AS MarkDown3

    ,MarkDown4 AS MarkDown4

    ,MarkDown5 AS MarkDown5 

    ,CPI AS CPI

    ,Unemployment AS Unemployment

    ,IsHoliday AS IsHoliday

    ,'STANDARD' AS INSTNC_ST_NM

    ,INSERT_DTS AS INSERT_DTS

    ,UPDATE_DTS AS UPDATE_DTS

    ,SOURCE_FILE_NAME AS SOURCE_FILE_NAME

    ,SOURCE_FILE_ROW_NUMBER AS SOURCE_FILE_ROW_NUMBER

FROM {{source('source','fact_COPY')}}

)

SELECT *

FROM transform