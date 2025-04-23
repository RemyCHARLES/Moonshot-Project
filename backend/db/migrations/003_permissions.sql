-- 003_permissions.sql

-- Grant full access to admin
GRANT ALL PRIVILEGES ON DATABASE dj_app TO admin_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO admin_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO admin_user;

-- Revoke access to dj_user, then set minimal rights
REVOKE ALL ON DATABASE dj_app FROM dj_user;
REVOKE ALL ON ALL TABLES IN SCHEMA public FROM dj_user;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA public FROM dj_user;

-- Give only access to use the database (needed for connection)
GRANT CONNECT ON DATABASE dj_app TO dj_user;