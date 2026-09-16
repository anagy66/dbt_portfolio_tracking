with

source as (

    select
        * exclude(dbt_scd_id, dbt_updated_at, dbt_valid_from, dbt_valid_to)
        
    from {{ ref('snsh_positions') }}

    where dbt_valid_to is null

),

refined as (

    select
        *,

        (position_value - cost_base)::numeric(12, 5) as unrealized_profit,

        case
            when cost_base = 0 then 0
            else (position_value - cost_base) / cost_base
        end::numeric(12, 5) as unrealized_profit_pct

    from source

)

select * from refined
