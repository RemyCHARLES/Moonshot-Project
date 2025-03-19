-- Create Users Table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Lessons Table
CREATE TABLE lessons (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    difficulty INT NOT NULL CHECK (difficulty BETWEEN 1 AND 5),
    content TEXT
);

-- Create Scores Table (User Performance)
CREATE TABLE scores (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    lesson_id INT REFERENCES lessons(id) ON DELETE CASCADE,
    score INT NOT NULL CHECK (score BETWEEN 0 AND 100),
    completed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Progress Table (Tracks User Progress)
CREATE TABLE progress (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    lesson_id INT REFERENCES lessons(id) ON DELETE CASCADE,
    status VARCHAR(20) CHECK (status IN ('Not Started', 'In Progress', 'Completed')),
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);