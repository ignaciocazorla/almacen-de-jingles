-- Add user role reference to user table

ALTER TABLE users DROP COLUMN user_role_id;
ALTER TABLE users ADD COLUMN user_role_id UUID NOT NULL;
CREATE INDEX users_user_role_id_index ON users (user_role_id);
ALTER TABLE users ADD CONSTRAINT users_ref_user_role_id FOREIGN KEY (user_role_id) REFERENCES user_roles (id) ON DELETE SET NULL;
