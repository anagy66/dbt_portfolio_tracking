with

source as (

    select
        * exclude(lunch_utc, dbt_scd_id, dbt_updated_at, dbt_valid_from, dbt_valid_to),

        lower(trim(lunch_utc)) as lunch_utc
        
    from {{ ref('snsh_exchange') }}

    where dbt_valid_to is null

),

refined as (

    select
        * exclude(delta, lunch_utc),
    
        try_cast(replace(delta, '_', '-') as float) as delta,

        case
            when starts_with(lunch_utc, 'y') then true
            when starts_with(lunch_utc, 'n') then false
            else null
        end as lunch_utc

    from source

)

select * from refined
