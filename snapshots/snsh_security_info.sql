{% snapshot snsh_security_info %}

    {{
        config(
            unique_key = 'security_hkey',
            strategy = 'check',
            check_cols = ['security_hdiff']
        )
    }}

    select * from {{ ref('stg_security_info') }}

{% endsnapshot %}
