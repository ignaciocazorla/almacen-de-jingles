ALTER TABLE jingles ADD COLUMN user_id UUID NOT NULL;
CREATE INDEX jingles_user_id_index ON jingles (user_id);
ALTER TABLE jingles ADD CONSTRAINT jingles_ref_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE NO ACTION;
