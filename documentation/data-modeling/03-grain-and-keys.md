# Grain and keys

**What it is:** **Grain** is what a single row of your fact table represents. **Keys** are the
columns that uniquely identify rows and link tables together.

**Why it matters:** Defining the grain *first* prevents double-counting (the most common
analytics bug). Keys keep your joins correct and your data trustworthy.

**The basics**
- **Grain:** decide "one row = one ______." Ours is **one row = one loan.** Every measure must
  make sense at that grain.
- **Primary key:** uniquely identifies a row (e.g. `loan_id` in `fct_loans`).
- **Foreign key:** a column pointing to a dimension's key (e.g. `grade_key` in `fct_loans`
  points to `dim_grade`).
- **Surrogate key:** an artificial key you create when there's no natural one — like our
  `borrower_key`, made by hashing the borrower traits with `md5()`.

**Example**

A row in `fct_loans`:

| loan_id (primary key) | grade_key (foreign key) | borrower_key (surrogate key) |
|-----------------------|-------------------------|------------------------------|
| 88637                 | B3 → `dim_grade`        | `md5(...)` → `dim_borrower`  |

And we *prove* these are sound with dbt tests:

```yaml
- name: loan_id
  data_tests: [unique, not_null]      # the grain really is one row per loan
- name: grade_key
  data_tests:
    - relationships:                  # every grade_key exists in dim_grade
        to: ref('dim_grade')
        field: grade_key
```

**What's happening:** `loan_id` being unique guarantees each loan appears once (no
double-counting). The `relationships` test guarantees every `grade_key` in the fact has a
matching row in `dim_grade`, so joins never silently drop data.

**How we use it in the project:** Grain = one loan; `loan_id` is the primary key; `date_key`,
`grade_key`, `state_key`, `purpose_key`, `borrower_key` are foreign keys; `borrower_key` is a
surrogate. All verified by passing dbt tests.

**Recap:** Grain = what one fact row means (one loan). Primary key = unique row id; foreign key =
link to a dimension; surrogate key = a made-up key when no natural one exists. Test them.
