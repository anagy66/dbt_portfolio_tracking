with

source as (

    {{ current_from_snapshot(
        snsh_ref = ref('snsh_countries'),
        output_load_ts = false
    ) }}

)

select * from source
