# Loading data into a database (ETL)

**What it is:** **ETL** stands for **Extract, Transform, Load** — the process of moving data
from a source (like a file) into a database. When you load *first* and transform *later*, it's
called **ELT** — which is the approach we use.

**Why it matters:** Data almost never starts inside a database. Getting it *in* — reliably and
repeatably — is a core data-engineering skill. We use Python because it's excellent at reading
files and talking to databases.

**The basics**
- **Extract** — read the source (our `accepted_…csv.gz` file).
- **Load** — insert the rows into Postgres.
- We do the **transform** later, in dbt, so the raw layer stays faithful to the source.
- Big files are read in **chunks** so we don't run out of memory.

**Example**

The heart of our `load_to_postgres.py`, simplified:

```python
import pandas as pd

# read the file 100,000 rows at a time, everything as text
for chunk in pd.read_csv("accepted.csv.gz", dtype=str, chunksize=100_000):
    chunk.to_sql("loans", engine, schema="raw", if_exists="append")
```

**What's happening:** Instead of loading 2.2M rows into memory at once (which could crash the
program), pandas reads a slice, writes it to Postgres, then moves on to the next. `dtype=str`
loads everything as text so the raw layer mirrors the file exactly.

**A real lesson from this project:** LendingClub files contain junk "footer" rows (like *"Total
amount funded in policy code 1: …"*). Our script keeps only rows whose `id` is all digits — a
reminder that **real data is messy and you must inspect it before trusting it.**

**How we use it in the project:** This script loaded all 2,260,668 loans into `raw.loans` and
dropped 33 junk rows.

**Recap:** ETL/ELT = move data from files into a database. Read big files in chunks, load the
raw layer as-is, transform later, and always expect messy rows.
