"""
Load the raw LendingClub accepted-loans file into PostgreSQL.

  - reads connection settings from .env
  - creates the 'raw' schema
  - keeps only the columns we need (left AS-IS; cleaning happens later in dbt)
  - loads in chunks so it runs on a normal laptop

Usage:
    python ingest/load_to_postgres.py
"""
from __future__ import annotations

import os
import sys
from pathlib import Path

import pandas as pd
from dotenv import load_dotenv
from sqlalchemy import create_engine, text
from tqdm import tqdm

PROJECT_ROOT = Path(__file__).resolve().parents[1]
DATA_DIR = PROJECT_ROOT / "data"

# We keep ~25 of the ~150 available columns. Everything else is dropped at load time.
USECOLS = [
    "id", "loan_amnt", "funded_amnt", "term", "int_rate", "installment",
    "grade", "sub_grade", "emp_length", "home_ownership", "annual_inc",
    "verification_status", "issue_d", "loan_status", "purpose", "dti",
    "fico_range_low", "fico_range_high", "addr_state",
    "total_pymnt", "total_rec_prncp", "total_rec_int", "recoveries",
    "total_rec_late_fee", "last_pymnt_d",
]

RAW_TABLE = "loans"
READ_CHUNK = 100_000   # rows read from the CSV at a time
WRITE_CHUNK = 1_000    # rows per INSERT (kept small to stay under Postgres' param limit)


def find_source() -> Path:
    for pattern in ("accepted*.csv.gz", "accepted*.csv"):
        hits = sorted(DATA_DIR.glob(pattern))
        if hits:
            return hits[0]
    print("[error] No accepted-loans file in data/. Run: python ingest/prepare_data.py")
    sys.exit(1)


def make_engine():
    load_dotenv(PROJECT_ROOT / ".env")
    url = (
        f"postgresql+psycopg2://{os.environ['POSTGRES_USER']}:"
        f"{os.environ['POSTGRES_PASSWORD']}@{os.environ['POSTGRES_HOST']}:"
        f"{os.environ['POSTGRES_PORT']}/{os.environ['POSTGRES_DB']}"
    )
    return create_engine(url)


def main() -> int:
    src = find_source()
    raw_schema = os.getenv("POSTGRES_SCHEMA_RAW", "raw")
    engine = make_engine()

    # Only load columns that actually exist in this file.
    header = pd.read_csv(src, nrows=0)
    cols = [c for c in USECOLS if c in header.columns]
    missing = [c for c in USECOLS if c not in header.columns]
    if missing:
        print(f"[warn] Expected columns not found (skipped): {missing}")

    with engine.begin() as con:
        con.execute(text(f"CREATE SCHEMA IF NOT EXISTS {raw_schema}"))

    print(f"[..] Loading {src.name} -> {raw_schema}.{RAW_TABLE}")
    # Read EVERYTHING as text. The raw layer should stay faithful to the source,
    # and this avoids pandas guessing a numeric type that later junk rows break.
    reader = pd.read_csv(src, usecols=cols, dtype=str, chunksize=READ_CHUNK)
    rows = 0
    dropped = 0
    first = True
    for chunk in tqdm(reader, unit="chunk"):
        # LendingClub files contain footer summary rows
        # (e.g. "Total amount funded in policy code 1: ...").
        # Real rows have an all-digit id; drop everything else.
        before = len(chunk)
        chunk = chunk[chunk["id"].str.fullmatch(r"\d+", na=False)]
        dropped += before - len(chunk)
        if chunk.empty:
            continue
        chunk.to_sql(
            RAW_TABLE,
            engine,
            schema=raw_schema,
            if_exists="replace" if first else "append",
            index=False,
            method="multi",
            chunksize=WRITE_CHUNK,
        )
        first = False
        rows += len(chunk)
    print(f"[ok] Inserted {rows:,} rows; dropped {dropped} junk/footer row(s).")

    with engine.connect() as con:
        n = con.execute(text(f"SELECT count(*) FROM {raw_schema}.{RAW_TABLE}")).scalar()
    print(f"[ok] Loaded {rows:,} rows. {raw_schema}.{RAW_TABLE} now holds {n:,} rows.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
