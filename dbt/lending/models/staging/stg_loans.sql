-- Staging: clean the raw text into proper types and tidy names.
-- No business logic here (that lives in the marts) — just faithful cleaning.

with source as (

    select * from {{ source('raw', 'loans') }}

),

cleaned as (

    select
        -- identifier
        id::bigint                                          as loan_id,

        -- loan terms
        loan_amnt::numeric                                  as loan_amount,
        funded_amnt::numeric                                as funded_amount,
        -- " 36 months" -> 36
        nullif(trim(replace(term, 'months', '')), '')::int  as term_months,
        int_rate::numeric                                   as interest_rate,
        installment::numeric                                as installment,
        grade,
        sub_grade,
        purpose,

        -- borrower
        emp_length,
        home_ownership,
        annual_inc::numeric                                 as annual_income,
        verification_status,
        dti::numeric                                        as dti,
        fico_range_low::numeric                             as fico_low,
        fico_range_high::numeric                            as fico_high,
        addr_state                                          as state_code,

        -- dates  ("Dec-2015" -> 2015-12-01)
        to_date(issue_d, 'Mon-YYYY')                        as issue_date,
        case
            when nullif(last_pymnt_d, '') is not null
            then to_date(last_pymnt_d, 'Mon-YYYY')
        end                                                 as last_payment_date,

        -- outcomes (what actually happened to the loan)
        loan_status,
        total_pymnt::numeric                                as total_payment,
        total_rec_prncp::numeric                            as principal_received,
        total_rec_int::numeric                              as interest_received,
        recoveries::numeric                                 as recoveries,
        total_rec_late_fee::numeric                         as late_fees_received

    from source

)

select * from cleaned
