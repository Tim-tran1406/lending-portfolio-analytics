# Facts vs dimensions

**What it is:** The two kinds of tables in a star schema. **Facts** hold the things you
*measure* (numbers tied to events). **Dimensions** hold the *context* (the descriptive labels
you slice by).

**Why it matters:** Knowing which is which tells you exactly where each column belongs when you
design a model — and stops you from building a confusing mess.

**The basics**
- **Fact table:** one row per event; mostly **measures** (numbers) plus foreign keys; it grows
  very large.
- **Dimension table:** one row per "thing"; mostly **text attributes**; it stays small.
- Rule of thumb: things you **sum or average** → facts; things you **group or filter by** →
  dimensions.

**Example**

Classifying some of our columns:

| column                        | fact or dimension?      |
|-------------------------------|-------------------------|
| `loan_amount`, `net_return`, `roi` | measures → **fact**     |
| `grade`, `state`, `purpose`, issue month | labels → **dimensions** |

So `net_return` lives in `fct_loans` (you sum it), while `grade` lives in `dim_grade` (you group
by it).

**What's happening:** "Average ROI **by grade**" uses a measure from the fact (`roi`) and a label
from a dimension (`grade`). The two table types play different roles, and that division is what
makes the model clean.

**How we use it in the project:** `fct_loans` holds measures (`net_return`, `roi`) and flags
(`is_matured`, `is_default`); the `dim_*` tables hold the labels we slice by.

**Recap:** Facts = numbers you aggregate (big table). Dimensions = labels you group/filter by
(small tables). Sum/average → fact; group/filter → dimension.
