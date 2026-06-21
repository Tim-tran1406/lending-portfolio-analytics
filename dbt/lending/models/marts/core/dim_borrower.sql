-- Borrower dimension. This dataset has no reusable "borrower" id, so we build a
-- "junk dimension": one row per distinct combination of the categorical borrower
-- traits. Because there's no natural key, we make a SURROGATE key by hashing the
-- combination with md5().

with combos as (
    select distinct
        home_ownership,
        emp_length,
        verification_status
    from {{ ref('stg_loans') }}
)

select
    md5(
        coalesce(home_ownership, '')      || '|' ||
        coalesce(emp_length, '')          || '|' ||
        coalesce(verification_status, '')
    ) as borrower_key,
    home_ownership,
    emp_length,
    verification_status
from combos
