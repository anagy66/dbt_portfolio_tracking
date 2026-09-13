with

source as (

    select * from {{ ref('ref_positions') }}

)

select * from source
