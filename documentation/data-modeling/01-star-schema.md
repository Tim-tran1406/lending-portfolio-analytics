# The star schema

**What it is:** A star schema is a way of organizing tables for analysis: one central **fact**
table (the events you measure) surrounded by **dimension** tables (the descriptive context).
Drawn out, it looks like a star — hence the name.

**Why it matters:** It's the most common data model in analytics. It keeps queries simple and
fast, and it's exactly what BI tools like Tableau expect. Knowing it is core to both analyst and
data-engineer roles.

**The basics**
- A **fact** table sits in the middle: one row per event (here, one per loan), holding the
  numbers and the keys.
- **Dimension** tables sit around it: the "by what" you slice — by grade, by state, by date, by
  purpose, by borrower.
- They connect through **keys**.

**Example**

A mini version of our star:

```
dim_grade(grade_key, grade)          fct_loans(loan_id, date_key, grade_key,
dim_date (date_key, year)                      loan_amount, net_return)
```

Ask "average return by grade":

```sql
select g.grade, avg(f.net_return) as avg_return
from fct_loans f
join dim_grade g on f.grade_key = g.grade_key
group by g.grade;
```

**What's happening:** The fact table holds the *numbers* (`net_return`); the dimension holds the
*labels* (`grade`). Joining them lets you summarize the numbers **by** any label — that one
pattern answers a huge range of business questions.

**How we use it in the project:** Our star is `fct_loans` in the center, with `dim_date`,
`dim_grade`, `dim_geography`, `dim_purpose`, and `dim_borrower` around it. It already answered
"realized ROI by grade."

**Recap:** Star schema = one central fact table (numbers + keys) surrounded by dimension tables
(labels). Join fact→dimension, group by a label = an answer.
