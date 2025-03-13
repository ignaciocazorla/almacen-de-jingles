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
