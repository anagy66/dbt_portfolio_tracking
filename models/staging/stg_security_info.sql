with

source as (

    select * from {{ source('seeds', 'raw_security_info') }}
    
),

renamed as (

    select
        SECUROTY_CODE::varchar as security_code,
        SECUROTY_NAME::varchar as security_name,
        SECtOR::varchar as sector_name,
        INDUSTRY::varchar as industry_name,
        COUNTRY::varchar as country_code,
        EXCHANGE::varchar as exchange_code,
        LOAD_TS::timestamp as load_ts_utc,
        'raw.security_info'::varchar as record_source

    from source

),

defaults as (

    select
        '-1' as security_code,
        'Missing' as security_name,
        'Missing' as sector_name,
        'Missing' as industry_name,
        '-1' as country_code,
        '-1' as exchange_code,
        '2020-01-01'::timestamp as load_ts_utc,
        'System.DefaultKey' as record_source

),

combined as (

    select * from defaults

    union all

    select * from renamed

),

hashed as (

    select
        concat_ws('|', security_code) as security_hkey,
        concat_ws('|', security_code, security_name, sector_name, industry_name, country_code, exchange_code) as security_hdiff,
        *

    from combined
    
)

select * from hashed
