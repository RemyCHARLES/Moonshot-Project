-- permissions.sql

-- Donner tous les privilèges à l'admin sur les tables
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO admin_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO admin_user;

-- Révoquer tout de dj_user
REVOKE ALL PRIVILEGES ON DATABASE dj_app FROM dj_user;
REVOKE ALL ON SCHEMA public FROM dj_user;
REVOKE ALL ON ALL TABLES IN SCHEMA public FROM dj_user;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA public FROM dj_user;

-- Donner uniquement les droits de lecture (SELECT) à dj_user
GRANT CONNECT ON DATABASE dj_app TO dj_user;
GRANT USAGE ON SCHEMA public TO dj_user;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO dj_user;

-- Pour que dj_user garde ses droits même sur les futures tables
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO dj_user;