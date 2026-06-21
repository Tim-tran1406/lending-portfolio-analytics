# Shortcuts for common project commands. Run `make help` to list them.

# Load variables from .env (if it exists) so dbt and the scripts can use them.
ifneq (,$(wildcard .env))
include .env
export
endif

.PHONY: help db-up db-down prepare load dbt-build dbt-test

help:
	@echo "make db-up     - start PostgreSQL (Docker)"
	@echo "make db-down   - stop PostgreSQL"
	@echo "make prepare   - extract the downloaded LendingClub data into data/"
	@echo "make load      - load the raw data into PostgreSQL"
	@echo "make dbt-build - run all dbt models"
	@echo "make dbt-test  - run dbt data tests"

db-up:
	docker compose up -d

db-down:
	docker compose down

prepare:
	python ingest/prepare_data.py

load:
	python ingest/load_to_postgres.py

dbt-build:
	cd dbt/lending && dbt build --profiles-dir .

dbt-test:
	cd dbt/lending && dbt test --profiles-dir .
