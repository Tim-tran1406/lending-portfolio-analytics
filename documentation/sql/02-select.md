# SELECT — choosing which columns to see

**What it is:** `SELECT` is how you tell a database *which columns* you want to look at from a
table. It's the first word of almost every SQL query.

**Why it matters:** A real table can have 150 columns. `SELECT` lets you pull out just the few
you care about, instead of drowning in all of them.

**The basics:** You write `SELECT`, then the column names you want, then `FROM`, then the table
name. End the statement with a semicolon `;`.

**Example**

Imagine a table called `loans`:

| loan_id | grade | loan_amnt | int_rate |
|---------|-------|-----------|----------|
| 1       | A     | 5000      | 7.5      |
| 2       | C     | 12000     | 15.2     |
| 3       | B     | 8000      | 11.0     |

Now we run this command:

```sql
SELECT grade, loan_amnt
FROM loans;
```

We get back **only the two columns we asked for**:

| grade | loan_amnt |
|-------|-----------|
| A     | 5000      |
| C     | 12000     |
| B     | 8000      |

**What's happening:** We told the database, "from the `loans` table, show me just the `grade`
and `loan_amnt` columns." It ignored `loan_id` and `int_rate` because we didn't ask for them.
Notice it returned *every row* — `SELECT` chooses columns; choosing *rows* is a different
keyword (`WHERE`, coming next).

> **Tip:** `SELECT *` means "give me *every* column." It's handy for a quick peek, but in real
> work you usually name the columns you want — it's clearer and faster.

**How we use it in the project:** Every analysis starts here — for example, selecting `grade`,
`loan_amnt`, and `total_pymnt` as the first step toward calculating which loan grades were
profitable.

**Recap:** `SELECT columns FROM table;` → pick the columns you want to see. Use `SELECT *` for
all columns.
