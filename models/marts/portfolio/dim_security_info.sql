with

source as (

    select * from {{ ref('ref_security_info') }}
    
)

select * from source
