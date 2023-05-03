CREATE TABLE IF NOT EXISTS artists
(
    id          UUID PRIMARY KEY      DEFAULT gen_random_uuid(),
    artist_name VARCHAR(255) NOT NULL UNIQUE,
    created_at  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE artists IS '商品テーブル';
COMMENT ON COLUMN artists.id IS 'ID';
COMMENT ON COLUMN artists.artist_name IS 'アーティスト名';
COMMENT ON COLUMN artists.created_at IS '作成日時';
COMMENT ON COLUMN artists.updated_at IS '更新日時';

CREATE INDEX IF NOT EXISTS artists_id_idx ON artists (id);
CREATE INDEX IF NOT EXISTS artist_name_idx ON artists (artist_name);
CREATE INDEX IF NOT EXISTS artists_created_at_idx ON artists (created_at);

DO
$$
    BEGIN
        IF NOT EXISTS (SELECT 1
                       FROM information_schema.table_constraints
                       WHERE constraint_type = 'FOREIGN KEY'
                         AND table_name = 'products'
                         AND constraint_name = 'products_artist_id_fkey') THEN
            ALTER TABLE products
                ADD CONSTRAINT products_artist_id_fkey
                    FOREIGN KEY (artist_id) REFERENCES artists (id);
        END IF;
    END
$$;