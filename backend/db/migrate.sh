#!/bin/bash
psql -U postgres -d dj_app -h localhost -f migrations/001_roles.sql
psql -U postgres -d dj_app -h localhost -f migrations/002_tables.sql
psql -U postgres -d dj_app -h localhost -f migrations/003_permissions.sql
psql -U postgres -d dj_app -h localhost -f migrations/004_policies.sql
psql -U postgres -d dj_app -h localhost -f migrations/005_seed_data.sql