INSERT INTO users (username, password_hash, email) VALUES
('dj_remy', 'hashedpassword123', 'remy@example.com'),
('beatmaster', 'hashedpassword456', 'beatmaster@example.com');

INSERT INTO lessons (title, description, difficulty, content) VALUES
('Intro to Beatmatching', 'Learn to sync tracks.', 1, 'Lesson content here'),
('Advanced Mixing', 'Techniques for smooth transitions.', 3, 'Lesson content here');

INSERT INTO scores (user_id, lesson_id, score) VALUES
(1, 1, 85),
(2, 2, 90);