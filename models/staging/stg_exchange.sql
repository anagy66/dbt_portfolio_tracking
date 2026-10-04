with

source as (

    select * from {{ source('seeds', 'raw_exchange') }}

),

renamed as (

    select
        ID::varchar as exchange_code,
        Name::varchar as exchange_name,
        Country::varchar as country,
        City::varchar as city,
        Zone::varchar as zone,
        Delta::varchar as delta,
        DST_period::varchar as dst_period,
        Open_UTC::varchar as open_utc,
        Close_UTC::varchar as close_utc,
        Lunch_UTC::varchar as lunch_utc,

        'raw.exchanges'::varchar as record_source

    from source

),

hashed as (

    select
        concat_ws('|', exchange_code) as exchange_hkey,
        concat_ws('|', exchange_code, exchange_name, country, city, zone, delta, dst_period, open_utc, close_utc, lunch_utc) as exchange_hdiff,
        *,

        '{{ run_started_at }}'::timestamp as load_ts_utc

    from renamed

)

select * from hashed
