DROP TYPE IF EXISTS product_status CASCADE;
CREATE TYPE product_status AS ENUM (
    'NEW',
    'USED',
    'OUT_OF_STOCK',
    'DISCONTINUED'
    );


CREATE TABLE IF NOT EXISTS products
(
    id             UUID PRIMARY KEY        DEFAULT gen_random_uuid(),
    product_name   VARCHAR(255)   NOT NULL,
    description    TEXT           NULL,
    product_status product_status NOT NULL DEFAULT 'NEW',
    artist_id      UUID           NULL,
    genre_id       UUID           NULL,
    release_date   DATE           NOT NULL,
    stock          INTEGER        NOT NULL DEFAULT 1,
    price          INTEGER        NOT NULL DEFAULT 0,
    created_at     TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at     TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE products IS '商品テーブル';
COMMENT ON COLUMN products.id IS 'ID';
COMMENT ON COLUMN products.product_name IS '商品名';
COMMENT ON COLUMN products.description IS '説明';
COMMENT ON COLUMN products.artist_id IS 'アーティストID';
COMMENT ON COLUMN products.genre_id IS 'ジャンルID';
COMMENT ON COLUMN products.release_date IS 'リリース日';
COMMENT ON COLUMN products.stock IS '在庫';
COMMENT ON COLUMN products.price IS '価格';
COMMENT ON COLUMN products.created_at IS '作成日時';
COMMENT ON COLUMN products.updated_at IS '更新日時';

CREATE INDEX IF NOT EXISTS products_id_idx ON products (id);
CREATE INDEX IF NOT EXISTS product_name_idx ON products (product_name);
CREATE INDEX IF NOT EXISTS products_created_at_idx ON products (created_at);