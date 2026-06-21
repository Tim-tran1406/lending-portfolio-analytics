# What is a database?

**What it is:** A database is an organized place to store data so you can ask questions of
it quickly and safely. The kind we use stores data in **tables** — like spreadsheets, but
built to handle millions of rows reliably.

**Why it matters:** You *could* keep data in a CSV or Excel file, but those get slow and messy
at scale (our file has 2.2 million rows). A database keeps data structured, lets many tools
query it at once, and answers questions in milliseconds using SQL.

**The basics**
- A **table** holds one kind of thing (e.g. loans).
- Each **row** is one record (one loan).
- Each **column** is one attribute (loan amount, grade, …).
- A **database** can hold many tables; a **schema** is like a folder that groups tables inside
  a database.

**Example**

A tiny `loans` table inside a database:

| id | grade | loan_amnt |
|----|-------|-----------|
| 1  | A     | 5000      |
| 2  | C     | 12000     |

Ask it a question with SQL:

```sql
SELECT count(*) FROM loans;
```

Result:

| count |
|-------|
| 2     |

**What's happening:** Instead of opening a file and counting by hand, you *asked* the database
and it answered instantly. With 2.2M rows, that difference is everything.

**How we use it in the project:** We loaded all 2,260,668 loans into a PostgreSQL database, in a
table called `loans` inside a schema called `raw`. Every later step queries this database.

**Recap:** A database = structured storage for data in tables (rows + columns), queried with
SQL. Schemas group related tables together.
