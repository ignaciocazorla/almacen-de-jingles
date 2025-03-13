CREATE TABLE jingles (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    nombre TEXT NOT NULL,
    fecha DATE DEFAULT null,
    link TEXT NOT NULL,
    tiempo_inicio TEXT DEFAULT null,
    nombre_video TEXT NOT NULL,
    banda_original TEXT DEFAULT null,
    creado_por TEXT DEFAULT null
);
