with

source as (

    {{ current_from_snapshot(
        snsh_ref = ref('snsh_exchange'),
        output_load_ts = false
    ) }}

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
