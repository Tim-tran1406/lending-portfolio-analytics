-- Grade dimension at sub-grade grain (e.g. C1), with its parent grade (C).
-- sub_grade is a clean natural key, so we use it directly.

select distinct
    sub_grade as grade_key,
    grade,
    sub_grade
from {{ ref('stg_loans') }}
where sub_grade is not null
