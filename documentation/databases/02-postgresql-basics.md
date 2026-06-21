# PostgreSQL basics

**What it is:** PostgreSQL (often just "Postgres") is a specific, free, very popular database
program. It's the actual engine that stores our tables and runs our SQL.

**Why it matters:** "PostgreSQL" is one of the most in-demand skills in data jobs. Learning it
means learning standard SQL on a real, professional database — not a toy.

**The basics**
- Postgres runs as a **server**: a program that sits waiting for requests.
- Your tools are **clients** that connect to it.
- To connect you need a **host, port, database name, user, and password** — exactly the values
  in our `.env` file.
- `psql` is the command-line client for talking to Postgres.
- Inside a database the hierarchy is: **schema → table → rows/columns**.

**Example**

Connect to our database (this runs inside the Docker container):

```bash
psql -U lending -d lending
```

Then look around:

```sql
\dt raw.*                         -- list the tables in the "raw" schema
SELECT * FROM raw.loans LIMIT 5;  -- show 5 sample rows
```

**What's happening:** `\dt raw.*` is a psql shortcut that lists tables; the `SELECT` returns 5
rows. You're now talking directly to the database that holds all 2.2M loans.

**How we use it in the project:** Postgres is our **warehouse** — it stores the raw data and
(soon) the cleaned, modeled tables that dbt builds. We run it inside Docker so the setup is
clean and repeatable.

**Recap:** PostgreSQL = the real database engine. A client (like `psql`) connects using
host/port/db/user/password, then runs SQL against schemas and tables.
