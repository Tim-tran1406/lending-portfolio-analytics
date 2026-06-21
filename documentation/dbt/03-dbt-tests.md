# dbt tests

**What it is:** dbt tests are automatic checks that your data meets your expectations — for
example "this column has no nulls," "this key is unique," or "this column only contains these
values."

**Why it matters:** Data breaks silently — a duplicate key or a stray value can quietly ruin a
dashboard. Tests catch those problems *before* anyone sees a wrong number, which is what makes a
pipeline trustworthy.

**The basics**
- You declare tests in a `.yml` file next to the model.
- Built-in tests: **not_null**, **unique**, **accepted_values**, **relationships** (checks a
  value exists in another table).
- Run them with `dbt test`. dbt writes SQL that searches for rule-breaking rows — **0 rows
  found = PASS**.

**Example**

Part of our `_stg_loans.yml`:

```yaml
columns:
  - name: loan_id
    data_tests:
      - unique
      - not_null
  - name: grade
    data_tests:
      - accepted_values:
          values: ['A', 'B', 'C', 'D', 'E', 'F', 'G']
```

Run it:

```bash
dbt test
```

**What's happening:** For `unique`, dbt runs a query that counts duplicate `loan_id`s — if it
finds any, the test fails. For `accepted_values`, it looks for any `grade` outside A–G. Our run
showed **8 tests PASS** (including `loan_id` being unique across all 2.26M rows), so we *know*
the staging data is sound.

**How we use it in the project:** Every model gets tests. They're the second of our "verify
three ways" habit — alongside checking row counts and re-deriving a number by hand.

**Recap:** dbt tests = automatic data-quality checks (not_null, unique, accepted_values,
relationships). `dbt test` passes when no rows break the rule. Cheap insurance against silent
bad data.
