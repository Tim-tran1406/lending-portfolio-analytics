# The raw / staging / marts layers

**What it is:** A way of organizing a database into three "stages" of data, from untouched to
business-ready. Each stage lives in its own schema.

**Why it matters:** Mixing raw data with polished results is how projects become a tangled mess.
Separating layers makes the pipeline clear, testable, and trustworthy — and it's how real data
teams work.

**The basics**
- **raw** — the data exactly as it arrived. Never edited. If something looks wrong later, you
  can always compare back to the original.
- **staging** — raw data *cleaned*: correct data types, tidy names, junk removed. Usually one
  staging table per source table.
- **marts** — the *business-ready* tables: the star schema and the metrics people actually use
  (default rates, ROI).

Data only ever flows one direction: **raw → staging → marts.**

**Example**

Follow one value — the interest rate — through the layers:

| layer   | what `int_rate` looks like        | why |
|---------|-----------------------------------|-----|
| raw     | `"13.99"` (text)                  | exactly as the CSV had it |
| staging | `13.99` (a real number)           | cleaned so we can do math on it |
| marts   | used in `avg(int_rate)` per grade | answers a business question |

**What's happening:** The same piece of data gets progressively more useful, without ever
destroying the original. Raw stays faithful; staging makes it usable; marts make it meaningful.

**How we use it in the project:** Python loaded the CSV into the **raw** schema as text. Next,
dbt will build the **staging** schema (clean types) and the **marts** schema (star schema +
profitability metrics).

**Recap:** raw = untouched, staging = cleaned, marts = business-ready. The one-way flow keeps
the whole project easy to trust and debug.
