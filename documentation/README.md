# Documentation — Learning Notes

Plain-English notes explaining every skill used in this project **from the basics** — not just
what we did, but how the underlying tool works. Each page teaches the concept, shows a small
worked example (a sample table, the command, and the result), then connects it to how we used
it here.

## How to use these notes

Read a page right before or after we use that skill. Each one is short and self-contained.
Examples use tiny made-up tables so the idea is clear before you meet it on the real 2.2M-row
dataset.

## Contents

> Pages are added as we reach each part of the project. ✅ = written, ⏳ = coming.

### SQL
- ✅ [01 — What is SQL?](sql/01-what-is-sql.md)
- ✅ [02 — SELECT (choosing columns)](sql/02-select.md)
- ⏳ 03 — WHERE (filtering rows)
- ⏳ 04 — ORDER BY & LIMIT
- ⏳ 05 — GROUP BY & aggregations
- ⏳ 06 — JOINs
- ⏳ 07 — CTEs (the WITH keyword)
- ⏳ 08 — CASE expressions
- ⏳ 09 — Window functions
- ⏳ 10 — Dates & cohort analysis

### Databases
- ✅ [01 — What is a database?](databases/01-what-is-a-database.md)
- ✅ [02 — PostgreSQL basics](databases/02-postgresql-basics.md)
- ✅ [03 — The raw / staging / marts layers](databases/03-raw-staging-marts.md)

### Docker
- ✅ [01 — What is Docker?](docker/01-what-is-docker.md)
- ✅ [02 — Running PostgreSQL with Docker Compose](docker/02-running-postgres-with-docker.md)

### Python
- ✅ [01 — Loading data into a database (ETL)](python/01-loading-data-etl.md)

### Git & GitHub
- ✅ [01 — Git basics](git-github/01-git-basics.md)
- ⏳ 02 — Branching & pull requests

### dbt
- ✅ [01 — What is dbt?](dbt/01-what-is-dbt.md)
- ✅ [02 — The staging layer](dbt/02-staging-layer.md)
- ✅ [03 — dbt tests](dbt/03-dbt-tests.md)

### Data modeling
- ⏳ Star schema · facts vs dimensions · grain & keys

### Tableau
- ⏳ Tableau basics · dashboard design

### Finance domain
- ⏳ Lending terms: default, charge-off, recovery, ROI, vintage
