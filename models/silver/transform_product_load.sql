{{ config(
  materialized='table',
  transient=true,
  alias='fact_TRANSFORM',
  schema='SILVER',
  pre_hook=macros_copy_csv('fact_COPY')
) }}

WITH ranked AS (

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
  SOURCE_FILE_ROW_NUMBER,

  ROW_NUMBER() OVER (
    PARTITION BY Store, Date
    ORDER BY
      UPDATE_DTS DESC,
      INSERT_DTS DESC,
      SOURCE_FILE_NAME DESC,
      SOURCE_FILE_ROW_NUMBER DESC
  ) AS rn

FROM {{ source('source','fact_COPY') }}

)

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

FROM ranked
WHERE rn = 1