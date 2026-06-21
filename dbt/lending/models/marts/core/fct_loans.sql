-- Fact table. Grain = ONE ROW PER LOAN.
-- Holds the foreign keys to the dimensions, the numeric measures, and the
-- business flags we'll analyze (matured? defaulted?). This is the table the
-- reporting marts and the dashboard build on.

with loans as (
    select * from {{ ref('stg_loans') }}
)

select
    -- degenerate key (the grain)
    loan_id,

    -- foreign keys to the dimensions
    to_char(issue_date, 'YYYYMM')::int as date_key,
    sub_grade                          as grade_key,
    state_code                         as state_key,
    purpose                            as purpose_key,
    md5(
        coalesce(home_ownership, '')      || '|' ||
        coalesce(emp_length, '')          || '|' ||
        coalesce(verification_status, '')
    )                                  as borrower_key,

    -- descriptive numerics about the borrower
    annual_income,
    dti,
    (fico_low + fico_high) / 2.0       as fico_score,

    -- loan terms
    loan_amount,
    funded_amount,
    term_months,
    interest_rate,
    installment,

    -- outcomes (what actually happened)
    loan_status,
    total_payment,
    principal_received,
    interest_received,
    recoveries,
    late_fees_received,

    -- derived MEASURES: the whole point of the project
    total_payment - funded_amount                              as net_return,
    (total_payment - funded_amount) / nullif(funded_amount, 0) as roi,

    -- flags
    (loan_status like '%Fully Paid%' or loan_status like '%Charged Off%') as is_matured,
    (loan_status like '%Charged Off%' or loan_status = 'Default')         as is_default

from loans
