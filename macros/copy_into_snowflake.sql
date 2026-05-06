{% macro macros_copy_csv(table_nm) %}

    {{ return(
        
        "COPY INTO " ~ var('rawhist_db') ~ "." ~ var('wrk_schema') ~ "." ~ table_nm ~ " \n" ~
        "FROM (\n" ~
        "    SELECT\n" ~
        "        $1 AS Store,\n" ~
        "        $2 AS Date,\n" ~
        "        NULLIF($3, 'NA')::NUMBER(10,2) AS Temperature,\n" ~
        "        NULLIF($4, 'NA')::NUMBER(10,3) AS Fuel_Price,\n" ~
        "        NULLIF($5, 'NA')::NUMBER(10,2) AS MarkDown1,\n" ~
        "        NULLIF($6, 'NA')::NUMBER(10,2) AS MarkDown2,\n" ~
        "        NULLIF($7, 'NA')::NUMBER(10,2) AS MarkDown3,\n" ~
        "        NULLIF($8, 'NA')::NUMBER(10,2) AS MarkDown4,\n" ~
        "        NULLIF($9, 'NA')::NUMBER(10,2) AS MarkDown5,\n" ~
        "        NULLIF($10, 'NA')::NUMBER(18,7) AS CPI,\n" ~
        "        NULLIF($11, 'NA')::NUMBER(10,3) AS Unemployment,\n" ~
        "        $12 AS IsHoliday,\n" ~
        "        CURRENT_TIMESTAMP() AS INSERT_DTS,\n" ~
        "        CURRENT_TIMESTAMP() AS UPDATE_DTS,\n" ~
        "        metadata$filename AS SOURCE_FILE_NAME,\n" ~
        "        metadata$file_row_number AS SOURCE_FILE_ROW_NUMBER\n" ~
        "    FROM @" ~ var('stage_name') ~ "\n" ~
        ")\n" ~
        "FILE_FORMAT = " ~ var('file_format_csv') ~ "\n" ~
        "PURGE = " ~ var('purge_status') ~ "\n" ~
        "FORCE = TRUE;"
    ) }}
{% endmacro %}