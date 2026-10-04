with

source as (

    select * from {{ ref('ref_currency') }}
    
)

select * from source
