-- backend/db/seed.sql
\c dj_app

INSERT INTO users (username, password) VALUES
('alex', 'hashed_pw1'),
('sam', 'hashed_pw2');

INSERT INTO sessions (user_id) VALUES
(1),
(2);

INSERT INTO performances (session_id, score, feedback) VALUES
(1, 90, 'Great transition'),
(2, 70, 'Needs better timing');