-- 004_policies.sql

-- Drop existing policies if any
DROP POLICY IF EXISTS select_self ON users;
DROP POLICY IF EXISTS insert_self ON users;
DROP POLICY IF EXISTS delete_users ON users;

-- Enable RLS
ALTER TABLE users ENABLE ROW LEVEL SECURITY;

-- Allow dj_user to SELECT any user (temporary, adjust later if needed)
CREATE POLICY select_all_users ON users
  FOR SELECT TO dj_user
  USING (true);

-- Allow dj_user to INSERT new users
CREATE POLICY insert_self ON users
  FOR INSERT TO dj_user
  WITH CHECK (username IS NOT NULL AND email IS NOT NULL);

-- Deny DELETE for dj_user
CREATE POLICY delete_users ON users
  FOR DELETE TO dj_user
  USING (false);