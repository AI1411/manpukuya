CREATE TABLE IF NOT EXISTS genres
(
    id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    genre_name VARCHAR(255) NOT NULL UNIQUE,
    slag       VARCHAR(255) NOT NULL UNIQUE
);

COMMENT ON TABLE genres IS '商品テーブル';
COMMENT ON COLUMN genres.id IS 'ID';
COMMENT ON COLUMN genres.genre_name IS 'ジャンル名';
COMMENT ON COLUMN genres.slag IS 'スラッグ';

CREATE INDEX IF NOT EXISTS genres_id_idx ON genres (id);

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
                    FOREIGN KEY (genre_id) REFERENCES genres (id) ON DELETE CASCADE;
        END IF;
    END
$$;

-- ダミーデータ挿入
INSERT INTO genres (genre_name, slag)
VALUES ('洋楽', 'western'),
       ('J-POP', 'j-pop'),
       ('JAZZ', 'jazz'),
       ('クラシック', 'classic'),
       ('K-POP', 'k-pop'),
       ('ロック', 'rock'),
       ('ヒップホップ', 'hip-hop'),
       ('R&B', 'randb'),
       ('EDM', 'edm'),
       ('ハウス', 'house'),
       ('テクノ', 'techno'),
       ('ダンス', 'dance'),
       ('ヘヴィメタル', 'heavy-metal'),
       ('ワールドミュージック', 'world-music'),
       ('レゲエ', 'reggae'),
       ('ラテン', 'latin'),
       ('ブルース', 'blues'),
       ('ゴスペル', 'gospel'),
       ('フォーク', 'folk'),
       ('カントリー', 'country'),
       ('ゲーム', 'game'),
       ('その他', 'other');