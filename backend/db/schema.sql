-- backend/db/schema.sql
CREATE DATABASE dj_app WITH OWNER = admin_user;

\c dj_app

-- Create tables
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL
);

CREATE TABLE sessions (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    started_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE performances (
    id SERIAL PRIMARY KEY,
    session_id INTEGER REFERENCES sessions(id),
    score INTEGER,
    feedback TEXT
);

-- Permissions
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO admin_user;
REVOKE ALL ON ALL TABLES IN SCHEMA public FROM dj_user;