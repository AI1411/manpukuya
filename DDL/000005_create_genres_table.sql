CREATE TABLE IF NOT EXISTS genres
(
    id         UUID PRIMARY KEY      DEFAULT gen_random_uuid(),
    genre_name VARCHAR(255) NOT NULL UNIQUE,
    created_at TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE genres IS '商品テーブル';
COMMENT ON COLUMN genres.id IS 'ID';
COMMENT ON COLUMN genres.genre_name IS 'ジャンル名';
COMMENT ON COLUMN genres.created_at IS '作成日時';
COMMENT ON COLUMN genres.updated_at IS '更新日時';

CREATE INDEX IF NOT EXISTS genres_id_idx ON genres (id);
CREATE INDEX IF NOT EXISTS genres_created_at_idx ON genres (created_at);

DO
$$
    BEGIN
        -- 外部キー制約が存在するかどうかを確認するクエリ
        IF NOT EXISTS (SELECT 1
                       FROM information_schema.table_constraints
                       WHERE constraint_type = 'FOREIGN KEY'
                         AND table_name = 'products'
                         AND constraint_name = 'products_genre_id_fkey') THEN
            -- 外部キー制約が存在しない場合にのみ追加する
            ALTER TABLE products
                ADD CONSTRAINT products_genre_id_fkey
                    FOREIGN KEY (genre_id) REFERENCES genres (id);
        END IF;
    END
$$;