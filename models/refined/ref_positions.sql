with

source as (

    {{ current_from_snapshot(
        snsh_ref = ref('snsh_positions'),
        output_load_ts = false
    ) }}

),

refined as (

    select
        * exclude(report_date),

        {{ to_21st_century_date('report_date') }} as report_date,

        (position_value - cost_base)::numeric(12, 5) as unrealized_profit,

        case
            when cost_base = 0 then 0
            else (position_value - cost_base) / cost_base
        end::numeric(12, 5) as unrealized_profit_pct

    from source

)

select * from refined
