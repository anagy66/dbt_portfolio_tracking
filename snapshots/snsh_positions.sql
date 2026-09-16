{% snapshot snsh_positions %}

    {{
        config(
            unique_key = 'position_hkey',
            strategy = 'check',
            check_cols = ['position_hdiff'],
            invalidate_hard_deletes = True
        )
    }}

    select * from {{ ref('stg_positions') }}

{% endsnapshot %}
