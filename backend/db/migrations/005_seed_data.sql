-- ✅ Clean development seed file
-- This script inserts default data if it doesn't already exist.

-- Insert default user
INSERT INTO users (username, email, password)
SELECT 'alex', 'alex@example.com', 'hashed_pw1'
WHERE NOT EXISTS (
  SELECT 1 FROM users WHERE username = 'alex'
);

-- Insert default session for user 'alex'
INSERT INTO sessions (user_id, started_at)
SELECT id, NOW() FROM users
WHERE username = 'alex'
  AND NOT EXISTS (
    SELECT 1 FROM sessions WHERE user_id = users.id
);

-- Insert default performance for session
INSERT INTO performances (session_id, score, feedback)
SELECT s.id, 85, 'Clean and synced mix'
FROM sessions s
JOIN users u ON s.user_id = u.id
WHERE u.username = 'alex'
  AND NOT EXISTS (
    SELECT 1 FROM performances WHERE session_id = s.id
);