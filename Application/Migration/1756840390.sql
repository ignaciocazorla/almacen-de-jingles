-- Add columns "tema_original" and "comentario" to Jingles
-- Rename "creado_por" to "autor"

ALTER TABLE jingles RENAME COLUMN creado_por TO autor;
ALTER TABLE jingles ADD COLUMN tema_original TEXT DEFAULT null;
ALTER TABLE jingles ADD COLUMN comentario TEXT DEFAULT null;
