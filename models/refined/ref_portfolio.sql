with

source as (

    select * from {{ ref('stg_portfolio') }}

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
