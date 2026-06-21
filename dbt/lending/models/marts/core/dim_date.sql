-- Date dimension at month grain (loans are issued by month, e.g. "Dec-2015").

with dates as (
    select distinct issue_date
    from {{ ref('stg_loans') }}
    where issue_date is not null
)

select
    to_char(issue_date, 'YYYYMM')::int    as date_key,   -- e.g. 201512
    issue_date                            as full_date,
    extract(year    from issue_date)::int as year,
    extract(quarter from issue_date)::int as quarter,
    extract(month   from issue_date)::int as month,
    trim(to_char(issue_date, 'Month'))    as month_name
from dates
