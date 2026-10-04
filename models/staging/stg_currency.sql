with 

source as (

    select * from {{ source('seeds', 'raw_currency') }}

),

renamed as (

    select
        AlphabeticCode::varchar as currency_code,
        NumericCode::int as currency_numeric_code,
        CurrencyName::varchar as currency_name,
        DecimalDigits::int as decimal_digits,
        Locations::varchar as locations,

        'raw.countries'::varchar as record_source

    from source

),

hashed as (

    select
        concat_ws('|', currency_code, currency_numeric_code::varchar) as currency_hkey,
        concat_ws('|', currency_code, currency_numeric_code::varchar, currency_name, decimal_digits::varchar, locations) as currency_hdiff,
        * exclude(currency_numeric_code, decimal_digits, locations),

        ifnull(decimal_digits, 0)::int as decimal_digits,
        ifnull(locations, 'World')::varchar as locations,

        '{{ run_started_at }}'::timestamp as load_ts_utc

    from renamed
    
)

select * from hashed
