-- 001_roles.sql

DO $$
BEGIN
   CREATE ROLE admin_user WITH LOGIN PASSWORD 'secure_admin_pw';
EXCEPTION WHEN duplicate_object THEN
   RAISE NOTICE 'Role admin_user already exists';
END $$;

DO $$
BEGIN
   CREATE ROLE dj_user WITH LOGIN PASSWORD 'secure_app_pw';
EXCEPTION WHEN duplicate_object THEN
   RAISE NOTICE 'Role dj_user already exists';
END $$;