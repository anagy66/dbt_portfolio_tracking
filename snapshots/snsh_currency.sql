{% snapshot snsh_currency %}

    {{
        config(
            unique_key = 'currency_hkey',
            strategy = 'check',
            check_cols = ['currency_hdiff']
        )
    }}

    select * from {{ ref('stg_currency') }}

{% endsnapshot %}
