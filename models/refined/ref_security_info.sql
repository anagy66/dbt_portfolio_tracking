with

source as (

    select
        * exclude(dbt_scd_id, dbt_updated_at, dbt_valid_from, dbt_valid_to)
        
    from {{ ref('snsh_security_info') }}

    where dbt_valid_to is null

)

select * from source
