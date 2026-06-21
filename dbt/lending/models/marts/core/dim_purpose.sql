-- Purpose dimension: one row per stated loan purpose (debt_consolidation, etc.).

select distinct
    purpose as purpose_key,
    purpose
from {{ ref('stg_loans') }}
where purpose is not null
