with 

source as (

    select * from {{ ref('raw_portfolio') }}

),

renamed as (

    select
        accountID::varchar as account_code,
        symbol::varchar as security_code,
        description::varchar as security_name,
        exchange::varchar as exchange_code,
        report_date::date as report_date,
        quantity::integer as quantity,
        cost_base::numeric(12, 2) as cost_base,
        position_value::numeric(12, 2) as position_value,
        currency::varchar as currency_code,

        'raw.dbt_portfolio_tracking'::varchar as record_source,

    from source

),

hashed as (

    select
        concat_ws('|', account_code, security_code) as position_hkey,
        concat_ws('|', account_code, security_code, security_name, exchange_code, 
            report_date, quantity, cost_base, position_value, currency_code) as position_hdiff,
        *,
        '{{ run_started_at }}'::timestamp as load_ts_utc

    from renamed
    
)

select * from hashed
