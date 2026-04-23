{% test assert_valid_email(model, column_name) %}
    select {{ column_name }}
    from {{ model }}
    where not {{ is_valid_email_format(column_name) }}
{% endtest %}

{% macro is_valid_email_format(column_name) %}
    {{ return(adapter.dispatch('is_valid_email_format', 'easy_shop')(column_name)) }}
{% endmacro %}

{% macro default__is_valid_email_format(column_name) %}
    {{ column_name }} like '%@%.%'
{% endmacro %}

{% macro bigquery__is_valid_email_format(column_name) %}
    REGEXP_CONTAINS({{ column_name }}, r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
{% endmacro %}

{% macro spark__is_valid_email_format(column_name) %}
    {{ column_name }} RLIKE '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$'
{% endmacro %}

{% macro postgres__is_valid_email_format(column_name) %}
    {{ column_name }} ~ '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
{% endmacro %}
