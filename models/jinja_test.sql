{% set payment_methods_sql %}

select distinct payment_method from {{ ref('stg_payments') }}

{% endset %}

{% set results = run_query(payment_methods_sql) %}


{% if execute %}
{# Return the first column #}
{% set results_list = results.columns[0].values() %}
{% else %}
{% set results_list = [] %}
{% endif %}


with payments as (

    select * from {{ ref('stg_payments') }}

),

pivoted as (

    select
        order_id,

        {% for payment_method in results_list %}
        sum(case when payment_method = '{{ payment_method }}' then amount else 0 end) as {{payment_method}}_amount
        {%- if not loop.last -%}
        ,
        {% endif %}
        {% endfor %}

    from payments

    group by 1
)

select * from pivoted
