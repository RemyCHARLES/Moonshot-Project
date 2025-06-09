ALTER TABLE users ENABLE ROW LEVEL SECURITY;

GRANT SELECT, INSERT ON users TO dj_user;

DROP POLICY IF EXISTS select_own_user ON users;
CREATE POLICY select_own_user ON users
  FOR SELECT
  USING (username = current_user);

DROP POLICY IF EXISTS insert_user ON users;
CREATE POLICY insert_user ON users
  FOR INSERT
  WITH CHECK (username = current_user);

DROP POLICY IF EXISTS select_self ON users;
CREATE POLICY select_self ON users
  FOR SELECT
  USING (username = CURRENT_USER);