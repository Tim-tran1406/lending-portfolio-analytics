-- Geography dimension: one row per US state, with its Census region.

with states as (
    select distinct state_code
    from {{ ref('stg_loans') }}
    where state_code is not null
)

select
    state_code as state_key,
    state_code,
    case
        when state_code in ('CT','ME','MA','NH','RI','VT','NJ','NY','PA')                          then 'Northeast'
        when state_code in ('IL','IN','MI','OH','WI','IA','KS','MN','MO','NE','ND','SD')            then 'Midwest'
        when state_code in ('DE','FL','GA','MD','NC','SC','VA','DC','WV','AL','KY','MS','TN',
                            'AR','LA','OK','TX')                                                    then 'South'
        when state_code in ('AZ','CO','ID','MT','NV','NM','UT','WY','AK','CA','HI','OR','WA')       then 'West'
        else 'Other'
    end as region
from states
