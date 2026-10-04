{% snapshot snsh_countries %}

    {{
        config(
            unique_key = 'country_hkey',
            strategy = 'check',
            check_cols = ['country_hdiff']
        )
    }}

    select * from {{ ref('stg_countries') }}

{% endsnapshot %}
