{% macro get_email_provider(email) %}
    {% set providers = ['gmail', 'hotmail', 'outlook', 'apple'] %}
    case
        {% for provider in providers %}
            when CONTAINS_SUBSTR({{ email }}, '{{ provider }}') then '{{ provider }}'
        {% endfor %}
        else 'other'
    end
{% endmacro %}
