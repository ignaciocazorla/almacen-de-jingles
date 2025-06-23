-- Create User roles and permissions

CREATE TABLE user_roles (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    name TEXT NOT NULL
);
ALTER TABLE user_roles ADD CONSTRAINT user_roles_name_key UNIQUE(name);
CREATE TABLE user_permissions (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    user_role_id UUID NOT NULL,
    resource TEXT NOT NULL,
    "action" TEXT NOT NULL
);
CREATE INDEX user_permissions_user_role_id_index ON user_permissions (user_role_id);
ALTER TABLE user_permissions ADD CONSTRAINT user_permissions_ref_user_role_id FOREIGN KEY (user_role_id) REFERENCES user_roles (id) ON DELETE NO ACTION;
