### 📂 How to setup the database from scratch (with migrations)

This guide explains how to **recreate the PostgreSQL database** from zero using the migration system.

---

#### ✅ Prerequisites

- PostgreSQL installed and running locally  
- A user with superuser privileges (e.g. `postgres`)  
- `psql` CLI available  
- The project cloned locally

---

#### ⚙️ Step 1 – Drop and recreate the database (if needed)

```bash
psql -U postgres -h localhost -c "DROP DATABASE IF EXISTS dj_app;"
psql -U postgres -h localhost -c "CREATE DATABASE dj_app;"
```

---

#### ⚡️ Step 2 – Run all migrations

```bash
cd backend/db
./migrate.sh
```

This will sequentially run:
- `001_roles.sql` → create roles (admin, user)
- `002_tables.sql` → create tables (users, sessions, performances)
- `003_permissions.sql` → grant access control
- `004_policies.sql` → enable RLS and policies
- `005_seed_data.sql` → insert example data (optional)

---

#### 🔍 Step 3 – Check inserted data

```bash
psql -U postgres -d dj_app -h localhost
```

In `psql`:

```sql
SELECT * FROM users;
SELECT * FROM sessions;
SELECT * FROM performances;
```

---

### 📦 Purpose of this system

- You can **rebuild your DB schema** anytime in a reproducible way.
- Anyone cloning the repo can run `./migrate.sh` to have the **exact same database**.
- You can track DB changes in Git history.

---

