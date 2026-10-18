{% macro to_21st_century_date(date_column_name) -%}

    case
        when {{ date_column_name }} >= '2000-01-01'::date
            then {{ date_column_name }}
        else ({{ date_column_name }} + interval 2000 year)::date
    end

{%- endmacro %}
