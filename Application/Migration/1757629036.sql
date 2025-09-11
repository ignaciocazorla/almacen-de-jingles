-- Update jingles columns "banda_original", "autor" and "tema_original"
-- to allow using SQL filters

ALTER TABLE jingles ALTER COLUMN banda_original SET NOT NULL;
ALTER TABLE jingles ALTER COLUMN autor SET NOT NULL;
ALTER TABLE jingles ALTER COLUMN tema_original SET NOT NULL;