select
    *

from {{ ref('stg_portfolio') }}

where unrealized_profit_pct is not null and
      (
        unrealized_profit_pct < 0.0 or
        unrealized_profit_pct > 100.0
      )
