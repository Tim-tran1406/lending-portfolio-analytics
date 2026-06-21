# The staging layer

**What it is:** The first dbt layer. You build **one staging model per source table**, and its
only job is to *clean* that table — fix data types, tidy names, parse messy values. No business
logic, no joins, no math that answers a question.

**Why it matters:** It separates "make the data usable" from "answer business questions."
Everything downstream gets to start from clean, predictable data, so the rest of the project
stays simple.

**The basics**
- Name staging models with a `stg_` prefix (e.g. `stg_loans`).
- Materialize them as **views** (cheap, and always reflect the latest raw data).
- Typical work: cast text to numbers/dates, rename columns, parse values like `" 36 months"`.

**Example**

Our `stg_loans` turns raw text into proper types. A few columns:

| column   | raw (text)       | staging (clean)      |
|----------|------------------|----------------------|
| int_rate | `"13.99"`        | `13.99` (number)     |
| term     | `" 36 months"`   | `36` (integer)       |
| issue_d  | `"Dec-2015"`     | `2015-12-01` (date)  |

The SQL doing it:

```sql
int_rate::numeric                                   as interest_rate,
nullif(trim(replace(term, 'months', '')), '')::int  as term_months,
to_date(issue_d, 'Mon-YYYY')                        as issue_date
```

**What's happening:** Each line cleans one column. `::numeric` and `::int` change the type;
`replace`/`trim` strip the word "months" and spaces so `" 36 months"` becomes `36`; `to_date`
reads `"Dec-2015"` as a real date. The result is a view with proper types, ready for math.

**How we use it in the project:** We have one source table, so one staging model — `stg_loans`.
It cleaned all 2,260,668 rows and now feeds the star schema we build next.

**Recap:** Staging = one `stg_` view per source, cleaning only (types, names, parsing). It gives
the rest of the project a tidy foundation to build on.
