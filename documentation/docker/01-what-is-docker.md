# What is Docker?

**What it is:** Docker is a tool that runs software inside a **container** — a small,
self-contained box that already has everything the software needs. You can start or delete the
box without touching the rest of your computer.

**Why it matters:** Installing a database directly on your machine is fiddly and easy to break.
With Docker you run PostgreSQL in a container with one command, and remove it just as easily —
and it behaves the same on any computer, which makes a project easy to share.

**The basics**
- An **image** is a blueprint (e.g. "PostgreSQL 16"). You download it once.
- A **container** is a running copy of an image.
- A **volume** is storage that lives *outside* the container, so your data survives even if the
  container is deleted and recreated.

**Example**

Running a database the old way means installing and configuring Postgres by hand. With Docker
it's essentially:

```bash
docker run postgres:16     # download the image (if needed) and start a container
```

**What's happening:** Docker grabbed the `postgres:16` image and started a ready-to-use
PostgreSQL — no manual install, no leftover mess. (In our project we use Docker *Compose* to do
this more tidily — see the next note.)

**How we use it in the project:** Our PostgreSQL warehouse runs in a Docker container named
`lending_postgres`. That's why setup was a single command, and why your data lives safely in a
Docker **volume** called `pgdata`.

**Recap:** Docker runs software in disposable containers built from reusable images, with
volumes to keep data. It makes setup clean, repeatable, and shareable.
