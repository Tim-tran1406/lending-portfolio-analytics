# Git basics

**What it is:** Git is a tool that tracks the history of your project's files. Every time you
save a meaningful change (a **commit**), git remembers it — so you can see what changed, when,
and undo mistakes.

**Why it matters:** Git is non-negotiable in real software and data work, and **GitHub** (where
we'll publish) is built on top of it. A clean commit history also shows employers how you work.

**The basics**
- A **repository** ("repo") is a project folder that git is tracking.
- The **staging area** is where you gather the changes you want to save next.
- A **commit** is a saved snapshot, with a message describing it.
- Core commands: `git add` (stage), `git commit` (save), `git status` (what changed),
  `git log` (history).

**Example**

The typical cycle — and exactly what we did for the foundation:

```bash
git status            # see what changed
git add .             # stage the changes
git commit -m "Set up Dockerized Postgres warehouse and data ingestion"
git log --oneline     # view the history
```

**What's happening:** `add` chooses *what* to save; `commit` saves it with a message. We also
set the commit **author** to you (`Tim-tran1406`) so your GitHub profile gets credit — and
deliberately added **no** "Claude" co-author.

**How we use it in the project:** Each meaningful step becomes one commit, with a message that
describes *what we did* (never "part 1 / session 2"). Next we'll connect this repo to GitHub and
push it online.

**Recap:** Git tracks your work as commits. `add` → `commit`, repeat. Good messages + the
correct author = a professional history.
