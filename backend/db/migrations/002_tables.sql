-- 002_tables.sql

-- User table
CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY,
  username TEXT UNIQUE NOT NULL,
  email TEXT UNIQUE NOT NULL,
  password_hash TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Lesson table
CREATE TABLE IF NOT EXISTS lessons (
  id SERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT,
  position INTEGER NOT NULL
);

-- Lesson's pages table
CREATE TABLE IF NOT EXISTS pages (
  id SERIAL PRIMARY KEY,
  lesson_id INTEGER NOT NULL REFERENCES lessons(id) ON DELETE CASCADE,
  type TEXT NOT NULL,
  content JSONB NOT NULL,
  position INTEGER NOT NULL
);

-- User's progress table
CREATE TABLE IF NOT EXISTS user_progress (
  user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
  lesson_id INTEGER REFERENCES lessons(id) ON DELETE CASCADE,
  completed BOOLEAN DEFAULT FALSE,
  current_page INTEGER DEFAULT 0,
  PRIMARY KEY (user_id, lesson_id)
);

-- Rewards table
CREATE TABLE IF NOT EXISTS user_rewards (
  user_id INTEGER PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE,
  streak INTEGER DEFAULT 0,
  xp INTEGER DEFAULT 0,
  gems INTEGER DEFAULT 0,
  lives INTEGER DEFAULT 5,
  updated_at TIMESTAMP DEFAULT NOW()
);