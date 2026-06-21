# What is SQL?

**What it is:** SQL (Structured Query Language) is the language you use to talk to a database.
You write a short instruction called a *query*, and the database answers it by returning rows
of data.

**Why it matters:** Almost every company keeps its data in databases. SQL is how analysts and
engineers ask questions of that data — it's the single most-used skill in data jobs, which is
why we lean on it heavily in this project.

**The basics:** A database holds **tables**. A table is like a spreadsheet: it has **rows**
(records) and **columns** (fields). SQL lets you ask things like "show me these columns,"
"only these rows," or "group these together and count them." You describe *what* you want;
the database figures out *how* to get it.

**Example**

Suppose a database has one table called `loans`:

| loan_id | grade | loan_amnt |
|---------|-------|-----------|
| 1       | A     | 5000      |
| 2       | C     | 12000     |

A simple SQL query:

```sql
SELECT grade, loan_amnt
FROM loans;
```

Read it as plain English: "**select** the grade and loan amount **from** the loans table."
The database returns:

| grade | loan_amnt |
|-------|-----------|
| A     | 5000      |
| C     | 12000     |

**What's happening:** You didn't tell the database which files to open or how to read them —
only *what result* you wanted. That's the whole idea of SQL: you describe the answer, and the
database does the work of finding it.

**How we use it in the project:** Everything — profiling the raw loans, building the star
schema, and computing profitability — is written in SQL (often through dbt, which is just a
tidier way to organize and reuse SQL).

**Recap:** SQL = the language for asking a database questions. Tables have rows and columns,
and a query returns the rows and columns you ask for.
