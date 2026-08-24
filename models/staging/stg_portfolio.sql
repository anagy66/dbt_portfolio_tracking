with 

source as (

    select * from {{ ref('raw_portfolio') }}

),

final as (

    select
        accountID::varchar as account_id,
        symbol::varchar as symbol,
        description::varchar as description,
        exchange::varchar as exchange,
        report_date::date as report_date,
        quantity::integer as quantity,
        cost_base::numeric(12, 2) as cost_base,
        position_value::numeric(12, 2) as position_value,
        currency::varchar as currency,
        
        (position_value - cost_base)::numeric(12, 2) as unrealized_profit,
        (unrealized_profit / nullif(cost_base, 0) * 100)::numeric(12, 2) as unrealized_profit_pct

    from source

)

select * from final
