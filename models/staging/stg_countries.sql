with 

source as (

    select * from {{ source('seeds', 'raw_countries') }}

),

renamed as (

    select
        country_code_2_letter::varchar as country_code,
        country_name::varchar as country_name,
        region_code::varchar as region_code,
        region::varchar as region,
        sub_region_code::varchar as sub_region_code,
        sub_region::varchar as sub_region,

        'raw.countries'::varchar as record_source

    from source

),

hashed as (

    select
        concat_ws('|', country_code) as country_hkey,
        concat_ws('|', country_code, country_name, region_code, region, sub_region_code, sub_region) as country_hdiff,
        *,
        '{{ run_started_at }}'::timestamp as load_ts_utc

    from renamed
    
)

select * from hashed
