# Running PostgreSQL with Docker Compose

**What it is:** Docker **Compose** lets you describe a container in a small file
(`docker-compose.yml`) and run it with one short command — instead of typing long `docker run`
commands by hand.

**Why it matters:** The settings (which image, which port, which password) live in one readable
file you can commit to git. Anyone who clones the repo gets the exact same database.

**The basics:** The compose file lists **services** (containers). For each service you set the
image, environment variables, ports, and volumes.

**Example**

A trimmed version of our `docker-compose.yml`:

```yaml
services:
  postgres:
    image: postgres:16
    environment:
      POSTGRES_DB: ${POSTGRES_DB}          # values come from .env
      POSTGRES_USER: ${POSTGRES_USER}
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
    ports:
      - "5432:5432"                         # connect from your Mac on port 5432
    volumes:
      - pgdata:/var/lib/postgresql/data     # data persists here
```

Run it:

```bash
docker compose up -d     # start in the background
docker compose ps        # check it's running
docker compose down      # stop it (your data is kept)
```

**What's happening:** `up -d` reads the file, starts Postgres with our settings, and maps port
5432 so tools on your Mac can connect. The `pgdata` volume means stopping the container does
**not** lose the 2.2M rows.

**How we use it in the project:** We run exactly these commands (wrapped as `make db-up` /
`make db-down`) to control the database.

**Recap:** Compose = one file describing your container + simple `up`/`down` commands. Ports
expose the database; volumes keep the data safe.
