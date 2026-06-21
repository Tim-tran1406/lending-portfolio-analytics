# Lending Portfolio Profitability & Risk Analytics

Analyzing **2.2M+ real LendingClub loans** to answer a question every lender cares about:
**which borrower segments actually make money, and which lose it?**

---

## The Problem

A consumer lender approves thousands of loans across different borrower grades, terms, and
purposes. Some loans get paid back with interest (profit); others default and are charged off
(loss). Most analyses stop at *"who defaults?"* — but that's misleading: a segment with **high
defaults can still be profitable** if the interest collected outweighs the losses.

The real business question is harder and more useful:

> **Where do we actually make vs lose money, and how should we change our lending policy?**

## Goals

This project answers, with data:

1. **Default & charge-off rates** by grade, term, purpose, and borrower profile.
2. **Realized return (ROI)** per segment — using the *actual payments received*, not just default counts.
3. **Risk vs return** — which segments give the best return *for the risk taken*.
4. **Vintage analysis** — how loans issued in different years performed over their lifetime.
5. **A recommendation** — which segments to lend more to, and which to pull back from.

**Deliverables:** a reproducible data pipeline, a tested dimensional model, and an interactive
Tableau dashboard a non-technical stakeholder can read in two minutes.

## How We Do It

```
Kaggle CSV  ─►  PostgreSQL (raw)  ─►  dbt (staging → star schema → marts)  ─►  Tableau
   data          load with Python       clean · model · test · aggregate        dashboard
```

1. **Ingest** — load the raw LendingClub data into PostgreSQL with Python.
2. **Stage** — clean and standardize the raw columns (types, names) with dbt.
3. **Model** — build a **star schema**: a central `fct_loans` table surrounded by
   `dim_borrower`, `dim_grade`, `dim_date`, and `dim_geography`.
4. **Analyze** — build reporting marts for the business metrics (default rate, ROI,
   risk-adjusted return, vintage performance), validated with dbt tests.
5. **Visualize** — connect Tableau to the marts and build the dashboard.
6. **Recommend** — turn the findings into clear lending-policy guidance.

## Tech Stack

| Layer | Tool |
|------|------|
| Storage / warehouse | PostgreSQL (in Docker) |
| Ingestion | Python (pandas) |
| Transformation & modeling | dbt |
| Dashboard | Tableau Public |
| Version control | Git + GitHub |

## Data

[All Lending Club loan data](https://www.kaggle.com/datasets/wordsforthewise/lending-club) —
accepted loans 2007–2018Q4 (~2.2M rows). The raw data is **not** committed (see `.gitignore`);
the scripts in `ingest/` reproduce it from the downloaded file.

## Repository Structure

```
.
├── docker-compose.yml      # PostgreSQL database
├── requirements.txt        # Python dependencies
├── ingest/                 # Python: prepare + load the raw data
├── dbt/lending/            # dbt project: staging → marts (star schema)
├── dashboard/              # Tableau dashboard link + screenshots
├── sql/                    # exploratory profiling SQL
└── documentation/          # plain-English learning notes for every skill used
```

## Skills & Learning Notes

Every skill used here is explained **from the basics**, in plain English with worked examples,
in the [`documentation/`](documentation/) folder — SQL, PostgreSQL, dbt, data modeling, Python
ETL, Tableau, Git, and the finance concepts behind the analysis.

## Key Findings

_Coming soon — added once the analysis is complete._

## Reproducing This Project

_Step-by-step setup added once the environment is finalized._
