with

source as (

    select * from {{ ref('ref_countries') }}
    
)

select * from source
