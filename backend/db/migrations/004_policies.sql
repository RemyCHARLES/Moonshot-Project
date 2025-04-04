-- 004_policies.sql

-- Enable RLS
ALTER TABLE users ENABLE ROW LEVEL SECURITY;

-- Policies
DROP POLICY IF EXISTS select_self ON users;
DROP POLICY IF EXISTS insert_self ON users;
DROP POLICY IF EXISTS delete_users ON users;

CREATE POLICY select_self ON users
  FOR SELECT USING (username = CURRENT_USER);

CREATE POLICY insert_self ON users
  FOR INSERT WITH CHECK (username = CURRENT_USER);

CREATE POLICY delete_users ON users
  FOR DELETE USING (false); -- deny all deletes

-- Optional: apply to sessions & performances later