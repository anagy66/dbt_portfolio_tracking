with

source as (

    select * from {{ ref('ref_exchange') }}
    
)

select * from source
