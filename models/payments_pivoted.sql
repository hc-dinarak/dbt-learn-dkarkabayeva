
{# Returns a list of the top 50 payment methods in stg_payments #}

{%- set payment_methods = dbt_utils.get_column_values(table=ref('stg_payments'), 
                         column='payment_method', 
                         max_records=50, 
                         default=[]) -%}

-- Pivots the payment methods into columns
select
    order_id,
    {%- for i in payment_methods %}
        sum(case when payment_method = '{{ i }}' then amount else 0 end) as {{ i }}_amount
        {%- if not loop.last %} , {% endif %}
    {%- endfor %}
from {{ ref('stg_payments') }}
group by 1