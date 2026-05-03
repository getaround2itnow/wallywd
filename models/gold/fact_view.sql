{{ config({ "materialized":'view',

 "alias":'fact_VIEW',

 "schema": 'GOLD'

})}}

 

WITH view AS(

SELECT

    Store AS Store

    ,DBT_VALID_FROM AS VRSN_STRT_DTS

    ,COALESCE(DBT_VALID_TO , '9999-12-31 00:00:00.000') AS VRSN_END_DTS

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

    ,TIME_ZONE

    ,SOURCE_SYS_NAME

    ,INSTNC_ST_NM

    ,PROCESS_ID

    ,PROCESS_NAME

    ,INSERT_DTS

    ,UPDATE_DTS

FROM {{ref('wally_snapshot')}}

)

SELECT *

FROM view