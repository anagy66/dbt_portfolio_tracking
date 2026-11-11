{% test no_hash_collisions(model, column_name, hashed_fields) %}

{% set fields = hashed_fields if hashed_fields is sequence and hashed_fields is not string else hashed_fields.split(',') %}

with all_tuples as (

    select distinct
        {{ column_name }} as hash,
        {% for field in fields %}
            {{ field.strip() }}{% if not loop.last %}, {% endif %}
        {% endfor %}
        
    from {{ model }}

),

validation_errors as (

    select
        hash,
        count(*) as num_collisions

    from all_tuples

    group by 1

    having count(*) > 1

)

select * from validation_errors

{% endtest %}
