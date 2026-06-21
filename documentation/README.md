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
- ⏳ What is a database? · PostgreSQL basics · the raw / staging / marts schemas

### Docker
- ⏳ What is Docker? · running PostgreSQL in a container

### dbt
- ⏳ What is dbt? · the staging → intermediate → marts layers · sources & refs · tests & docs

### Data modeling
- ⏳ Star schema · facts vs dimensions · grain & keys

### Python
- ⏳ ETL: loading data into a database

### Tableau
- ⏳ Tableau basics · dashboard design

### Git & GitHub
- ⏳ Git basics · branching & pull requests

### Finance domain
- ⏳ Lending terms: default, charge-off, recovery, ROI, vintage
