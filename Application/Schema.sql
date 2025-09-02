-- Your database schema. Use the Schema Designer at http://localhost:8001/ to add some tables.
CREATE TABLE jingles (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    nombre TEXT NOT NULL,
    fecha DATE DEFAULT NULL,
    link TEXT NOT NULL,
    tiempo_inicio TEXT DEFAULT NULL,
    nombre_video TEXT NOT NULL,
    banda_original TEXT DEFAULT NULL,
    autor TEXT DEFAULT NULL,
    user_id UUID NOT NULL,
    tema_original TEXT DEFAULT NULL,
    comentario TEXT DEFAULT NULL
);
CREATE TABLE users (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    email TEXT NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    locked_at TIMESTAMP WITH TIME ZONE DEFAULT NULL,
    failed_login_attempts INT DEFAULT 0 NOT NULL,
    name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    user_role_id UUID NOT NULL
);
CREATE INDEX jingles_user_id_index ON jingles (user_id);
CREATE TABLE user_roles (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    name TEXT NOT NULL UNIQUE
);
CREATE TABLE user_permissions (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    user_role_id UUID NOT NULL,
    resource TEXT NOT NULL,
    "action" TEXT NOT NULL
);
CREATE INDEX user_permissions_user_role_id_index ON user_permissions (user_role_id);
CREATE INDEX users_user_role_id_index ON users (user_role_id);
ALTER TABLE jingles ADD CONSTRAINT jingles_ref_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE NO ACTION;
ALTER TABLE user_permissions ADD CONSTRAINT user_permissions_ref_user_role_id FOREIGN KEY (user_role_id) REFERENCES user_roles (id) ON DELETE NO ACTION;
ALTER TABLE users ADD CONSTRAINT users_ref_user_role_id FOREIGN KEY (user_role_id) REFERENCES user_roles (id) ON DELETE SET NULL;
