{% snapshot wally_snapshot %}

{{
config(
  target_database='PC_DBT_DB',
  target_schema='snapshots',
  unique_key=['store', 'date'],
  strategy='check',
  check_cols=[
    'Temperature',
    'Fuel_Price',
    'MarkDown1',
    'MarkDown2',
    'MarkDown3',
    'MarkDown4',
    'MarkDown5',
    'CPI',
    'Unemployment',
    'IsHoliday'
  ]
)
}}

SELECT *
FROM {{ source('xfm', 'fact_TRANSFORM') }}

{% endsnapshot %}