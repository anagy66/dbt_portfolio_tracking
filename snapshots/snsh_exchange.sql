{% snapshot snsh_exchange %}

    {{
        config(
            unique_key = 'exchange_hkey',
            strategy = 'check',
            check_cols = ['exchange_hdiff']
        )
    }}

    select * from {{ ref('stg_exchange') }}

{% endsnapshot %}
