-- backend/db/roles.sql
DO $$
BEGIN
    CREATE ROLE admin_user WITH LOGIN PASSWORD 'secure_admin_pw';
EXCEPTION WHEN duplicate_object THEN
    RAISE NOTICE 'admin_user already exists';
END $$;

DO $$
BEGIN
    CREATE ROLE dj_user WITH LOGIN PASSWORD 'secure_app_pw';
EXCEPTION WHEN duplicate_object THEN
    RAISE NOTICE 'dj_user already exists';
END $$;