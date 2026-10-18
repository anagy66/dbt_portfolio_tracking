with

source as (

    {{ current_from_snapshot(
        snsh_ref = ref('snsh_security_info'),
        output_load_ts = false
    ) }}

)

select * from source
