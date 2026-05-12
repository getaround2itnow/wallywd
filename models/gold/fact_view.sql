{{ config(
  materialized='table',
  database='WALLYWD_S3_DB',
  schema='GOLD',
  alias='fact_SCD2'
) }}

SELECT

  MD5(
    CONCAT(
      Store,
      '|',
      Date,
      '|',
      DBT_VALID_FROM
    )
  ) AS STORE_SIM_ID,

  Store,
  Date,

  DBT_VALID_FROM AS ValidFrom,

  COALESCE(
    DBT_VALID_TO,
    TO_DATE('9999-12-31')
  ) AS ValidTo,

  CASE
    WHEN DBT_VALID_TO IS NULL THEN TRUE
    ELSE FALSE
  END AS IsCurrent,

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

CASE
    WHEN DBT_VALID_TO IS NULL
        THEN DBT_VALID_FROM
    ELSE DBT_VALID_TO
END AS UPDATE_DTS

FROM {{ ref('wally_snapshot') }}