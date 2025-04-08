-- 004_policies.sql

-- Enable RLS on sessions table
ALTER TABLE sessions ENABLE ROW LEVEL SECURITY;

-- Drop old policy if exists
DROP POLICY IF EXISTS insert_session ON sessions;

-- Allow dj_user to insert their own session (via RLS context app.current_user_id)
CREATE POLICY insert_session ON sessions
  FOR INSERT TO dj_user
  WITH CHECK (user_id = current_setting('app.current_user_id')::int);

-- (Re)define existing policies for users table
DROP POLICY IF EXISTS select_self ON users;
DROP POLICY IF EXISTS insert_self ON users;
DROP POLICY IF EXISTS delete_users ON users;

CREATE POLICY select_self ON users
  FOR SELECT TO dj_user
  USING (id = current_setting('app.current_user_id')::int);

CREATE POLICY insert_self ON users
  FOR INSERT TO dj_user
  WITH CHECK (username = current_user);

CREATE POLICY delete_users ON users
  FOR DELETE TO dj_user
  USING (false);

