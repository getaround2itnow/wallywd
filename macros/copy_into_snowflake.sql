{% macro macros_copy_csv(table_nm) %}

    {{ return(
        
        "COPY INTO " ~ var('rawhist_db') ~ "." ~ var('wrk_schema') ~ "." ~ table_nm ~ " \n" ~
        "FROM (\n" ~
        "    SELECT\n" ~
        "        $1 AS Store,\n" ~
        "        $2 AS Date,\n" ~
        "        NULLIF($3, 'NA') AS Temperature,\n" ~
        "        NULLIF($4, 'NA') AS Fuel_Price,\n" ~
        "        NULLIF($5, 'NA') AS MarkDown1,\n" ~
        "        NULLIF($6, 'NA') AS MarkDown2,\n" ~
        "        NULLIF($7, 'NA') AS MarkDown3,\n" ~
        "        NULLIF($8, 'NA') AS MarkDown4,\n" ~
        "        NULLIF($9, 'NA') AS MarkDown5,\n" ~
        "        NULLIF($10, 'NA') AS CPI,\n" ~
        "        NULLIF($11, 'NA') AS Unemployment,\n" ~
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