with

source as (

    select * from {{ ref('ref_portfolio') }}

)

select * from source
