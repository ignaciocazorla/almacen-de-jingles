-- Your database schema. Use the Schema Designer at http://localhost:8001/ to add some tables.
CREATE TABLE jingles (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    nombre TEXT NOT NULL,
    fecha DATE DEFAULT NULL,
    link TEXT NOT NULL,
    tiempo_inicio TEXT DEFAULT NULL,
    nombre_video TEXT NOT NULL,
    banda_original TEXT DEFAULT NULL,
    creado_por TEXT DEFAULT NULL
);
CREATE TABLE users (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    email TEXT NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    locked_at TIMESTAMP WITH TIME ZONE DEFAULT NULL,
    failed_login_attempts INT DEFAULT 0 NOT NULL,
    user_role_id INT DEFAULT 2 NOT NULL
);
