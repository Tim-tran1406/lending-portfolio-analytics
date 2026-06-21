{#
  By default dbt PREFIXES custom schema names with the target schema
  (e.g. "public_staging"). This override makes dbt use our schema names
  exactly as written ("staging", "marts"), which matches the raw/staging/marts
  layout described in the README.
#}
{% macro generate_schema_name(custom_schema_name, node) -%}
    {%- if custom_schema_name is none -%}
        {{ target.schema }}
    {%- else -%}
        {{ custom_schema_name | trim }}
    {%- endif -%}
{%- endmacro %}
