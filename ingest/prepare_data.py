"""
Prepare the downloaded LendingClub data for loading.

You downloaded the dataset .zip from Kaggle by hand. This script:
  1. finds that .zip (in this project's data/ folder or your ~/Downloads),
  2. pulls out the "accepted loans" file (the one with payment outcomes),
  3. puts it in data/ so load_to_postgres.py can read it.

Usage:
    python ingest/prepare_data.py
"""
from __future__ import annotations

import shutil
import sys
import zipfile
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parents[1]
DATA_DIR = PROJECT_ROOT / "data"
DOWNLOADS = Path.home() / "Downloads"


def already_prepared() -> Path | None:
    for pattern in ("accepted*.csv.gz", "accepted*.csv"):
        hits = sorted(DATA_DIR.glob(pattern))
        if hits:
            return hits[0]
    return None


def find_zips() -> list[Path]:
    zips = list(DATA_DIR.glob("*.zip")) + list(DOWNLOADS.glob("*.zip"))
    # Most-recently-modified first, so a fresh download wins.
    return sorted(set(zips), key=lambda p: p.stat().st_mtime, reverse=True)


def accepted_member(zf: zipfile.ZipFile) -> str | None:
    for name in zf.namelist():
        low = name.lower()
        if "accepted" in low and (low.endswith(".csv") or low.endswith(".csv.gz")):
            return name
    return None


def main() -> int:
    DATA_DIR.mkdir(exist_ok=True)

    existing = already_prepared()
    if existing:
        print(f"[ok] Accepted-loans file already present: {existing.relative_to(PROJECT_ROOT)}")
        return 0

    zips = find_zips()
    if not zips:
        print("[error] No .zip found in data/ or ~/Downloads.")
        print("        Download 'All Lending Club loan data' from Kaggle first.")
        return 1

    for zp in zips:
        try:
            with zipfile.ZipFile(zp) as zf:
                member = accepted_member(zf)
                if not member:
                    continue
                target = DATA_DIR / Path(member).name
                print(f"[..] Extracting '{member}' from {zp.name} ...")
                with zf.open(member) as src, open(target, "wb") as dst:
                    shutil.copyfileobj(src, dst, length=1024 * 1024)
                size_mb = target.stat().st_size / 1e6
                print(f"[ok] Wrote {target.relative_to(PROJECT_ROOT)} ({size_mb:.0f} MB)")
                return 0
        except zipfile.BadZipFile:
            print(f"[warn] {zp.name} is not a valid zip, skipping.")

    print("[error] Found zip(s) but none contained an 'accepted' loans file.")
    print(f"        Checked: {', '.join(z.name for z in zips)}")
    return 1


if __name__ == "__main__":
    sys.exit(main())
