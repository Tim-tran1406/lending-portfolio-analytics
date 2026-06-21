# What is dbt?

**What it is:** dbt ("data build tool") is a tool for transforming data **inside your database**
using plain SQL `SELECT` statements. You write a SELECT; dbt turns it into a table or view for
you — in the correct order.

**Why it matters:** Instead of messy one-off scripts, dbt organizes transformations into
reusable, tested, documented building blocks called **models**. It's the standard way analytics
teams do the "T" (Transform) in ELT — a strong, in-demand skill.

**The basics**
- A **model** is a `.sql` file containing one `SELECT`. dbt creates a view or table from it.
- `{{ source('raw', 'loans') }}` means "the `raw.loans` table we loaded with Python."
- `{{ ref('stg_loans') }}` means "another model." dbt reads these references and works out the
  **build order automatically**.
- `dbt run` builds the models; `dbt test` checks them.

**Example**

A tiny model file:

```sql
-- models/staging/stg_loans.sql
select
    id::bigint        as loan_id,
    loan_amnt::numeric as loan_amount
from {{ source('raw', 'loans') }}
```

Run it:

```bash
dbt run
```

**What's happening:** dbt took your one `SELECT` and created a database object
(`staging.stg_loans`). It also remembers this model depends on `raw.loans`, so it always builds
things in the right sequence.

**How we use it in the project:** dbt builds our **staging** layer, and next the **star schema**
and the **profitability metrics** — all in dependency order and all tested.

**Recap:** dbt = transform data in your database with SQL `SELECT`s. Each `.sql` file is a model;
`source()`/`ref()` link them; `dbt run` builds and `dbt test` checks.
